Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794939643;
	b=2BB5pQPIto5j4bZ39tmYsMmLD3kRtX84AsX3pfePIPjxZI3XlD+lFlC4nroE0aDHMAac
	 wj3KsGNn0SWlqkZq/M7mfAQB2CzQLbVm3e+qxCpNLeTythC3F4+/bF3VDcbm/RUlVWvYI
	 Kuy22cXQLOOde7S24R6e90V/230KmLXkIn3xpk1tUQY9b00ryMBN7v+SJOzQh7Y31WOAk
	 79Rt0QL1GI8gL+6a3l8Ccb/5QEIJFvUjaKQHSUEylW/exVjQhuWucXhDZRo384L3zFAyJ
	 YzMAE/U53InGJWwXOK47WB+Xa6ORpmD+2g6jQW8NdTLBojiU+BwJ83YhUu24k9ltKBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939643;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Mr9Gioz7APaks8lwRUENN/7kA0rQc3+qCQw8XHOeYVM=;
	b=xdLYiK3Lb7YgXPH5ux+m/QjyW9ivJDU+2jVw3FrTib6UYFvbg7rq78AkD7+ezBiBIT1I
	 ZQvsIdZeVTvh1KD6FapTvGsCUTyxFRCJaXnkfksdPLbzEXXhWd8hAqyLZ4LjMNHk7Nf7I
	 RwTQG6H+4u9hzmotNpSK92KrRSfsaRQ+laFgWR6uS/BANVXI0eFcec5Bd0jDMvWJxafjN
	 p9bG9i4N6NW04zBfTOJv5Z59lV7gfGM0UVxBVS4rUUDMrFIEIyQbcrmIsviVZ7PHNXbkI
	 OEFzQkRGYcno2uJWoVJ25dRTjOUfrMfQhBmRxQ1rf2acvlbtAtV6yxvtmGLjU3cFpWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A/AOikid";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.41
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11883606A31C
	for <git@vger.kernel.org>; Tue, 17 Nov 2026 18:20:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11883606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A/AOikid
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-67db6d4054eso3017335d50.1
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 10:20:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794939642; cv=none;
        d=google.com; s=arc-20260327;
        b=ie9RYwfsB9Y7HW05dbjyEnjW9Y9RVG4h66PaJJF4vLAqFQsFsJD14jSYo6ukVvLljW
         3WUdPrHi+2ET/wRRDuLsN4R1bkrNWyFrXEKZCnrXhYcZPEWLfXzwEzz5hSiqC2pnrcii
         GOL5/OQ8qqP3EzdrO2Dh1tpxtaRQ+4Lro1rVpqrOrT6ex0rU54bzf3HwSZyUEcNoW75J
         awFXGiVGUJxtgiBL5lJKQY+eHC9ew/T3EHmRMFVRuz7djA55DZdnYnHDn9/L8uudIIvG
         qZiZ9zFsjMaoWRzNqynuQJ81Kg0pCnGFqtuJKQ22er2TmmRZR0aIkIzxlL7KlOc0fXjA
         UT8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Mr9Gioz7APaks8lwRUENN/7kA0rQc3+qCQw8XHOeYVM=;
        fh=iNbqGl+ZRtOwUE8RylFKlJNZrRuxzRCBZalDHq4T70E=;
        b=hyjuYup5GFanqtCIv61WTT+/rGT+vLpA7OYVxJpURx/dODH7NBH/AlEF73Xo2e8s0Q
         bpTRq1sIWIu546jny4UHYI6XcaNaHH9pe95M3+Kd3uPPU+egpCuOfslgEDtrXI8I9o4c
         ifFzMG4/fvDOmFx0/nO33AF0tuhcg5+uRdF9G5Lg0/gKuXSezRl0OwLNkh6Bg3buB7VG
         YZgL08iTRqbWpfGHSnpqc4GyeZy8edrghjx34dpg2Zn1whneLIr77f2eRCNe25gDpAwe
         Fe/pKTXokPGVy52nkoWMSoWUQ8QWXWsxCn+5q4J/gNri46DGM8GcrZxsmiisvlmC5wZp
         QB1w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794939642; x=1795544442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Mr9Gioz7APaks8lwRUENN/7kA0rQc3+qCQw8XHOeYVM=;
        b=A/AOikidzK++Rfus6jWuei7jznzeRJxNgRcFjTC/yM4Wv8GexsWF7ve6ETIrpKDNrj
         eHc1AirZWtaLiwHBjWCpLzFbom6rc9c6UOFH3Pyo2DUd8QmQnB+lNRUR/YxDF8tHyppT
         oDtHt9v80sjLMdEA6Qs+iJAa4WuTdUhBTHFpfrk6kuaUrsoqA4SWZkHhvzKCTIQzIJTL
         xdFmgdPKe1PX2W06yjZWW0lfjyEfXjBNEajlA05IuyLx4bEjlF3tAi5TArCoMJvi0OoQ
         rxBedFxVL9Ei2C2zGB9DAF1mFzi9PAwNxbTYbJQ/xQVT6X37tGfZcTb3zDt6j0YeEzDq
         k8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939642; x=1795544442;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Mr9Gioz7APaks8lwRUENN/7kA0rQc3+qCQw8XHOeYVM=;
        b=gbdgR/i4c/odsReiAR3aSANu7S39walkOY8GKNW+/xGcPaSJGgMJEBfbNbLUp9SFh2
         w+c8viWor2WjydDS6lu5/BYQh9j8E3VOH1QnYa+jj2CbYysg+zssQjiAtcauzoyeIsv2
         BylevsjbWG/TNulU/JsYumwfAdOmpJQTAK0zndpJAasoG/0TkrBXDBQRi/5ko8Ban+qp
         x2jUbrXJObw8TxECUL4JSDr+juD7YvDD0kUlX1oMRcpv+4P7xEXVCrRFwwUhjwFCBsQr
         46FTFZ8lU5tQR1gEUQz+TXP2BvJFVXTbi43uqyS4JNobPj8CCMbTmtXBmc6+dwEv0ozS
         oLPw==
X-Forwarded-Encrypted: i=1; AL+hErG2bpX9CUiAswIZvE5il8xajk35B4f51GDKwLbVUE5qdSG+piCGDED+VGXYu6Vyplq3Kqs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9K9HVnSEBPjrCvbhiL90xj9K3KBCLcnm0asD416RyV48W41Cix
	60n/wRIdF3MBcTesbIgxgU0ncIhbVr1zkwi7boXl0msGM/tuxsJXmyoTP0YWTDP5EADNxfQnnbI
	Zp025lJ9Z+QYtLMSGxMxF1usDxSaAcF0=
X-Gm-Gg: AZFdTZcoIPz3thxJOzaivDoMpvEnDoZL5jIo9HcXHkczQVUFRUHfVDnxA6J4ibdTuzU
	4xozmt2xKenPeO4/4wlxhk8+ijnyPXnrV/hrWbrIqNsDcrqWpmB3bDPVeWI4vof1GQoAK6FEHb5
	ZUf+tThk3pMOS7UavwsNJJfTnCcS9bd5Iy0paqU4c+qx6MaRv63LvV4698g7drdtul5JXo35erw
	DqdG4Cj1TdVstwwN+0YgIQiOY4vGr4axikLffq57SYTeY/nkJbp+iOQL2WJckm3PL36lQQOYx00
	aVE18L8Y4eH1j47KTieKc4iCueGn44Dah1upuNP0xpHVzGmScTkYDWhaOOS0pnvmecsJu+fFGJX
	ujF+1Mnpuxbk/MBJEMU/l6sgh5lIXfnoRPs8Vtrr1PDj0shE2YY2hJVclYJ2dv7FRqmaBH6yQ8k
	BU06EzXxpezSEdWOJ/pydwxbYcKfMGpTvylz9jS90lw8gYhea23HiqkYD6i6H3N8tuzUsU2a420
	QxcSr6zZitqYLI8BQRBNwDUG0QewS5c2cvgPxdY
X-Received: by 2002:a05:690e:7a2:b0:67c:2674:ec65 with SMTP id
 956f58d0204a3-67dd3feec14mr135080d50.59.1794939641933; Tue, 17 Nov 2026
 10:20:41 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CACWAS-UqbkgfzsJ2283=OgoUHRs-FeRNYc0zkBR2y0XD4jTWsw@mail.gmail.com>
 <AS4PR02MB83363999DA64DD82F6E25FB0EB7B2@AS4PR02MB8336.eurprd02.prod.outlook.com>
 <xmqqik1vfizh.fsf@gitster.g>
In-Reply-To: <xmqqik1vfizh.fsf@gitster.g>
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Date: Tue, 17 Nov 2026 19:20:30 +0100
X-Gm-Features: AclHuK8OrGUvksOeQlGkaSb2fBv6GfxFxHDVuJga_wsRyhZKkpkwqHNcpLkkGxM
Message-ID: <CAFpMFfBJdBukP87oX9a-GMvOncs_US-LbqqTHP6n=7hv-JUJWQ@mail.gmail.com>
Subject: Re: Email formatting (was RE: [Outreachy] Draft internship proposal:
 Improve how command arguments and options are scanned and parsed)
To: Junio C Hamano <gitster@pobox.com>
Cc: Richard Kerry <richard.kerry@atos.ai>, "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 6:47=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:

> I do prefer to see a blank line between paragraphs, and here
> "paragraph" includes a block of "> quoted" text, so I do not mind if
> somebody adds to the documentation near where we talk about the
> line-length limit and line-wrapping such a rule.
>
> Thanks for raising the issue.

Hi Junio,

I can add that to the documentation, next to where we already
talk about the line-length limit and line wrapping: a blank
line between paragraphs, and a quoted block counts as a
paragraph too.

I'll send the patch once it is written.

Thanks,

Okhuomon.
