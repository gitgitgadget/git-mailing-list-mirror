Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3838A244660
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457067; cv=none; b=qZzjJTNI4Sr/4mLQkJtR8Ap/KkXKA/yU7jIul5ymi/VXGiFl9dYkDoPoYTRdZMVOGnllTxUxIbwE0RLb+2bNyktGjDA7SRRTpGSDEI4JcLseiu/vLpu9xDhfaPF9hOrDSngEH6PUQ0xXdgMjL51+79duYjaEYHhup5vTxNFdHqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457067; c=relaxed/simple;
	bh=bgvrTHAHp80t8ZtH83s9h2RA8yz94gPQVbXrr2Qaixo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=laR33DayMMhJMS3Gf8+6k6OW5lBILkwd+TaMsvo4pvnr8A0XGJnw1bo33fHpVnrTXTACpVIPfSKxJZhjYRYUXn9/Ppi8gRvANGhnISuBv3xnjUwrcfiu1423p2PhEYIz8wrLmJF64yyrvVv16Kd7+BOl2518Fkm6XQ8k31RCdGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYyvCBT4; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYyvCBT4"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-486fe655187so681455e9.2
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457065; x=1775061865; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3VqCGC9kQ+2jrnxX0CIUTNC4FxTJmmeLA17Ro5Ccqc8=;
        b=lYyvCBT41/QDUkZI0UQepx0UAwmCkBGfeg3wPBhgucZx7a/oBkNovCLUhP8gxyOMPM
         mxZil3rz1n28gsW6YlP1QMaU+t7exmcF2db7iMREeHbMIMdw5qrUs3KM/FkpD7AxrxSL
         ZVlCaPxeCvZvIziFkB5RCWFzXMa7Ns6RKHFKaiiFZfC/qdVLvcwsg0VbT7smRIx0sFDk
         RKwLWkHkHw48SZbHJW6LJBRlGGaqr5FqWot3LkS2ABWDD0cxXJZLUa5L8wdt6hm2eEBQ
         nOZsxtZrWYpmwcZLfj7cS+/AARFEGsGwnfTV6jYWA7bFuTXTbNdhVdE9AomSHzvBnOlD
         /iww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457065; x=1775061865;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3VqCGC9kQ+2jrnxX0CIUTNC4FxTJmmeLA17Ro5Ccqc8=;
        b=bb7rECNfaVl9diAguB9tAJVvCnrMSlSyLKy9PjtlhGIdquDMB0uzX25swaBCg6Fdb3
         CMShQGD25ljGreEqFpYmXDMx2ScWHPz1oidtehdJBgk3bpW8Dcm2L1KqGihTKsJeTNQj
         zhKKG0dinzADtuLTbo3dawpBa2VO/eiwW2Yf32GfNzfX1jSdz4ZTSUsxtK+2KDHREXmt
         JmXxDHPkaosxW0QlOo4XW1XN3nNfk3PH5Y+CvZme8Nh1lOMtN9ag9hK9cI4H9LaKOB8A
         WEaf7nQykyQFi7pIjhDUB43ExptjT6u1j4XYCNG1nKsy860J9xCtAQspsPXM6Go9lu3p
         e7Og==
X-Gm-Message-State: AOJu0Yxma16FfCCduy/Lqgwfsfy4h/lpAR9HyXdTGqmL57PSqW2URX1u
	uX87zow7Nan6au+wU09qbV0mYAVIHShGPsBW3umgRIuHKGzthKguk3xF
X-Gm-Gg: ATEYQzw0Z30t1GdEElMzFQHVO2Vb54iwaKGbo+7ySFs7kSk97GrZrsJRyWBe6BwmsXH
	XG7QJ4W96lNgrtcYqp4IlQZKedEOAj7Vnp947t6K/DDlyxeWFNO2lxjgKD+mR+Y8a/6BQFN66j1
	OK9ISTdvEdq7WlYVLhSr1HCzac79X69dUhl6UAGzRhA9T3OpuMpP9bT696v3JBVXTM0s1MhLNRE
	KfXksUV5jdMhhA1aFm0H4iJGZcljHTmfMT/CpqIcdYAJd1ZT23oPExs+wkmOZI4B06Lr/iNmrxK
	13IvmDpx21qunbMRrrSYotY8MWVrdG90V478uZ25cZnhrfPMam8k+4ep7karGLIC/9hZX6pDP9h
	bfMt8nVNZOXuZ6Qp48pT7iKldZzSnE/vPLSU9Bl1HO1kLYsaUM+/ZIqqoWqiO1IOYQdxm8kRdj4
	sWFIhgQBUKyef++ksV+ypVRlxFtizNeooOaXqT44ASQso7FaYbAdrf81ooo0/+D8/0PPIWUFnbv
	eYk/ZFa2Ng9SIqc
X-Received: by 2002:a05:600c:34ca:b0:485:3a27:a960 with SMTP id 5b1f17b1804b1-48715f0369fmr63665515e9.0.1774457064475;
        Wed, 25 Mar 2026 09:44:24 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1785:c801:9102:504:16e7:c44e? ([2a0a:ef40:1785:c801:9102:504:16e7:c44e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4871e5ec998sm6576795e9.6.2026.03.25.09.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 09:44:23 -0700 (PDT)
Message-ID: <56632ad9-d953-4884-858c-038448f30a1d@gmail.com>
Date: Wed, 25 Mar 2026 16:44:13 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 2/2] replay: add --revert mode to reverse commit
 changes
To: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, ps@pks.im,
 newren@gmail.com, karthik.188@gmail.com, johannes.schindelin@gmx.de
References: <20260313054035.26605-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260324220401.47040-3-siddharthasthana31@gmail.com>
 <xmqqh5q4xvyw.fsf@gitster.g> <87cy0s0wt5.fsf@iotcl.com>
Content-Language: en-US
In-Reply-To: <87cy0s0wt5.fsf@iotcl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 25/03/2026 15:10, Toon Claes wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Siddharth Asthana <siddharthasthana31@gmail.com> writes:
>>
>>> diff --git a/builtin/replay.c b/builtin/replay.c
>>> index 2cdde830a8..d3c1d920f0 100644
>>> --- a/builtin/replay.c
>>> +++ b/builtin/replay.c
>>> @@ -83,7 +83,7 @@ int cmd_replay(int argc,
>>> ...
>>>   	/* Parse ref action mode from command line or config */
>>>   	ref_mode = get_ref_action_mode(repo, ref_action);
>>>   
>>> +	/*
>>> +	 * Cherry-pick/rebase need oldest-first ordering so that each
>>> +	 * replayed commit can build on its already-replayed parent.
>>> +	 * Revert needs newest-first ordering (like git revert) to
>>> +	 * reduce conflicts by peeling off changes from the top.
>>> +	 */
>>> +	int desired_reverse = !opts.revert;
>>> +
>>
>> Compiler notices -Werror=declaration-after-statement error here.
> 
> That's basically the only comment I have on this series.

Yes, everything else in the range-diff looks good to me

Thanks

Phillip

> Except for one micro-hit on the existing docs about <revision-range>:
> 
>      <revision-range>::
>      	Range of commits to replay; see "Specifying Ranges" in
>      	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
>      	range should have a single tip, so that it's clear to which tip the
>      	advanced <branch> should point. Any commits in the range whose
>      	changes are already present in the branch the commits are being
>      	replayed onto will be dropped.
> 
> Next to --advance, we should also mention --revert. But that's totally
> not worth a reroll and can be addressed in any other later series.
> 

