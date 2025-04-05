Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2C148FE6
	for <git@vger.kernel.org>; Sat,  5 Apr 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743871191; cv=none; b=th/J+Xl7VrOFR64AssJAxfQ5eA/Hj+volFvng9Iv6zvlyXNhAvDQTw5RT4bNJ7Yb8PGW2lvfAC0W9DUmo2sPK04/Xr0V60swxJhYaf6cW2ICWN11+q16S0yUBcp1zhnsabhBwLut2EpbblI2jdxRZ7sZ9JAa2oKvN+wEN66RN34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743871191; c=relaxed/simple;
	bh=XFX1NN9RC4qK8Lz0BsCIgw4AdGjK+f69DFykZT2Z9CU=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=X/221chBFu7GyHg2Fk2fXXiuwlEPqqcnj5WMiHXO+0F9p8hIUSYVRvAe5AYrvYi89lALrgIyOLT/UVTmb7y6/Jkkr1Yq4sL4gNj0DywR6I0PdUs0gaN3KZhM2LVVFmJiSktuBDv9VIQSoEd7ySt1+S5Y1JeC2tu4Ur2e2pBrw2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQCK9Ulq; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQCK9Ulq"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7370a2d1981so2515563b3a.2
        for <git@vger.kernel.org>; Sat, 05 Apr 2025 09:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743871189; x=1744475989; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XFX1NN9RC4qK8Lz0BsCIgw4AdGjK+f69DFykZT2Z9CU=;
        b=FQCK9UlqCARQnJ6Nvnh5pF+yAOq3JvJiy5eavueQrpygq02T/9/Nmh4jvxJlyxpHni
         749YMK9B+8YahxrbPjrlM6aVp/EZE7PQcCHzksmup1kYiFXTr62AzOmtOefSvVTBU6uH
         lvpQxsZCTDdtyPGVyX8MIJxlOoYBDc4WfNJ5z3vYeof467IWix7T2aKYioUSZiTR6Kb0
         eEnQWFIhgI/v5viNDiYhWhzbrnh5K4NHcemKFjjPzf4SJyHW9C9f7b3UWfHVzQ9gH1sN
         JD8wqK5sMHhw7OizUolAXWGiwPVePm5mJ7p7Vpl8LwZdDVLgcD8JrgrNk6wHU+ETvhSw
         o8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743871189; x=1744475989;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XFX1NN9RC4qK8Lz0BsCIgw4AdGjK+f69DFykZT2Z9CU=;
        b=mSbdjbuefH1BuQbzaMcz1LteEIgh/vF1XFYVRjkHlgTyUR5D7NiTtu8EdFtdglSlOo
         GbBJs9CMR0fj7FuDURGk5aqoW278G7bpKL9Ff6OIak56k2s9RsjV+0Uf1/DRQBnuZVQ7
         EPY+wY8WFL3imLGP4e2hsoMDIhd34gwPk0hHVUwJMyF15pBySGmgvaN+gczKopZDTKXx
         vX1iObGjvVCDsfyCZ2Df5yUlD0S4hjp2QC1IJVOilU7BQHCny/PgxVCOm3qXUneMkDrA
         gAfaytfxexht2aKAgMAt2A6P3/39HBnPoAJSpBFvkkmJeQ24z93vFFl5gjSnjJPUr0YK
         F30g==
X-Gm-Message-State: AOJu0YyDBnesZv+Vey9aWbkfdCssFOgSQVdRmUMBG2W2xQOQzTHyH9o1
	KEkSOnT5pL4y1noWzPky9FDWPpNMemNEiYnumv7otrR7oup3pWRK
X-Gm-Gg: ASbGnctGj26HnFgqWyXGcadqafm3jEpxekeK35pHSEkGfLe79Ww61vPe/YZ75ehBgdU
	LpYrnnVSrg/M2ZrhR6Bs2Kjp1w/fGaInHg8pK1P8vikLvh2vH0IOYCsDArm7dFSGTbOgjYO6Id6
	+fQaaThjAYpsglN5huOf5XnhkhKYth2iZApyAGL/wTAPmRCsqcprciKdZJ/qk7bBX7UvrHEef+e
	4jzZAkO7GdyBSC5V6ZanKCEcX+GYQuzle7zgR/NJbMcaSI4725w/D2KiF4N9+5qMFsZj2JAtr5X
	CeksqmCy1uEljUIyQXRdRzwA4xucnbzbVznn1ZKQzFpodgVD21Yt8dYMF1RGvgBr/ZyRozLvHXV
	cCgDPqOm9Yg==
X-Google-Smtp-Source: AGHT+IEF+2D7ID4XXGSXtxX8rP8SzVpek9jjPHwsFkA/RYDLfC3LcKPcnDOUANJ7vD/GSomj7++zDQ==
X-Received: by 2002:aa7:8890:0:b0:736:a4ca:62e1 with SMTP id d2e1a72fcca58-739e4815f68mr8973257b3a.6.1743871188938;
        Sat, 05 Apr 2025 09:39:48 -0700 (PDT)
Received: from smtpclient.apple ([2804:7f0:b77d:1bb3:1c58:99e9:16d3:9d91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739da0e2f6asm5423972b3a.165.2025.04.05.09.39.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Apr 2025 09:39:48 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.500.181.1.5\))
Subject: Re: Make 'git stash list' more informative
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <edcd6174-e931-4ab9-b61d-8126a6cab740@rawbw.com>
Date: Sat, 5 Apr 2025 13:24:02 -0300
Cc: Git Mailing List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <29E4ED32-4909-48EF-86BB-67111B62AE1A@gmail.com>
References: <edcd6174-e931-4ab9-b61d-8126a6cab740@rawbw.com>
To: Yuri <yuri@rawbw.com>
X-Mailer: Apple Mail (2.3826.500.181.1.5)

> It contains the last commit's subject which often/usually doesn't =
really describe the stash entry.

`git stash list` accepts the options from `git log`, so you can change
look at its manpage to find other options that show the information
that you want.

> I propose to amend WIP stash entry descriptions with size, number of =
dirs and files

Perhaps this helps you:

`git stash list --stat --pretty=3Dreference`

You can customize following the format described on =
https://git-scm.com/docs/pretty-formats.

> Thanks,
> Yuri

I hope it helps you!=
