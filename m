Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FA233FE33
	for <git@vger.kernel.org>; Mon,  3 Aug 2026 16:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785774895; cv=none; b=TPCqHIzQIzWdZkuHpXIeK6mn5Yde5UWASC7q8iCN3aw8HRB9xRPEERooEASzvcv/oQCM9eqV2yLuI70FkrtgXtf5drOKXV/UzaNe8hng6NnHkB+cdJzxpbDVVKtmrgQOMMv4Vs8VjFf40l2mQym36UoDlzZAisKbs+2h7TrPm+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785774895; c=relaxed/simple;
	bh=NzZ409yd1I9Eymro1zJZhvwcQJvZRmSHCPnCWD63gu4=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=EFMDGmZgEQBeivO0D8CPusPB7hnjQt6dpFBy7x4eNcX+oharMlM4I7NLh9NS+NYuh18GNOOV13GHzcEtqLFlAuhCCqRJqI292ucpcIhHSA6POrCPBiz/nRt5EbVjKQaW963EI3mUOJ6WGvixCfXkGNtC2TgrM3jeurmmYa/OM8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jKoLE4tH; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKoLE4tH"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-81e8fa1b8d6so46765037b3.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2026 09:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785774893; x=1786379693; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YbpKDvrwIBAymAK5mbDTCOBL/hB1UA/NPLgBkstakf0=;
        b=jKoLE4tHUxZKxq6JpDhFBzHHp73IMAb7JDdua5xBh6gJX5FUevL122wKUgQKKeZLqb
         Qp7fodcX6BX8bzQEzKXXII8VLsQ2sn3Kgb/8sxuoiKMoxqD6LzP11Z8AZzjokUMABm7k
         GnIP6pcKl7OsPN//+pFOqsR5+bkWlg3y++lm6uW36XOJ3gECZJOhwKjjCFSC8mrnaWNK
         sZjt9d2QBXwHZ5na1lhoZZVzU6vOYu6LkL22rkhmAQAKLc4NhOOCLkC4AI5OSFObRPoA
         LDAhwd89o+dcHi220nr9NrSnguC8yV37gpzmIdbv/2YM8+KyxQaniTqiDa37CP8/27bw
         areg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785774893; x=1786379693;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YbpKDvrwIBAymAK5mbDTCOBL/hB1UA/NPLgBkstakf0=;
        b=GpxKafTX2Pc57BWdiIB39udZNe3NiOnJFzTmBTdi7zSV+DXBgLFfNINvXBG4lX+X4E
         NILqJjc/3hOZ6Gr9rgXg8FeMt1RXEC0eTM3VI8c5FAl+1C8tq3AOwH5oo3L3tc0TiAvJ
         DQCRFjN4eTmPEfhQx9VXAlzuOM/dZxpDvP2Ufy9y4Y+QxlRFBD19jyJtzccW0/ISTUIp
         +kj8AqFrCUHqQQj0GTyICStGLuACQFIHsza94F1vzdWVtN7L2D8eeAsfS2t4fb8/LS9C
         GEEQMMF6bHggmCm0V7XnN0cc2Q7OqV3rc1bODCpfZy7LhzKEhuf/SR/EjmDfJiN96fxr
         BG/w==
X-Gm-Message-State: AOJu0YxmPnpxjsiXFXJ/zStX4hCrgMpwGOaeKN3pcwLEcqRiedMMqD8J
	XQlbHR0+ahgvbnK3pMgzk/AsYMZ5WGuoGp4TwgSJ7GI8Jgc3KpSFK1y3
X-Gm-Gg: AR+sD13g5VOjCWVbfhgr2K9bi5qp2qczFOJ7IBljkwbrlVTzLnRln9S/LuIGGH3+ygL
	QbWTiJZa5l5UdBR3Yx2TLWKcbbOUtnz7faMU72A7FOul4Db7SIIsaAUbBVm8/hK4/oFbAKqy/K6
	9G1Voi/xKh7I4TgOStamo3npdyw7HxC4KtqmynueS16vQcDxBrSMRPUALvaRD7THCIlZfA3EJ1Q
	6YS7jeLGI2Z/ePoH9ltVcpLVgGdzj2FtFGIGboUgVKvtK51PFDShI6wxXb5Dbd8mNfy71o8JKZF
	Ib679khw3UwSXjm1b436x9Xn2igi9F0fU9S5edr74TUWiJOl7DJ3aMVmqyGtQ5LthmgM9t/PTKA
	3OLxc6Shwa0iCODZ3l2XPvzxmGoHzL/8A+ydHEXmtoQnbAtLNVTvPnsxoMADAmdnmBE2IauTYjw
	NkeWSdSqyv8Yra477Isi7oM04e6ykkK1KGo2g5M5VOF+FSPnlDsDfE5nKRLCkPVTxUm0vMqh3R6
	CJim9LL35Kx0WeY60wOGm/an128IJh9QeUmT1b8w5wwPOM1z1hqyZIjlzt1jEbS4LV7NNocxHhH
	m47FkXxjtlCPHwvBajvSjar6/jJe8bVlH6gjaI3oXOVOjtEy
X-Received: by 2002:a05:690c:ecf:b0:814:7a54:3a93 with SMTP id 00721157ae682-81fd4b372d9mr147275237b3.23.1785774892877;
        Mon, 03 Aug 2026 09:34:52 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:9092:700:406b:6c90:b0ee:a2e1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fcd1242a1sm57487557b3.42.2026.08.03.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:34:52 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [ANNOUNCE] Git Rev News edition 137
Date: Mon, 3 Aug 2026 12:34:41 -0400
Message-Id: <961BCBE4-8A69-44A5-925E-5F163B0814CC@gmail.com>
References: <CAP8UFD3huzOo76ZyJesf3=AcbwW=pJKpQQUZSD_Tohhd4vFV2g@mail.gmail.com>
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
 Jakub Narebski <jnareb@gmail.com>, Markus Jansen <mja@jansen-preisler.de>,
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
 =?utf-8?Q?=C5=A0t=C4=9Bp=C3=A1n_N=C4=9Bmec?= <stepnem@gmail.com>,
 Taylor Blau <me@ttaylorr.com>,
 Johannes Schindelin <johannes.schindelin@gmx.de>,
 Bruno Brito <bruno@git-tower.com>, Patrick Steinhardt <ps@pks.im>,
 Jeff King <peff@peff.net>,
 "brian m. carlson" <sandals@crustytoothpaste.net>, lwn@lwn.net
In-Reply-To: <CAP8UFD3huzOo76ZyJesf3=AcbwW=pJKpQQUZSD_Tohhd4vFV2g@mail.gmail.com>
To: Christian Couder <christian.couder@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 3 ao=C3=BBt 2026 =C3=A0 01:36, Christian Couder <christian.couder@gmail=
.com> a =C3=A9crit :
>=20
> =EF=BB=BFHi everyone,
>=20
> The 137th edition of Git Rev News is now published:
>=20
>  https://git.github.io/rev_news/2026/07/31/edition-137/
>=20
> Thanks a lot to Bruno Brito who helped this month!
>=20
> Enjoy,
> Christian, Jakub, Markus and Kaartic.
>=20
> PS: An issue for the next edition is already opened and contributions
> are welcome:
>=20
>  https://github.com/git/git.github.io/issues/856

Thanks for the write-up, btw. Proved inspiring to come back to the USE_NSEC s=
tuff today. Hopefully more to share soon ;)=
