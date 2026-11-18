Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795029168;
	b=HnZGBnLswVSwvuqSZr7IsCW4CadqJProyAHoVrexCqSQx+IDdq1lQHkDiON/jNLIOIDS
	 jMhzB+QupLntskcIz0/yDtYfc6il95IvyPRHYRIrG/0lqcVjl9bvffqP7KdIpkreWyZqm
	 LvPYCYUPtzJ1BIhkTyZXe34OMYs2f/08QFFDccSIIVwzagKvlPq0/l3Hv/oyODlK7v7Jc
	 VN3nKpLJRGIV5qtXjJewslbTAZHIx6ajRMKIGqxC/ln1Nq/ZTk/wB3bdUTk+SORoCK9l2
	 SIOuoV5DKvdVHVE3uIVq7REDHoDkB82c38Ln2dJtYwgApWaDPuaie/ZfRbibEHyuxsA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795029168;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=nIs7+J8M3MhXC7R2humMBIyX+dtONEuMEcs0XKCh4wo=;
	b=J5vXhETzOAY8oEH8rLXDyG91Ghh/5+51xOo/BxhzLZhS41YB7DBp110FSR8yVW/PEUpC
	 u1q/cqb1WcuJjs0KNskBwJ1uRh/eKJn945wbEW/GmJlXXboGW8YMbCJap1FFgBf4BEIZ5
	 ogdJeaAEAuEBOhFPhbTRihnqWiop7qh8IyZzl9/JLep+9lWpVQUOF2S+ntCCnQiwCZCEf
	 hncAoc7QPnOSBP8R/cn7mMg5ugqlMPWeAAIFR0RwaqGogUUdzNGva77qRdEfKoGIHDS/Q
	 wqXbntg47/ZPm4A8VgOJsjRvJ7CyP1uadjAOpL0+5WYbcIMz3eqci/SCzeN7MwYTT2w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8D+KP1U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.48
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A5B606A338
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 19:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2A5B606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8D+KP1U
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-702fd86d674so959088eaf.2
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 11:12:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795029167; cv=none;
        d=google.com; s=arc-20260327;
        b=rEOvGwJ5HhmRRiREr+oScrZKZAVxv8e2F7m0o6cpUK5cBBw8DTX6FBRyl3Se5ccdSF
         RSfsGKyLnit8Ofx6b76XzkPoIEh1TAzM3JuY7MkfakA+v+5CwGXGxYydbbobgvin1kik
         iDTRmXQgtN+dFLjq2aJaslf39mVyyCAbvivkGMAS19Q9mAfatstt1wgnXtxD6fqv8ZHc
         6lN0hgQZ60Uo6SUuMYYJQhbzIvX1irc9qtfcUXSPuCdaVAXg2oMhoocWukGZNjzRE4pr
         KcjmWU5918sMGaieJtenG46+1cVrr5d7+JDAzUqd6koOn6i4UeAHgklva0b6Q+xJ7Vkk
         FP+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=nIs7+J8M3MhXC7R2humMBIyX+dtONEuMEcs0XKCh4wo=;
        fh=XktqL/MyGiXPdCiIKDDtLLe8CLkSeKXGqq03+MB/JO8=;
        b=NBjrnosU+TgXgRcttCGSMOsbs+oKMcsA2KIey/0x7Xt8jBd6WN7FdpJyBdiUhWuTv7
         WuLRStpLbKf/5HXkcdsR4dCSVxu4Wi3NgQSCPtJgVaVFDsAr80kotfqfXpN/8ePpwM1x
         Qe3b7pzlflCQhIwJFJFXIAKaNAAqqFCyiNa/WYGO01vd7yDAf+0oRj+UpN4eXfWAoATS
         26G+MUw6qJSN7ZXyQPKKQHhlg+hdFsmuj3DSh3d/VkfroM6P99mKndt8C1Br9V/nnj37
         JF0XlfjBAqqyuK+s1JLbOUn0kjQOuahm4pU6he9i5CE5Jrn98eu+NPDzWOinmj8UVkkT
         2G2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795029167; x=1795633967; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIs7+J8M3MhXC7R2humMBIyX+dtONEuMEcs0XKCh4wo=;
        b=Q8D+KP1U2bB7xL57IJ6WQKUDl9z6UAeIWrzGoYdrhNXV6sS94sBFp76GZ3h23mb/J5
         rBI79Dikk+hg60brLmTJSJXMGP+Ul7Ak0hNKNTCDHo0iSOiuOs+kMezgMRWQdNRlufVP
         Rl7EbF8Ml3ceIEK/WHc6W+WYBVZSREq6hCv1P+uWPF8Z8Drc0dWKML2DdbtkEvtJiGUi
         /gHwDQ0aVvpVGvzlsGlhfSBVQP64dvp9K+KTKVRNlAZIQoL6aXojLqGHFVAU2Pe+W+x0
         R/bOFpeO4sq9MIA8qtVLs9UcuqN4SbgbO/Dhvu6s+mnXzG7jm6l1///LCF/dmLVxI3pO
         XnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795029167; x=1795633967;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nIs7+J8M3MhXC7R2humMBIyX+dtONEuMEcs0XKCh4wo=;
        b=jJUxo6N/uL/mDGfGrqSu1ID8lm/zGVWg+hsyp4MJWnBmQQQP783MT1681+GQVSdBj9
         ekgui8sd6t/4exseAJLo+/fcuLiOkPcqLG+2/jISnOXAzqG2dyaFt5FEUs7NpQoShAAe
         aQKYTsYvt553XEXbUnWQxucqjdpToUm2L8h0o2nF4OTX4GTVyJf1rIkaZC06wQAdma75
         izWkmh/SA53Hh8veoLxBk+7YoXsuQy/68DAPvUdCXQO4acQxDtUnm3u7wbNGYHbI9UVN
         maiZbJRx7H4Cuu0rEOLGBGY9gv3/oziXJkXQ1EjaVP6h/jvjHeI2fil+2k+AWjtp3lEr
         gOFg==
X-Forwarded-Encrypted: i=1; AL+hErFerfa/7zJ3DdlEeNWIO/ImUQVplNUDQ7D8FO1S64GRBlOIfWJdXvtumsgBiC7n3vD/lfk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/YTzTB0sDkwbw8gkrYpKGE7z4q45olzezanHtysBakBK2/lGct
	6Mxoc84Xqt/gMVhNFC6bU+7GEl3HLPxiwkCLepavw9TkwACloMUkBB6Bo0TVopqmloH2bECYh5H
	OUyvA52CA1fKE15RuYZZ3Mwb+A6oJDaC0y0us
X-Gm-Gg: AYBFou2wUO5oB75qnpZTKXGGGTlNNOlnLIysTNQi0RzBejh+Ze9cLm1VAOYVOo/u+5b
	uY/u/V6sTKvZtdLDMRfNABqfapu2DawHTyjFSpJz0vowXgk1tGGC+jkOauHZAZ3HICPj8zNZrwo
	alNQ3305D1hjp+GsN2aUmWwX5etFStDL+uUcznqwehkPebLwxxhcvkfThFGlrKVIucy6IbWhWkL
	5bm94nfYQmH1yCo6TOZIV5X8vUfm6ZtS1WtNQSfjcf35nh8/G30UUZLUoNF2ui5h1z9MIdDj5V9
	FoP89av/6Vv9Qo9Rx+dunLKYjKSEg75N4aOkB4+rqZuNcTnJF+KjEJeINBl8c4/B16bgrXPGqSn
	J4R3IEehiAQT+Mkd+GLi6AOwv50I7ScVvglQ=
X-Received: by 2002:a05:6820:16a4:b0:71a:d76b:fb33 with SMTP id
 006d021491bc7-71b1826ce1emr2427460eaf.8.1795029166612; Wed, 18 Nov 2026
 11:12:46 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <xmqqmrr7fllq.fsf@gitster.g> <xmqqqzgjcjes.fsf@gitster.g>
 <CAHWeT-Zt=1MjD=fbOiAiQtb28Q4DAR_wF12iymXmeXzGyyLgbQ@mail.gmail.com>
 <xmqq33szavmy.fsf@gitster.g> <CAHWeT-ZcOqm9PXzM5W18+ktJ4gBdPNyx+g_2ZCaW25ufKH4g5A@mail.gmail.com>
 <ghwlqak2j9.fsf@gouders.net> <CAHWeT-Yh8yTnG7rLjvO+XBtU=bZHJ3WWoQQsPfvJO013P2GSPA@mail.gmail.com>
 <ghik1uassi.fsf@gouders.net>
In-Reply-To: <ghik1uassi.fsf@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Wed, 18 Nov 2026 19:12:34 +0000
X-Gm-Features: AclHuK8y3FFGl9wM8RErK1obSJ7hbinM9335_LyNldSVTDS7sNLyMADIyiJdSOc
Message-ID: <CAHWeT-ZjZHFE1BhRSwv6cvK4=rk0ZXNak8uG1y75Pgy+vNVQdQ@mail.gmail.com>
Subject: Re: [PATCH v2] utf8: add display_mode_esc_sequence_len_counted()
To: Dirk Gouders <dirk@gouders.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dirk Gouders wrote:
>
> On Wed, Nov 18 2026, Andy Koppe wrote:

> >> And as far as I know, we would need an FSM to identify valid sequences
> >> if we are going to allow colons.
>
> > No. The parameter field can be any mix of digits, colons and
> > semicolons.  Semicolons separate parameters, colons separate
> > subparameters, and individual (sub)parameters can be empty, which is
> > equivalent to zero. If the field consists of nothing but colons,
> > that's one parameter with multiple empty subparameters.
>
> My statement was a bit misleading, because
> display_mode_esc_sequence_len() already is an FSM
> accepting the language "\033\[[0-9;]+m".  My concern was that I doubt
> that simply adding ":" to the alphabet and as valid input to the state
> "parameter"  (without introducing one or more new states) would still
> let it accept only valid SGR sequences.

"\033\[[0-9:;]*m" is the complete regex for SGRs. (Of course, it's not
that simple if you wanted to actually collect the (sub)parameter
values, but git doesn't need to.)

> It seems I can learn something: is "\033[:;m" a valid SGR sequence?

Yep. That's two parameters, with the first one consisting of two empty
subparameters, and the second one an empty parameter.

> But, such a discussion is difficult without defining what language you
> want to accept.  I guess the two links were meant as a definition and I
> have to confess I didn't yet read them.

To be fair, ECMA-48 isn't the most readable, but once you realise that
3/0 stands for 0x30 (aka '0') and 3/11 for 0x3B (aka ';'), it's not
too bad.

Andy
