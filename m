Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370623ADBA2
	for <git@vger.kernel.org>; Sat,  8 Aug 2026 19:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786216115; cv=pass; b=XBGAwgRpQ7Rqpq7dPuuw44PdyMbbCZW/Lgh4rAZMRqAyJUAxMJbSN7nAUi5/S0qvNliPlVHKxspnN+WdHWZVwkXTZaWeLlXuIawQQ9HnkHfcO1Kb7zXCFiokjN+760z4uzguUOLcjo3EdoRq5dR7mzgATIscik+GxNs8VMtRiGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786216115; c=relaxed/simple;
	bh=Ksk0YdUim3txJ+IABvIkCRNiRV2Ol6WnKxb3X+Lc67w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=IO4HmHP7jPPWf/z0MIBP8Fej8L3BPNE+q6o2svpL1aPEdvPE1/iqeu6DlE0h9L1Ne/lcJGSoR0lA99lROOTBmDBP28JY7LfPzETRaDWUw+MEgXGgnr+IYqSqi3DLxMPBH0IH4Fy1Urk2LAOlw3YuJiQkbCReUw87k1JLEF7URqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2IDuXyr; arc=pass smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2IDuXyr"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-6acc15016f1so368235eaf.3
        for <git@vger.kernel.org>; Sat, 08 Aug 2026 12:08:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786216113; cv=none;
        d=google.com; s=arc-20260327;
        b=LAhpHMdv2iy8y2ini6gqtt0S+Ku67+AdrocNSrCBsVRsJagbdUl2XMfIpbjCEz0qiI
         jmDHvheXLGKsPrX/MQv6iAsoTaxQcmzmoO3J2eMIhkSyhLYvKldpbgxVLyIYeq/Bi1F9
         SzCH4/wmD8SOqpcVMHRB2r1Es1JqrefR45SHTLfWKtYVVUJ3qKSKQLxPHZm+p0mOs6Ha
         BmaoBC/P6knkiC0ZISXCZ36e3Exn7k4T9sYhQUFAUTVG9wYcXEBV8FHgaATzzJ+VeNlJ
         dcRVlf20zi66t0td1Nb1f21VEmt1rl/QcpuW0GO8txstA6rFYDGy8g10IIVHBltjll6Y
         gk0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :dkim-signature;
        bh=Ksk0YdUim3txJ+IABvIkCRNiRV2Ol6WnKxb3X+Lc67w=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=T1URoAhaj/tsSmRYBGovzARBPyARod9DiRpEqHxByk9jLkuys7niii6qmtksfW6lNf
         JVARHGCE53Aczz0/5OzkzKeBtJqtNTOLdvkcWnXpXbICNGMW9Wssgs9HuTXn6klzCRDj
         oX9FHgmtqpE6ZyFu1SGyLJl8BcpSPVEJFkNbMH4nQJCfbJ/WV0BMvSmkVsw+LYi0/p6p
         58uJX2IhC2kHD792cWK81FUvG1Nmss5EDO9F8IRuPUKUy23Qx57RINMgOutzNtb1cw1X
         ySP+7lLiTBcEMOTDPHTgrenDNKJwm9JquzbT9F6I/l/6D9JT542f/rVuUxWSoYy1pMG2
         pkNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786216113; x=1786820913; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ksk0YdUim3txJ+IABvIkCRNiRV2Ol6WnKxb3X+Lc67w=;
        b=m2IDuXyrZrVm5K3jaezALPbz1WIv9MlboVos97wqfVhIUWaxA4G2BO8o3JMjwfhUdg
         8/NHGrxCJWd0a9JMc/QL7CCyteOMuR1jtrp9SNUrmCrIWRY28IifTeJu6gA17nJMI3dn
         FSr1kwIWX52OEvU1B8jKERnkxXtcEKHcAhksMAdCMkn7yr1b5iDDcOj/gSwHPYHzslhS
         hokWD/PC+BfLyimv8w+jeLqw9J/E3R7e29fXus2C+Y+xwCjOdzGtOyL9Xu5SHE3d0ZEX
         ffqkrZuj8kQkD10ED5Denba7ti0vwV1XWMZPEzY//Vor37uNjqqscVdPdwsDN97XfzUZ
         77rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786216113; x=1786820913;
        h=content-type:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ksk0YdUim3txJ+IABvIkCRNiRV2Ol6WnKxb3X+Lc67w=;
        b=KtjAJzXCd8h0Q+/RsZkuMtbjdLmpOMIHWP1w0Jb0xe+5txfnrOQIHtps+dzhvoQlG8
         4x0KIigBZ2oDduwsd+PL5eErpxlP+OZJ0dSqCjSpFpLURoiwmTKNaK9lJw+6BGIUs4ey
         PMDdzUW5t41oglUPH8ArfPcoZTmVXVPdbaXUfo9ZeH89XDmGRFPkqmBYFnKdjWHc7wLY
         O1wwwsV2wy7E/gnV/LtJiHsRbbm44JUloTaaiFCe9j+4Lv0WIa8IZL+ktGua6gZiq7g2
         QthmdxJZcADDLzOW5CuXY4VsOL0oV5HqO5rEgUXFQYA2M7kwfWIFWO73VBttrleIDQRX
         HtgA==
X-Gm-Message-State: AOJu0YzP/xcQZyD3VD26rIsDocZlitnLCaCH2bJoYVmWzprjSWXFbqsh
	p500gwWdB0+SarAbgQBTyHK5c11SFXxSYky4w01JxFlNAFKkJpep2YruLZGpgGRoivfzC4NW8G8
	fg1/EiJUmmr8JL7iV9x47TveH0eayEKDMCat6
X-Gm-Gg: AR+sD10zg6Slg3WWAwET/UD28sseZ4PeYl3dRY6ak41yuVH9BrSBiUIQdnd+sGN7XEJ
	oxY1wUGldrPdz16a9hZKtYwfCwt0Rw6AB6XNitVJbqoZfh9+JCZeFQeHcQBazmx29gS5y2DU/yk
	VAnEoYgQ96xsO3c42cKcib16lt4EegR4W9UHLpLHwhLoDYCL5HIAVh0xC5jMeBEht5o7BLoEous
	s9BLI4I3TotodotPbvJ1JuYujBbNPa2qMDdsLOubNEFHbF1e39BmpQJPjKZ6Q4vOfuuYe+42YSY
	ZfMKRjc4+PnDvHAahZWh4JpH3PfzDYHySXtIVN8cK+e9i3pJ5KhnAwF7I7Wn7Abupwzfk/Uu6/O
	/Vu4B9PbLSlLoYQySJXR+Yk6XHXGcg6Pkg9X5gIOpJU5f51SVgy4dhO0iFenbFpjNd+svNdYzAQ
	==
X-Received: by 2002:a05:6820:4dfc:b0:6a1:7790:258e with SMTP id
 006d021491bc7-6ae96ec782bmr18041506eaf.18.1786216112964; Sat, 08 Aug 2026
 12:08:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
 <CA+rGoLeNzxaTrq50jE=at=0ecnZ5Diy+Q-0McG-R+XFTQ7oMow@mail.gmail.com>
 <CA+rGoLe+n314hrbKBSU61Hn=uVQN+OqOF5AVt2gPOityUUL_AA@mail.gmail.com>
 <CA+rGoLdOjybHB7w1Wd0Or0wJUKjTOev7f1pZbj7dhAZRbs-2eg@mail.gmail.com>
 <CA+rGoLePg9MHE+OcVtKo5ho8ziNp9NBWAuWc4ZEZ2kevZf5WKg@mail.gmail.com>
 <CA+rGoLdMnLfVF91hP3c5bdLnAv9ViW2r9pR0yejK2kQNNWSBUw@mail.gmail.com> <CA+rGoLexpn-U3d+NzjO5COEDzyAkmKXOaaeusZ6rXDxkOVYnGg@mail.gmail.com>
In-Reply-To: <CA+rGoLexpn-U3d+NzjO5COEDzyAkmKXOaaeusZ6rXDxkOVYnGg@mail.gmail.com>
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 9 Aug 2026 00:38:21 +0530
X-Gm-Features: AUfX_mzJgyefxA4m2ixExk74J1IntTmZvH1tBXV02O1bJkz8H6IUqNZChx7a5tk
Message-ID: <CA+rGoLfpTi1uwM5vZshwYDitQ_KNfKvJ+W07RDe34wJD8NMz_w@mail.gmail.com>
Subject: [GSoC] [Blog] week 9 and 10: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi!

My Week 9 and 10 GSoC blogs are live!

https://jayatheerth.com/#/blogs/gsoc/week-9
https://jayatheerth.com/#/blogs/gsoc/week-10

Feel free to give them a read and share any feedback ; )

Regards,
- K Jayatheerth
