Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2523346AC4
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 22:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770070665; cv=none; b=hlS0k46toLVsoIC1eHiVQQAmE0ksS1elOxqu3hqD2VU5XDkIgkXxuUfxiVZLZ/etFzZcMbJTB6qCGZQEziiqaJQodQccE+9jiZfD82Lkzwrvr0TV7nN9FAJ8kpnPW6K5XY6oD2j5F7J/9xvvhmouMOJ4FC0FeSe1t7MHSw+c6jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770070665; c=relaxed/simple;
	bh=2p8/vpvjPZcgN4vJmug7wPgN0eIWlXN2/7d1L1pxWzE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=keiwIUbIhnpBHUjKk6DJESvrEoqHkHb1Y067VNsQBeyhr0OVJM3hvVOcKpG+jyIk2SZiLK70GCpCJPhgFtHu9Z0qE+lT9ME/Sp2icUI6HEEmU2iiIIS3Fx+VNGvuVEKw5WVCl/lAuhSP01w86e02wDP6FLTbEHeQ3p0BxN4GRqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=beMlVSLC; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="beMlVSLC"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794e95357cfso8619377b3.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 14:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770070662; x=1770675462; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2p8/vpvjPZcgN4vJmug7wPgN0eIWlXN2/7d1L1pxWzE=;
        b=beMlVSLCUITfC1ohNng3xCrhmLDstPdfsGOG5it8z6AXz1fM+DJXs/f5GFHBW+OTB7
         1RlMiimbUryGmdM8o4Dcn5MXoPsoJU4Y9GAAzNH5LNvRk0USuqzf+WSqyC085M/ZIF93
         28rGLVBoqnS5gSELc8qO9MLorDfZXiz+A7y0I5NW7DQT3yLxBDUFI/yRpYF8tmrJDiWt
         qVjBQ+N0vcABhLItw67F3X95tU3OFDiZqVWZNr8KVjpdxGjN7l43kUh4yDSJPfxpupRh
         rxkGcL5NYIQMpwbA2LXwBOIl2w6WbBLuv/dZ9xQvOLPHYuwUzfUrmLW8R1AnQVpqhXZn
         TGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770070662; x=1770675462;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2p8/vpvjPZcgN4vJmug7wPgN0eIWlXN2/7d1L1pxWzE=;
        b=r2Q4EqcCtDSmIfIEK/snAoZBWgAdMAuff65yAO0jjPXYfrzuj9JzwIRUAm9/p73wIC
         OCJXfeJHJkAqk2w+nk2fBNh0Uh3ClzLZCPhJnLlopkbp6MBuh6G5gZotPSFlVWTRFqZW
         UaaK9nizyKSCg3cx0GT1TWFUdccNTcBXss/O0oyBZt4nry7xEF2heVWTSdS2wCOuV1bX
         cS8sUPvFThCfwO9czE2bgx3Km4v5Ynao2IzrIBMKWa44ZhhmVF8XFDGtuo2YxRT06MQZ
         Wn6E/bg52SpeS/TxaYSS6yj6xyzu+o1QS+zFVbIE54ki9eVsQHMPJzDdn5yTIAjAr6ip
         7caw==
X-Gm-Message-State: AOJu0Yz5gZbqjS06mhlJjaZZTb0ZSl2Ryr4I+9jXW7oXG+fcaz4nDkIp
	8uLQhLpJXmj6Bkn94MvlMpaYx1X9IeWYb8QGZS0rx8wcopGo7QSDVgOk
X-Gm-Gg: AZuq6aLdvIfsE/VPAKkEKjUOvQ5MMxYLlJ+PbzYadpUpgTIjL7mCx/i63C6j4sku0fC
	DCOk0g1ZtakyV17V8t6+f/AOEF2QYNTfIMOCrEjQYYKiJlygiGr9GBrJaAk0OX3NgYZzyU6rlLK
	gxUoyOJ3KDqH6kunCtTWRepctmAn+4gEjXrhpR/Lnsk093/UYGKPQBxpYLVAiDQZUMszc1xZ93x
	1zFtP5bralt8jFatLOFs0UfcMhibxGmcxAIva9sdSVdhEJXo8oU+DerqclRajMOV48Or02cMM6I
	8RB7IG/UsCoMJam6Ry8C3EN2Ukfkq/rRUNqxlLe4fIKOkrul77eNYvly/Oi4NAivX6yD9+RbS70
	ikudUgC4NOyl967G5rNVAMBbz6+Vt3B4qoYTTT/QcE4uo+bwj2M4KZz/2eFWSWrxB1RLbNk6MeD
	9KhG89r6MFch78XIm3tRK/GitBsnfHn+/jE6vVnhDZzwvcKGoki+Mizu3udacFWkwWdpwQG9mh4
	s2hPI22bnNI11klazyFblxAOxcJ
X-Received: by 2002:a05:690c:c509:b0:794:e5be:89a5 with SMTP id 00721157ae682-794e5be8bf1mr24946877b3.70.1770070662474;
        Mon, 02 Feb 2026 14:17:42 -0800 (PST)
Received: from smtpclient.apple ([2605:a601:90eb:5600:c4d5:7951:15da:10b5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79482762e59sm95003527b3.7.2026.02.02.14.17.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Feb 2026 14:17:42 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon, 2 Feb 2026 17:17:31 -0500
Message-Id: <A8942826-6235-4C46-9217-708671ED4678@gmail.com>
References: <20260202211919.4968-1-haraldnordgren@gmail.com>
Cc: git@vger.kernel.org, gitgitgadget@gmail.com, gitster@pobox.com,
 phillip.wood123@gmail.com, phillip.wood@dunelm.org.uk
In-Reply-To: <20260202211919.4968-1-haraldnordgren@gmail.com>
To: Harald Nordgren <haraldnordgren@gmail.com>
X-Mailer: iPhone Mail (21F90)


> Le 2 f=C3=A9vr. 2026 =C3=A0 16:19, Harald Nordgren <haraldnordgren@gmail.c=
om> a =C3=A9crit :
>=20
> =EF=BB=BF
>>=20
>> If you don't need to be on a branch, then "git switch -d origin" (or
>> upstream, or whatever your remote is) should work just fine.
>=20
> Thanks, but it needs to be a branch, do you use detached heads for
> anything? =F0=9F=A4=97 For me, the only ever happen by accident.

Yes, frequently :)

I run =C2=AB git switch -d origin =C2=BB a lot to avoid having to keep a loc=
al main branch up to date (if I don=E2=80=99t use it for anything, which is o=
ften the case).=20=
