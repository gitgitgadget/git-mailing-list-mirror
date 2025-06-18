Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C2881C5D77
	for <git@vger.kernel.org>; Wed, 18 Jun 2025 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750282604; cv=none; b=C0zrqLuLeJoGefZkpvA87QOJyUONZlxoVNASHB08YeGO/h2Yi7I+zPzqbxbk7SpU9Be3xnPlzzSUDm9Ygug7m1BGt5apz0ywUvG7b/OEyDoIqHWDAlVlt1B3ysWKj3KGzCjELBvNqnhp/qPX4EpCi+ewMUqv5F2X+22N16/hdZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750282604; c=relaxed/simple;
	bh=aeco73CqDkt63OTXIqqtoyA2ywx3L6+1IAcUEcIgZHM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f5L89l1Jq7DQYzeiAbgeZw5OQy1k3rLuepT3KdG4nRdwLtOI+4lT+Gxhz6CXsoQEAC35KR1JF9pc8DqxYmv9CDta+5HBYntSvLwWBsnj+J2KZLguZ5LmsCFp7job3voNyCBEPDeULpv64Y5zNNWv8AQM8gBkG6h/n8mllZDGlTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c5528c98bdso2772985a.1
        for <git@vger.kernel.org>; Wed, 18 Jun 2025 14:36:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750282600; x=1750887400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aeco73CqDkt63OTXIqqtoyA2ywx3L6+1IAcUEcIgZHM=;
        b=nw7BTe6YzRcn0iIWFDZ4qNH4yomcq0nO0RoJUhdQfdYYE4GLs4yGqMQ0y36Uc4ZIPz
         1qKDVc95MlCVEr6dyncdfw5Q7MpTcdMcWyP2kyFDnLqhaJSP/nBuAuTDhMC/s+gmc+7I
         I00D9cdOnGJ59ZTWZ40d8cFV/8H/s+p2KTvhOH7GYWn/X/5XSQEijfx5FN4z+gWLT2nW
         SAw6A5zODwoGgCUX0SRtxTW+tCEanVvGQCk5ChaQ8afKWRGrIYzZZ3F2LvRFCMXD0YDG
         SnHyaEViqCUqnYinRPJyhPLc7DT6vtzyQEjrNCbnwgoOOJFyJomQrKctgIAVPx3XzVNY
         /3dQ==
X-Gm-Message-State: AOJu0Yy1Jx2ex3vE1pys/fzyjgpbevD8pUjHPfyaGiFB5DQKSyLwhwmF
	4aGElfcXq4Id33ZX98RNaFPUcaVbY5j77mSObvesmXuTl1PgCsbVz/V3n9yhur7m/L0DHA9abKy
	g6ODwuqi9Jac0G81nvzZhB2tEx950hnDwxTjP
X-Gm-Gg: ASbGncvMzc3hk/IzTYSCl7ewubFiZbkX1JtSWsdiO4x7DeQzsNl3huT7IAifJ93iPCI
	FE3v03AoX1Tk75a7zt+JnW6/rFjy7iR99iR2Z+Va05TmZj5wh8EDw+elBinv/gu7uJVcOvwdmQN
	vIDc/OT102xdjpsEbn/UTfSfvvyq8aBuRQfVNCY+Nw3EFGeMmapSYWUeX6iMQIKM33wfAJnCc4E
	Cf1ptFUhXJaNMo=
X-Google-Smtp-Source: AGHT+IFV5XgStJUj0+4/cS3aYa7cOsR0cnKJVXIIWce70rKb9e2oY/9AfS7uzyEXBPgBZc7w9dupC0FQoa/3fDOy0Fc=
X-Received: by 2002:a05:620a:27d0:b0:7c3:c406:ec10 with SMTP id
 af79cd13be357-7d3f1c1c159mr62101085a.14.1750282600092; Wed, 18 Jun 2025
 14:36:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <AS8P191MB2174CB58B1A29D1492EE7842FAB42@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cTK+jz_kF7zd85nVRCn-6sqbH0o7N_ZDtDZDVjYbYgQtQ@mail.gmail.com>
 <AS8P191MB2174A636B81F92212F4B0C03FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <CAPig+cR4Jb0w=McwobCrtySD1nH8sF6rv7MGduQ-yVsRUHHSBg@mail.gmail.com>
 <AS8P191MB2174D9A6C109202A5195CAA2FA96A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
 <AS8P191MB2174894CB42C62AC32F63DD5FA72A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
In-Reply-To: <AS8P191MB2174894CB42C62AC32F63DD5FA72A@AS8P191MB2174.EURP191.PROD.OUTLOOK.COM>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 18 Jun 2025 17:36:29 -0400
X-Gm-Features: Ac12FXyGNvcw8FR1C-D_v4nFdXHpuuiQEc_hf-MxHU5lQz3OxbK4o7MHidIFy8g
Message-ID: <CAPig+cRW+dmj3j23oSRc=nBnwFM6zTJ=WR=1vZScnxycFS3tqA@mail.gmail.com>
Subject: Re: Possible git-gui bug
To: Lauri Reilson <Lauri.Reilson@proekspert.ee>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 18, 2025 at 5:29=E2=80=AFPM Lauri Reilson
<Lauri.Reilson@proekspert.ee> wrote:
> Hi, Eric!
>
> I know I promised to check that patch out and get back to you. The first =
pard I had no time to do. However, I have installed the latest Git version =
(2.50.0) and my problem is fixed. Thank you for that.

Thanks for reporting back that Oswald's patch[*] did indeed fix the
problem you reported.

[*]: https://lore.kernel.org/git/20250315140913.577422-1-oswald.buddenhagen=
@gmx.de/
