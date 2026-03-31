Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23C4181334
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 00:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918379; cv=pass; b=IP/Sl0J13wMG1XFW3ZggOa4v+VQn/6JR7RpiGP1V0XmtaVpFxiGzjAKFXWIMoNLZQCgQNW9NXZ6uYIPxHV9UlmoYnzQh0XZsq7XAb9PFs6ERq4DG0l5Z9Yz9iweLUlgmP0EA640sTPQ+TOUh0Q2z2f1VNdjm9s5uout4180o58k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918379; c=relaxed/simple;
	bh=SR2wCqsTg7w6WRCm4SrKX4dB+iN43mn4qDt4verGFdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WKZOVLBge+Jc3ZAC0FYQMNC/4l+0YllplTCeSl40a5WTdqABSWnaK5kYAkAq3ikzKJYK+TOlATtb7WdgiIskM9uFkH1CeREqQyM+tW/HjaEeNoh0aL1+ZheqeY1dtOogmAseYQDWwjUtlo6Y3+E/B5F+jRwWvtSwkMUhS751LIk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FQnTbD5C; arc=pass smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FQnTbD5C"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12732165d1eso7061524c88.1
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 17:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774918378; cv=none;
        d=google.com; s=arc-20240605;
        b=bJaV4ILKMXCHDl4e8JM8H/+vnkc7cBd+UbF1iAeYXDxskx/nanV7ZWSP1ZjEe8u5ua
         kMwTNIvo/sDF9u9L/tvJHhcIIRjip56nC7K+jBYqAUQl7piH9h9ygrtJT+vrkSYkSnf1
         wlG2cNtT7h0QDl5jAouETgIIbMqWFWdPpfWf7M/DM+qgZx65wljhcyXEK/5QUrMFDUt+
         Fmn0tQe8/yN2xNFY5IlsxqpTobuwyraXhQ7lcYynDYlOkUpYAMNjnWr3f+OofqcfwoiZ
         J8wbJHuFQ8NtuLNWFNkw+vgNsxOM6hmELOtSLUZHdO+prHsfKEe29BM4nJTRRsQ1yUco
         +nlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cbt+FXrbuZ+LlYtrwTAsWrQXROXHVmY57eDe5m7W0xs=;
        fh=IOYtyoWt77kTC++1Qc2uVIXZtRVT7H26+YEmKwQoAcI=;
        b=lOMhsex1kHOOgvGKhYB07a2YuqLKXY3f+LatYBgMDb01JfPbrsr8kjQsOZ/UU/S8Sj
         YPRLy2KYyVG7Nrz64OzwiAFSH0KvT41t7gXhUaIzbc69zapWM1hQFTPBP3FF1fSQCSBR
         vUOUbWWQnysQ0EMucQzHhiXoVQLcflrGGO6AIIXDQXaNDyV8KVqSz7RvzzswySPyo2Qx
         0HWFgqYzdBHw96kFY1CPUxxnG/wMJXPxyLxQhwqrvytpA+PnKcxUpf3gx0rcRTAxeTVu
         Nd4dG0AGesjOk7mIrUZqiXj0XMhahuP/+PVQXWk9N/zSkpKLtOYqPJCMy/2IRn2T9FzL
         5pug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918378; x=1775523178; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbt+FXrbuZ+LlYtrwTAsWrQXROXHVmY57eDe5m7W0xs=;
        b=FQnTbD5CKpSdzfzhIKDwsDGORKDe7YRxshAQC3HdYdCvDKQiYpA5lqsD69dOYRrdJC
         sZdFU0jmo8sgDa59TjXCEpLhGyFj56WUp6WKynccjOqwAEZU1zzchKdcodRXJ8J0NSHe
         1p297q/FQMecnP6ADQUkjdzUZ01Ia+imlZLzIecKjplFlsg+0+SkzBPTK9nZPMwFLLvs
         yZ6xkBmo/BX/ID9YP8hyNVitVmUaa1j7OOvTnsD5fAoCpwh8he7bLmjaPVibYmqEHvv3
         4LPoxTmjHmfWYvQzETUiVqYJSIwMpnFfXlkQPID2oHz9NXNr7YiFnoXkEa+UKGncoJib
         L/vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918378; x=1775523178;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cbt+FXrbuZ+LlYtrwTAsWrQXROXHVmY57eDe5m7W0xs=;
        b=BgVf8sDQQ7ONrDn0VbNK98dmyvSRCT6mbAqgxnOo9hm64IupQoPRU/WxHpb799HhcI
         1aGHBuM4aTTUjIMUYtTlzarW3di+J3tRXKOHRxc51sT6ermx0k9vkYC4yfliZDZCkZNl
         7OhY8N+ESWDV3sOeHGdg1FM7PIf90wVLO3zbSB0WUp8ft34fVV7FkRMrU55nn8t0IkDu
         g3DBPLoDWrKBe9b088cN5osKeaCPyrPNJ8Bxkrv4WR0b0x1RmmGR1DbdqrGVB0Qilhmh
         1+ZlqptQPFENB/byIKI7UANKV8rznxe31foNxOkNwIaJ3PDr0ISXLmxyIYY5ncB6PORz
         JrdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXb+ERvHOOH9MK8R2cJrcsSHlfCgp8ruTPPgnpfkpWDVWq0lcLXc7Y3rX8/dRCxzsweAKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxB2NBuCPaGt00p9W9DFsUprXozfc/KtedAw1/yGUUTrgSIphHg
	yx7SCb1DzPhqeoQ4K4bTwt30sxa0pOfy9ku92XUZwfBag1QgtxN17igihvplh3xbhT/AeclsmYg
	A+eHI0FkfcxZRxt2atr273Hp0DTKiqkg=
X-Gm-Gg: ATEYQzwhEh9GQMnIbzsPN0HerNnLo5tHiemvwi2q2Lc+nMvsIV3KJxk1oXoIXea3V9e
	6SGXK7TWhm6FDjuUs6VIOUihL4AW3x/TCdyqqW87JM7H6fMV1LjXip/dBP/g+0q9ws5ChLtLdVo
	4PLZDNXxt2wm2QrHz5UbT5WFcYKKKnTKED8LS4RJb+IbGZltNAyrihm0ioWtebcEdywpCXa3ZNC
	ePRPY5AcSF66BSJYw+Bh3Fog7iAt4OSB/1q9Y7AlC081hmo90rkJkj0Tix+Nve8u9wd/B2psjph
	dL2YBDQOsBTPRs+qFVnEj4baLNhPuVdH86hiP2Ir1CQ0hKVxiTxnRRbHS9zh394f6RqdG51c5NE
	aBnuOof6/f0JXGzDeEg==
X-Received: by 2002:a05:7022:f8b:b0:122:3a5:fc42 with SMTP id
 a92af1059eb24-12ab28d07ccmr7388475c88.20.1774918377750; Mon, 30 Mar 2026
 17:52:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANYiYbFM9+4xGmeBRNCC6VyW9EzjEFxEWHDNnOVhJNM73Ga_FA@mail.gmail.com>
 <cover.1773704908.git.worldhello.net@gmail.com>
In-Reply-To: <cover.1773704908.git.worldhello.net@gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Tue, 31 Mar 2026 08:52:46 +0800
X-Gm-Features: AQROBzCFDKdSqhXJzjNml0TDGPc5NE-ayOIr65Bi32rYRzfIXVNOieV0_tCEwD4
Message-ID: <CANYiYbFpexxr8hihAQA_v6Gr+mvxS=1GKToDVf-O2B9XXwEWaA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] docs(l10n): AI agent instructions and workflow improvements
To: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>, Git List <git@vger.kernel.org>
Cc: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	Teng Long <dyroneteng@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 7:55=E2=80=AFAM Jiang Xin <worldhello.net@gmail.com=
> wrote:
> ## Introduction
>
> This series introduces AI agent instructions for Git localization (l10n)
> workflows to help localization contributors quickly complete drafts and
> use AI to check translation quality. The changes focus on:
>
> 1. Separating agent-specific documentation into po/AGENTS.md for
>    targeted optimization of AI-assisted workflows
> 2. Providing step-by-step instructions for update-pot, update-po,
>    translation, and review tasks
> 3. Simplifying location filtering for PO file commits via .gitattributes
>
> AI-assisted translation is optional; many successful l10n teams work
> well without it. When used, AI output serves as reference only=E2=80=94hu=
man
> contributors must review and approve before submission.

Hi Junio,

The l10n window for Git 2.54 will open soon. I will merge at least
patch 1/5 ("l10n: add .gitattributes to simplify location filtering")
into my tree. The new GitHub Actions workflow already supports checks
based on the filter attribute.

As for patches 2/5 through 5/5, would they also be appropriate to
merge during this l10n window?

--
Jiang Xin
