Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79B7B672
	for <git@vger.kernel.org>; Mon, 11 May 2026 01:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778462968; cv=pass; b=AlFWTOc5OGLbhDO2uDDDE/rAIRsnfQCmB7OeyL1kpd9mkG99eqPpXxu67h3we/y3qNcbCwPKVtPd0hhgkexb0qCXNlqFH9rJ52LE4s5/JFJYfkdnjWl4cS88bHQcLkGuMStzzieckG2B50qf2QjWk4LmpbKTRX98OO78SxFLl+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778462968; c=relaxed/simple;
	bh=dZTx1Hdn9diIAvbjZjj6VaYt5oByCtIHIZ16ly76eQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EcBeZ/FczcSJ7zb14lOF2QAaC0nvpJBicmT580BLuCq9DSr/GQupqJSkhmE76xiQIm0+2hXv0aU7ux9GxgYzSs+HVXckzpvj6inJgyb+L1ilyjadq31iodVwx6qYj/OmJxLqfQ4/N+2fAQzJbUyaUdxWzFDpIGCiMa12gJV61FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkWrG2Tw; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkWrG2Tw"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-393a49d2e5eso31862431fa.2
        for <git@vger.kernel.org>; Sun, 10 May 2026 18:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778462965; cv=none;
        d=google.com; s=arc-20240605;
        b=h7LdZRd1n0vQcBHqPEuuld2JergqH7vUZ73R1YKMLmfTzOSZszl8MRGgDd9XC//O5L
         FRZjtYaKFN9Mu9x0LfV10F7xZrQ/UXxRa44jf4KyApoHOb/X9MJ+kdrUArc39z1Zw8Re
         eBpHOvgPFiFnBw55RDc+S0mxRHMZtWHUTQu+wgIK6jNeYHxEpRlF4ImMIlKgkBjaCTxH
         GYGlErvUxcNwLsAoqkQ4w3gLDggJlNhmt9OlE5k7bTZx6mxyBMRMCgUNedW/wc1dTxc/
         FKL5+TbFqRbal56xxDOKCDojB8M42lE2zVR0m7sRUD0DxYJPtsNAFS3e+STjQ4IQe3ET
         jfBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqeWy+/szqcOo/ZIq8viyPWmeZYbtIKAIGn2Ux0pJNQ=;
        fh=DOj4aov6QCZNHIut7J9bRSVLpYXeERrLPgwttad+t8s=;
        b=M7wfHpypn3Ex0mCDptUu2pO3+rZGcUrlQEUYCiaHx5w2St5DhNhNfknutV6lPR/ngg
         kO59Y4vFzyH6rTuD7unkJhsi/v1UDK0WSen5GGOcwRn11erar50CqXCYLNBPOK7O7tJO
         Y+yQ2y43l0nOPp+hI3PZHosqL55/bodcJf4ywERIdo4lU+gCJSl1fWektvIARnkHiXs4
         tSahrwpJvy0XWGnA5WonOQQIw02ruIdZnsN3kBE83ck7nUVCtmZUQri3zTgcANRacSM/
         KBA8k2PqNmt9pQ4JFdmzppaUzDpfz4RIvBeAu97rsQGwTwFs8Jqul9JmrEkPvYZTm7I2
         ttng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778462965; x=1779067765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqeWy+/szqcOo/ZIq8viyPWmeZYbtIKAIGn2Ux0pJNQ=;
        b=mkWrG2TwD8UGSZiuBJye7EP7vE/FftmwNPpFFX1OaRATJ/Hb9y/zw4OLVcZQgq3gad
         OlMjnvotuzs8j+ynKuq4OTC9h9y2SKPkl3+X8guFGUEdBdSHUZEGqydFNgh5RQeF/o+z
         35kwkSI47a5RtA+dojA3AF1kphqEahe5b+/1GMaQuCIZQrHfJZ3W3R3xpxvf9zAAz7NK
         Ij5B2BgSX8Et9tIcHVruDg95cwRAVJV4cuHrot2DQCPDLOnPmhMXo6yb0OTGfFN4LM58
         IX1V/GV+9vf6OSwSgqIujfi1LxjrsKXB5jIrxLaNBKae67Q/gBYxe9y35KmPDcRIPsca
         p6eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778462965; x=1779067765;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqeWy+/szqcOo/ZIq8viyPWmeZYbtIKAIGn2Ux0pJNQ=;
        b=hE/2zxIt5TaiA2m+kiujNADjNcQy4RrWtV4p/kmwceQk/7uBVXEWU9RugdJR8LHgUw
         nZjA+RIRuRUuw7nBpPLeYqhgW/mR1fI84P+32H6rX4K4Kw+uzf7CYka7y9f9Thjldvf0
         QkebwV9UBHHiHgNgUIajwfrG5D7LMxxxCrWD6/a7MpHx8466hfkiSM+gUp3WmqpHpagd
         o1+jcFMISA2mA/kldAVmrvFwf86sX8IjT1rXGjpRQmDXDmmcJwxu+Z12xYMl4VFCs4Pf
         fzxihjK2j1cVJVAG1z1VVLR7KRSlYd7jdoKIbuNAYTrebXajqrWxGQudJry21ouxGzXM
         aAiQ==
X-Gm-Message-State: AOJu0YzU8stFPCjAzkr2b+cvWCWh2Nhhnm/gpOHec5THfCbdVpcYUHbq
	CwwfiW/CKGTHDZFltNcUbGpIXqDKa2d2JPCtlGzQPXHaPBQkh8KgSihp0MBnM+xm7+7F352ikBP
	a0zq67yF/NXgFCc9EzFF0HmjUjfc4nOQ=
X-Gm-Gg: Acq92OHgkYdd4NP9N6YZuM62iNJg84io7TLz8Tx+glIFG5CDEexmrj6ue5YVq71I7K/
	QvqEBskvKh6DVSbwJM97W0XuwLyBX8pqae6s7o8gSsSVZuPoBQgpEWroZZdNT8+JC89O3KIg55w
	6ElSAlgWyLlw+OkaeNjf6ENy/2hDyLo0rRX5wX3wqBuDBrl+ByaQJy+RxmMFn15yyA+HM1BbbML
	WJic4/xN5kGPienIRs/Vh6NX4orxGhdA1WsQUEv2IUSqTKDnR6F+yjpMrOzZWFjHDxmNvjW/mXC
	6RcpbnXn/SADhn3/WssRTPpxJwz8jSGw+GRFBW4jZB16WpXkK+/poh1UCgRJrHGElWnb1XEnldy
	lxSuy7og0I5ouOjjex30t4qc953PwrQY8AOft+27EkStx0BkdVtxOIWUkHpaK1Ew=
X-Received: by 2002:a2e:a448:0:b0:38a:43eb:239e with SMTP id
 38308e7fff4ca-393c412e1famr57061931fa.13.1778462964696; Sun, 10 May 2026
 18:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260507-document-log-no-follow-v2-1-ee7bcbbe612f@gmail.com>
 <20260510-document-log-no-follow-v3-1-d6d3368c64bb@gmail.com>
 <xmqqik8u95yn.fsf@gitster.g> <CAJ-ks9mPzCr3obAw5cE071GNjzy_ZLzF4mQdnUbQY5H4WPw3sA@mail.gmail.com>
 <xmqqv7cux0q7.fsf@gitster.g> <CAJ-ks9krzLO_+O74omAfeVByUBh=rDGSVSarf5PGwkdWepzubw@mail.gmail.com>
 <xmqqh5oewz6c.fsf@gitster.g>
In-Reply-To: <xmqqh5oewz6c.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 10 May 2026 21:28:48 -0400
X-Gm-Features: AVHnY4Lv_eQUJxteggQu6iKpKfoCqryO2wO-5gGn7-Bc-GFUWA1kETyt9SQg6N8
Message-ID: <CAJ-ks9n=DcwqyP7K_q0Ki6_3_+o5=558FK1DKr0+VyiM7q69EA@mail.gmail.com>
Subject: Re: [PATCH v3] doc: clarify --follow and log.follow for git log
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 10, 2026 at 8:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> >> Undefined behaviour can change without notice, and users should be
> >> strongly discouraged from using it.  Describing what the current
> >> implementation happens to do moves us exactly in the opposite
> >> direction.
> >>
> >> `--follow` is a checkbox feature. You can use it "only with a single
> >> filename on a linear history" or all bets are off otherwise.
> >>
> >> That is what we should describe if we want to be honest.
> >
> > At the very least the documentation should state this...?
>
> Sure.
>
> Doesn't the current text for the option
>
>         `--follow`::
>                 Continue listing the history of a file beyond renames
>                 (works only for a single file).
>
> pretty much cover that, though?  The configuration side is a bit
> more verbose but essentially says the same thing, I think.
>
>         `log.follow`::
>                 If `true`, `git log` will act as if the `--follow` option=
 was used when
>                 a single <path> is given.  This has the same limitations =
as `--follow`,
>                 i.e. it cannot be used to follow multiple files and does =
not work well
>                 on non-linear history.
>
> We do not say anything about what the feature happens to do when it
> is given a non-linear history whose branches each rename to the same
> final name that you start following from in the more recent part of
> the history, either, and stop at saying "does not work well".  We
> should treat that case the same way as the case where the user gives
> a pathspec with multiple pathspec elements or a pathspec that
> matches with a directory.

Sorry, I was unclear. I was saying that the documentation should be
explicit about the cases that constitute "undefined behavior".
