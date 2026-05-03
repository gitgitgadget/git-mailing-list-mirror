Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB9B16A956
	for <git@vger.kernel.org>; Sun,  3 May 2026 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810787; cv=pass; b=bWehF+C6ZdiTqDvOEk0BoIFLglt7sq2RX3uWdQsmOKGMXnUMx2Hk45c3mcIMJp/Jw2cLpKyDJ6/msWRa7HrUNem2ZUOwayKWOcclsRAdNohTUVCUdXCMKOsSOuGVsN9NGRwWmqmAMT8+byCMCDkBZEWARz0Go9imOSb/Rv0aIzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810787; c=relaxed/simple;
	bh=Ql9KVYgegbbTNgj4ztKC4tjb/9s2uaGUqFZBx3n9xtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MC2iaypRNOy2HFakp6wsBW+42xPjgW1KKXPZNxhdeia6vO3+UsMpDGFPZSqryiPI3AzpEZWlpjmLXhhOcTJuSi134YIvh48fgCkTGKCiTgWbdtxw3eWKeqSwutT1oszVJpWXsGW9H/5mMj2EJ5Pt5gBWQAG50xKMq0csX5c7cq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yxq1nrbf; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yxq1nrbf"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7991db3dc98so34727997b3.0
        for <git@vger.kernel.org>; Sun, 03 May 2026 05:19:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777810785; cv=none;
        d=google.com; s=arc-20240605;
        b=AvbxPj/RCupE8R/Bl/c3fL4VI63+dWBm6NIR5RPhgQQGWP9oxjEnLciwov4jDMJ1nv
         v8Sg/y8Ksr2/0TZLWbREfMIbw/9UeGAbnD4Xn2Aqbwjr6XBKPYM4eR0GGBM0NZXmJ2hv
         wp+/vaP1WL2bdtvYASXUxQOoPCoScrZK++URb4aEF2b+eelvuYXfrIUjZuHVGh3sGGWw
         yhYXUxifi3cgF+DO+Kuiu+ZxcYgZH2HvsNpQC7DgKoS3/FXkN2ZNYs3vHk4+P0VYcF6E
         iqZlNzDd5D4YQEdoolPCxDkhIdQBMIPevRov75qpscnW6gkbDQ8SR3SXOYG6wA9AGyac
         IoSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ql9KVYgegbbTNgj4ztKC4tjb/9s2uaGUqFZBx3n9xtE=;
        fh=gvKaZoOWggMFLUd55+WZ7sGqcct0CzIHsD/GyxLGPlY=;
        b=iJc6QpkErLQK5ydepPrWILlmfFN1cT276Qfsd5oQ//Bf3y9OreJBwMEAb7PMwVL/mF
         IakPl/d5S3b74eNf9lO5IsBzFWsP40xTpjU4AvtS2D5ZXHEbNb81GgNtj4SKSqqeQt25
         VldypPec2Gu5I7uwTU1XiFEiRZvtUHSeazKZ0Vk6AqTMF0sjyhpBltqOY+8bEMunQzkh
         bxSJQ60sYVBjC7PZJTYSaLWNvU7bq40vwWk6vk7FeiKnpHzkgEKhlFMQhxi0B1NGPbpy
         xutopDR1pAV1cxYgV0bz/Zvy6oo2eeVhOOfD55eCbwyXPKt04uurZI0cRMAX5x1ATJjX
         U+/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810785; x=1778415585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ql9KVYgegbbTNgj4ztKC4tjb/9s2uaGUqFZBx3n9xtE=;
        b=Yxq1nrbfuFTRrzwv/hL5sPQ4ip8KCpWl3Vk6DsjYstS2SifLYnJbx7X19lcHJi2ajg
         IdGnH9xcpHRez7hSxybeM9OIcRdCqKUin6W3HBy9CaAc5gRo7lGltuNDwLEubgSS/z7g
         N5quXjNLA9PQi2moKO/ywXqXvA/Cn7r/U3eJuWJ2LQeIFsemVA/LWz+Qi+LHJdKz7bOH
         8D4XJ9+ui2SnvkJe+ZPKczBTgrz+C7h9weBlCNcrH8G4meKFy9NV3H9/WYwkk60osso8
         qUzW4o0kL3oEWj7DLPbYCgwfYRYxgxRsL/yjRttETEXXNUjyUN8k9mOPJtB7BeF2VxoV
         ULdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810785; x=1778415585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ql9KVYgegbbTNgj4ztKC4tjb/9s2uaGUqFZBx3n9xtE=;
        b=WH/KX+pdTqxLnphi7nYrBaEs94qePPME2qU7zx0sHqjxchzOmEi2RzRw/ResIG/ODo
         l37pu4vRDywf9akJ//sXI762/CoxRIX9P8PXAvx1i8dn1fiI2vWDgHliF/edJnNBRXg/
         ZCY/bEW1vZPapk0PPmdLvsf/K81IDirq+N6gRGaOtUmub7QebmDEhuRTbN6mwriPXcZc
         9oQlxhLZlyJLweuL6A3FJ4ztFj5gthYFeuZqyNBkQtTEjoFLVjNtf4Wa49B07gminnRP
         Mr6GJMmfTEkjKQT1s6Iny8Ir2k1O3bHPsQHjfaANnmKa6bnlHt+753qP0ajuwN7Txzw7
         PMjw==
X-Forwarded-Encrypted: i=1; AFNElJ8UQ2fltTrXd28NEdXnG/cjMIsWoyrphD7Vu0tD31SWkqWFLzYRbWffnMg8A4h7FmiKNIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRpagfzF1CrEFnR3/budJTd01v2EtucY35cMac2nAMuHSRHSeo
	0KOWBSyTgV+1n3O5hp4NMbpner3zEihPvVxuMuRRQzBzYCjZojt7ZtdO9KwHkmbPA1/f/UpbVaQ
	9dHcqM8Z02HWkXbIETmD3854yU2D6jZE=
X-Gm-Gg: AeBDievpC5K3CwcfujBMAC7UC7mtKp2VfeQi3F9iejSo1kW21m0bDUGKOTG5lqUaOAj
	UldosJKkUCb4ReQ698Rvl2c46p5YGThcqtsbtORzIwnKzOCcws2wiFhAkUkGg3WKKl6JpbtgutT
	eRGcLTTUzvOnkOugsKK2VuY7v41wMCdnbvuwv59vZSQs3w1+vDrT2HYSvSDrBI8F5xRy2aGprFd
	XaVNu6CE9SPEafVZoilzisnvZqOaLJIAUTzNGZhYtB643uI3RKNdOUp3aa2S9paLMhuAMid5Rv5
	QRTsCyKxPeietgPo4JOliAxlyArbrW3n5QGKk6lYalgaEHKzcTLRwRZpDbQkYMlSjoUrPch7fS2
	0z8R7NaG05eYwRO8f/t/8fG+L7V5FlevOleVBmKOsk7X+SEEulyV+jp0xVccN+yA1x0k+dhRDNh
	Sep/Tw1NatwjxDZFs=
X-Received: by 2002:a05:690c:c664:b0:7a0:4a34:16d6 with SMTP id
 00721157ae682-7bd77274684mr49675917b3.44.1777810785054; Sun, 03 May 2026
 05:19:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2287.git.git.1777803242592.gitgitgadget@gmail.com>
 <CAN5EUNT27bYwjdXRQTffbtHFpkV68rAajqgXtbKHu6OjhzG_mA@mail.gmail.com> <AAB01B60-F569-49C7-916D-A03549E6C210@saagarjha.com>
In-Reply-To: <AAB01B60-F569-49C7-916D-A03549E6C210@saagarjha.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Sun, 3 May 2026 14:19:35 +0200
X-Gm-Features: AVHnY4LYnVgfrHtnY4WuaEVUOaTwBl6gJ_oy4aoXmlzDoEQ5NOcOgqbt_KnB7dg
Message-ID: <CAN5EUNQoT1y+09bCMwKiyw4zruRbsbxCEpE2q4-rVwRDK5u9uw@mail.gmail.com>
Subject: Re: [PATCH] submodule-config: fix reading submodule.fetchJobs
To: Saagar Jha <saagar@saagarjha.com>
Cc: Saagar Jha via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El dom, 3 may 2026 a las 13:24, Saagar Jha (<saagar@saagarjha.com>) escribi=
=C3=B3:
>
> Hi Pablo! I figured the change was simple enough to be self-explanatory, =
but I expanded the description to indicate what the bug was. Let me know if=
 there=E2=80=99s anything else you=E2=80=99d like me to fix (I agree that t=
he CI failure is probably not related to my change, but I can try my hand a=
t looking at it after if nobody has?)

No, by doing a quick search you find:
https://lore.kernel.org/git/20260402041433.GA3501120@coredump.intra.peff.ne=
t/

I was noting it so other reviewers know that your patch has nothing to
do with the CI failing.
Nit: Try to have 80 columns at most per line so the lines doesn't get too l=
ong

--
Pablo
