Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF91241C64
	for <git@vger.kernel.org>; Mon, 26 May 2025 10:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748255718; cv=none; b=b4bryvmzmoIQFzpUa2XOdZDu/+FTtDVsX3OTDP3aRVgKkGOL87t2SZfa3B2ZptIlkm0rZ1OpNobOl73G/gebfmK7ea+L8l92LOrLp6Ot3IC/J7tlfPSqgOVsVYx4JgE9FwOV/cCBD0m4t2ZeR3bzp1U5TreKRlOFvmrFpXlX2Jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748255718; c=relaxed/simple;
	bh=sTI2Oa2k6N5+YIBTxI2+K/byrKGpoPBBBCK08qHKlng=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oAWOmzKuaKhrzxf0xsXfBe2/QGkE0PJavhdsT75DotocXnFc5g1XuF7FOkPsmEsicxaBuWM0qtATwBAXK4wr4VXBCBsRMbewt/MLZ3pYfoshiL1p6ijxpO5giLmbQm+Aic86eSYfHYal+CTAX5i0DsBOHGAiFLudmJ5E73DZ+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvYdx6U1; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvYdx6U1"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-ad564b7aea9so623954066b.1
        for <git@vger.kernel.org>; Mon, 26 May 2025 03:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748255715; x=1748860515; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vc9QjLmI7IyE4d5DgrMeAoVtXAQv2V5UHICnrurDOOA=;
        b=BvYdx6U1KoAG6LN7xRXlc5HMpfxbds4JYzwZJ3Ws6+f5vG0ZzdK2SDHaOgdCYj957V
         00LwDh8NXEt3a/MdqZZx2OYGEMgdQXZgU+/13krTSVQ+G81Fj/faaXi5DlolXtutx3Uw
         GcRWreZI7kCMj99HxcjAfwEIpl11IODNz0y7XwsNFnePQF3HJs4aSDRKtr2JXaT0yp28
         bTH2YO0TKaVasiyFz6esyHuv/29vLuweBYtEheNqS+8FEogCVIlkcbkHlmuJXiv6k3oN
         SsZjtYE+Ho7LWCK6miNfS/2+1Yk9EYyqqn90ZmgEwedwbW51JFu/829KrIYLyTb09wIF
         H7iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748255715; x=1748860515;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vc9QjLmI7IyE4d5DgrMeAoVtXAQv2V5UHICnrurDOOA=;
        b=YBUhwhh9TRfn4lZzr7uApKjg8keyo1PTc/HF7faaL+pSvRC2pgM2WponkPm+p3JY3d
         zsVezBYuZrLFhCcuIL8UdZDoFKUlS4lddmBBxXk5nLEBzBdhLhT4IsguZOOew378BtDR
         deoSFWNb+Al9aLgJ5ztMfOeup6mXiy07SYm1XYitSdcwOae+nsWn2yW8pBr8Yjex/XfE
         mPKnK7j1zwbbniYxN2v70WIyTGharPcQGl8w9Y2YyV8FqnPL8qYmwFESxFx53LRPwr1b
         +un4WUfeUB/xw65KWfz5f5uLnk/LknCXq5GnwH14MwINCwnFjYN0HPKTgWRxPSkhvUuv
         ZnBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBo3SlXodaYlCKXm3gA/gsZurV1Na/AeqadXKXXXWEql8TQx8yglg14ICRQ08Ww5YtM/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD8J0d5P0C71im9TQLsFuhV4hP8QGOynThXScdMjubBAbaAzf+
	B3SC99Rb96xLfCir2CFz+Ib2FndoGT1PU2KvTWcfiKwdmXG/UMcuISE/x0UP0gM7GZVlm8gAz8n
	vgkyUThPsi6Y0JooRee5Og6nzfkFFVQ0=
X-Gm-Gg: ASbGnctjkl91kX8ioC+Eds5n93++mMo1ss9ekQH8vkY6Og8dR531iQ2jqKnx6ic4zU6
	Xhq8MgAkclCJ+7zg2DVlyFxWBL8ivNDzaNSOjKkApCJvIZCvxsx1Qb2pqZca9EnAPyBshVHyKoX
	Kwomay94OtB0jiGhaXGYLC+3XPeH82bNyXMiAzWm9avq1WgA==
X-Google-Smtp-Source: AGHT+IERdaXaksyzo7Eh0hYrbql8WnFEZ29BsuXBGRTFPw8bAuH4gh/omOoa+udY1UQ78G5Mq/3tkWExJIzw6NXgDe8=
X-Received: by 2002:a17:907:2cc6:b0:ad2:e08:e9e2 with SMTP id
 a640c23a62f3a-ad859b5729amr698272466b.27.1748255715150; Mon, 26 May 2025
 03:35:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250424203904.909777-1-christian.couder@gmail.com> <aAq1nvcPRlIPal5l@tapette.crustytoothpaste.net>
In-Reply-To: <aAq1nvcPRlIPal5l@tapette.crustytoothpaste.net>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 26 May 2025 12:35:03 +0200
X-Gm-Features: AX0GCFsh1RYKF5oDBxo0gUeXMBjG2PefiAFwBdStV3-m3UV3QRqDzfrFwSwuLDk
Message-ID: <CAP8UFD1VamVNnoNbD4OFysB3aJSBQciZ4zL-DowCokFqobEzVA@mail.gmail.com>
Subject: Re: [PATCH] fast-(import|export): improve on the signature algorithm name
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Jeff King <peff@peff.net>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 25, 2025 at 12:05=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-04-24 at 20:39:04, Christian Couder wrote:
> >  Here <alg> specifies which hashing algorithm is used for this
> > -signature, either `sha1` or `sha256`.
> > +signature. Current valid values are:
> > +
> > +* "openpgp" for SHA-1 OpenPGP signatures,
> > +
> > +* "sha256" for SHA-256 OpenPGP signatures,
> > +
> > +* "x509" for X.509 (GPGSM) signatures,
> > +
> > +* "ssh", for SSH signatures,
> > +
> > +* "unknown" for signatures that can't be identified (a warning is
> > +  emitted).
>
> I don't think this is a good set of options.  We can have SHA-1 or
> SHA-256 options for any of the three.  If I create a SHA-256 commit and
> sign it with SSH, then it couldn't be exported with this type.
>
> It is even possible and valid to create a signature over the SHA-1
> content of an object and sign it with one protocol, say, OpenPGP, and
> then create a signature over the SHA-256 content of the object and sign
> it with a different one, such as SSH.  Git does not natively support
> this, but it is possible to do by hand.
>
> These should be separate fields: one for the hash algorithm and one for
> the protocol.

Yeah, I agree that the set of options is not ideal and it would be
better if it was possible to get these two separate fields.

> Alternatively, we can just keep the hash algorithm field
> and parse the protocol by reading the first line, which will differ for
> different protocols.

I am not sure it's easy to get all the information without checking
the signature. I have tried a different approach based on checking the
signature in the v2.

Thanks for the review!
