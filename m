Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B95D538A
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730072921; cv=none; b=fyvzBv+7Ndz0MY0/zBAdHRriU+WIOFVnyXiNTuv0KtpiJvUZrmkSbdfyUHWYHMeZq3YMlYGgw3QoYbHBjqa51o9ivHDAO3p8LjvKvwo1r/za4ydBg0msENcqL2xyoNRLlDE+O6u1cMwN3iGANNdg0cLMJWg860GA733WSo1yZnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730072921; c=relaxed/simple;
	bh=Zr5EtVeNTYeVNFjH3m3bp8UsQGnQap8mDSXeftCMNUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJujiuzn5LpMe3XZNwH5zsRttrsS/0/St4Vq9RpGQT1TZkL/ZPTqXhnHbsKuAdZFhpScqMQBOM90lqz/QU9uaTo7QzedY178W4CJPHfCLUMSomQl8d//pVez+YTeie6Frn7GdH4ajjQdmsGtKidlP9KlujLilpYqDHpKThhX0Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Q+PUl7Fj; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Q+PUl7Fj"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e290200a560so3763913276.1
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730072918; x=1730677718; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BxmdnSAha1VmineuMIXQtzNxs1BqMwebcZc1OyVijvE=;
        b=Q+PUl7FjUCzOK7J4ypsxWBN1f9xVPp4W3vD9HGUkMtgg8eE0LdkBVZo0oHsPSFHYFv
         aozblIBZXet7cuPO46S68Z2dtoXgt3ksgGO7Nke1QCFN2fnfRgxysK/07FNLzhMekCNT
         eTQ79dYyjjlM57lTshg8ceFlXZUaC24WMaazlLQrBruDLYoSUq5V/aeUMfcw4G4e4I4J
         eG6XSafvzJqp9S5mgYosXMXvyTHpHFsdsQbfH6DtyZfUcNlEtlDRcK7f4effU4HoCgAU
         eAYcY2fEfKmT1FoWNn+as3MwORaaXuzTqwS4Jl70eT1UDy1uWmNZm4n24KdBO0CdcnbR
         Wt5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730072918; x=1730677718;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxmdnSAha1VmineuMIXQtzNxs1BqMwebcZc1OyVijvE=;
        b=f72j6SUN/sAjwBP7jWvIFE90ID6Pyi/soLQTPiHebVrI5LZg2l9XoOJVOD9s4LGtOp
         zA114nty2pAhSOinPfzHT0hAxrgnbCrkfjL+/+XPDOYOfSFIXBD0FhZuZZWjOEk7wDK7
         mPLnQMLiqpIAG7qu9R/JXpCgiVAAC0J6YRaHMiNXnYGJpsuiptiFptT+iBdRAX+he+SE
         kgxtUrInLZQUDvhx72jfUObbstc/5cAPwivRIIUun9xQxw4Lam7PHfITDuGwshI+GdzU
         zXbe2ZqFH/vDsOHtvK/xUnKxMTCK/Vhr8vHEPPy9qfnE4/ZGYsiP1uSXi/wh4D5U25A1
         Lxag==
X-Forwarded-Encrypted: i=1; AJvYcCWlZmRmNh/VsxIYlZ6mZQ72SB5vzEvZnN6se2m6PdvI+41KP7NTFKlIv9k5o+IaJTHLWF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiTn5WFfjAzz0PmyTVVJYYSXb3VC872JIRfFWXIif6FOr6nj7
	ai7QjgsUbCyWnqc2DGiUl/Y8vilzGxYOWXk+mBIK+QkdlcLJciTN5DSiC6SyRYE=
X-Google-Smtp-Source: AGHT+IE2+LCWMpHs5u71WlCmRz85n05l7wSL+iw0tkB/edA+mCzydlHomQeRFM8Pn3aSS9ZPa+Yq7g==
X-Received: by 2002:a05:690c:660f:b0:6e3:13c6:7fc3 with SMTP id 00721157ae682-6e9d8ab3ce1mr54812487b3.28.1730072918060;
        Sun, 27 Oct 2024 16:48:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e9c6bd91c4sm11935417b3.32.2024.10.27.16.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:48:37 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:48:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 2/3] compat/mingw: allow deletion of most opened files
Message-ID: <Zx7RU6sgIJjNSutE@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <cover.1729770140.git.ps@pks.im>
 <c308eafbbb5a7c853b8126750c4c44a8b8635192.1729770140.git.ps@pks.im>
 <a769d5a6-0d0f-4df4-b581-539d00aacbc9@kdbg.org>
 <Zx5eipv_Un3x1j-4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx5eipv_Un3x1j-4@pks.im>

On Sun, Oct 27, 2024 at 04:38:50PM +0100, Patrick Steinhardt wrote:
> > > +	int fd;
> > > +
> > > +	/* We only support basic flags. */
> > > +	if (oflags & ~(O_ACCMODE | O_NOINHERIT)) {
> > > +		errno = ENOSYS;
> > > +		return -1;
> > > +	}
> > > +
> > > +	if (oflags & O_RDWR)
> > > +		access = GENERIC_READ | GENERIC_WRITE;
> > > +	else if (oflags & O_WRONLY)
> > > +		access = GENERIC_WRITE;
> > > +	else
> > > +		access = GENERIC_READ;
> >
> > O_RDWR, O_WRONLY and O_RDONLY are not flags, but values occupying two
> > bits of oflags. This must be:
> >
> > 	if ((oflags & O_ACCMODE) == O_RDWR)
> > 		access = GENERIC_READ | GENERIC_WRITE;
> > 	else if ((oflags & O_ACCMODE) == O_WRONLY)
> > 		access = GENERIC_WRITE;
> > 	else
> > 		access = GENERIC_READ;
> >
> > or similar.
>
> Ah, that makes sense indeed. Will fix.

It may be nice to write this as a switch statement, since we're always
comparing the value of oflags & O_ACCMODE, like so:

    switch (oflags & O_ACCMODE) {
    case O_RDWR:
        access = GENERIC_READ | GENERIC_WRITE;
        break;
    case O_WRONLY:
        access = GENERIC_WRITE;
        break;
    default:
        access = GENERIC_READ;
        break;
    }

, but it is a minor point and I certainly do not have very strong
feelings here.

Thanks,
Taylor
