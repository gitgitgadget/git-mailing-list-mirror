Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD042609FD
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827306; cv=none; b=oAAf4KWs6H7Wj5h3KIwaFnjg5mPsc7N07jih3C6l9jtCl+YK0mz+lg1a6qmIuYIBGNm/sPG3atRrAxbkOxvtTHJuu+Hfue2EFRIRnTZNXyAgZw8jwBRcRc/t71PrZ+GuyvPYQ4oZ/JVpD+ONR5DOe2PObexJ9743j1VEpap5kB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827306; c=relaxed/simple;
	bh=MydccrQmKPZ5YsmEo3BhE/B+tf3QwF+LkUGgc5uvwTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qF8BghBKLDngvcj1nKjb7CQJaz9w8Z5x8RIQKl158lJ5sqHVpr9XpPk0ppNPuG6sDvW5XgCubfywPu68vvTBN40uldyRC82nsftySGwvkUaHJPhvZ2TArg8lJMNfU77EhwllkTMH4d7axe98v0aqktn2e2PEsB9wStUjFqXeYbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OhRJLPKi; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OhRJLPKi"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-691c5776f95so7819284a12.3
        for <git@vger.kernel.org>; Tue, 30 Jun 2026 06:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782827304; x=1783432104; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8gjyQiTffu2gK5OyjLZ2m2ngCDnOhmbIjATNmuRHy80=;
        b=OhRJLPKiEYWXOz/lbunwlyHdjASC6rbQ06q71pmhmoF26qwdtNCkGq9gZ9mF8kSFZ9
         SLlDJTj1EE+kuD408nXJ7RSiMAvZJpU1yteqJuRANioAH9LGAzTgBt5CGHxs0t9z4jza
         DT2y73sYjAItUSnyIZDCDsvZcJwNBL3e4W7Upq+uyLHEQdY5iewNbcj5IlYAcUBGKfR0
         4iU/Ns8ztZhO+zlfmtPRKbXICfXQ9vL6itW0/ezCCl494WAIudGQFYjQC4aBfxVROaOB
         bXhTO0fShgdZep0P5rlHgV7sZU05QA82CBp35ZyLzgB786tLtfRS8vn4dBrPMbP5YZHe
         NTaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782827304; x=1783432104;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gjyQiTffu2gK5OyjLZ2m2ngCDnOhmbIjATNmuRHy80=;
        b=hdlz2I89VhQs2trBXIiL+Q+JOB9Qt8MSEhngxjKOwZTQIPf0JLrkmmyPVPNxZGLh3N
         C6kqpQ0QhS0Qmr+md2xN25GRdUrZbRmi6sMLoWxQD087LzMKGe/O41lzpjNBNcNnm4wD
         Tx7xelJJU3nZgZfcITAFTzPnFVPgSQfY/0vSSWNnnA5v9EdJ2fHGMnVjlPg7WxOtVhOX
         hyQUJ2xAzP3nzabcZAdTnZJ3ZApYNVit/UjlXXSetklksmZWGwf+yw3KlbsfkXwD4vyO
         div0Xdk+lYaVpdrjAuIqjHT3P17aTQcj4LgoZS2JgQIxKNBRgW1NjFVlO5+Hdqd4NrWu
         6Q6A==
X-Forwarded-Encrypted: i=1; AHgh+RpvNHI8SuxyrY5b41V1Lgj90BgB99d703GEwK8SOW0jOUBF78PDtyan7cJW0RWyQE88GHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATChib3RifleiP7Oab1LuqRmK4sh0QNurE3tyDmlKWMLCfF8L
	CW1ZCbX/2vjT7cUuNrd/H6UiZLWiTyNOQaQJaL8AqGPtpQGF5t7i4yEW
X-Gm-Gg: AfdE7cmYSIvLCiH5O80OqaOxKo3c8odcyuQwzHzTsOGxaNtIB90FOCSrxMtyyVQl5mp
	Bgx5Q63XP3aul720turg6yz7XchYnhGmCC549UvY4j8359dkbEEFSeEJ3IQ3BxGG42Q7cBA4SNe
	drC/b/k7ft/RH0cXhQMEB5HayKa76b36WiwRpzZbaLmKp1hgyq4ielZqOC9kvEOYIjC7TGJfTV+
	jOHf6d89WUv0DpOHzmH9ZzErdvAtZb5vx8PMNA7BNLHoDPkFlmxOVEeFozVgYT6BfvxVmdMesd7
	KXxAspg5EuADgal+oQ/4owU0jLZYZS6lYD2btAUm41kerZ1Ah9hkEjqcTg1CVLx07aQ1eCZbydb
	0Ee3OF+Y78oQpLdxGSZNXoXYRV7bFtXmcZPmTTfvtl4PwaXKcXfewk3/p4qosYUv/MV9oOuLZTg
	l6i8UMEl1zDQg9bkpghmizeiYsgtG+LtPZRjppaG37joff/P7nC/g7zkTMzp3Qt1WC7r4=
X-Received: by 2002:a17:906:fe43:b0:c12:34ed:da11 with SMTP id a640c23a62f3a-c12873872afmr158982266b.61.1782827303313;
        Tue, 30 Jun 2026 06:48:23 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:69a:b801:201a:26ab:8d41:fb43? ([2a0a:ef40:69a:b801:201a:26ab:8d41:fb43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1288f46dccsm134881766b.48.2026.06.30.06.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jun 2026 06:48:22 -0700 (PDT)
Message-ID: <4b505228-4846-4a48-9255-e249f4e70a1f@gmail.com>
Date: Tue, 30 Jun 2026 14:48:20 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 0/4] history: add squash subcommand to fold a range
To: Harald Nordgren <haraldnordgren@gmail.com>, phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>,
 Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
References: <pull.2337.v4.git.git.1782021195.gitgitgadget@gmail.com>
 <pull.2337.v5.git.git.1782338102.gitgitgadget@gmail.com>
 <d37e8f4f-d1f9-45aa-8c95-ebe676d54671@gmail.com> <akIQLM6xZTHBudWT@pks.im>
 <3b3af3ef-a043-4af9-964e-429237789c97@gmail.com>
 <CAHwyqnWQmObWr3N81_EU6F13iyKp3FfY8KSNFfoAjS4r_0qJrQ@mail.gmail.com>
 <dff9378a-267f-4b49-bee4-615b4bf75abb@gmail.com>
 <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <CAHwyqnVN=McZjtQGcPnoVOHAd0+VDNPXy_N949VMsqZty3RDjQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/06/2026 22:13, Harald Nordgren wrote:
>> You've trimmed the line where I said
>>
>>   >> Possibly with a comment before each message saying where it came
>>   >> from.
> 
> Sorry about that! Can you show me the example of what it would look
> like? It's much easier for me to reason about it then.

For the commits

     123 Commit one
     456 Commit two
     789 fixup! Commit one
     abc squash! Commit two
     def amend! Commit one

It would look something like

     # This is the combination of the following commits:
     #   123 Commit one
     #   789 fixup! Commit one
     #   def amend! Commit one
     #   456 Commit two
     #   abc squash! Commit two

     A better commit one subject

     A better commit one body

     # ------------------------------------

     Commit two

     Commit two body

     # squash! Commit two

     More text for commit two

I've rearranged the commits in the summary to keep fixup commits with 
their targets instead of listing them in the same order of "git log 
--reverse". As we're dropping uninteresting messages I not sure there is 
much point in numbering them[1] so I've just used a plain separator to 
show where a message ends. For squash! commits commenting out the 
subject shows where the original message ends and the message from the 
squash! commit begins. I'm on the fence as to whether it is worth having

     # amend! Commit one

above the first message

Thanks

Phillip

[1] If we really want to number things we could number each commit in
     the summary and then use that to label it in the message template
     with separators like

         # This is the message from commit <n>

     instead of separating them with

         # ----------------------------


