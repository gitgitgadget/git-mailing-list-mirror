Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57D214813
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 10:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295421; cv=none; b=sraI2Xni0vrNBxeSavZ767UGhZQEt59udDAFOPzDlamPGs+hoFDr/YNROJxKWc3ZesXu3GXfNkmQfPrFixZN68laBJMNZTRDBHINpnQx2lD3SEscpPY7x3+QyiSaQDnwlKrVVIjr0RtFxPKiLoLMbbLkIzWt5nFvtOnXyvDlOqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295421; c=relaxed/simple;
	bh=xV5XpsSXoMWNNTh19VA7VAwEDm88JQ+Gc85spamJqLQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Q3fq2TSFzouD3BQLKSo7bvmTyZhLQUElMP8oLynFeJOCQXMS2s4LauMkWfsaUr2f15TLhRFJ21BS610jdcBSzcJ2nUJ442E2jj/wUrinOsNj90qe+xNy0HjAQt/Ex88GghrawQmJO183H0Q11PbTRRgdWx7SXRuYc0FRPV7JpDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dexKVgd0; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dexKVgd0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1789295411; x=1789900211;
	i=johannes.schindelin@gmx.de;
	bh=rRdmBnX76FJNohX9mONSwrnEHppgT/r8utzRzbnr/OI=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=dexKVgd0uhjr++8DfnVt5RTq7vKWZHC7lhTrzbyeflrbWblBjSsWvg88BVhtjeQo
	 hDKiSmHrcOKSxvJgUpUBFa3ZeGv4OSvGVOzevkwnSym76x/91CrtFqul4witqnfPH
	 fojyjv4gcCqA7j7h/SS5CghUE3Rr0yFrZoJpeDCWHEyBKpXmlNhQqgLAMetMIx4Pf
	 sJetRaKjzBxjRAzuyjiKS8A+YnKzK32D9vmOfEWcc5ihCXStEZ7lPstoUAYhv/BIp
	 HEzR7SxEuATER3d8SbNqGRWEo86ib3/4vL0nsHWcaZQOOEcXgCouDU06Wmu+iBspq
	 S5A9pB3jP3JvrAiZYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MiJZE-1wZNK90Uo2-00hetW; Sun, 13
 Sep 2026 12:30:11 +0200
Date: Sun, 13 Sep 2026 12:30:09 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: James Le Cuirot <chewi@gentoo.org>
cc: Junio C Hamano <gitster@pobox.com>, 
    Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 1/2] rust: pick a GCC-compatible Cargo target under
 MSYS2/MinGW
In-Reply-To: <c29cd39efc7b472ff1aeaede367d7f39f3ca1eeb.camel@gentoo.org>
Message-ID: <e963a26f-6336-b52a-0466-30c81fd8ac02@gmx.de>
References: <pull.2213.git.1788272509.gitgitgadget@gmail.com>  <pull.2213.v2.git.1789153730.gitgitgadget@gmail.com>  <6567eceb32c1bdcff5927c6baf0cadc97af7485b.1789153730.git.gitgitgadget@gmail.com>  <xmqqa4pna411.fsf@gitster.g>
 <c29cd39efc7b472ff1aeaede367d7f39f3ca1eeb.camel@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary=8323328172412210517892954111375
X-Provags-ID: V03:K1:YMO61Sb5z1d2fhoXSY2n3xNqfnPRV1ZX6SFCtHXcilxYA87uF8h
 tEV9BbynFj0yOMmFYMhtfa/EFbwjRzac5cYpDnymQbPd9EuKP1y+x4LBGKWCeqUVjU0dC5i
 4Vc8tesHsjXlNFVQpdvEyRjGKxX2jhTeXNCrqtpd0I/DJXkAOhrl/0Kc+A/KWVBoY4yNLZo
 NnaqaVXX0RmGcHJDHaXyA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+hwvI93ilvM=;8heZRG+lYxry8eU5zAZNlvRYi+W
 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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328172412210517892954111375
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Junio & James,

On Fri, 11 Sep 2026, James Le Cuirot wrote:

> On Fri, 2026-09-11 at 14:09 -0700, Junio C Hamano wrote:
> > "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> > writes:
> >=20
> > > @@ -993,6 +993,7 @@ endif
> > >  ifndef DEBUG
> > >  CARGO_ARGS +=3D --release
> > >  endif
> > > +CARGO_ARGS +=3D $(if $(CARGO_TARGET),--target $(CARGO_TARGET))
> >=20
> > Should this use CARGO_BUILD_TARGET (instead of CARGO_TARGET) to
> > match what the officially supported Cargo environment variable is
> > called?  It would also help us work better with the changes from the
> > jc/rust-cargo-build-target topic.

Sure.

> >=20
> > Thanks.
>=20
> Yes, without explicitly setting --target at all.

Cool! My first experiment failed because I missed that Makefile does not
automatically export `CARGO_BUILD_TARGET`... =F0=9F=A4=A6 But now that I e=
xplicitly
export it, it works as you claimed it would.

Thank you!
Johannes

> This is how Gentoo Linux supports cross-compiling of its Rust packages.
> Just avoid setting CARGO_BUILD_TARGET (or passing --target) when you're
> not cross-compiling. It will cause Cargo to behave differently, even if
> you give the native tuple. For example, RUSTFLAGS is normally applied to
> both the build host binaries and the target host binaries, but when an
> explicit target is set, RUSTFLAGS is only applied to the target host
> binaries.
>=20
> Regards,
> Chewi
>=20
> > Author: James Le Cuirot <chewi@gentoo.org>
> > Date:   Thu Sep 10 11:20:14 2026 +0100
> >=20
> >     rust: respect CARGO_BUILD_TARGET when locating build output
> >    =20
> >     When cross-compiling, Cargo always writes to a target-tuple subdir=
ectory
> >     determined by CARGO_BUILD_TARGET, even when it matches the native =
tuple.
> >     The build looked in $BUILD_DIR/$BUILD_TYPE directly, so it failed =
to
> >     locate the freshly built library.
> >    =20
> >     Respect CARGO_BUILD_TARGET in the output path so the correct artif=
act
> >     is located.
> >    =20
> >     Signed-off-by: James Le Cuirot <chewi@gentoo.org>
> >     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> >=20
> > diff --git a/Makefile b/Makefile
> > index d4b775953d..f0ca2e4f72 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -959,7 +959,7 @@ RUST_LIB_NAME =3D gitcore.lib
> >  else
> >  RUST_LIB_NAME =3D libgitcore.a
> >  endif
> > -RUST_LIB =3D target/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
> > +RUST_LIB =3D target/$(if $(CARGO_BUILD_TARGET),$(CARGO_BUILD_TARGET)/=
)$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME)
> >  endif
> > =20
> >  GITLIBS =3D common-main.o $(LIB_FILE)
> > diff --git a/src/cargo-meson.sh b/src/cargo-meson.sh
> > index 75f3cd1265..83c7e7b79b 100755
> > --- a/src/cargo-meson.sh
> > +++ b/src/cargo-meson.sh
> > @@ -38,7 +38,7 @@ then
> >  	exit $RET
> >  fi
> > =20
> > -if ! cmp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" =
>/dev/null 2>&1
> > +if ! cmp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUIL=
D_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a" >/dev/null 2>&1
> >  then
> > -	cp "$BUILD_DIR/$BUILD_TYPE/$LIBNAME" "$BUILD_DIR/libgitcore.a"
> > +	cp "$BUILD_DIR/${CARGO_BUILD_TARGET:+$CARGO_BUILD_TARGET/}$BUILD_TYP=
E/$LIBNAME" "$BUILD_DIR/libgitcore.a"
> >  fi
>=20

--8323328172412210517892954111375--
