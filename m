Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ADD3E92AD
	for <git@vger.kernel.org>; Wed,  6 May 2026 09:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778060276; cv=pass; b=N72+DEYbPAMjeSQX6yPn7XpFexVS480PS++C2IU4lE0GoqBubr5D7QUXF9AwIWpEqJ5Qt91MB1ZurEiI2NfXFOSsnAP6HfcEKaeRS2wLKjFVoMbG9HEonLncrnPLsfuFm3xRYar9UzLr7VpkLhqJPmU1d48UHDP7yk3YkE7kJjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778060276; c=relaxed/simple;
	bh=e15yK5JIs3ywqU4VdpgA81ZgD8g/hpZomGuZva4arxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K/KQ+mTDxAX/4wW3B4l39Pcu4mUwWeBYqgumYPSq59CAyReDVU0syPkCfERdUb8npO/65aca8tB8lO/gTtfvwSrXrDN6ctZiOr65tBnNKzaP77Foyo6vUMk2gKP7ehXZsPUEyVn0Md4TWvapxFFZ++D9Lbdn+m8GcvqCEJ/+QBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jjiOXYin; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jjiOXYin"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bb962ce4dcfso908555766b.1
        for <git@vger.kernel.org>; Wed, 06 May 2026 02:37:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778060272; cv=none;
        d=google.com; s=arc-20240605;
        b=lVJy41mWpfsI03Umup9aXJoTKxdpoFJSWD8T7+7FzxDrx0AyEdTlyIN/+SOPuny1xD
         4pERGpNfpJUKBYLj8zFO4T1DpNL4eMriEmlqCpvU7IbdU/K5bCDsyK71mVjFNMfeyerA
         hStWWII1sNkqdSv0U4+kyNYLyJDFP0WoqJYrtM3h98wFsTLUAWTjUKO6V2PKNOrCZV6C
         bVERyz5lBwwNNayy/OXwohF3Skkv79FCX6eKRMUAHc1JLAN9xS4okPJrWwMhmvSfoSrZ
         dxl579J/tQf+vBiqapt8VeKssTO+GECZasFIkuX6L62OU1XPVsrAENKPRMNnsNnG8qBg
         4O3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FnEEZs0LPo8jTzxsyZjVKK/doOEJLaIh6oHE3QAO+Y4=;
        fh=sDGZ+2Nijwp1pt2jsg5Ol1vsqwD5gIjIoV+5qeunqtE=;
        b=Wyyi1sU+N+up/qbVeRvt93noO0n1OnWaDqfK3VIPLbLnNG78PonM7BFJ1unRF93Mku
         xRDUW/EpdZZVz1pUNocBdWS17zT04cZrepiKyO+A+DJk4gIBwCcM6lVfvzEcQtS0c3t7
         b+9FqFffmf8pZB4nWX/COqaQ/OH2W59avhgD4vXewFhdDeEXhGcO6w9dqJTORDALF5TY
         TH9/RGZM3JHMHjFbTvJJ1Y3ZR9WgNljx1Y8rtIx7awKt52lJg/DoA76ulub2SAhLPEtt
         Ul3d9uV4pJIYfX1GDUhS4w53Hy0lDSNNSLlHm21NE8r2pY6Yj9Mj58PKZ6DunjjhCkma
         5qOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778060272; x=1778665072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnEEZs0LPo8jTzxsyZjVKK/doOEJLaIh6oHE3QAO+Y4=;
        b=jjiOXYinwIPC9+LXfo31xNlyPike1/odM1O/DekAxK4c12ETtvAWAc0/cUDtNGPD0s
         PzpMeAHKl8OIxiLdqeTX6OEa6Nk7wgT5JfJvdX/+pvM9xwZvg2umVouB/UpURNftJTVX
         BVfJgYm81BM3xBvdYPrzKfN89rd5PKeldUqnP5sy7bexfKgqPndZSTve6mpw8eD7YQGj
         /YsUOwIXWzKmmBvvyKqmvPCZRJI2ZGW517FuZesN29hn5ascFRm0p9Le72RrBPMng8w7
         pwz9RCe+eLuJPJSJZY/bDeTO3URM3TUEEJGY2/mOJHRxUXqRTWD1qM90uUXEko1ytIlZ
         QiPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778060272; x=1778665072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FnEEZs0LPo8jTzxsyZjVKK/doOEJLaIh6oHE3QAO+Y4=;
        b=JzhnxEye9Hkk+H/x8N5ITExdzy5lKrAdK5UPLGNnr/0m0C3WTc8Ph9D0XcjGI0Ql5f
         Qf+kVBPXyMK+/ieZ/3mYnBgFm0c3vFFZESgGM9AQ0LguiTt1DQfdONNnN7qL8xbf0Dj5
         OCaTnErQdxN0LK0iM/EfuT+x1yZiiko0PjFlSWaOnQlwatfbB96cPjloYnuKPKL2JXJQ
         xUPSWKUJayyvPy7E4R5Cp3WWPm5wA+M5F2BT0Z/7HgAzNfYAcim3AsT6OC9VljHBsljt
         T0YGyfscGkAIhs6M2kAGjqtKkpY+PJyGpbt2zlgaRANoCdigkZMecOshvGtvxN6d+pGS
         Dhcw==
X-Forwarded-Encrypted: i=1; AFNElJ+NXUgLxCwmgyXA7mNVpBYoWR6paTMaKGt4o4D76ypc7c+EmTldbJfCBsxqnsbbC4RplyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaYfTNcsijRqb95AIdJAPErHjFPhnpGNKPxjFxsJ8GbmdtQ3OE
	+4RqGy1gnyjmBPDbNynaC6IjxrDV5IWMon3dx15VUrXO5xhjFBQ5DS9fKhV5GFROHRGVL9neUeL
	ylx6BF705eMpkbx/ro9B1eXPQJfiEhczlAho/1OQ=
X-Gm-Gg: AeBDieuy1gr279uaul3fNK1GwHedUJlfytAVvzCbppx6kecN8ISX9QgwIGTeemjm/3w
	Oz8rWKAj3MAAPT7+Qk4t6iJ/RsdDtMjE3d+5AT9OX4eLYHPP+nJai42+IQJILzIRFAGRxuSbJPq
	UtpTXuydFqy57ePHbQLlskh3lgyN0cYDVGogB/1l9hJ6/yuvMzPha0IJ3aS43gN5Ytjg+Rp5Yu4
	PlkYRqKqnQkXLZQYZM3gs2FP+4f67F16H2c5anAn/qhiijm9CAFB05OVEy1gy0ClfLC3F9F5nyW
	IUCy3KVZ7Euvxl3m
X-Received: by 2002:a17:906:ef0b:b0:bb7:dbd6:b401 with SMTP id
 a640c23a62f3a-bc56cd314bemr110299066b.31.1778060272038; Wed, 06 May 2026
 02:37:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2d3f5504-f5dd-4171-96e8-b5633b6a1f5e@app.fastmail.com>
 <CAPx1Gvf5Vts3oS2BdFQ4PpCR-UY=5cYW7fgOkRuQpi8ug2JXDg@mail.gmail.com> <3364c573-b7f4-4ec0-b471-312aa11028fe@web.de>
In-Reply-To: <3364c573-b7f4-4ec0-b471-312aa11028fe@web.de>
From: Mikael Magnusson <mikachu@gmail.com>
Date: Wed, 6 May 2026 11:37:39 +0200
X-Gm-Features: AVHnY4I_lRfzlWzG4nU4kvXZDSuH7rgzQmKToNFgN8jQ5en6C-4RZgBx3Ud-SWc
Message-ID: <CAHYJk3Q6xjW8mBvbQkN3vsDb2e9Em6PuDinFoTFwqkTXaKK=rQ@mail.gmail.com>
Subject: Re: Git trims the last character of content from remotes
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc: Chris Torek <chris.torek@gmail.com>, Hugo Osvaldo Barrera <hugo@whynothugo.nl>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 5, 2026 at 9:46=E2=80=AFPM Ren=C3=A9 Scharfe <l.s.r@web.de> wro=
te:
>
> On 5/5/26 2:34 AM, Chris Torek wrote:
> > On Mon, May 4, 2026 at 10:02=E2=80=AFAM Hugo Osvaldo Barrera <hugo@whyn=
othugo.nl> wrote:
> > [snippage]
> >> When the width of a whole line is the same as my terminal width ...
> > [snippage]
> >> ... sideband.c prints ANSI_SUFFIX =3D "\033[K", this escape
> >> sequence being "clear the line from the current position until the end=
 of the
> >> line", and this is the root cause of the issue.
>
> > If you have a non-empty prefix
> > string before this "clear to end of line" suffix, the solution is more
> > obvious: print the ESC [ K as a *prefix* rather than a suffix, but
> > that fails with the empty prefix.
> We do have a non-empty prefix, but why would it be necessary?  What's
> wrong with clearing the full line starting from column 1?
>
> Anyway, do you mean something like this?

If the purpose of the clear is to reset the background color on
wrapped lines, this will not have any effect, since you clear before
the new line is wrapped in. (This is a bit of an obscure edge case, if
you set the background color, and wrap the line, the entire new line
will be scrolled in with the active background color, then you write
perhaps 10 more characters and send the sequence to reset the
background color, but the entire rest of the line is still brown, or
whatever it was set to when you wrapped).

Example command to reproduce locally,
% echo -e '\e[43maaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa=
aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa\e[0mhihi'
(Add more aaaaaaa if necessary so that the line breaks before they end).

--=20
Mikael Magnusson
