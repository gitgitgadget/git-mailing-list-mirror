Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3533A033
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 14:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780411757; cv=pass; b=Zemv9cXalIPGHqmEnQeY3NduPWSvHlI/idihQVgt3HVfx3o5gfDzoK9GzVgVi0DKmnH8u7kzimUqPD0b1jqo7DJd0ZlZxT1RUZWUoSm6ok7NKBxcfiwDvWt5OEuWjdnLoJZnoM5qrTTQSxBZNrOdmvlBD57+LQkq4mWlMQPBFjg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780411757; c=relaxed/simple;
	bh=qNTfwPKmgLRSH4yePJeODIuTs9bE801yhqvA07YK97Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=PhzM9Jqfw//AhZg4xxMhaWUFY0a5+exxITvksOqCYmbKazEWU640OWJcpsX6Y3wtgdcCLAq/AFeMPCj3YPmYr/vU1lc5ov6E1c4coMbvH9PiawMDaaVsZInwVxyl45seKLDQc4f0PqlDALABy2T/29PKOq0jfecb9+Fq7UL+uIg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iKO4d/7A; arc=pass smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iKO4d/7A"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-43ccf0ba2e5so1072466fac.3
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 07:49:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780411755; cv=none;
        d=google.com; s=arc-20240605;
        b=epLStqfmM2cXXESFEdZtwSuiH4OX1PkHBL8Rg0KKqGbwUhb9q8xaLr8m/mrg2EIasS
         L5Dx8MBYZ4FmeABqAoi+aUe9uGdSHTqIVK+l2RBXhtdBxfHP7jih/8h2xmbzYhinEub3
         8Su/hely0Bm3+ws+XjtIt3aLunivfz1kxKwLLTGNCjnqSyfzJknNnbUAgOCm8b7y31f5
         e++1jP2u4k9VkXYXr9FgjDK/pnbf9M5+Wa734P5IDeVUL91QiwAxYKsPK7qCK3juaR8N
         os4kKp13n4c+n8JktwCElooNHDcj/l/dzBq284B7a2pkZ4I8Mt3FAq9vCKn16hzorZOC
         uYJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=az5iEKV7dFlA00R48DTSQrLIRLbaD/x8D+Be0nRNt8A=;
        fh=zArTJ4vZS90FphYRsWj8gMvAyDs5Y7g35vO7MmdkPNk=;
        b=Pl9QESbofW/72iKDP6rvnAEyw36OetM296jreYvOA0zKYnMRFgOL1cLIf93RIEzJTk
         fD65nfgcDRF0r5ZX0BJFtkSgr5qN/6cSp41zQP5kSGeJfpC4m8wK2f+xm3s4ytQZ2Nsv
         EnQqIDlTiYo6GKRJhhfA6KUBBuO9Rel7rDXU9Oyc+pFydBuCXa8q/W9I1TRvpr412rVm
         O3FSKoNMaQ0/T2rDuAPYmQi7BidwldLhTZgQuDqG2fevqlFcPC+2amFxKj8OmECdtpod
         00OsPW9IfpqdOwiIrqOK0B/pT7xM22jMKN1Ja0Wj07SKjG/JxXe0Chf2AkPz5Uu4Pv37
         0dkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780411755; x=1781016555; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=az5iEKV7dFlA00R48DTSQrLIRLbaD/x8D+Be0nRNt8A=;
        b=iKO4d/7AAM2D0g3fFV5SMKbE9UT3JCLQe/GlemYUiTaL/aPBaelwiuX+GIgi495snP
         aWgpeNTXSTi1AfZnT8wfmFhQyZiHrXSHDoz0ltovYb95RVtMF8qlTuc9ixRypDh+HEMz
         /R8LQgkx7HRytaGVWiLpRg6N998Z9STgNMPRe9zZhPI0MymoBS/evb/r0iAYXJpnQTvU
         9C99okPmEgkdQ8pDpfou9kRqoaIsPOc99o5UE47Af6xTyD88pJkrkajleKQHwcoyLqOS
         K3R6utDuChap/4xhPNlKBfFDzDAIO0ZN87h0gNxP76S5xyvEJ+Vb1kuYiCvyEAVoaVPm
         hqrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780411755; x=1781016555;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=az5iEKV7dFlA00R48DTSQrLIRLbaD/x8D+Be0nRNt8A=;
        b=hr/P2GnMmv/sffDfkEzAlYP8t2pj5NoWLVlKApGBzWiBwltHMFcAP+89YsadxX0GTF
         yDoByEN+KazaOngwoU9Vurq0CLe7IfQQEBrlzzfU6tE2d3OZp+zZJ7hKuJcUNXjO9IiY
         ASsDzE//71ks5tIiG22KQ/gwdCrDjMBQaKV4I49TGsXOPLgz56MnGg/xxhnE8RlH4vSa
         DdMNoAyqlWV3AC6e56HW+mShlEHD3GNk+LV+OlPdhOCKkbStyLnmoy5PKKMFC7OlKs+k
         H6o3NJEuwi0ZDXbqJIen3+oCVG0BQYOtg5+2G4/VQpt/E+MWUfRLcEGOO/tNyQUsHzxS
         bCuw==
X-Gm-Message-State: AOJu0YxalCf4jggPgWvZEzLv0V8o7F4Sc5KcDPNxJ3e7vV0yo3B4I/oL
	ASnZu4ErrJjmFzt+pXaesvuUq4LcnpRDDTbgg7/FugmBrUJO0ozNquce23UXXeFTVRLQnFV2tEM
	Zf+DVqm85rA2E2I7vFhkKNdVsWN1Io5+IH5gK
X-Gm-Gg: Acq92OHlD6s1Jj28a0WOUype38ABK6+SWhlKZfjIlnLQ2rkAdKiIRPQy7L3MGx1JMkQ
	w4SPCH7bMTfm9dPCYmvLR4iHqi//eWgMBlfHA33pGeO8Qh9+YsAX6dguzP5Me+wzmkJDpkOwgYB
	5KPstYZah6APNycTMP/yQCXU5c4WoN55YAijIQ0/R7zwxUbqq+SbbuLgMSa4P8EIHNyi/h7Yk+Y
	n6tHgPulJTan1UEwskTQpSkHmB9AQVc7IGuW/7+bYPBvh41ExJl5rkxDy70ktRWFijJ+xgRFswM
	wLsPOI+Hd/USJBjySIxoeg/Na5Y/BvyqwNCHzGADhAl8bmptlsvPaQ3IsaBiOQvF8MiB9xL7yAs
	ermo=
X-Received: by 2002:a05:687c:40a4:b0:43b:722c:d2a with SMTP id
 586e51a60fabf-43ca4202ac2mr8394946fac.19.1780411755131; Tue, 02 Jun 2026
 07:49:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 2 Jun 2026 16:49:03 +0200
X-Gm-Features: AVHnY4KpxYcj9QEwimtPWhqS5lZO1zSBLAv7Oe-Mm50ETrFo1MoHYbRBMM2ClSE
Message-ID: <CAP8UFD1KKxrDsKa70LcHdm7sE8D49pBW-7w_5_LvJn54OfzLfw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 135
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>, 
	"Matthias A." <mha1993@live.de>, JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Pablo <pabloosabaterr@gmail.com>, Chandra Pratap <chandrapratap3519@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>, Tian Yuchen <cat@malon.dev>, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Bello Olamide <belkid98@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 135th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/05/31/edition-135/

Thanks a lot to Matthias A=C3=9Fhauer and =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec =
who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/846
