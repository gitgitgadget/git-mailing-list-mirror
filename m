Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C3304BB2
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 10:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777286168; cv=pass; b=BdVp9Lo3jds+CuswjLJIGt83jGw+S3p4qVnQt0h2Ah2JJsXyrp37dycsD2zSeq2GFtIjPCVVownHJp0KUIeuMKQ9VRYxpDSrW+cmmkw/bcoP0PJvdHMhv+m6apUtt38I+xX+k7g+lQqhpxXXrO/HNXhY+BMHkuGI3CQvbpBat5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777286168; c=relaxed/simple;
	bh=9OllAWyvpLXTeiXIT2MoxPNGq0kWrQSOQOnV07C2PoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QG2qi4p6tGwNt52bFHZhjftoVExTpFTv4Mtf537Hxhiz5sQal9ksRzkBVsBfJFPC6xD1X7HpMl3sK7sA+otZvWPdp9wmnnUo40m2btbJBnsCuXWhr/PwAKTLYdxGQBwurowhwmL20IoMgrq4g9O1jjRxqKX4xRfusIK5gcXbKpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0IId42m; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0IId42m"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6587cee8b57so1447981d50.2
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 03:36:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777286166; cv=none;
        d=google.com; s=arc-20240605;
        b=gaKfUvi9BSoiUsvJIgtZmOBU8fCHtrHdl2e0oJHTijPobRn2LGHQ6FN0p5+Ytb86DM
         Eevt4F4189iiHFoa2SoF/3VaPlINnu8dHjM5scRkEMKD6UfiWy+phy2pFcbmPTNO4Sri
         jJpUNADMAmAPNw13zK3tYX0JZVWc8IJKdzyj3uuyKju/DzHeRzb3Id/cVdcvA+urHT8u
         azoddcL4CX+qpbjYw2+ILmgC4Sm2kQ1SuJTC5bdwKwDw0qCLRpKHTDdBQaYosd1kxYHB
         oBMQj9jwr3+aDxS7KdbmFyAGsXLFnDknOOseV9JNoX+t1kW4N8dkXL0Dxl6UapZWOUcM
         VaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cK03s26V4lenznyJewG80wil2885FHd1Ff+kLdiPNBc=;
        fh=0Jv23e9qI4uTuWHw4/OJIS1KDYkZM1elnUUXTUV98Qc=;
        b=TlWOoVIGwHvgzjT2cE0hWWimYenqYtpONYUVyttZQ2P0vbFIrG1AFFKkea1cpKEviF
         HousJHQ7LT1oVXI0mZc0RJoaBQ2FNIkmyAIfSmBYjU8Emh/NHn/QM3gKQeeTd8ufqaeV
         +zoa4ztNGYQKweVz339VzDLN708In9U6EnYzQjq4eKyOyPSp/35LG6ThfbmbP9V7MQOZ
         XjXUuHGvDAn9zqWPoQ4INJ/wcGkw3YDZWsJrPsz5/yTTQk/2w3KNgou0GiFoqLK6d13/
         Km6cLhayxEMu4ouTYtUsKqMQvoOrsL+8X112icRRSz4gZw4muqVQ3UUH/9keW+iBUA4P
         M3Pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777286166; x=1777890966; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cK03s26V4lenznyJewG80wil2885FHd1Ff+kLdiPNBc=;
        b=f0IId42mXgTA5xS046dWzEJ3P+S3DzRNNcE5JeDWeYM8u3y35AMh0G1iZVEZRVF47Z
         ECCQevj2RPclkxb/QIXUP4tKWDCOfIff43aBtp+T8vBBOYVFMty38Pd2QaS0rZ4LKSqc
         4GCtAvieyqO1TOp0jW+rgLDD34J+s02kbNOZi+xjySM0HZz3zJ0WKLJy/lYlt8QWckFE
         DR74mB9V4xelNARwn5MzujJn3+qSdqG7G1HBY0HEoxvJiHY90kY70mIQJnzmt1s7vQNH
         yyQ7w1tDACS7n1bMN68vyU/bWnmU0Zcs9jV/QQ54+uDjCMLX73iR/LweA993mcrY6HIP
         zK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777286166; x=1777890966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cK03s26V4lenznyJewG80wil2885FHd1Ff+kLdiPNBc=;
        b=ln0iCseekOKBBMfRWOa0XwLnWk2onuJFZyWJkowkBF4CrZ+lD06iLjVaH5BqmGztG9
         qHb4LcgiMZfc4B4/c/in4jjwsHjBUS3/JKgUiEiC6qmfTo4Uvhmmj6y+i0NV7kPZMQCI
         6s4wV9FM0y+5BorRSQM7L4qve9U99YK8qm5TQ7ZxL4SkhysS4fZ6r/VaaE2A5a8mblD1
         ihWtB7/Wi8BvnTqakaSyLLXqqH94zftDvPAwA5TUaGhXPHU4f2RV0z6rkp/58JE1OxEM
         RLU8fY0lgSYjxRxv32++GnpMXiqns7x6eoVJsuE4L+zeJuUlkf4ajQC1s5uw75+FV8nf
         aiaw==
X-Gm-Message-State: AOJu0YynPbOc8z0hPLcapxJM5qU5eAWARkGBlVZMHJ3oejO1saXW0o2s
	VoeEhQEBAdAYbDD0wR6HhueSh0++9lDiAfgyUzB/aLOQgjqmuzReV19SnHSSu2/ByTETFgGRbQR
	AiV++0H23BYI1biHSpUNWxCWj66jvpgrlAEoaLyo=
X-Gm-Gg: AeBDieubTDPq29rBU5Z4yavr5jLQLylnlrktzSKNCsa9vTXP+jvaZGN8Mb7VB8dKQbO
	BTP2QcQY7lzRYpdCiHVd2I2szp4fmxklQPeOylQoYdWDF4detO0AMk1AVyaMS9fA7JO3urI6gZf
	m92DNP2/A80wiHu8LmO51/rLrFQbj97wO8tCVMWEinrLUwG7Kczx3DB1l5KAhsZNHhpISM4TiLg
	NvRLroRVQm/clsymX95wNMWtPkRjRkSyCfXHmXwWB77gtiZItyQgFFHtH1mf8sJI4f2Q1ii3SW7
	yu732et8Gt8zpv6bGwq+c+GjMlKBXocUf5aecmRC5ZvHf4jS0X+Ke0RlrI2I7w7c8PtuFReupOH
	rFqP+MweY7P8o61pk8V+Wls5tGXoXKI67EbxxICLAvsj9bB/YdBCM2QCUiWW97OoYKtt6ugaJTe
	kp5J0c5hB2N8OKjRAwJg==
X-Received: by 2002:a05:690e:4183:b0:64a:e781:891f with SMTP id
 956f58d0204a3-6531089ec8dmr31806062d50.28.1777286165702; Mon, 27 Apr 2026
 03:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260404092425.550346-1-pabloosabaterr@gmail.com> <20260427102838.44867-1-pabloosabaterr@gmail.com>
In-Reply-To: <20260427102838.44867-1-pabloosabaterr@gmail.com>
From: Pablo <pabloosabaterr@gmail.com>
Date: Mon, 27 Apr 2026 12:35:53 +0200
X-Gm-Features: AVHnY4IKcFvNLOF9uncF7lzu_yY49si9AdPm_6t9yXJXLR0VaLZ_Z7Ecly25X5M
Message-ID: <CAN5EUNR=paCXY9-pQ=78LF0cQak2rLu4eeY905LbE6d3zeygrA@mail.gmail.com>
Subject: Re: [GSoC PATCH v3 0/1] graph: add indentation for commits preceded
 by a parentless commit
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Christian Couder <christian.couder@gmail.com>, 
	karthik nayak <karthik.188@gmail.com>, jltobler@gmail.com, 
	Ayush Chandekar <ayu.chandekar@gmail.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El lun, 27 abr 2026 a las 12:28, Pablo Sabater
(<pabloosabaterr@gmail.com>) escribi=C3=B3:
>
> Pablo Sabater (1):
>   graph: add indentation for commits preceded by a parentless commit
>
>  graph.c                      | 115 ++++++++++++++++++++++++++++++--
>  t/t4215-log-skewed-merges.sh | 124 +++++++++++++++++++++++++++++++++++
>  2 files changed, 233 insertions(+), 6 deletions(-)
>
>
> base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0

Hi!
This patch seems to have a problem to get reviewed, I improved the comments
at the code and simplified the example graphs at the cover letter and
patch to try
to make it easier to review.

Let me know if any clarification is needed,
--
Pablo
