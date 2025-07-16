Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA342EF2AC
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 23:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752709513; cv=none; b=PlyCxbjBJJZJX/r8vJRB+ir/Kbueutf6W6yrhv0L0o4x/L9Cd8f0D9MFTZK9B4x0XZTvvXdzEkhIaHckFmGskYorz1iMAr8tX8WvB3eEUFe4c47QhieokyMnviR2ApmUjW7geqnzS9X505UUATsJCo4ejlFrJw/q2EdLXZxtIrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752709513; c=relaxed/simple;
	bh=XZ+ehFEeq4kiGDXjL42OiIj9Xe7fK3/i/FuRGPFvtJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Koezb5JrUnYHOnyX5R2OUhU5CsYnvxnj/DgjNUZ68zWfhn/d5MJ6DAy3DUIeIbf4nNJkDraMKzvOYZxEgPkZ2wVhPtHslYxPs+WEdKq0da6UK8RAVDVOMZmHLBib3RtQimUGg7DPWm4R6Czf2jr7MzyTsm77NbYMaZ2YnA1bmB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kbncrz5+; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbncrz5+"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a6cd1a6fecso284829f8f.3
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752709510; x=1753314310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DIl4m067+VC1gPMhLwg6bTGnuL4jgVIraOsF8a+GeNU=;
        b=Kbncrz5+tfL948M27urOM+mhblONpFB6NGzgSkLQmItejLK5b/AbPtMaGqlChBNDRX
         8H7iADkCo0whrrmyD0ex+lgw0ZRF+xnCcDfi1OTLjmu+p9xBUE/hpOAX1o9e1iCtcOBL
         l+n4bkkXEOjB04d3I5+pq2QATTomEWfiFXPpdr2etKC78H16Y5/vD89YABwi5+EBYRGy
         BTc4lYpkmQ7eiWZQwvGLvFtf8a0coEchWPPgMmSlfTMa59+KpYYKxTuYskonNJn69m0o
         TUD7CeNJBrHEr09CAx+ugwXPOggxqi3MA9YzdEplW5xeuvn4Sx0qdXngaS+bkuwLtMnN
         XLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752709510; x=1753314310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DIl4m067+VC1gPMhLwg6bTGnuL4jgVIraOsF8a+GeNU=;
        b=JzeQzHws020vCyDQscFMDx2dk134x7FCs/I1/RvTeM7gjGr/f1Z9A4POW8B0mH5XZu
         cwAQ+952EIWbbsuaTyaNAyTWDKww3N3XGvlvROSCElmLX+vqPbKwYZEvLpqlSAPEgNJL
         /JNFPt2HoP8o0Eb3wjwabsiHdMyiO4nkluXRNmHcq/5KMPvz/kNIAZzR+YOClm8A7YbW
         LEFzO3/c1UU4j293F1VfQhN14ceO/eU8i+uwZYfhbJQyH/cr1D6bVf6wYuDzL7c7sBs1
         8kRhargwLUOa0mI3oV3x1++/r1RFHe222Ge4yRzBeXpP2okUeZSX7dI6PpfXcaDHeIef
         DFOQ==
X-Gm-Message-State: AOJu0Yx9mp5kF5iSKHOeW455K5HS6AZoGEGLiljQH11g/gWc/C1hLjj4
	xsoiDvJkZL3D8AsTw/vrxDaXCMUeW4Fu0+TCFtiQZRD4qPEx47mP+Tig+6MUyuoCHJzsY0Jnm2t
	8F7yP9kwASVLl3/FD54ZIWhgWNekPpZ4=
X-Gm-Gg: ASbGnctQynqgUWTe9nAdjpyfBWEOA8mSKshQcvj16wxl8dddVN21pzSgkkq3F4iLgA9
	Ykx3uAaL38x/Z9MLuaDVvSl8Q4oDbzDnudtby3SA03cVJmSaEMVBz6QMxoly6ZZkmlHdenfRkUf
	DL5+vCUI4Rkaa+kwzSLEVZ8d2TbqIwhCKOdwGmXOxmhs+JCAeUVe7IiaqoGNk+KThLrQe3C5o5C
	XJVY3f2QbT2Jv+oXYvgbiCFfPIPdxW+gsPKJd0GXvtX9vMk37g=
X-Google-Smtp-Source: AGHT+IEPZHjP8NcF34q2HnC50pPOvN3G3Z7wbPcWe8847Ft96uR+4IDlHQPAAWESuCfLQOwaXgUQXvq4+M+NjENzWMI=
X-Received: by 2002:a05:6000:43c8:b0:3b6:936:976c with SMTP id
 ffacd0b85a97d-3b60dd4fademr3440712f8f.17.1752709509537; Wed, 16 Jul 2025
 16:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715114407.37955-1-carenas@gmail.com> <20250716193000.44673-1-carenas@gmail.com>
 <629a1c11-fceb-4f25-a917-319a99bfed57@gentoo.org>
In-Reply-To: <629a1c11-fceb-4f25-a917-319a99bfed57@gentoo.org>
From: Carlo Arenas <carenas@gmail.com>
Date: Wed, 16 Jul 2025 15:17:28 -0700
X-Gm-Features: Ac12FXzdyRwUuf6V2Z0Y-uerfWc7EKTGCkxJLwN_imLKxQvGc-Surtog6Hr4yjs
Message-ID: <CAPUEspg9apj011c4nRCjcxxOsxBtGfBz8p1vw9LwQ1uebw5=mw@mail.gmail.com>
Subject: Re: [PATCH v5] meson: work around broken system PCRE2 dependency in macOS
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
	sandals@crustytoothpaste.net, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 3:10=E2=80=AFPM Eli Schwartz <eschwartz@gentoo.org>=
 wrote:
>
> On 7/16/25 3:30 PM, Carlo Marcelo Arenas Bel=C3=B3n wrote:
>
> > +if pcre2.found() and pcre2.type_name() !=3D 'internal' and host_machin=
e.system() =3D=3D 'darwin'
> > +  # macOS installs a broken system package, double check
> > +  if not compiler.has_header('pcre2.h', dependencies: pcre2)
> > +    if pcre2_feature.enabled()
> > +      # Attempt to fallback, method can't be pkg-config
> > +      pcre2 =3D dependency('libpcre2-8', method: 'builtin', default_op=
tions: ['default_library=3Dstatic', 'test=3Dfalse'])
> > +      if not pcre2.found()
> > +        error('only a broken pcre2 install found and pcre2 is required=
')
>
> If you want to override the message from a specific dependency() call,
> "required" defaults to true and aborts on the line before
> "if not pcre2.found()"

It is a little hacky, but because we are not using the method: auto, then w=
on't
try pkg-config again and fallback to the wrap because as you said, required
defaults to true, and allow_fallback is true if required is true.

The only way this dependency() will fail is if --wrap-mode=3Dnofallback and=
 that
won't cause it to abort.

Carlo
