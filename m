Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38521F957
	for <git@vger.kernel.org>; Fri, 14 Mar 2025 17:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741972578; cv=none; b=mQkav0QzP5P4BR4LKZo/FOaGkHwzgCaUGUuIO0G5bjbFCWt8EWaRq9aZV6jggl8sFL/mM+9Mxk8MHTHDBP4Jq3M8tvF6cQSFbu399Ufc8Rh6/UJFetnvE5Pz+nA0MvPfL30cKakSYEcjAfhD+lwxFL5efeoNtX1DCYCGQt2xTjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741972578; c=relaxed/simple;
	bh=j93y7QZZciPOpJkJuJqUfdCj/oHgY2+pFwLXO/LYi88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YW0usgbdla3y2pkxXiWZ+gam6QhyGDj7ktBDV5T9QNpjohTweDjFcnTyML+jJlsEjdDOZ0ElunbdR9Z3ZPr799jLTe5i3N6ACv5QqNp5HlOZEmYBZWGFtWdvzdbXQFMkJw8M9tDuPelZX/HOcMb2HCIvkLwdB38DMv9ZYRcBAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HpeN0NBS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HpeN0NBS"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3014ae35534so2289443a91.0
        for <git@vger.kernel.org>; Fri, 14 Mar 2025 10:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741972575; x=1742577375; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0734PcBYik1QXk3JdXI+B/UC2Ji4iPHIcbEvVLAvZBk=;
        b=HpeN0NBSJ/BxJmzwUYfGFcd870GtZN7y8uWU3UrzE2o5QgTHUQmph7pVzS1cPnrqDS
         dqmTTGrgxJ26uXKhWxquzUrPYkDRddl4K/cgXBPTtXXu7chS0TImTStaM2L5m29zDcYr
         HFG23ChKwctTYsB/O/+/YF3eKr66gtUWY+4LBQdClckRmZrQhOusx1c0WKfWM84x7HBG
         XaCqN59ivs7Ifn8zEVDbUMEUJR2yyjyahuLVEyBf34UIIC61v9rAGBRcCQ8tktdMHh3t
         g109ibBOIciPVV9yBzIH8lvUnjuXzfoJSoyPPKpyKqjvtBWDFtCtrCgT3f6XvhHFKyd/
         vPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741972575; x=1742577375;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0734PcBYik1QXk3JdXI+B/UC2Ji4iPHIcbEvVLAvZBk=;
        b=p/JM7Ph4w2a9EBK8UWX5BM09sC1321GIZWvgiQTGEN6PMRr91vNi6yjBatBpXhnqgK
         OPOZEwbgJEqJlW/wgC0Zg+kh31+zi8OMEF04hmm0kufzLQ4NHEvfcqRytOvqR74VvuRt
         hImLucTAMr9vgIdBsnopbFD6RKL2wakr8p4d3H+blluUHgBnHaxaKXI67hsQzKIyCtkA
         kL+f5iwQJLxeZJUgcg0/tsi5fn7Maa48zEXDselFXf7G6wjmEDnfVSL0Ny9YsBoK1TvJ
         a6DhPLSMIDGY4JDsIxHLMGP6iRbd11HjVxy2IXwRyxM7ylvl/WLOD8L4wfiUVPkRQt7u
         A9gA==
X-Gm-Message-State: AOJu0Yw9BXB0tUd4h2VGJOJUPZ4YzPo5TftCaQNIgzyy/67iAb2wrbnK
	KAtHlc0zUVIe5bBnTaS1LgAZO+6gZ8tnbcB7RbIM64X401RJBPHStuiFNXdNGj3qOjVXwL/F6X4
	Iud0hbwYHWGtJ6DqW3cXbd4+CR64=
X-Gm-Gg: ASbGncsZT4TVdaQ+pzJvnLzcqKb39xlc+SqOn6y/h+Qo+tY1Xhy2THtuwhKnohQ1kqB
	ErdJh6GTmkeTnyfjZDaL4TmVdhi9DwbUNZjYmMf38M64r2RSolCFYuxn/3xyNSu1aIc9PqBsKdj
	PtUWiQGdVOJh9vqJcn20z4R+tgCy2/4pO6pZ0wh1UG/98AJnCNBH7Qt8oQ+OU=
X-Google-Smtp-Source: AGHT+IETmrjU6SdyKTcwERVOZGaIvh1QunH5a9y2K8TjA1DC68vLR0gXp4DdE2dvsKouttmpAgC/PpnxAfpuv2WOSeU=
X-Received: by 2002:a17:90b:3fc7:b0:2fe:ba7f:8032 with SMTP id
 98e67ed59e1d1-30151c9cb5bmr4718694a91.9.1741972574759; Fri, 14 Mar 2025
 10:16:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
In-Reply-To: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 14 Mar 2025 10:16:02 -0700
X-Gm-Features: AQ5f1JohoCoT1HliZsF-zc8kzD-6koCMANoO8gRvPemL1yzaS2Fhva6EX2ccy0c
Message-ID: <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com>
Subject: Re: `--ancestry-path` documentation has wrong graph
To: Han Jiang <jhcarl0814@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 2:04=E2=80=AFPM Han Jiang <jhcarl0814@gmail.com> wr=
ote:
>
> Git - git-log Documentation --ancestry-path[=3D<commit>]
> https://git-scm.com/docs/git-log#Documentation/git-log.txt---ancestry-pat=
hltcommitgt-1
>
> The graph for `--ancestry-path=3DH D..M` should contain commit C.

Indeed; D..H contains C, and C is an ancestor of H.  I apparently
overlooked C in that example when writing that documentation.  Would
you like to submit a patch, or would you like me to do so and record
you as the reporter?  I'm fine with either, but if you want to give it
a try, the relevant file is Documentation/rev-list-options.adoc in the
repository.
