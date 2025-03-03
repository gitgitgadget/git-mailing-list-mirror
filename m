Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E560A218589
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 16:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019791; cv=none; b=tJRt6p1nyQkR/GO/elAcLHDEN7W7CBO3QAOvxD4hpGdq2Xg+W5Dnb+wNEj6KnW+AUu+au40ei+aQah9xLCGfByS15lGg5/9b2zS/YYVulcCe4u7cY1apMtW6vsheCo6JfeBOLDPsMUDMAcvmkQOEdyUftdfvYfCVmsK2Gt4JD2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019791; c=relaxed/simple;
	bh=z7PRYPvqPVYeoXTTYJvMbnUbri4jDIQtQbSCRMiMYHg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=TlsHgC7BxDtyPVqccwzKU8vv5whrjzGB6p1pEsDiEGbdP6PkByWZqFuZSMbxma69Ca8W4IaVTIkNrCzILZF64C6y+Akj+3tSkch9QLHWhqvMOQdLxiuLfkR4GOBbJCXBjkWuplJ8aePH9j3ksiBUfiJflqv4if2z7OcnaVxkoyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEvAsx9G; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEvAsx9G"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aaf900cc7fbso832850966b.3
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 08:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741019788; x=1741624588; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0/xhoLCcLQa5X4DjXTkfc2PUFMb6ZCEE72cpA1PSnBc=;
        b=WEvAsx9G0MWfr+VDYFVBxDadKh4k2IexvS1QKRmGbXiO/rOCdzGlR5KTDqknH7QGN+
         TWnJtE5vXS2r5YUtb//jfCs6Hyx9mcqT6dC7dUIJkS8Q/GuqsyR9Z6ECUdpozGEWVzgA
         50oIIr8C7HEHCtOS2voazdM59iWSwLMWptTI2eMphCtjuKN8kKFreW3IkNEe0zrsfwDj
         wdaE5T4QSjufv0QkoBbyFxF/0DQn0+Wj+xYnvxUIBuzggjUrYnzRxlINYlJDZWUeC2Fu
         rcZP2zWcqoX8yNUf/alsciGg0voK4PBvUU4KXnVBp5A2Hr8wdzUmKOqGRDfUL2PI8HSo
         4SOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741019788; x=1741624588;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0/xhoLCcLQa5X4DjXTkfc2PUFMb6ZCEE72cpA1PSnBc=;
        b=FvNLWmdjL3KvhqSK+6eKg9msk2wqs0k+HIVEUnpahwMw9la5PfIckdYN3UQRXc8pdg
         W8yhnD23KezUPU0cz0iuxP+Wy56uJZ552Jx7wRPccTZ7xgNrbjtSfvaogb03Oojnwz77
         6vTNWDcNFPjCEA4PmszKINCljPoHVNyM1WA9m0go1yFb5Vx/n2w31m/OOKWf3lk7y094
         VBLlDrHzYfAOPCh4uLpet7Qb8e4o7E37N1HoIWG/wgqm0vQxfXwDPK6CWzaCttYsS6nC
         V5ybWSxGJLUMZ0DOoVA6x2uoC+7AF/XWQG62kwU9LA/O5JDJsw5D+2ZeGzHECZZOhDLy
         /YZA==
X-Forwarded-Encrypted: i=1; AJvYcCWuRfKRutZTY99DrB2g9wFhtNbEw68bNrlSCkd3Hqcpz8q18zH7v6NtVR+BtQu1buCRf5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzaAZxzx37o2AHM/H2slAGGIaAg+xyUtz151xCSwtTuS0/pCHR
	gbz8tgzF2UdjLxSMQAoMSFLFjuUuFrcUn4RvvoGUK/1BcvpBlqUU
X-Gm-Gg: ASbGncv8UJ4Mrn2SqFLUyNSSRtRktZNiBrQud6jZwGTR3uze2bYrd+iFKvucUHinx6x
	vCuQgtZBpJ85MvwugPgADGllim2u2VJy77dqRAP2YmEtyE4E9fo2bv6xvbDAjeycLrSoscGzxWa
	x7XCpHRlL+sEngoVQIVhyI6RrDh3K/OMfpJO9UmOGocVzZdZifkD4aT2yfdQs66n2RCIrBl9XEY
	R+zS1DBL7zVLayy5wKc7JYq3Q1t57Ki/sY356wpsRbWb0qQLnFye9IUR1BWjGC3Ri3tRhw1NddX
	9U1kWI+/nnJQv6LWeeV+4mNY66mIP9krT2PI45AeN21dHukMP1Zaoz3GqlkK5sgqexgjKqdfDUZ
	rizDnXEkMfHSuN08kMwkMW5A=
X-Google-Smtp-Source: AGHT+IH+ZmilkBaeRWl8Mjpp8Vy9VzneNp607Y1EtQ9pMOnLONtkC4Rpf55ziSnc2jolvLe4IYbmYQ==
X-Received: by 2002:a17:906:794e:b0:abf:7406:a5c3 with SMTP id a640c23a62f3a-abf7406a640mr592408466b.51.1741019787814;
        Mon, 03 Mar 2025 08:36:27 -0800 (PST)
Received: from ?IPV6:2a0a:ef40:700:a501:27ae:70ed:9eda:7f80? ([2a0a:ef40:700:a501:27ae:70ed:9eda:7f80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf55e88748sm460304566b.54.2025.03.03.08.36.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Mar 2025 08:36:27 -0800 (PST)
Message-ID: <65d903c0-6b4b-4a55-b7e4-4a277417f0f1@gmail.com>
Date: Mon, 3 Mar 2025 16:36:24 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 3/3] completion: fix bugs with slashes in remote names
To: David Mandelberg <david@mandelberg.org>, phillip.wood@dunelm.org.uk,
 David Mandelberg via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: Jacob Keller <jacob.keller@gmail.com>, Junio C Hamano <gitster@pobox.com>
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
 <95ffa62df6ce394249a8ddabb84fb2b517825fe3.1740901525.git.gitgitgadget@gmail.com>
 <c03192bc-68d3-4645-9bd3-93a338a7496f@gmail.com>
 <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
Content-Language: en-US
In-Reply-To: <2323bb52-f43d-4f40-8955-4c648677a93e@mandelberg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi David

On 02/03/2025 20:34, David Mandelberg wrote:
> Op 2025-03-02 om 09:17 schreef Phillip Wood:
>> On 02/03/2025 07:45, David Mandelberg via GitGitGadget wrote:
>>> From: David Mandelberg <david@mandelberg.org>
>>>
>> This sounds like a useful improvement and I like the idea, but I think 
>> running "git for-each-ref" once for each remote is not going to scale 
>> very well for people who have a lot of remotes. I think it would be 
>> better to try and strip "refs/remote/$remote/" outside of "git for- 
>> each- ref". I've not tested it but I think something like
> 
> Good point, I hadn't thought of that. Do you have a rough estimate of 
> what "a lot of remotes" is? 100ish, maybe?

I'm not really sure what a "large" number looks like for people who 
track a lot of repositories. On windows forking is pretty slow (our 
shell-based test suite is incredibly slow on that platform) so I think 
it makes sense to try and avoid adding new processes.

> I'd like to do some testing 
> to get actual performance numbers before trying to optimize this, 
> because I think the optimization has some drawbacks, see below.
> 
> If optimization is needed, another approach is to parallelize the forks:
> 
> {
>      local fer_pids=
>      for ...
>      do
>          __git for-each-ref ... &
>          fer_pids="$fer_pids $!"
>      done
>      test -z "$fer_pids" || wait $fer_pids
> } | sort | uniq -u
> 
> That might cause spikes in cpu/memory/disk usage that aren't ideal though.

Yes, if there were a 100 remotes that's a bit of a fork-bomb.

>> local sed_cmd=
>> local remote
>> # ref names and therefore remote names cannot contain '*?[]^' so we
>> # only need to escape '.$/'. Using 'sort -r' means that if there is a
>> # remote called "github" and another called "github/alice" we will try
>> # and strip "github/alice" first.
>> for remote in $(__git_remotes | sort -r)
>> do
>>      remote="${remote//./\\./}"
>>      remote="${remote//\$/\\\$/}"
>>      remote="${remote//\//\\\//}"
> 
> Just FYI since it took me hours to figure this out myself: I think this 
> would break tests on macos because of an old version of bash that 
> handles backslashes weirdly. I think removing the double quotes would 
> work around that issue, and be safe because word splitting doesn't 
> happen in assignments.

Thanks, I'm not familiar with bash's extensions to parameter 
substitution. The completions can also but used under zsh 
(git-completion.zsh is pretty much abandoned I think) but it looks like 
bash and zsh agree on this expansion.

>>      sed_cmd="${sed_cmd} -e s/^refs\/remotes\/$remote\/// -e t"
>> done
> 
> Mostly just a note to myself if I end up using this idea: I think a 
> space in $remote would break this because bash would split up the arg to 
> sed. There's probably some way to fix that with extra escaping though?

I should have said in the comment above that ref names cannot contain 
space, tab, newline etc. so we don't have to worry about the shell's 
word splitting splitting the patterns. They cannot contain backslashes 
either.

>> __git for-each-ref --format="$fer_pfx$sfx" \
>>      ${GIT_COMPLETION_IGNORE_CASE+--ignore-case} \
>>      "refs/remotes/*/$cur_*" "refs/remotes/*/$cur_*/**" |
> 
> This would search for $cur_ in the wrong place because * only matches 
> one path component, right? Changing to ** might help, but then it would 
> match in places more it shouldn't.

Oh, good point I'd missed that. Could we change sed to run with '-n' and 
generate an expression that looks like

     -e s|^refs/remotes/$remote/\($cur_\)|\1|p -e t

with the appropriate escaping of $remote and $cur_ so that we only print 
the output of for-each-ref that matches $cur_?

Best Wishes

Phillip

>> sed $sed_cmd | sort -u
>>
>> should work and means we're only forking three extra processes no 
>> matter how many remotes the user has. I'm not sure if it changes the 
>> output order when GIT_COMPLETION_IGNORE_CASE is set though.
>>
>> Best Wishes
>>
>> Phillip
> 

