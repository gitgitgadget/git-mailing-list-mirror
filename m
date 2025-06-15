Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8645729A2
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 00:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749947189; cv=none; b=RPUejKMiFwQGA8TjVSBPkBntoXMcJu20huU5/AJsjpQcccplkD18olE638QkoVSCuUeEqH8e/aYGWPL+SwNuPFlTbJlhzwYrsMR+32VYwmwDSG4e8zPUSGED44OiC8mm/PddjRZZXwuveYuyj/lzTFlDS92n6VS3XR+4tAlQY9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749947189; c=relaxed/simple;
	bh=SzQC1m9iMbd350E5OODOImDCWD9UXUsd8NA+c8hYY80=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=GvGcLcjI2TVXcgCM+mflQApZUkJSgDLvOGZQs4KCHmF7r8L3nAosLUa3a1B4bPf8pxMLGe6B/VoRppGhRWhsrDjbhZQK33mBXUZjuq1IDGnj8pgvqzWJU6f/s1xaRbcEcWhcp5jM7VeIzOfm34KADxq9x/1Rkdxtis1YX0KlfFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czPXBwc6; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czPXBwc6"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7cadd46eb07so362373085a.3
        for <git@vger.kernel.org>; Sat, 14 Jun 2025 17:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749947186; x=1750551986; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ckWgj7vpEEoNqUQF4yJZlZ6lvcDRspJXya8HWnf00RY=;
        b=czPXBwc6XKEhEHl+h3OQZS8Mi/wBrlHzXed39jnsniLEade+CleaPcE95sFsOIYt7p
         ASOSdllyhoXt6bPre3UyM79BhfZLUFTQrCmhrqFVWbKo/xAxmO3mDyxQsV7OBFEnVC2K
         Lh20f0L4dhOWb/CZn67u/udzbTeVoajPKALVlQ+amxDi34ghxwFZUxnPNSLPI1HBNR7l
         btZ0tN4GhwAVA6fTjGWnInHDLbGenCRL5y1BdIqEevLKIExJhU6iwhqEgmxPCwbu84aq
         X0fMOSagq08I7skQaz/tzLGYpOkor09B/JYjRGnnEdZ9EmAb0JR35oBXOFUTsF+yfgvr
         0Dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749947186; x=1750551986;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckWgj7vpEEoNqUQF4yJZlZ6lvcDRspJXya8HWnf00RY=;
        b=fHgkr5QEt1FrNsYE3C1aKjRntTFJ7VmN5rDywCNzc5+O2Cv44Rq3X9Y42S7Ky28g4b
         WeDurj+70q25+8CzsaxGr0PL6FXFRY2qdjzH9wN6wp06NXrU6xHplDFHXmtQ2LOETGOY
         jK8mxJzWUrCFZNRyhVwOXDmBaIpIE1Ajbp2x8EemX2mjtYR0bih9M9vMsHHZHGY6DcFD
         Keg3oCA3epYVa5pt7V7ZSy744JnygaviL/Yi6h75FOTT/rON8XBeFQx2F8O3Ruvdm+ea
         asZ3nNgGax1CYgkf8SQIPm/PvFpsjO3cHVuYJOMg42m5jDEGGCXeK2GfAeWXpQkKglPv
         D0hQ==
X-Gm-Message-State: AOJu0Ywxtn1faZx7+JRFWMGsolVLhPBkTxn7bDZ2xaecjZEcm+EckZfQ
	IRK25JNMrBFRrH8q03s1Ila9HJGThJ3ufOuDznmo0wKrvLqOhCnb/8sP
X-Gm-Gg: ASbGncur7c/CT3mA5NHdpN4iq1r3zQleXCH3gLJEq1FLFrYkxXBAaNHtyUjC3MPTg9x
	JLUmc9aqMWptbcP5EOlMp6/aIFUYhCL1GMFu9X7edYvZ71lIzQDX/HfMvN4o9MybOoSZxFUsLgG
	niZ+Wu72i6slvEXiv+XfLUbrEKnov0E6DKTJXbGgGlWa6uNt3rbtcUQ2HD0wSD79S9ZYsax2RhY
	I+0BhPGgTxVx3cK13k95Q1HErp72ifkz/POHQInjtZqRLX9peX3t5Lf9HmD5hl62GDOxVfqdQRp
	LwMH1kID9AIpjo7cIRCeQEfIxR8hJ1DF1jvxJCdqEQqXUYW4Z4+MsETUjZvII5Q+LAuyTJ2SjSN
	RdUvjAMvaavEJEE0=
X-Google-Smtp-Source: AGHT+IEHZ1d5VIP+t0K0tEd2zo/gEWWEYWxRGlW5QcNfLEgwkRq45sisKBUnewfzAv7lc9RnlCxo0Q==
X-Received: by 2002:a05:620a:430f:b0:7d0:9505:1797 with SMTP id af79cd13be357-7d3c6c08d0fmr732623485a.4.1749947186429;
        Sat, 14 Jun 2025 17:26:26 -0700 (PDT)
Received: from smtpclient.apple ([2600:1004:b263:760a:25b1:6481:a909:e9db])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eac18bsm358464685a.75.2025.06.14.17.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Jun 2025 17:26:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Question: regarding understanding code base
Date: Sat, 14 Jun 2025 20:26:15 -0400
Message-Id: <AF617F39-7B22-44A3-BF08-D21CCFBEBD20@gmail.com>
References: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
Cc: GIT Mailing-list <git@vger.kernel.org>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <CA+rGoLf8Lf0gbPEUjTU9Zc9KQrzui4pjyvfxhA-LT4YuafqeOQ@mail.gmail.com>
To: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 14 juin 2025 =C3=A0 08:44, JAYATHEERTH K <jayatheerthkulkarni2005@gmail=
.com> a =C3=A9crit :
>=20
> =EF=BB=BFOk so a couple of weeks ago, in this thread[1]
> Junio advised that one of the best ways to understand git is to go back to=
 the
> _inital commit_ and travel back to the latest ones.
>=20
> And I happened to quite like this idea, cause I still have to dig up a
> lot of things in git.
> The main question is
> What are the best and smallest set of git commands to do this as
> I can set this up as an alias and use this trick for many other projects t=
oo.

If you want a checkout of the root commit, assuming there=E2=80=99s only one=
, something like

    git rev-list | sed -n \$p | xargs git switch --detach

ought to work. You could feed something similar to git-worktree. But it=E2=80=
=99s a little harder to =E2=80=9Cgo forward=E2=80=9D with Git=E2=80=99s data=
 model, and I didn=E2=80=99t totally understand =E2=80=9Ctravel back to the l=
atest ones.=E2=80=9D

>=20
> 1 - https://lore.kernel.org/git/xmqqfrh3qe2w.fsf@gitster.g/
>=20
>=20
> Thank you,
>=20
> - Jayatheerth
>=20
