Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB9B1DB125
	for <git@vger.kernel.org>; Mon, 29 Sep 2025 21:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759180801; cv=none; b=Nwizt9SgSGKReqbJPxtZ+SkQxXjwkk+TtHh+TT2eC1KuxwjHzNbzB4rKljBdaRI5iWJCLhOHrZubEDgiN+TOPdW7DiS/C2OJuZuS/ml1h4RjDPlfoo/leUP8TtZZaLx2rWtSMcktgNy2IFT7NIKQM02Td3Dh+Fm2t2htrSp4BLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759180801; c=relaxed/simple;
	bh=HCX3m3iEgMCw7YrhBcG5WvqEk1uRmzJbJQezhoWx1e8=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=awiACQw1OCm/hcpTWihIS30klneiZAxTuV700sdsNTL9rB9gH/DA/Y1rBdVIHt3jOMmfXByKUbBggTPsJe4gbJwqyPbVjSxrUB0fbRT8XAVg+20TXz5KpjPwmQt8P684tfNpKeM8YUZOd1iFG04wnOgRKmNF5ZIU+L1GC09NEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf2mdEoA; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf2mdEoA"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-71d6051aeafso54395127b3.2
        for <git@vger.kernel.org>; Mon, 29 Sep 2025 14:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759180798; x=1759785598; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIPtMY5JgBaVKF0Ixaz0KV+bbo0XCoVYHXqz13HZfUc=;
        b=Zf2mdEoAqof51hLKNicrpFY8oIeW40vzBwpkXofGIkwYKyGigf/AW/x+24jqaJHJYP
         RLQ8k/8z6I2qOl/W8jNVFd+lFcS7m6hbUZaUWRfUYLrKjQv39Ky3L/alprnyilragsJ7
         UH/nnvvvnFuAvlQ1a7pvOcxD8i0z7j+3Yu8E2xt2g8em8O38gyvsCt2uOxt9OEmpRIKA
         ux7Eu6GuStpj0BDXyeswz1Zwk9GROUbsX4NUJvxAGz4qwBkapAl9kIaalQ5khdRJL6tC
         NQ5BlAIVyVkrfdrxql31qPkCkoWNDKKOzeZL4DVbOZspIO8A6SoHdX9piHAWkKSi1WlH
         3k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759180798; x=1759785598;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIPtMY5JgBaVKF0Ixaz0KV+bbo0XCoVYHXqz13HZfUc=;
        b=kXpEpYZ+sCOs/5hzA4U2UO7Cl70RNAc86VVa9Gahs+Yox9hfxkLTuWnX4KyWaesFQe
         ik1WquNoxccPcD5bojlge4cJx6ptzRER+7n3Fp2HBQGywBXm8jZX+RswMjj3CQ7k+9sb
         5sI8U1r6c7xTxUY59q5z8c/z994BBB9OkYE+Je7olMN46+QagaeStip8LzXuxzmw9rfL
         F+lwcmmRMWVlLIOlCANkaGmUZn+LSPqNs54Zq1v/H/2w2HkMHw1NM1aSK+hMOg8QvpKU
         tntUIsYUTigzqgqSAklpsgvupmNDxuBBP2qycAawom68FM1wSyrZ9sdiWKsBqJSTl75W
         fW7A==
X-Forwarded-Encrypted: i=1; AJvYcCWmh0evGDU6TYl1o7GpnFLkapbT/NIWQ9qHZFwUftRev/5qDUZQ/73q5XwKLbPmNqhDeSY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU3ljQiwPh+z0mIertwWcjx92oq75VaWwwDocc2V21uEERUguB
	m25wAGGqboGmr+M6As+GwIFFQ4RCUUQAzOzdaq5Qlyxcm2QioeLJBa43sRTe5x+c
X-Gm-Gg: ASbGncuu1Esc0IlC/oxO3bBrVIxA+YhMh7jnA8tuUuPX8Qt8tGNRu/D2fXmuxvY5AfY
	pzPhW+7So28l4rQQZb7GoAy0+EiZLXeDLbHOBGmA/Uf0/6aPb2AOtUMRiJDkgmavMO7Wt/W2BW+
	PCkoo7/Oif5FXeSFegqhxZhK7xzsDKW4fcEBimajSkHaRJPa/OeH2KcITvmIQPdmfaD2N3CKB7g
	CUvYoYlRa3KJMbnLcEEOe0RxN1YejMUK47Ktat8Klf7p0CZYpeYAn+8dVCmQSCdwczbPfFCKHBx
	9lcxNU5DB5pPgdA0q1MIt8CvdybDKFjy/tFOepz1wdQuCmET7CnhLXxnUoutDZ3wgVgXTCJe5vy
	NR2YMInTCRN06gJdi2zNFqV3Gmge6unvt1krzU9WhzmTsPqNS6Cw=
X-Google-Smtp-Source: AGHT+IH6wMTAsAjEQrR//z2juBs7MflG1/v1zXnTDwbGya85MAHErtzK/Pdx3Jq/Nval2xxKmzsRMA==
X-Received: by 2002:a05:690c:4808:b0:772:a175:8b75 with SMTP id 00721157ae682-772a175b577mr133147477b3.13.1759180798218;
        Mon, 29 Sep 2025 14:19:58 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a8:8b00:e8c8:f46d:5858:5703])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-765c7da8385sm31707777b3.60.2025.09.29.14.19.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Sep 2025 14:19:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC] How to accellerate the patch flow (or should we?)
Date: Mon, 29 Sep 2025 17:19:47 -0400
Message-Id: <B0E6ED38-85AB-4D8B-BC72-9056086A28E5@gmail.com>
References: <b583b17e-96a5-4f22-8cc4-acbd3dfec82b@app.fastmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
 git@vger.kernel.org
In-Reply-To: <b583b17e-96a5-4f22-8cc4-acbd3dfec82b@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 29 sept. 2025 =C3=A0 16:13, Kristoffer Haugsbakk <kristofferhaugsbakk@f=
astmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFOn Sat, Sep 27, 2025, at 23:32, Taylor Blau wrote:
>>> On Fri, Sep 26, 2025 at 03:24:04PM -0700, Junio C Hamano wrote:
>>> 4. While the above cycle is running, the maintainer may queue it in
>>>    'seen', for two purposes.  (1) not to lose sight and forget
>>>    about the change.  (2) to catch potential conflicts and overlaps
>>>    with other in-flight topics to keep their interaction manageable.
>>=20
>> Perhaps a third purpose is to let the maintainer (or those who use
>> and/or build off of 'seen' as their daily driver) detect any bugs in
>> that topic, or via interaction with other topics in 'seen'.
>>=20
>>> The time taken during 7. is pretty much fixed and unless we are
>>> willing to sacrifice the quality of the end result, cannot
>>> reasonably be shortened (note that this is based on the assumption
>>> that "find any remaining bugs while it is in 'next' before it hits
>>> 'master'" philosophy is working, but we have never run experiments
>>> to shorten this to say 3 days to see if we see more bugs on 'master'
>>> yet).
>>=20
>> I have mixed feelings about this. On the one hand, I am a little
>> uncomfortable with the idea of shortening the time in 'next' to fewer
>> than 7 days. I, too, have the feeling that having more time in 'next'
>> gives us a greater chance of spotting bugs in a topic that is otherwise
>> destined for 'master'.
>>=20
>> On the other hand, how many people are using 'next' as their daily
>> driver? Of those, how many are actively looking for bugs in the topics
>> that are in master..next. And of those, how many are actually triggering
>> unique code paths that would expose those bugs in the first place?
>=20
> Theoretically all the projects that make heavy use of git(1) could run
> `next` (and `master`) as an alternative configuration of their
> integration tests.

This reminds me of crater from Rust: could we work with know =E2=80=9Cbig us=
ers=E2=80=9D in the ecosystems to run their tests against our next/master Gi=
t periodically? On every commit?
