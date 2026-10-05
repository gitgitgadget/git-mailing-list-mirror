Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADDDD449992
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 12:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791203370; cv=none; b=L9uo4d5Nex5bb34rc/3gU9OYTljpFgqMjOM3orj7JretphIBWQQ0wUsCWF+eFOBQ6UamgiMmsHERuHBjkt8IDCx9Q1vBIe7qY81woc50eWOivfA5TibLd70N12L6Q/PCmroYdJ0EUAV+P+RFN04EFURBgVEB1EodAr54NKry/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791203370; c=relaxed/simple;
	bh=O6/dS80RtXsUPR6njORGeKwVXdGzh1qAThRJq6f4Lrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aAu21aOzVJjWA8a0BU+jDrLNmWm1SkAvxuM86PaTWfyvxOYpCUhYDhvU4FSgXlxuB74q5365/OK5x8rA8EEW5WdP+StHjRp6ibaMuguYo3q+vW7HegnKtN/FFzse3tDfLnCTPCLEm6FU/Nqty+ThVdDoF2814nY9QuyHBkHD5eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlvFN0SC; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlvFN0SC"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-8167e0d1f90so1477564a34.0
        for <git@vger.kernel.org>; Mon, 05 Oct 2026 05:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791203367; x=1791808167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fr4ndSwu39tU34VzOME9oGfv1Qme3y01x51erEeQhY8=;
        b=nlvFN0SCNrYqUm3G34qoH1DNOQPIoqHIe00D+jNeR1wscdlNuzDaSVNk7SwZcIOKJs
         4yhvb/n2TUM4zINS/7LqIwcXyQ9OsZ1qXJJvnpfYCTp4yPaFZcwF6Rdc8ugi8mWEDhO2
         xkzyKcjed/75wI6D05HTTbBZTH+9+lWmEN4n1NEL0pVFbhuveo+poyKPkU5oplRRocGP
         nrVB2r0o98W7zD9M9KyxqDhlzl23JmAS7FcYaXGff0u/0u7nO1hQJFFQUQbAmE3OTXr/
         lL9ain3op/vFKv1LZC1BiYW/ITTcSODhHavhcl1Ty/SGg1FZ3qw+HSJ+B8ZvKVkKvRL7
         kgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791203367; x=1791808167;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fr4ndSwu39tU34VzOME9oGfv1Qme3y01x51erEeQhY8=;
        b=PRNpQ4+K9GYtYqsV4g3mfLAquiRigAsCN7UZIKUdKktwDNyguPgZpfwapYs79ReIoF
         AX1ksLdnS2bKWkV7ilHD5oMUt6aVpuQwV4qv6McmqUnMhAB9TmcLxew0PVQ0kQYMrzvm
         lpp2cean2//F6C7rsiRoNa3mxL3/gVHZpQEk59aKqXfhnFlHKBojIVkWnjtQbIy8iJu4
         0aP1QMx2OuH8OitqAuiEXTVYy6LS9+brGSpW0w49fHqndc8R/O9LTqW2GoKzGKQz5Yee
         0xdqSCzpcRaE5Zo3YWHqeyR4FTMIEiZkDOmgGP3gNyXDdtcP2ABN3sFfpZVOM0Q6rbrR
         O0fQ==
X-Gm-Message-State: AFuF++kqxC+xypxZGEVzuOBy/MymJ6MMumgaFrNlddck083Yhu3LlPta
	RTe4Z7adzcV8j58/xcdrk9dlzjOSzMqdUlw7L5gtwfGNd22q/1hZNWwQk/fgUKr4
X-Gm-Gg: AYBFou2I3hlZcYuFqo+H3sBsoRt9mJON2vn8b8NwRTOf8LPkgfI7ojxy1CBFCrI4GxH
	7H64T0o8hgG4ys4i8WshHeMHCJeOrd6mSqrPHMsMEFDc8jp0AuRnbMizDaGObVBzzuWQezA08vI
	h8g4qqEdBwo7BRGuQCyFwz/Y3TjAaHCoDoBTUvJV5YQO2Cd8ieCLtNLV+ym1ZAKo7uPIZZFIP0W
	jxuR+vCoF6wRrHVsBAA8vyDSUPgVq3zAi2oRZf4E3WBrEqsSqwRtHBNNFrdV1W72mJQmNflUsUS
	7EkqQB2lNBNRjZKOvODGpSMJk0bOAgz72tlGF3lSP75YZ4kdRnYBl3c9wM0ykyE3oV3c/vFbgAS
	H+WM4wpdoHUeS5arHl8VY0iuMj6h1sCXIlEn0ymRyg3s4Nh80IsSoQBxXxJ4KwpJwl6VGZL85VF
	X3p+tbx6h01/sivd9ddFLmomg9EQeNfRwSWl2WiBMFcQ4PcJWZUA5PJXyF+Uwt4wnzfmm9oKLzt
	yN571hKW1W7Y7s=
X-Received: by 2002:a05:6808:c102:b0:4b2:8d7b:390b with SMTP id 5614622812f47-4f5290fcb31mr9772262b6e.19.1791203367336;
        Mon, 05 Oct 2026 05:29:27 -0700 (PDT)
Received: from [192.168.25.219] ([115.108.41.154])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4f5245d16c9sm12225418b6e.10.2026.10.05.05.29.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Oct 2026 05:29:26 -0700 (PDT)
Message-ID: <b829d416-f36e-454e-a141-3fc93fd62cb3@gmail.com>
Date: Mon, 5 Oct 2026 17:59:23 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 4/4] setup: communicate why a directory is not a
 valid git directory
To: Patrick Steinhardt <ps@pks.im>
Cc: Git mailing list <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <20260924120502.2642141-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-1-kaartic.sivaraam@gmail.com>
 <20260929102513.712181-5-kaartic.sivaraam@gmail.com>
 <ar0ywAlMDuzK1Hvb@pks.im>
Content-Language: en-US
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
In-Reply-To: <ar0ywAlMDuzK1Hvb@pks.im>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/30/26 21:33, Patrick Steinhardt wrote:
> On Tue, Sep 29, 2026 at 03:55:10PM +0530, Kaartic Sivaraam wrote:
>> At the moment, there are a few scenarios in which the error message
>> surrounding an invalid Git repository is a bit blunt:
>>
>>    $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
>>    fatal: not a git repository: 'repo.git'
>>
>> In this case, even though repo.git is a valid Git repository,
>> we get an output saying it is not since the GIT_OBJECT_DIRECTORY
>> does not point to a valid object directory. At the moment, the
>> user is on their own in figuring this out.
>>
>> Instead, make it more easy for users to figure such issues
> 
> s/more easy/easier/
>

Ah. Will correct.

>> particularly in cases where they have explicitly specified
>> a Git directory. This intends to improve the error reporting UX
>> by clarifying why the specified repository is not considered valid.
> 
> Which I think is a good motivation.
> 
>> We achieve this by means of using the new helper
>> is_git_directory_verbose() that has been introduced. With the
>> same, we get a more helpful error message as follows:
>>
>>    $ GIT_OBJECT_DIRECTORY=/does/not/exist git --git-dir repo.git rev-parse --is-bare-repository
>>    fatal: not a git repository: 'repo.git'
>>    reason: cannot access object directory '/does/not/exist' set via $GIT_OBJECT_DIRECTORY
> 
> Having a separate "reason:" line feels a bit off to me, but that may be
> subjective. I'd have preferred to have it on the same line, or maybe
> first have "error:" followed by "fatal:".
> 

Hmm. Let me think which of these I could adopt. Thank you for the 
suggestion.

>> diff --git a/setup.c b/setup.c
>> index a0fb68f7f6..a0d3c0c5bb 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -1195,6 +1195,7 @@ static void repo_discover_explicit_gitdir(struct repo_discovery *discovery,
>>   					  int *nongit_ok)
>>   {
>>   	const char *work_tree_env = getenv(GIT_WORK_TREE_ENVIRONMENT);
>> +	struct strbuf invalid_gitdir_reason = STRBUF_INIT;
> 
> Nit, please feel free to ignore: I'd just have called this `errbuf`.
> 

Noted.

-- 
Sivaraam

