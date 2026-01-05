Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FDB72D8382
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609500; cv=none; b=UyrSww1M+bobirWdVUlRayudqICTOQ1jdeAGJN2Q5yMiR0XVifihFZzXpJGfsPHx0KQMY9RFD7R6P3+zk7YYEeTnubnme90aK7ARkDLXtsTgkjnbaGoSzuK4VUVFP/y0JiOFvZ1cXtzulIwcUelJ2g49gOxGkWc2f0TsA9bdCxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609500; c=relaxed/simple;
	bh=cQoGiOfcP9Wjqyp2YlPZCqW/hU9h829gPXSwKqhmjeg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b212wDq8Wy7OV0hceG5GdENAwkW1dhg0mo70od1lbVNP59MnFxl6hFtnmP7T+zTsKW1/IFccQ+vIRLDOPv2Xt5+ribybi4aSOH45Q4OzcADLZcfOn2pMP3SaF7LlfyJY5BsA0RngkuSBuF7CkbIrO4u+/XvD1Sb0tmzfsTjMQc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2z8jwdE; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2z8jwdE"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so2940524066b.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767609497; x=1768214297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cQoGiOfcP9Wjqyp2YlPZCqW/hU9h829gPXSwKqhmjeg=;
        b=k2z8jwdEoFUJTlVzbZ4J78SqMh/LxRksoYeg2VJNAXxEJtuFTPwvZcNPqCoycbEE/8
         t3wkWBEXkFiEhJToXfvz93cxumb0sLafv8i6x6F5mJ5f0kEHq4vg52aaL81VzfOxoPpc
         gdm+q9WPf+pfM538uf8WGqAMxQQIFXWQXwpzuQgHUJU9UakJlIP/ESapmYn1UDIPGc66
         OaMf7E5K4KotKUCHEqIFBtDTaYbrQSJcdZ/UCF3WEoIHj1xa3zjS6jUAzKr1n3uhRMvk
         5wyLuolDHYxCkwB+SJGiYe4DRQA9VK3fzQSDg8eVj3nmvRLABWPIYfkUROnVc38cEZYR
         FnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767609497; x=1768214297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cQoGiOfcP9Wjqyp2YlPZCqW/hU9h829gPXSwKqhmjeg=;
        b=CYxT/krdcb89CPEJGipqM5ap9QGr7BdeDxcpCa7m2LRKrG0rSOwirhXfFMe24yRPOh
         Vh93fE7Zv3M/N70cXn+IPYhAvs7bvBeaM+K2jPsJGabAxAQYX6w4qRHK+U/Dt64yw7AJ
         Gcw22VJFYlhQSDWUc+uc24fYyLvcDufR7r5x25hSwTSSU9+GYQBK+y4SKORJD8lTXeuF
         PZ/ABfp/4CWw5F0z8GhsZUv6zxNrGZ8VUP9d0GHKMdr1PG2Mmp2dv9TNGirgr6dRew77
         xGdtSDOUcCA8kaCl6ofl2snaIVWaAQqykHDKL9+6gCsu5QhKh0xZbd3VAo/075a9Dqc4
         XxCA==
X-Gm-Message-State: AOJu0YyKsO7gKd9DfGNyGEmHbRl4L3f3+m1lRDItao/JO8G7XPWA6SkE
	akN+0vuWOiXFdAYb3Q1b06OD05i+0il6cOmMw3NivybylXFKEnFzH7FVEuGa/oYG/RIduaJzMWK
	0+r8u17TwgVNhBgJg9duS5HIECSoElBusoQ==
X-Gm-Gg: AY/fxX62lcIJ0/pXzSZgBIx637CN6P9Dseg0W6tKU27EadImyDPNXGOILs//FR1XEMT
	W+IaUyphUt+Y4NgneE98UKtmWhHkJYFhzu1Wx3jLCQV6CsPipdfKFY23KUVHN6PcEdeIv6pprdp
	lzsKpYpdAox4pfdGEJXyspzVztd2bW8V/Zq4B37srBBeDsyqQm/bOB+XHyy9i56BPhtsI+HGjhj
	hcbwJ9h1jFJB+3jI39qSp1Uw/TRnjWfgxeaM/+Kf1X1mTv3PZ/QVIn4F0HI6abCXYn1ENtO7R6v
	zOfJPlv2ktmQ2Cyqll5OAkOAYs08swwxtMk00dgU7mNFPPbLNxX3esrI
X-Google-Smtp-Source: AGHT+IGh/8LGEL/m8W91Kx0q5nnPxNDRbSRpEt9aMWxjKhUVT1HiHqDE1UWBURYN9lDDyezMpc9/y/Q1jb82V6Pwyzo=
X-Received: by 2002:a17:907:d8a:b0:b73:a2ce:540f with SMTP id
 a640c23a62f3a-b8036f55069mr4831460666b.17.1767609496647; Mon, 05 Jan 2026
 02:38:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251230161228.61455-1-kavyanshbagdi224@gmail.com>
In-Reply-To: <20251230161228.61455-1-kavyanshbagdi224@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 5 Jan 2026 11:38:03 +0100
X-Gm-Features: AQt7F2qYCOah21876mgVn9P2nUTv1C2lyqDu8sfKW7wtXb7zaDeXH4v8o5V0nRQ
Message-ID: <CAP8UFD3vOdyLb-LJtQqHGNESaejPB0kCi75Me0_5QVdKxaqSag@mail.gmail.com>
Subject: Re: [GSOC] Introduction
To: Kavyansh Bagdi <kavyanshbagdi224@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Kavyansh,

On Tue, Dec 30, 2025 at 5:13=E2=80=AFPM Kavyansh Bagdi
<kavyanshbagdi224@gmail.com> wrote:
>
> Hello everyone,
>
> I'm Kavyansh Bagdi, a thrid-year Computer Science student from Udaipur, I=
ndia.
>
> I'm currently exploring the materials mentioned in "Hacking Git" and sett=
ing up the repository locally to familiarize myself with the codebase. So f=
ar, I've read "General Application Information" and "Sending Patches by Ema=
il with Git". I plan to continue exploring the remaining documentation.

Great! Thanks for your interest in contributing to Git and welcome to
the community!

> I look forward to learning from the community and contributing.

We look forward to your contributions.

Best,
Christian.
