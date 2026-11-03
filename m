Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793732762;
	b=ZlOW/zujCYyN7DMgUDWtq0irXwmixtfe/bMjlXW0eFLjjMjQanWhjekgOctVkNVCxkQx
	 E5UlK9mUdPGwBhXLcgx5jrRHKJXorVq2o/oS7S0OApGuflpnSU+v/QK4U8kI/1GNaKbdE
	 RGPU8w0l4uGVtx4IcbsTkIHvtFQ1Xi5qIeCKbpYumpv+p8LKUwZgkGWyWVp4SbjK1mlqy
	 t+VzyyG9uBBhgGjoMdS7rFDVgnxEtT+Bf1vT4Wswb108Uwf4dxxasSBcsURM64NoRo6QT
	 0LHaWYi72GNLtBcC6p8R0wiWYPrKoTcp57AHzlX+QKavf6cYbKTZG2WgIQLasoY4WJQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:In-Reply-To:
	 References:MIME-Version:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type;
	bh=baDlr+IZxmXFG8l2fji/DYkqqsTNWTb7aI+o2m6/+d8=;
	b=gLixr4Ko3h2msv4Zug9gLDiGmkIrEfl0DdjuR9MyjmH4+ifMldFkU3pxeOJfNxi70m0S
	 MptoDyfjHQ2vfYBcz/HnjZLQrmXl02U+dn7G+Y237+b1K9XAPMrapuJ/FAB9JKClpE3xb
	 3WDhUN6X5ekg2si1v8izTfNglr8fa54llFy6Ejqr9RFAT12Qwnpy8kKgUbtBDpoG128le
	 yNUiocap4BI0m8WuS+T+YjNbr4/onvkcjywAhrTG0tVvca+8TnPK/IPOyuY0Nbe8jbK52
	 DVeJPp9/iH2PV61ZFDDUGn9nwEsBJH/9AVks4GGMkKfIkFqmMa66bq9C5fw6HYE9eOw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OVGRPLV9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.49
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D16606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72D16606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=OVGRPLV9
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so1293a12.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 11:06:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793732761; cv=none;
        d=google.com; s=arc-20260327;
        b=CZoRT0/nXBfPlNUSFP6gwHGqbVyYRw0qSM/k1NIgSGXL3686/TPr6KWNA0N2iI366P
         JNq/6JmVTHyCDZHBTtSigWtBQDH0CyGqxqVXi8haef7MMqF+QtyU6/YpPKjVhdqAyLrX
         x4Td5NKDNy+9RD0bZSURoFLWJVVoSKGNieTVFEBladwZYkJReLmV4p5/OMyi5Uov5tZp
         FkzpQ0YPj6DsnJO9lS8Ms8UFI4TR1BkvWuqbE2eVWCZUlIQ7U5Tm1EdcOPtQC/ls7IKO
         J8UV9W4stumNfEqSWdX+3kzduv+VloO79Ms4ADkFoBdxrXs36+xn6vQRR18kPxBNXBZW
         Rxew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :in-reply-to:dkim-signature;
        bh=baDlr+IZxmXFG8l2fji/DYkqqsTNWTb7aI+o2m6/+d8=;
        fh=YkC1o8BhKLEX/2gF2JnmcaCV6Pt0EAOAIz81VezVYjw=;
        b=MtC0wKp5wY4FFSEjgT+ezJ9+OzVf2Wv6CuSOB+4MEhHrHxRcb74kQRy/3i6ttORzrO
         PvRVOn2wTLbGKSkGfrl6AI4wwY8zD4/Yl8J0VSlj6fRYt+WGzenxS/dJW1PDNEQD3ZE1
         06kgsmidc9puv89UDLlYCwQyY4hm8D5riJ+Ma8OtvTSMB0atTV0L5xJUIH54ED1ATfJr
         n5wV/t0c820aPloc+N72qxNmJQDLthg418isfTqp9fCTLdQJCW0XdYS0D43b4Z4uUzSg
         XMBAYLnQqTlV8pA5Y27RtuPEavCiI03xYr/QJOP2hNQQ5cM3zSGiGrKowNwlUTljCJCM
         wRfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732761; x=1794337561; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=baDlr+IZxmXFG8l2fji/DYkqqsTNWTb7aI+o2m6/+d8=;
        b=OVGRPLV9fEzF0H4RYheNKBMy4Yi8onqQNHKEkR2eZlxkTEvK6DdOVjD7V822C8Yj2q
         5ejn8A1+EqlE0vtfMp0Gv1H6SdnCaQhPykkiSXTQVgdLFI/0C577PYpK4Gd9/6gP+t7F
         NDjjdPc2AkQLImeBeQ7X0nRwAy/pbF15Rfz9akianceiW1qNbrzzvOr6WBr3DRrzJVPc
         x44amzZWQE8xQqWtSp4VY3K17rGAAfEZnRRkN0CrdcQ7H8Xg+TpejV7oZR3IiS9ZL/Di
         +1VNx6WvlyHTY4dKBMDRNt3A4qwnjZuvezfoFuqWbtjt7V48G4MDSuvJoo7Km8GsJrWi
         qr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732761; x=1794337561;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:in-reply-to:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=baDlr+IZxmXFG8l2fji/DYkqqsTNWTb7aI+o2m6/+d8=;
        b=LtYA233zdg/4n1MMVXEPyFZgAH/594JczNGgQM+2tYiWLELcd8DqWCrGqOnW1Yg5rV
         9EMJWiCImYCxCYBCbH3Iwg6rF/xHZvkmOql9DGLHeOtm66vVgESbn+IQkaemPkEKfakO
         rJi5ALdJ1eg/pA3NCr3tegVDyqoWaXCKB8u//0Kb1aCwMVcqJHv5fXFU0G+LV7OsZNTj
         c86XVkpUcpNQhCOnN8z84rqnHjGRAzU1itm03w+6AcbRBpOYO6Xa0YSMCE034b+fTWQl
         IOhL3l+d02WixmKLEFnJQks9IVMOF4S+iBeGh3+etCftbUW2vN8h/1tLqQvFexUlZC3Z
         /evw==
X-Gm-Message-State: APuU4Z9ukXSjpG5zAl0p03L9IS35i2MOnHRwT7Ow8nqjnh8u5hTvIZKd
	tJptCI4OrukaRkHwJKakyTq6yuPusNRf/PpH8NTzcJuuxDdTKJ8JGHYthjWNXr4LKOmPqXQPRro
	AXvi1Y6SeAOrPtIpTGjBXS5zcTi5r0PBG1NugYm/C
X-Gm-Gg: AYBFou2VbOgyQGkUeVowhW6trIWfhZSEwP8/AoqcQJQB1ab6Urc5gjiLc1bNc4giLVP
	f2naUBC+Lm3ACuH1Exe7ROEF9NxiHOofLMW26AaYUaTjtgT2jRfd+chmBGqHsOu7Ae/V0ApJTkG
	VDtG3CIVLiWzBhf50SNNYd6/f4PWq8GahcvyKzcQ9QhglzTbD2l0pxmAyjDoJjKqVXSoeHxcR1U
	7R8dXg4f/CadgULInJDkJFGxyw1ToenS8xqDQD8KNYbuS6G7/uVsFrTdncFk9Q83cWZugivIi2p
	ykqYB4HuKzi1FIZgyHSVmBAmOFkNMuBzaxUtE/ESj3bRRFCbM9NXgZZSBLrAdhuOOAU81GisHXu
	1XMe8RMm/vyqN+0/Hp2B8HkuFoEEFxohy7lGl5WNa836DYTxjTktErOjZBrJX3rGknSrhcCrz7G
	+HOHbNY54PBiHv5nlbn/j++pXsAPAj6E28
X-Received: by 2002:aa7:d456:0:b0:6a6:7385:3eac with SMTP id
 4fb4d7f45d1cf-6b5561fb58cmr7112a12.11.1793732759229; Tue, 03 Nov 2026
 11:05:59 -0800 (PST)
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 11:05:58 -0800
Received: from 913411032810 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 3 Nov 2026 11:05:58 -0800
In-Reply-To: <xmqqpkwmaw51.fsf@gitster.g>
References: <pull.2287.git.1793462224.gitgitgadget@gmail.com>
 <36cef34668b6e2ceb867ca99029e8bc11d9cd63f.1793462224.git.gitgitgadget@gmail.com>
 <xmqqpkwmaw51.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Ravi Mistry <rmistry@google.com>
Date: Tue, 3 Nov 2026 11:05:58 -0800
X-Gm-Features: AclHuK8awoLIS4_PY8H1-6_B71Zlq2EssGRbNfl6YIY46PYDCJ23G5aJkGN22KA
Message-ID: <CAF+mdieDWEaVV3RT1xmxxpB6KPYOfN7mi_20vKnKe76C4vFP7w@mail.gmail.com>
Subject: Re: [PATCH 2/4] http: add exponential backoff without Retry-After
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Vaidas Pilkauskas <vaidas.pilkauskas@shopify.com>, 
	Patrick Steinhardt <ps@pks.im>, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> It somehow feels that the default value of 0 (immediate retry) does
> not mesh well with exponential backoff.  Will we keep retrying
> immediately after failing until we run out of retries?

Right, when http.retryAfter is 0 (and no Retry-After header is sent),
every retry happens immediately without waiting. I kept 0 as the
default to preserve the existing behavior from 640657ffd0 (and its
t5584 tests). I made this explicit in the http.retryAfter and
http.maxRetryTime documentation in v2.

> Or would it suffice to pass (http_max_retries - rate_limit_retries)
> in place of the 'attempt' parameter?
>
> Not complaining.  Just making an observation.

Passing (http_max_retries - rate_limit_retries) here and only
introducing 'attempt' in Patch 4/4 is much cleaner, so I updated v2 to
do that.

Thanks!
