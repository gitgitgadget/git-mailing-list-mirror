Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C658288A
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 13:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712928921; cv=none; b=Abk8yIRep33qN40d4CHpzjeJRsUGGp+zeqycG1bqzHz8+/QkLmQcjYB0Hh4Y8rf87nAkYQQYfDoKUejynoUt3sZTHP2sPYhyZabFGhPQgoJmb8dkomMBKVsSTPwWW8QgqYCcebAMux8IQX4eMAVKIQ80JDa0IFpdH4Tj8iCjtGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712928921; c=relaxed/simple;
	bh=teER/1KvH5RjMVY5RAIh1Id7qkuMvi/PTu4edKgcpC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kocrbvYQCYOsmXr5Gfvl95fpKARMBYfzsM5D66tkUO0+cFab8/ONLUJerIYMBZkSqI6FJLaXvjcs3id7TFLSJCAQUFJ6Bxz+6Ni/7JOLG8RSvLwywTuErO2Wd183iuhloA+3V2bdCudU0Av2FYLcdykYhm3H717XW7WAbjmitjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ekgK4gSg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekgK4gSg"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4180e794579so1606865e9.1
        for <git@vger.kernel.org>; Fri, 12 Apr 2024 06:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712928918; x=1713533718; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1WbKTs1qu6Ec+mL4G6aUAMdN2egrDpFlF/YDvHIIR7I=;
        b=ekgK4gSgUvawZo040/uQO6NdjhiAZyizosY67WTdGETCeeyJxMK07OzGfSrJrV9zIm
         /RecKzO/La/bdCS5HAaRNYdI7rD7BWbaELI8bpWgNLfGiOVF5kN9cXEIRiJ9zh69IeQ7
         2gmotleyJ23nUjFsRjVm8vBvYQIbnGPpQNycQQfM9qSaDPsCXZjRRoVRcMUtk1L+KpvN
         pBcOHeSPIC6nuBaNDgYf557EDyAyiAgkLELGEYQqD0R2rcSd9yaIEe4bYbzmOHkwg3gx
         JdKJnhI6PgcRbqF4gtxk3Mkpe7Pms3A3xXLV+ROmKoPHY6yv188MAuWqYa2XRGBn1rKf
         0CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712928918; x=1713533718;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1WbKTs1qu6Ec+mL4G6aUAMdN2egrDpFlF/YDvHIIR7I=;
        b=Q79gKXazwImPOiKVkbUtfqOXB8AbQhMeUMLK2zx8ORhKp1/lEq9Zf1UZ8p6BTlSRQr
         ZNbQrO/nzI8wYNblQSbDIo4iz0MiF4uRJcp29dOVr/Q+vnOCfDQMdL1tYS6ISAbZ0Wrk
         gkn7sDcmLtDBOnVvyvYcCzWqy+lzTjAEDZyjBe0DoSVeGuMb87/sbe5HSLHw6xMCPBDo
         FP2YKe7e8c+mrFSO8fKPpd1EMBNvvlFc5hckARP4ak2VPDymBEUvaD19trGnEUcAtz3B
         qlXuH3tgR7bhpQOpKFmOqQjsDvtTVnFFtFsd4BQ3SD6zb2BR32jm6sKqNcqFrqrpo+YX
         X6Mg==
X-Forwarded-Encrypted: i=1; AJvYcCXuF5vs1Gtdd0+RLjDiwc3zaggqrAzzsY/dAw4m6c+JsJ4Mk9PzH+RUfi5B6TGdXv+lwONT97AW9vOF21bWaWTwVBjH
X-Gm-Message-State: AOJu0YxMR7QBL2rkjRbtHpmEPHAF7NKSppzCYLge5Hza7BRpEOyktSZJ
	p9lnSAGaaypJpaptntIYiVwlrcoaM0ad0s0pUWNZKlbQ0GRDlNN7cr+pMQ==
X-Google-Smtp-Source: AGHT+IFQDib9tU+q/0QAtJR3XE/tJWJd08Z2BIfU0o/BaYrgAW3Mv1K8wQt0pLiVCSNBl9hdH4Eh9A==
X-Received: by 2002:a05:600c:3582:b0:416:9cf8:cf05 with SMTP id p2-20020a05600c358200b004169cf8cf05mr2207303wmq.18.1712928918235;
        Fri, 12 Apr 2024 06:35:18 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:68c:c401:12ba:addc:3daa:a3e? ([2a0a:ef40:68c:c401:12ba:addc:3daa:a3e])
        by smtp.gmail.com with ESMTPSA id bh14-20020a05600c3d0e00b00417d9360114sm5278688wmb.10.2024.04.12.06.35.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:35:17 -0700 (PDT)
Message-ID: <668a443f-8b44-45a9-ae2d-ef3e429456ef@gmail.com>
Date: Fri, 12 Apr 2024 14:35:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC] bisect: Introduce skip-when to automatically skip commits
To: Junio C Hamano <gitster@pobox.com>
Cc: Olliver Schinagl <oliver@schinagl.nl>, phillip.wood@dunelm.org.uk,
 git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
 Stefan Haller <lists@haller-berlin.de>
References: <20240330081026.362962-2-oliver@schinagl.nl>
 <864b0f22-b07b-469b-8fc2-56940fd89a8b@schinagl.nl>
 <xmqqcyr3s3gj.fsf@gitster.g>
 <b194ba7c-454b-494f-bef2-e9eac7ca87f1@schinagl.nl>
 <4bedcad2-218a-4b16-88a7-cc70cc126af3@gmail.com>
 <6dd4a5a4-9999-4c04-a854-09fc238c91bb@schinagl.nl>
 <d10bd772-2cf1-4838-bec2-ea2a639cabab@gmail.com>
 <2542ebd6-11ce-496b-b10b-b55c3a211705@schinagl.nl>
 <c4ed3e05-ae9f-42dd-835e-a52e710e70fd@gmail.com> <xmqqzfu3dcl1.fsf@gitster.g>
From: Phillip Wood <phillip.wood123@gmail.com>
Content-Language: en-US
In-Reply-To: <xmqqzfu3dcl1.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Junio

On 08/04/2024 17:49, Junio C Hamano wrote:
> phillip.wood123@gmail.com writes:
 >
> Having said that, a post-checkout script and pre-resume script may
> have a huge value in helping those whose tests cannot be automated
> (in other words, they cannot do "git bisect run") when they need to
> tweak the working tree during bisection.  We all have seen, during a
> bisection session that spans a segment of history that has another
> bug that affects our test *but* is orthogonal to the bug we are
> chasing, that we "cherry-pick --no-commit" the fix for that other
> problem inside "git bisect run" script.  It might look something
> like
> 
>      #!/bin/sh
>      if git merge-base --is-ancestor $the_other_bug HEAD
>      then
> 	# we need the fix
> 	git cherry-pick --no-commit $fix_for_the_other_bug ||
> 	exit 125
>      fi
> 
>      make test
>      status=$?
>      git reset --hard ;# undo the cherry-pick
>      exit $status

I like this suggestion. A generalized post-checkout script that prepares 
the wortree and can indicate that this commit should be skipped could be 
really useful. When having to test manually being able to automate 
building each checkout would be convenient even if one does not have an 
orthogonal bug to worry about.

Best Wishes

Phillip
