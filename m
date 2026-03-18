Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D6F29ACF6
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773864335; cv=pass; b=m8gL6i0zvsuz8ArybfXKAQwKj3l58p1f3RkeydQ8OtWgBMQvay3jyZh24p8BqtCHnzQGMyn7xTkd+qplaCOKLHD3bGiEMxLe+bTq0fEDHehTeUcR2vEIsCovtIW7NZGQZK0GAwE02wLWeN4244ueCDrNHoFXU3T0alJp399rlBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773864335; c=relaxed/simple;
	bh=VyhYoSNrwdANHS7IEuPnSmCHqmQY1Hl/aFqXB+52Z1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nolMWs5CleMoXCDhvvCOm8jTkOolzjfuv3A/JWvIWQXWS1uDdhphRy5T9lx4r1zNvXxpqgVWmFerdvO0Fevldbsa7GhZF4jkjH/zhLLAecF6cvuNUL7YO6jtCEyM5U/hlxhW/WK7TNzihZTNRAnxP0FBcAvTd6dZ6Fu0kqJspOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eI6pmexr; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eI6pmexr"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so2542125e9.2
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:05:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773864333; cv=none;
        d=google.com; s=arc-20240605;
        b=PMOy0kwk174ef78KkCfkPQXW+9XI0TqV0IcdsfRL7j1KC7l/IzJwM+qTHheD5hAVk8
         AklAiWnixpxZWlH8Z3js4dLK/J96AFrAXkQxX8oKiAHSlOjlxXCFoi8193VjgL3Y1+Nz
         u+l3vA+N8bXXy/QMT4YR/pwF1M0YKM3FsBzr4CytqClKJMnTTDhABch9Bg9WdicBiVzo
         kREgiOUaRT9J8tXW9D0JbYCoRtyqS30rlnUmYxy1u7f4PNbTtn4dMJpsBiZDUW0SgO/6
         rKqulg9iUUO/dRDLHPUXnqFFBWp8OFLCoQqIBv2E4e7ybf0FI3Bni2AmOvRDW5tCvF4D
         tIHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VyhYoSNrwdANHS7IEuPnSmCHqmQY1Hl/aFqXB+52Z1A=;
        fh=Ckcgi/XQvE6gZyhlhU63+krna+9MhVKkPE122X8g5ZU=;
        b=MZsSyhHJ8t9uPcz7Was8CCg+wA7Z8eYkVMQ6QYen2X+mu7LJQl810Zbrmo5UL8CHZN
         zSKMg2HXtmJiui5sG3gLtY+PE3/uONFJr49hIoXuiCDtyiXNAwj4o1trMy7GYXSfA+yg
         B3pX6PGSipVIftl/CzjGGg7DSl6LqyI5IO+e7qTXy7hZOfwSmtIYmyJ8r12d8YNNGXVR
         VWUUMDLP4mdJT22BeWZpgmVsXiNDANlmiqkrz8OON6E6NaaTx9fGrtHkZ8xSkbZnNimW
         +0kqtcJZIG4Wkg9CO1BOpLByeTlfJUbWE84llLZCTE8ZogtthA5Td3rkPAZdlp1+wX16
         W0Yg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773864333; x=1774469133; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VyhYoSNrwdANHS7IEuPnSmCHqmQY1Hl/aFqXB+52Z1A=;
        b=eI6pmexrMEMUWgRw/swc/k/dV5O/cxmxGWpeAKHNYcBEn2SBGupDX7RbgUtGvdi7BD
         e9rGaZmQrZ0hmpQ2hbSJC2Xyr6tHVSh+6fTvN+xHTRUWQHHB0cAtkW8j3McKKF01Aume
         96oKMWGFYkuDRprqpokF42wCFD3ozEniDr36WE2GdluSlJ5Xdv5S2G9y33aNTbFPBEV3
         zvqiDAnLjTaMiZnUAbc0jab0U/pNliIJErqmXL4Q88AV9Nn+sz+HACtsgH2v5JHsSFse
         gpAEs+U1twsSYeqNwc4E7P9Adkw680D2vujbd32NlDlot8RR7c+DZ2jDbPNB7bpVtO9h
         Au0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773864333; x=1774469133;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VyhYoSNrwdANHS7IEuPnSmCHqmQY1Hl/aFqXB+52Z1A=;
        b=XLqXT3n1bQPdutqE27lsX48Znav/fQ8ElCbPdBnQqj4JAKiP7yX2H6srBFC7Spb1cH
         SFXXFjMbx1TScTo0yLZFNLmCSXVoT+6A6vlE6y0bolvlA/rNLMelwdATe4uph2yU4DQc
         ImXNwS0IcrpMktxY/fxRMOTqnCWnM+McrDhrAIW0He8S1cxrdCGBNQZgdGuzi/xls9Ex
         QRHT43cU65HjuWJDBc+xp5XjUulh10PONjg88ZyuxHnt/EaV3muO+P1iXh43izf6KLWj
         MtgWhEhh3OWgks41TjxVgHpQkVRLhzoQGbXW0BDHYYOLvOwYUotorjAIE5WKb+/tDWbr
         r36g==
X-Forwarded-Encrypted: i=1; AJvYcCVaDmzWOaccHNGFibK81lgZSR7cVU0NbdnKs4f4GDiPVQLqQoGaC2DdK2KNV7sxHexqI0A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3ypFjfzbYyDRq8r8zYjIiBJ3wU6ZdCCaaMacUI1t8qHQVmbkF
	2FSsxpKblkaVyndbJW4B3bAPBfEEPp8yU5JObEjLxBO1dagnzGU8VZ0mZYExLc8ZGdCanzA8mfA
	SX8nGHiKswrxda6wyHWMTlZFnkosgOgM=
X-Gm-Gg: ATEYQzzoR5HQ/Y3vprcPCZvK5G2hecduqoFhNd2OIwFxWk02O8faygF5njNgML8wb9Z
	G61fO4UpG0pDSDbtocPJ8nfWzQPUMWzM2/+RPakjaKcI9LxflTrnAkZ9YeILl0wMaZJQNOi1gkb
	0PDIQixfjwYY53vLyBy421Hftrr1Pl/oaHeN63R4pQ3u3agvjfFRpVhQLTCL6tSby3sp0Spvtnd
	V8nOAGZ7RXr9HCAaxJwo6M8I7qCmSUdVPltnQYY8X7KdMqUnZSyV8EDzKvFU6NOQpXVobqtTXN1
	5DmRpg==
X-Received: by 2002:a05:600c:8b6f:b0:485:6ec7:2df with SMTP id
 5b1f17b1804b1-486f4435d46mr73121775e9.8.1773864332521; Wed, 18 Mar 2026
 13:05:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2071.git.1773857555312.gitgitgadget@gmail.com>
 <xmqq7br9q8d6.fsf@gitster.g> <CAN5EUNQOrBC9o8go=Vehzyzt4R_1eN2Hn5Q8t+E7am9fRc8_sg@mail.gmail.com>
In-Reply-To: <CAN5EUNQOrBC9o8go=Vehzyzt4R_1eN2Hn5Q8t+E7am9fRc8_sg@mail.gmail.com>
From: Aditya Indora <adityabnw07@gmail.com>
Date: Thu, 19 Mar 2026 01:35:21 +0530
X-Gm-Features: AaiRm50eg4O5nJ0-6_E0O9zGcFQXh4KDp7gOT2zEPkDaTWV9Jpcsq4MIBaWf_lo
Message-ID: <CAP6n+1V6b8Kf_jci=ZMX7=HNH85nX+z1FffFzy1hYgaoySPNDg@mail.gmail.com>
Subject: Re: [PATCH] t2107: modernize path existence check
To: Pablo <pabloosabaterr@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, QUANTUM via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> People seem to add the above to their test-path helper patches, but
> unless the coverage of the work is fairly thorough and you want to
> say "all the similar issues should be found with this command and I
> addressed all of them", I do not see much point saying how you found
> one of them and addressed it.

Understood. Will remove in v2.

Pablo <pabloosabaterr@gmail.com> writes:

> This seems fine but it could add more about why it is better,
> something like: by reporting loudly what expectation was not met.

Good point. Will expand the description in v2.

> I think it is because of how it is explained on Ideas for
> microprojects [1].

Yes, that was the reason. Thanks for pointing it out.
