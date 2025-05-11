Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E72B9BF
	for <git@vger.kernel.org>; Sun, 11 May 2025 04:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746937153; cv=none; b=vEU4ZCZNQaOxUvFlA6K8DwXjsM4zfivqKCfUXKEv3mOeEoLiGkP9vBRgvKni9S9HVKlwWzNS+oDryqEmlLO0Ou972CGgF0skksG6GFbqZrdyPVfX7EBc0GU1sRMWJmG6FHt4zpZjLtrRpryj5Q9eAVkDmHybWx8fhAKiXqeB8RQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746937153; c=relaxed/simple;
	bh=KkiJAKOSaIaS5PjEW82XxAdZLvKp6Oz27MAzUTmvX6Q=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type; b=iogbUhLZuH9vs1Y/YNhayxo04QYnalYkZ0NYkmRCSCi9vtZZdjjr1iYaxq189+gjQe+BGXV7u3AYhT40BvAbZ9yZ/M/5dEc92RiqW2Nw2u8qbz5/pF7pvtScHEKD4pVHVCwukRZF6k5iLnBK2hcEH6nuql4Ou6IUAAcSSskvxD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mz3qBK82; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mz3qBK82"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-30a93117e1bso4541382a91.1
        for <git@vger.kernel.org>; Sat, 10 May 2025 21:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746937151; x=1747541951; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uDJ/xIhEfcSr0hQw9Z4pqjHkhOOUZjNPMVV2i3H81ow=;
        b=Mz3qBK828QyjK+78yi71n4xnupIrhy28cW1L0/m1sLduKiaNa7UstxMoDn4FfFat6C
         3aIm3gNg+MBJnMHklDbNzvdPERf/ShJk22cT7bpcraoRmFJeeLBV/BLiABtYP+r4JmEK
         1EZiAc2HNNyDVvVYpb4Wl5EG8IsE2VrJ6d03Olak54HiEN6d/3ptF7Tt2CENQLoOMa5i
         Ola0Yke7J1ckfSznEEzDuXopQjwW/Yksl345+o72Trkj2OqH+Fp0gIQnJcMJ8CGIt0nk
         V5pW6n3/NFcuEiISlHM3ZqK+9cyucy95bf+JPpCzRRQewxenricfNr1mxFZZnty5S9x6
         JPSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746937151; x=1747541951;
        h=content-transfer-encoding:mime-version:message-id:user-agent
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDJ/xIhEfcSr0hQw9Z4pqjHkhOOUZjNPMVV2i3H81ow=;
        b=dYegyZegwSoolgfE9EAE++bx7iHjdExesCQ/TILQ3Mo4VYCUaq9jEQCk0ZjihLjuTR
         a2M2P5yrDsYao66tBNz7nUbVmn6eQnHRmZHKhJCy2npQKphW69b3dTsBQL7BvgJoqqMT
         Wc0HcIfzfADR+rPJ2m2Xpvl2GpT8Iv0l/tXeM113c7S9h22O5RkRi4W4bqCWJVXkefhR
         yfL0ckeYE0NI9FlGPG70w38Q/0RBSUM1diivL0x9bpgAllPFsOnO+EgEymtfJBrz7hAH
         z3uIDCP8mtV2qieExgZByfveWjX30FQozY+OD0k02U2tzmuQptQRt3kSKDqB0ApUSmMl
         BTNA==
X-Gm-Message-State: AOJu0YzU4ExCQCDf5LywCiuH3Enyp5xocjQmJVpOcEDsW15TA1Bb59TK
	q/V40CSXoe4X8GwnlqZbbNy3Ca8uRqGRPGv7kyPIOAsV6/YTvKp85GrdLg==
X-Gm-Gg: ASbGncvYVV23q9vL/x3kmXqBu3WhQcAHlQwPjB6oo3QtVd5gML6F6toJX+9fKEcZx76
	i08wkvE0sqezH02IoTK9gj41EXiwfV8ID507Mptj6gtajClIFtYNpmzr+neIo1sJr+VhEJHki7C
	AIV3CRXbHWIwa6QgHM1jiVWBfb0LoRl/xdcNxbEyw3WFXRK+e1+o+Bf6yGpnc7GEBc2rbNil1hb
	OX6q4bnKnK0f7nuEkAG3I7Rl8FYutCGLHElUghCyNa77F/lVbSPYtEX7Mg/IXd/VxMvVNI/ffQs
	uvqcfnSfA4k5u9YEZARxh+2xGYOInjWSD2GK4hxBKrGX2U3osF6k2zfXDw7oZx0=
X-Google-Smtp-Source: AGHT+IGvHrmg77LfbQ8baL6dKbmUIgktvN+1MlYSdbJyc7hwLyCY1WlP1pUsjP0jcdbixxSi1a3Xrw==
X-Received: by 2002:a17:90b:3903:b0:309:fd87:821d with SMTP id 98e67ed59e1d1-30c3d64c1e4mr14263013a91.29.1746937150842;
        Sat, 10 May 2025 21:19:10 -0700 (PDT)
Received: from ?IPv6:::1? ([2401:4900:4ace:3778:59aa:dc7e:a28f:3b69])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b234ad4205dsm3522890a12.44.2025.05.10.21.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 May 2025 21:19:10 -0700 (PDT)
Date: Sun, 11 May 2025 09:49:07 +0530
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To: Git Mailing List <git@vger.kernel.org>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Meet Soni <meetsoni3017@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
CC: Christian Couder <christian.couder@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Karthik Nayak <karthik.188@gmail.com>,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Jialuo She <shejialuo@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [GSoC] Welcoming our 2025 contributors and thanking our applicants
User-Agent: K-9 Mail for Android
Message-ID: <A2C60325-F96A-49FC-8910-035BFC209EB5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello all,

As you may be aware, the results for GSoC 2025 have been officially=20
announced[1]=2E We have 3 contributors contributing to Git this year[2]=2E=
=20
They are as follows:


  - Ayush Chandekar

    Project: Refactoring in order to reduce Git=E2=80=99s global state
    Mentors: Christian Couder, Ghanshyam Thakkar

  - Lucas Seiki Oshiro

    Project: Machine-Readable Repository Information Query Tool
    Mentors: Karthik Nayak, Patrick Steinhardt

  - Meet Soni

    Project: Consolidate ref-related functionality into git-refs
    Mentors: Patrick Steinhardt, Jialuo She


Let us welcome them and wish them a good summer of contributing to Git=20
via GSoC!

Thank you to all the contibutors who applied to Git this year! It was=20
a bit tough to choose from multiple potential contributors who all were go=
od=20
in their own respect=2E Hoping to see you around continuing your=20
contributions to the Git community in some way :-)

Ayush, Lucas and Meet,
Mentors are in the process of reaching out to their contributors=2E So, yo=
u'll hear from them soon=2E


[[ References ]]

[1]: https://opensource=2Egoogleblog=2Ecom/2025/05/gsoc-2025-we-have-our-c=
ontributors=2Ehtml?m=3D1
[2]: https://summerofcode=2Ewithgoogle=2Ecom/programs/2025/organizations/g=
it

--=20
Sivaraam
