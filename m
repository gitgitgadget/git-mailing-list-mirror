Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1FF330668
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 13:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530241; cv=none; b=T7RvnN+HCbRYTqUsFL7/2A8WAftZsXNMmSVaIMXIwbcxy+nS0Wv9WUv7ifuQ6Qyj3/IBA49fRf7SjYzViTud0lIW1L3/MQC69bs/yskXDgI7IMBh7vo18jmyZxgC1qzNxC5pqasajRfcreJzHLKLtDxGWMKk4w9UrVViypLP9SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530241; c=relaxed/simple;
	bh=qSD2G1hMFc2+9QUDgTb1aoePJwZDym8jWDs0k8Dbqb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=eB0hG+m/+SFxdFaAZizJk7vvpM48W0GMBnJxoNK83RAg+jUecngFKf4LyVReXRAyPhmay7GaV/VsRZ+IBFW//2Do2MlJjmbX8QCOAmD7VyzjaLIP43kiS3G9XCfPmXEpzKH8h3az6UluYATNsOXUl9ebnXb4pvHdHXNdYaSMIH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=copVlQVw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="copVlQVw"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c25344a8c6cso133200966b.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 06:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788530238; x=1789135038; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=t167sSW+yqBHxf+JAgYo/xxHru93Fm8IL09cOC7uuiA=;
        b=copVlQVwYhbH4qr+jo8UMcNCmx8qwtPDhfITNM50lwAw28ISwht2S4sCzWOS77McBq
         2xUIeW/gOmv58qwtmb4K5atGFzuWjXPaWtXTrlKHFhyqi2Gx4iHC7TmMbvYipIm0+Spz
         dGOcsPz4ehSSkBxVfaOqTPH+UQFa5Au4Ew4QagWEGjXECnWnayYXqUhYwhkrig4ttsO9
         66RrkJ5f6WdI1P+tjvbl59H0Flb6hhsIaBgo3dX43dXUEYCz0qeOVWGlk/znzw+pUXG2
         I/rokK4V5ml4lcQrbUr5zZm+9XEoSRVz0wrj2R9nMkX15tjMk7hRlhT3GiFte9PJ0ANz
         FKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788530238; x=1789135038;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=t167sSW+yqBHxf+JAgYo/xxHru93Fm8IL09cOC7uuiA=;
        b=SHYOs2ulyHZ5UqnHMvwveEWeb3WaBJ8Lbf+YaqXoajFLf1TYTbb7AWIBxTMHCJCbzs
         SppMY3PWQ2zjh0dBqTrywaxIPJlaenPvK8Yw+XfPnvV1LVipYzAy73+1Hj1L7suPTR3c
         dcLXADDBflrxM4sttVwCAUAke16jvczOicENqsHFFnemahofEX4nt9lFEV8YbgaT6xaq
         3GEiyEh/FBARRgMkBBvH8jb4WLZEeBH6RlktGIt1pkv0oFamXbBdCIovKTkSnL08hFWc
         mAGcit/fiz+QnOKQDNL1P3erx1YDZj0ANPakViPS16H3ANgixAvNKhfS1dd0xX+tNJrN
         Tedg==
X-Forwarded-Encrypted: i=1; AKwUvBzo46LrXtQ5nIA34NNCR9voS0Au1+lRvQP/Zz7A3bXKIHFQ69eLExhvsufm8YBcWjVjHqA=@vger.kernel.org
X-Gm-Message-State: AFuF++kBUHuwtfvMNdqUmQcaCEyzjJzlymHuuzFfpoVRaZpBgA+iB8dD
	5+1NWT/5D7SMDBlmg/AdNLhjJtnOraH9xwae/Xk8umyrqEtm//LbXxa6
X-Gm-Gg: AYBFou2+N0L5Pw2ZSozoJIYbH+DbGJmi4JCk9lJdxYeUkxCrjZkssmVBQoHv1FQ0rq4
	CyTllGCZmGPz+tV7me6RUMvZJQSJjTCBtwqd8gHWZYL5b3mPhaI1rDPBdIGNFIJuPOWwf1VIL5Q
	5LFIbxIL/TMDjwVa9JBywas0jMTMRzM5F3RkKVFHIhmoL/VoKnU4ht1BUIAjhwSD+VFFmq070dk
	UY7+0PeVwBqzBWclJm5WP61Gm+aHXtntTlXCsmupEByQiWtSkrUV6aUoNFgTtXYP0+VKdaE6FDB
	pJQ55yOy5X3MyMgkd5KDPIT4TG0VFpry7JOGLxsaqinr3+Xi8Bfrd16nU9J/9d3+gfSfFEPVLoy
	HkfGGrNkGHC7C8NhsynF82HkJdPW/Y4mwJ4SqLgpz92hGwcUiqAMU50S7329TCL6txo+0CjjeT7
	8veE1FTo6Vevhv6wWnUWm/Izec4ISZ6f+vZIPkY2OJsYaOQrgAt48kXp3Xjjw/3ztm6A5C+mokV
	byCI/2Sx3tPLVEdt15Zo+OCyINLyN0gbBbPT6vWm/4=
X-Received: by 2002:a17:907:dab:b0:c21:601:6501 with SMTP id a640c23a62f3a-c260ca32d8emr267868466b.20.1788530237924;
        Fri, 04 Sep 2026 06:57:17 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f? ([2a0a:ef40:724:6601:f3ff:aebc:61f8:d91f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588392b3esm7741151f8f.12.2026.09.04.06.57.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2026 06:57:17 -0700 (PDT)
Message-ID: <6d9595fc-6dc0-4bbc-b060-b34d782c6215@gmail.com>
Date: Fri, 4 Sep 2026 14:57:16 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting
 --no-commit
To: Aleksei Sviridkin <f@lex.la>, git@vger.kernel.org,
 Patrick Steinhardt <ps@pks.im>
References: <20260903125524.67889-1-f@lex.la>
 <5e77651d-38a1-451e-b96b-33c91c414eb5@gmail.com>
 <20260904124507.12977-1-f@lex.la>
Content-Language: en-US
From: Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20260904124507.12977-1-f@lex.la>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/09/2026 13:45, Aleksei Sviridkin wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>> What does pinning a test mean?
>> [...]
>> Using test_must_fail() here without checking the error message means
>> we don't verify the reason that the cherry-pick failed.
> 
> Dropped the test, so the wording goes with it. "pin" was jargon, sorry.
> 
> Your placement was the right one: the advice test is what tells us the
> pick stopped on a conflict, which the bare test_must_fail did not. But
> the clean-pick test at t3507:98 and the conflicting case share the
> !opts->no_commit guard, so the assertion had no coverage left to add.

I don't follow this at all - where is the existing check that 
CHERRY_PICK_HEAD does not exist when "git cherry-pick --no-commit" stops 
for conflicts? I was suggesting that we add a check for that to the test 
"advice from failed cherry-pick --no-commit", I'd forgotten when I wrote 
my earlier email that we have a helper function test_ref_missing() to do 
just that.

Thanks

Phillip
