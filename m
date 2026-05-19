Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53903E16B6
	for <git@vger.kernel.org>; Tue, 19 May 2026 08:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779179939; cv=pass; b=pHoZFao8My33KflQzPdUwHF+pFKG2x6WlQJ3bKnM8M4kALRFBU0sRZISm4y7BcbdvtIJYpmJut0+oi5ykNzEaSUjeKrdCB6Zg8KknGXt3QMS7H3A95APkYKGaIQS4rq5AWVzAEXeDC87Hb2HF1sp1DugTMtuf9Ol2QXcGneAzPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779179939; c=relaxed/simple;
	bh=7cnfPK/ClGfAsDbUakeaS8eJNH0QOtR32PUxdwpSTvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pQDStCpay8VfolmMI/NwlizqT+LVo0ebQ6TOcJ6EVn9rI/XC8hy3eACWfUqAgjb6uzrpSpGS34EUBGf6XDv97tKmBW/uelzg2E4Fvjx5hVixwY5VhvInnQJ2KuOPTVTFqsdYVJadbjLnw7IkyMm3HrnJc+/4IP8DOmes5XreYBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lu2xy5N3; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lu2xy5N3"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bd8f6ef4ba6so309324966b.3
        for <git@vger.kernel.org>; Tue, 19 May 2026 01:38:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779179936; cv=none;
        d=google.com; s=arc-20240605;
        b=In8o1mB6rM8QAXvDvp8AUoPMqBNWL618DenQ+g1wovcECegxGmDv68mN3czCL4r4qv
         LHVAU0EjYTpa8FhkJne9bhaXeTIPhuryrsCLpCgD9EjhVnvd54jc7Dq5lWwPk2v3VQhm
         9FTviOVQJh38y+dSIfh4CEypbLk8ZxwY0LnVn66/+GFtTqXpGIjchMQjY0JVkR+K6vm4
         q9qhRU/1jhWs+5NqRaq2SmUsc+RujI8ObPc7GknNXDOdfqe3QxdhjkTOF4IZglfBAakR
         oX2UM53kSKbmH9OVZE4qMjm+/Cdxpt43r8UmPcRC4j7Vjafn2QtNc+2UsfriWjJ0G02w
         D9oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=bZiuBdsbN37XpZMZ9PsAMuUO834qigGlrNC1859ogGU=;
        fh=+cV05xTzo7dNMa3Zi2EIDc1gA3slaAuwhYpcBkpKrds=;
        b=j3algLrxa2ECM95fKoitxTwLjPOWKDLZyiJXc4rTQkBr1sRdRizulsDhlrPZGO05Nf
         A6gS5diJZMG+6RvFuFIWpaG8luZ5tw2wDrzaGC6lUg8TK8QubjZv1EDZ1wpa6Y3Mty96
         x6Wt5C1yQIYDkIB2F7BNRjEB6rijsfxxJGcz1DBsaKJZNjxUiOMn0zeCktU5i6eT+vfE
         E7g98VrwEfmOxmf1qx52RyXL5iyScceAF6EWbnsHbHRdNxoA4At0KsCDMM1M5XIFMmuP
         aFaERmluwqUAn2Xn9M1EZHfhEbgnGrWH5kc8WV0uc+eIBILA6Fx1dBQTZWiosuB0XGpS
         yk7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779179936; x=1779784736; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bZiuBdsbN37XpZMZ9PsAMuUO834qigGlrNC1859ogGU=;
        b=lu2xy5N32Wexi3G7glBMICKRdVMtxTCsazAHHhW5VsGtrM2NU3N9ZQbpS1kiy6NIlE
         DIkvZQMMstO7ZBPa7lgwnfEthKJcyj0jIIiPzcW/l2EyGivJ118TKTzeovYpV/Fw8mpx
         zLknwsatBRbpJEC2Uoc2HjgELNMKc8k0yRGsbROBvzLIT7TxXU/Swt+fVnPDC5ewaCtW
         rcAT2AQtDO+qCGTd7U9tcfzV0wikYRUIICCBEZecl6BXV/TIaEblLCCHiQ391IixvHT4
         Ul6mG6SWJP06+AeFWnVg6LWeG+WJ4uLP97CKZ8wfVYVfPoSpRJwjAZAQptX5NbVWd0Ae
         YKGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779179936; x=1779784736;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bZiuBdsbN37XpZMZ9PsAMuUO834qigGlrNC1859ogGU=;
        b=tFfBUsEoMIHBuMqay5Xp10pOsTQVGEPixQAenqYENr4Gn7sMdnNW6uCjdGOUWfZhY8
         jvaELxWu7BOSuiTuj5N9H+CHHURU//BBVBbNbQxWyGeOMBK8iQrmbuJqqQFMZ8ePyVy3
         pSJokxMG5cKoIv3oOgRlkVlzNt/HRKmHyIXrU9bVYN6B9gIOKK9uv4Qr4WILKiIAN3eC
         cA2gbSiqB7399mzvQul/14RonTwJVmWhPdzq+Oiz+yxzkCzWXfEBd7VxeIjEqTC2vAsf
         KnHImzErRsUo60I0sLqLgoFXX5pvAv0GnH+UrFZgbylcxwJ7vISf4lInI1mDbSFMl1l+
         +zWg==
X-Forwarded-Encrypted: i=1; AFNElJ+A8++poeNZT8zp5deDKstiP16CG0abOVk3o7BABG0Drd1yO9C66aN0isPgzZww8zwbO7s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6dtohKjnh7PNg84N7dcIVZtm0EDjvOp5Rcn2N0SZux94HSFqX
	ewRUdaxwgwiYrV6Y1YLczrPguv7jBGCsagZevZDZ1HxN8qu1tjuEpd8rINlwB3Pe4HDOaYDeRlL
	IqFGB8wjeNoP0EK5eN+EJfF7RRFLoXKA=
X-Gm-Gg: Acq92OFi64p2LQPzSObDEGG8R/3k8zaystoN3jRZ15h76siuhxe4PNa8zvdpKdH6L+0
	5e/Lxi3c5YZhF07YZ214vK8w34wAEGD8YIkoWwhsWAOUAua0BOho7dGPNNTldaBF3MYFu0ZOy/S
	QZzraz/ZL4Rm8Kkkdjn82g2K8HmGb+1JZ3kk7oHa00/CCejY+WPzyusa0UcYUnAkVD6RJw5fnck
	K3NOocuh5quLgd3J8bwbzrS9gDlQu6mwLCYCt6oAo4X/+kMbUC2sG15snHf2Hctt9Yo3XWNnBbe
	gtcX4fQ=
X-Received: by 2002:a17:906:6a01:b0:bc3:989f:5179 with SMTP id
 a640c23a62f3a-bd5177ee410mr1015884566b.22.1779179935505; Tue, 19 May 2026
 01:38:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2281.v9.git.git.1778583307774.gitgitgadget@gmail.com>
 <pull.2281.v10.git.git.1779091483321.gitgitgadget@gmail.com>
 <xmqq8q9f9b5w.fsf@gitster.g> <CAHwyqnUx=59MK5zKL0uuFXKrZ6PEc1j_2WT-_xtsGewVH3gBKQ@mail.gmail.com>
 <xmqqfr3n7r1a.fsf@gitster.g> <CAHwyqnVtZDsBiGSk5rvMJGGk_KRg7XY_rJO4Q37hOxgoO_SJaA@mail.gmail.com>
In-Reply-To: <CAHwyqnVtZDsBiGSk5rvMJGGk_KRg7XY_rJO4Q37hOxgoO_SJaA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 19 May 2026 10:38:18 +0200
X-Gm-Features: AVHnY4IryIfIqzWMCMcXtxRIUhkUv-PHtKWgA8VqETC4Xm5dBlUh7vJcA12HOnw
Message-ID: <CAHwyqnXMWMz+_8Yccgje1FuzcxK2x26eNd9i7+_H1xHLs-VA+g@mail.gmail.com>
Subject: Re: [PATCH v10] checkout: extend --track with a "fetch" mode to
 refresh start-point
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Marc Branchaud <marcnarc@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> > > Yeah, good point. I will try to address this and send a new patch.
> >
> > Please don't.
> >
> > Next time, think deeply yourself and do not rob my time to think
> > these things for you.  I do not have infinite amount of time.  A
> > good balance may be if I find one issue in your current code, it is
> > likely that you'd better three more issues and fix them before
> > sending the next round, or something like that.
> >
> > Thanks.
>
> I already sent the patch. Sorry about that!

I didn't realize how much time this took away from you. My motivation
was always to put the topic into a better position ASAP, to avoid
anyone else reviewing an old version.

But I do know that it lands in your inbox each time there is a new
patch. So I will try to cut down on the amount of patches from now
one, since they are not free in terms of yours and other time. Sounds
ok?


Harald
