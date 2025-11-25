Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9C7219E8D
	for <git@vger.kernel.org>; Tue, 25 Nov 2025 17:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764092871; cv=none; b=IOwKhmJp0J48G8FF3QA3x7s6CKT8CeF5YHu0Clscn/eHf7LC0PqoEvuMb+CDR+ZlAz4dtyGQIe20ba7FGe0IsWSWO9WteQQ1/pbOH+d9EiTh4a+9AqHL7AXFYfUphL86m60bjdZ8MlVojIqT96XZ/fI7vFwy9EVFPYPtmGRCDas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764092871; c=relaxed/simple;
	bh=JWal/xlkRgH4ZLMlZmhvi+mR8tJ5V3GYpAQ8HsoH2dM=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KhL9agy1HQ4fXDoWyHzllf1sN5IQtDm6Iwd15+EX1foG/IWrfKCBHZsDZehpLHv/YzMKY5kqjcHSZGOBjt/XBw0/UiH3oOX0CJTQKgxlkNf8i7xVacYlyq1aBhlJjsbs6Tx3Y+bsGEFNXmNTX1bkwdnDYKVKCZjvWuJ1cYllonM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=FzOdZzzh; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="FzOdZzzh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1764092863; x=1764697663;
	i=johannes.schindelin@gmx.de;
	bh=wKE5yVDLlN++GjxVJhs991HNZz2iUF6rYYXM/b09/4k=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=FzOdZzzhaRRv6wUcvqku+JM6o/W+2k23k6VGy0r8SLy1JI6J3Qzjq9bQLZ6sR2K/
	 1F5I096cMJDF5O1HsLgOvQAjWa7laiv2NKc10ZWCkT/HJuq+nH2VOimHJr5Y4R5ko
	 BHJ3vaCRNEqXQz6bdbiBbWGWVSkblS0pTqL7Howsost8oVo+Tf7sCLDHo1mBt9Jxg
	 tmIoKnqHvXjHxOWybkKl3LMq5TgDAuiBJqDi33ZdjevpzjoHnH3djbz/aKMDlHzC4
	 HpwMFe594107N05+Rb2zGCKXk4YUyzqO0SdUkyEGOfjiAKGMWfrBqaTebXzKIsYfd
	 W9wL+SfnoZQq0B4uqg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.213.165]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1vfCuN3IbR-00Y7D9; Tue, 25
 Nov 2025 18:47:42 +0100
Date: Tue, 25 Nov 2025 18:47:42 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] make strip: include `scalar`
In-Reply-To: <xmqq7bvoiadg.fsf@gitster.g>
Message-ID: <235775ef-d12f-4b19-0b80-672c4e5e1812@gmx.de>
References: <pull.2004.git.1763409086322.gitgitgadget@gmail.com> <xmqq7bvoiadg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:SCAjKVC63Zw7FPDPjb6zUoScr0rqnJd40FBPFxZPxYAzUB70NJ2
 shA27WB/CWqUh8aLyvSANObj2OCP+og/46klOOuyh3Y3StvHYgizReueXYLHLarqvAI4W+Y
 pjhZdV9OUuqy1icRvaAk754+gb6t7gc7WuX2y/E1roGCSZJYGEU1dOhp5lbGWx4juggeBxb
 vb3ZfodmK5qzpDCc2cJSw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HGpwbxGo+00=;nnAd1UZl4Cka6eRrR9fsBPRjDqB
 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
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 17 Nov 2025, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>=20
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > When Scalar was made a canonical part of Git in 7b5c93c6c68 (scalar:
> > include in standard Git build & installation, 2022-09-02), it was adde=
d
> > to all relevant Makefile targets except for the `strip` target.
> >
> > Let's correct that.
>=20
> The motivation makes perfect sense.
>=20
> > diff --git a/Makefile b/Makefile
> > index 7e0f77e298..62f7f7bf56 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -2565,7 +2565,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
> > =20
> >  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shel=
l
> > =20
> > -strip: $(PROGRAMS) git$X
> > +strip: $(PROGRAMS) git$X scalar$X
> >  	$(STRIP) $(STRIP_OPTS) $^
>=20
> I wonder why the original names git$X here explicitly, instead of
> using say $(OTHER_PROGRAMS) that covers both of these.  I know that
> the undocumented INCLUDE_DLLS_IN_ARTIFACTS knob uses OTHER_PROGRAMS
> by throwing in non-programs like DLLs to it, so that artifacts-tar
> target would include them, but perhaps instead of working around the
> misdesign of that target, wouldn't it be better to correct its use
> of OTHER_PROGRAMS and use it here instead?
>=20
> The change (including the "strip scalar, too!" part) should look
> like this, I think.

Sure.

> Also do we need a matching change to CMake and meson?

I am unfamiliar with Meson, and do not see anything about stripping in
`meson.build` apart from a `--strip` option that is mentioned in a comment
(and which I would assume already handles all executables, otherwise the
move to Meson really is not worth all the hassle).

About CMake: It was always meant as a tool to help Visual Studio users to
build and debug Git for Windows conveniently (something that Meson
distinctly fails to accomplish). As such, there is no support for
stripping executables in the CMake definition, that's completely up to how
the Release builds are set up.

Besides, since Meson was picked over CMake as the modern build setup, I am
seriously playing with the idea of abandoning Git's CMake definition (and
with that, all Visual Studio-based developers, of course).

Ciao,
Johannes

>=20
>  Makefile | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git c/Makefile w/Makefile
> index 70d1543b6b..a63a4adbc7 100644
> --- c/Makefile
> +++ w/Makefile
> @@ -682,6 +682,7 @@ LIB_OBJS =3D
>  LIBGIT_PUB_OBJS =3D
>  SCALAR_OBJS =3D
>  OBJECTS =3D
> +OTHER_ARTIFACTS =3D
>  OTHER_PROGRAMS =3D
>  PROGRAM_OBJS =3D
>  PROGRAMS =3D
> @@ -2499,7 +2500,7 @@ please_set_SHELL_PATH_to_a_more_modern_shell:
> =20
>  shell_compatibility_test: please_set_SHELL_PATH_to_a_more_modern_shell
> =20
> -strip: $(PROGRAMS) git$X
> +strip: $(PROGRAMS) $(OTHER_PROGRAMS)
>  	$(STRIP) $(STRIP_OPTS) $^
> =20
>  ### Target-specific flags and dependencies
> @@ -3697,10 +3698,11 @@ rpm::
>  .PHONY: rpm
> =20
>  ifneq ($(INCLUDE_DLLS_IN_ARTIFACTS),)
> -OTHER_PROGRAMS +=3D $(shell echo *.dll t/helper/*.dll t/unit-tests/bin/=
*.dll)
> +OTHER_ARTIFACTS +=3D $(shell echo *.dll t/helper/*.dll t/unit-tests/bin=
/*.dll)
>  endif
> =20
>  artifacts-tar:: $(ALL_COMMANDS_TO_INSTALL) $(SCRIPT_LIB) $(OTHER_PROGRA=
MS) \
> +		$(OTHER_ARTIFACTS) \
>  		GIT-BUILD-OPTIONS $(TEST_PROGRAMS) $(test_bindir_programs) \
>  		$(UNIT_TEST_PROGS) $(CLAR_TEST_PROG) $(MOFILES)
>  	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1) \
>=20
>=20
