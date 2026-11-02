Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793617688;
	b=MfvBshvOu1Gx2ZYcfXecM6VFx5IjBN4+cfE616f815OHbJ5qEDy9Ao4LvoTujiBzj+26
	 g91XZy5RnK8lKGxL305ijoCgi/wQyFFpc2tJ0fQ3dRxUlkaNXx/Opm3LGrajU6FkunMUD
	 6nkYDhDuwtq05WaMERRCm1pN9ABJBFft46psPVClz9bF6JyWRIZD+dAgiV630BukuCEoi
	 E/J8ZPUHHwbs3sZMvN3Wbua1fpKA4k/2Rf54WZrHzlkjbScvgzl2PQiJ0PiqYcdP78lNt
	 eDuYk9kcNbOYFNV7jzqMk66zf0Z/kpHQ3rGz3Y+ZX57sKx9kF/QEcHj4RzEfWSEDgRA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617688;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=29UfsJJZD00nsgDOW3QpJM0q9R8OvtjaqjCjTi+yOOc=;
	b=qE5ZfdxhVtEdTL2Xzyrvf58b51xpEwpEv4BsOoC5mzeZDgnti39AxJEsvB1salVNMMgS
	 WeDdqKgVIWKjyWZ6Z0j5jPR0TE8BZ9XnC8GcusWULv/VKWG/1ySsrdZpXcOdrvzz93mHR
	 NJllinZUfxnf9fe3ZuQYWhzm2/nKVnFe+IZQyjELmr5HRRLvSrGLoHls330gaJ7TmMnHd
	 JMn77nFKIMZJtvUfalrUVvq/oymPF8Rk5t/A0xuoNBbW5mSIAf5pbtCBdO0K6VypN/xo6
	 PA4m/SZIGr1OIMFoVOCQXz/SLbEwqJnY2g1mSV+3yyCTt3H0qWGsESB4arWTX/J5AOA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyquFYnC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354E606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1354E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VyquFYnC
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b45f9ec1ceso3160200a12.2
        for <git@vger.kernel.org>; Mon, 02 Nov 2026 03:08:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793617686; cv=none;
        d=google.com; s=arc-20260327;
        b=m5RFI3Av8T3LO1V4i451oKhNRz/T0MsUHPFhxk+40Nc+L9lIoDSKMSx5KUjwrQrzL3
         x6JnrEvDYm4JS2QgMblnzuCszQYq7LUpMlrGt0Nfbn+rIzwwFh8710hs2ZYePNsG4FLo
         QqN0v8jtbfhJUTV/KbmiTDySIChUrFCt9xmALEI/D09BNeNMt/yP7d+qyjE8QsJIqpZW
         5kNHZeOwsWGlabvydA1ae7Cw83MXAzeIawCnIeuBnXL4o6bnkVFOrkARNCBLgFm1elNS
         9Z665SzshUFW7Rbvco/NEjXMXvBsZ5nCrDIdJulBtXHlQAwKzyEm84afCF0PaB97n1kI
         RlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=29UfsJJZD00nsgDOW3QpJM0q9R8OvtjaqjCjTi+yOOc=;
        fh=T6XGClctZ/7rfh9jTJVdqO7hAxdMgZvw4p7eTMhDQaw=;
        b=M59XHVZCZpBt66L8xLXeRQXe1j/N55Y+DrwXQTmZrha8WkuZBxQeG92v04P7oY2GHH
         oHGGRnd5wQQUdwPhrmBFUXfsCGI5M0zLmRtzvI77L0MfN6UJ0xCYohZ5w+afpc+entH/
         aeWxP1GscvUfrjTK0aYDb6oApJUpXS+y6FZbhhHZMSMajaGMwY/vpzix9hYXDcAT3FDT
         LEEegb6HxQo/V/0u9wYCLxjuJShbqLLMt6l2lsQ6bCLPi+HSAz9eyCu/YEbkyvX+VsML
         PiM3C+xE3R4zOY/zKnrh7dEt3rJOd03Zf+g9OqW4FKIfNI8CdBnx+wX/y7oSvHyUmhVl
         h4jw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793617686; x=1794222486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=29UfsJJZD00nsgDOW3QpJM0q9R8OvtjaqjCjTi+yOOc=;
        b=VyquFYnCiTt1gNCDjwhNhWzw8O6KopqZMyXMkVrkbi8RzS2bGr2pS9znbgP5caicEZ
         /f6QdegLenwD71Sj1YPCugI/wiRkbQjMXJlb1ABUMH144cwwb60b7Xu1LIO+l0My+EbC
         0ACe9cjMwAXwJdkeAee29zkHMMHVZ8oNR8Mx3fl9Znh0AIgh8kZDb6kKOFFp9VA5xP08
         uf3iX5qRBKbez/6EA6nTBCyKd3VJzhA7APmZzTaiSscWCaxa8pvLAnZrxGo2jQlyV0i2
         D4dLcgjAiLdrWYFKlu9rJPUN46WIhSgY/QIaa2lAn1VOR0m7eP30lVbQpnPu+tAX8iDU
         9WjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793617686; x=1794222486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=29UfsJJZD00nsgDOW3QpJM0q9R8OvtjaqjCjTi+yOOc=;
        b=TkRgHwfnIvydATDXgw21E4j61Y7o5ZqcOVRz7ezL0p5/kepbSgvDJ8R78ZhUaXRFDQ
         L9e9lJNc1nqL/Y76V9qkrEUrXkDkB9iPE+PtW4WvOXiPDN5Z37TVteMLvuU2GXrwy6Wx
         zIK72PIltZJUbfRhVIJOykJfUxAmhu06QjHNJvYPIeqDfUdicYKFs7/+1e7h+rnRPaFv
         hl2W7zz/wYtrwnwCIioO9m73vcbLPSO/m9KloDN1YIoic6AtAT3e2OK26xjItU8Ek/eR
         FHofEMG0vmYitJ5rh+6mBNbQ2tIC4PnqsLWMK8MLUOZynpDV2ZY5mo8JGeIBNsz1LNS/
         D3+Q==
X-Forwarded-Encrypted: i=1; AKwUvBwNwSZOe+SDb0L67fDyRjNiP/iK4Cm2gsQNCxoQ5z+7rb1wNxLnr1LF1FipYk5rp4hSPXE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/SaO03Zrs9zaONDbVqrbjFAjGCsHd3IfUgJ+xTXOkL2oqKOD4t
	HLRF3o+ZJNKCnsrWPxXuU594Sv6pxvvDXjiq6cPTzZPTwbUQXHIOPqjCRiEtrtLTxi+FAPTXfDi
	r81t37SsvL68RiWJZVLpjehPYrnOrwZ8=
X-Gm-Gg: AYBFou39UmVauAyKGzXVwLlTIAQGfpFzyqIrdBx+OoVRTvOxzxDOY+rUmlrbVplCIP4
	BUfPJ/YURrAX5VcpD/Q0zVvyngDMIajh5dOOpfAmk9uPvSyxJvjGJqQPzWxllvW0ZTxSW/44NGb
	Z47zO/NqCfKUQWOXq8znttUjgXGOmEi40i7rCovcmY1YeCR0ANCEJnvFyHoLmeIAdGGQXBj7Vbu
	OcbAbMC/uD5j72+ppj9zBzDh4o02ijaX3vy+7U9lrucL5/NPswgbN4HrTpvsCq/RsvLHli/b/CA
	GkXhPJnVyKoXrvwcc4wHUHBSezxCrTVLiNBEUP6PJAnMFur094NjQsjsHD0aRM+TegM2KXgxbsG
	kEicSJK1XgZRNqC5UriMCTc3J3XHbJqnSZCmv
X-Received: by 2002:a05:6402:1345:b0:6b4:bf13:b4a3 with SMTP id
 4fb4d7f45d1cf-6b4d61ccc7amr4744452a12.43.1793617686196; Mon, 02 Nov 2026
 03:08:06 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2413.git.git.1789898013916.gitgitgadget@gmail.com>
 <pull.2413.v3.git.git.1790189759802.gitgitgadget@gmail.com>
 <xmqqtslzlhbm.fsf@gitster.g> <CAHwyqnVzsvsGXzVj4P=rXJJTvfeQt0D39Aj7R1PTyQVkJbm4DA@mail.gmail.com>
 <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
In-Reply-To: <4836126b-e630-45cd-8757-861133ec233c@app.fastmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 2 Nov 2026 12:07:29 +0100
X-Gm-Features: AclHuK9_NpQWZZK_ACrD8W8YSunujjIgk67VOi-tQ4qaNGw8I-rYXMpSN11br0Q
Message-ID: <CAHwyqnUP_aeKSwj03be0PVdqLX=UYhwW22kBtoWU9Oy2XoaFLA@mail.gmail.com>
Subject: Re: [PATCH v3] object-name: explain why <rev>~N fails in a shallow clone
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, GGG <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> > Is it possible that maybe the review process needs to change if too
> > many things are getting stuck?
>
> The regular reviewers have been talking about review work being scarce
> compared to contributions (contributor work) for at least several years
> now. How can this be changed if there simply aren=E2=80=99t enough people=
 to
> review everything?

We can loosen the requirements on perfect code, as long as it does
what it's supposed to and doesn't have security backdoors.

Many things like tests, leaks and linting are already handled
automatically by GitHub CI. It's a good time investment to automate
more, because it frees up resources long-term.

> > Rather than discarding acceptable work.
>
> My work which has been stuck is also acceptable to me. ;) But my
> opinions are beside the point wrt. an independent review.

Maybe we can trade reviews if you send me the link or links here? :)


Harald
