Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1015619882B
	for <git@vger.kernel.org>; Fri,  3 Oct 2025 22:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759530167; cv=none; b=E7RfkIvwQfB6HXRXJK9SSQT+iOgT8Ah4G+l+6ixozo/PplFdFXi/xIBcQ7PB7lmAOCrXkLgBYvlcUgbEkPn5lUntAb9NGvd5olzOzsW4BYkJbXS/zaqSFytbKhzpk1N88LLbJz40LKbX/s/KWL7fgwOZy4G6eLPAia/r/rkdhw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759530167; c=relaxed/simple;
	bh=EeTZucsruLmbnS46OegqcEW63N2+49fdeAYyZfBWL2o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PoDg4F5m44IIbOVBtTr4/xqW+3ay/FqOdyIrzkMcDw3NMeJ3Pjsc2GgsnrC+oy0InPEK2nh2mbNlwY+m+kWAe8XxpWcrI7wh2ZZQhv3LbInJxg9M5KBM9F/WHZtDvptmZPiIG/uuJi09/WN/RmGcFLbLRRD4GLXqrDgUNX+cFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J0AdCYeS; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0AdCYeS"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b07d4d24d09so502063866b.2
        for <git@vger.kernel.org>; Fri, 03 Oct 2025 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759530164; x=1760134964; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FnSM1B4GjpBPL7wrnYSwOr/LyDeT4iqtd1HEajzDxmE=;
        b=J0AdCYeSJ4Hf13ZDu+h8mDXLkzkeS0pK+buD5aYcc2/wqVvGK3tHAOsLhxjBmQYgqt
         n3pBA+IDV6do6O3atdoupGWN9w4cHdckWQ9rttHGTmBw93FqxhAGruZb0kHSGYVZbhzF
         QbUIVd6cDzaScGRoX/jdx5nliK1SLU4uLWlkiRXMP5OBaFWUVo/MiqpXE4oxwPcEWrR9
         L1EGwGt8xxTyPZt5nqJuXKy3J7A6MXG9ZmGCX28NOsK/N3V4a9JsGERJwhgLKR1y1IbA
         TRc05xYoNHNZtUcidryqG+uRXRgECnEqzakX5AKEJ0gQQ0/AI4K/Cc/57zaRw/2AyOBv
         Vh9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759530164; x=1760134964;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnSM1B4GjpBPL7wrnYSwOr/LyDeT4iqtd1HEajzDxmE=;
        b=qCQhBxvRt2dG7iBdzhluQQOj8THVB+O4D2rD9V9EYdqRSrp4jWdD4d1yBM93KPMoPE
         i/c2KIpT5DQg+Lf++dGjQLb0mie6xvOzvHEU+DzeuxvlEphJ2YBBgnqykUVOlDdKLMoF
         iRKC4LQx7SBRmIBKVnKxtDh9NNbovthnzJgffmClksJ13e07CEstQYiDm4tS3ZpBHpN3
         Mkv021owVPtQRX/mTCpJ6EoYDCmVrDMrlnjWLEJdZyN3G2K860fm/HoX0fvFaBx9l0iA
         AIrqp7OjyKKQ8yeRucOQ/wBrGUOEuLPy/KaSusKGU83pl81dFjSst8GeyEyG6Zn1zOVt
         /nMg==
X-Gm-Message-State: AOJu0YzE37TNcvk/hbmn8SPIxAerUv0y4FMmkPUiqj1n77LcoX63YsOK
	ZAmLt45IgTqySnakp3HV5FMaggEK2zRAnc9U4UG6OrUWiRaK9z5iNsVwlSAwcOzobcbOXKaVFhb
	XjwMnt6F2ey0YV065XrSR/Xuqa5k4mBy2YiONOUI=
X-Gm-Gg: ASbGnctUHa+MGti2i5C31/RnU5Tufi0xYN1kUlcEQqkK8JNAapDz+HEF4oe5FMujM5m
	E7EujaKBfrXvsv5tR8m3wXuqq1TLMKMu7Y2PftQ4BxLo2jinyBHK1X5+x2PXoYb1uXknca7avRU
	mSSZyW8QnRE/L5+I93mUAOZhFzYtdVyJ+8dz58aNN9GeukrY/IqStkZnjqetCuNBbvUSW6KpTGh
	P81xPyx6WxliRYeQbcvW3tgGdI82JM=
X-Google-Smtp-Source: AGHT+IGLLCrZ84WeZQXt/XhJOHvTNAx6GfIBrWHO9cC+ElEoA9i7kLL3FpeXjeQsiKECebXdYOt+usfkVdxGaaU9jUE=
X-Received: by 2002:a17:907:3ea1:b0:b24:3412:7cfe with SMTP id
 a640c23a62f3a-b49c4299dfcmr577571266b.63.1759530163399; Fri, 03 Oct 2025
 15:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 4 Oct 2025 00:22:31 +0200
X-Gm-Features: AS18NWCWUk_hiH34_fo4vrsyRGq6j0EpKBPyzHuU2SQeKxX71QsZ6RGv1dBj2eA
Message-ID: <CAP8UFD2Dr8jd-_3Se6-3PDBFUd7tp05W2pc6pzxHsCgLctPFQQ@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 127
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, 
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	=?UTF-8?B?0JTQuNC70Y/QvSDQn9Cw0LvQsNGD0LfQvtCy?= <dilyan.palauzov@aegee.org>, 
	Toon Claes <toon@iotcl.com>, Gerard Murphy <gjmurphy1@icloud.com>, 
	Jack Lot <jack@themoderncoder.com>, lwn@lwn.net, Bruno Brito <bruno@git-tower.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 127th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2025/09/30/edition-127/

Thanks a lot to Toon Claes, Johannes Schindelin, Bruno Brito, Gerard
Murphy, Jack Lot, Ben Knoble and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec who helpe=
d this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/805
