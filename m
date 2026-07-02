Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE733C7691
	for <git@vger.kernel.org>; Thu,  2 Jul 2026 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783031437; cv=pass; b=mpjh9Zuwc0lyf9B6ghSvEIgLl+6FMSw35rdLShnud8fkEEZ3JTTDaNrOKC/yIyjUsuSv807LIvnpazajVQGAXkpFFFjqPqjA/qApuw3XlTxyWBHZHu9Y8oGJiUquUfsBKmDJughVRDXrviuTQ/MU8Gt2ToXlLF+5bNIdbLSiRNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783031437; c=relaxed/simple;
	bh=BOwWdC7ltxs1Wb8hkv4fDMojqQjvqe+0sfGdRLaPE0o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPiLR/VRf2J67SQETJXmw8GLMWuo3Z9/IGdutrSjOhmO2JOM/M/tClfglUQx4uUY/UC7nR8i/N9/zIMEwqHY5GngZgv0MZnkdIiIVUWMVeWeQIZBOLsZNBReB6bEcSspdltO1XOZkr2IA5anlCWL+3fEwDrtVLcNYahF9Q3213A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q74ADKKv; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q74ADKKv"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aebc8cb5bcso1595304e87.2
        for <git@vger.kernel.org>; Thu, 02 Jul 2026 15:30:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783031428; cv=none;
        d=google.com; s=arc-20260327;
        b=imEuNXkPDCH6lAfo4iEUQcxtIpka5O6tI6ColwV0SIsvf19YUMZo0PWy+92/1kfPhq
         6JVZ4t6scQnX62Pd0fP8wA299ZpXfbEWn31FCYQtghiiA0KJKmsLpHFbppVjajZD8YdO
         WfeDCOhua33g9B1Xy4NOaBQWzsEXWlPHa4GdY1XzOAr6/I1WfLNjRDOSrpB64kkN/cOm
         8m2EIM8t/sukGl2HD4K/aZ6E+csDiTFKNg5EwHQ2LPK35c61ZX0RaBaLNGQqAOxKLQ8h
         m0TUMai7iZLZ/iR2B8VdTv9omYL+5HdWk/djJghP8AyG7/d0JQOZUmCb+NOFmkNUmASx
         sJsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nt8ogUnlNzVpVJjFzzMA8atJtRI1z+UQUqxBg2HyB6E=;
        fh=XuxBRLyyp8WNhsJNokR1gNqd8RbBTRz/+64ANv+EvLs=;
        b=Qo9D1NM6lLb5iqUcAU4pvhGVbWel+qiEDB26TpLBL3ST/D5+TC0R2U1YrhzAl5dEEV
         0GuTcMDqC+NEl+pRQRwStGQhEarbHZ9G/kLUqlm0z2YVSLMx+iipcmQzAxajyzckds9a
         nfJEC47Tjpalhkj/4jnyKwIf1bSyB/eZIBaf+FGBZUQe9jbAIc3SHQ59DQI59B8PpVRr
         Xy8pdC07AilL/uyQG0xt1pP5aIUuUsXbU8wLP8Gy4SPqgNGl6QwRWdqsAQEesrb52Zmo
         vM7UXvI0dx1ajyswDDQ5Y/P7fVtCpY1GQzDAGAWXhXe1ihQF5L6538+Tm1My4uPY8Dz7
         sw0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783031428; x=1783636228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nt8ogUnlNzVpVJjFzzMA8atJtRI1z+UQUqxBg2HyB6E=;
        b=Q74ADKKvlHPKcFIkPf9VwCQriEY2eA/URZYe517qvWXdRLqhLSbfm/5vC3BHW7E7Nx
         OeH5o0mPSM9lVb9kCwMzB7DfG8obUWuSB/M2Un88iqps7w0xQmCD3x/Jz4zSVP75nQMh
         pHiZpbJ2mfv/Y8o2OhtvpqDcn2bkwy/xN5yB8YCcKWqP9NTwgpgC/GXO05wY3etDo5ix
         dqqJL8OhDc1OQPss5r/84srIBWoVzPOeoaSuhhp/hpeoyiKih48VR4xdzeAsdhf86fqz
         PuCcBOemXTR+vQ+YsRNYYKJXginwSETTkEXWJAX+KSixzYAe0WIKoUOcd5Se6DmDdlNc
         b3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783031428; x=1783636228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nt8ogUnlNzVpVJjFzzMA8atJtRI1z+UQUqxBg2HyB6E=;
        b=aMTPNuFbJ7USDlwA7r+Eboqu3raltb7CuMQ4jcf0s4bOvVFJAcMiIwOiS3yCsLvPBB
         uw7QDI2f6sw3iyeLpuLh0RacgY3HLkWjfxVNu2Oc6kqNXorjp26sj5GsxfNbqMujXHJY
         nUtzTIEoG0kjuDtWejdMhJNz7Pr2MI3j9B+qHW5+Zcuvj9nWossM3FNIBSr9SKfFHm9m
         CdUPG6pKBorzv073mbdNJy8VT+2WNTDPGF9bal9XmCRNpWtnOa5qZEHUf5rGT1s3mOn4
         7b+OKdjUC4Afb22EkfneCw83WxbnN5F69O35NpiBDQWxoWwiv26mjudokXEJF2qggeGa
         l8iA==
X-Forwarded-Encrypted: i=1; AHgh+RqPYcSQ/BTLfgjmkqcglc6dVsU0hLEuVze8y2xMxIdYaaYGXvtO3gOA3yDW8BPSh/R/hL0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8cn/n1CEP59ueDi8VCUANNcLnzDdITEDtaHRloij/0Dt1PYZw
	Ekr/a0cdBr8Ak7ND0tldThw5aAg8DO+raKiew03BILe1LpFYaEu7hI3zgMW7uXvXZty3n8y/cEV
	EFN6uTOB9Y5jdMRIetHBHQeH+bMQLqnBSBMPkGIo=
X-Gm-Gg: AfdE7cn3MYSt4ib7M37VYv9l7X49ATtGHJCOOVWgA3cQhtjJeoTcHlIoLpiH5ID5fF8
	BMkzfZ73pLEaIIY0w/VL7/illwNvblzYaHfmO/YfNXMTuNrTIiN8G2s9Mr7UYDWpO/MNZ//AUOg
	eQeGQXZFAWl6WrVDzWnVD9buqg00wgFeliUFYhq2EMod0kiiBBRdJi+QfhQtL6pZAMXZxmtEM/S
	RIBrReoDICcVoUSGGhIeQlkwxbaDrm5BUFU2M8crRw6m28XL2fy3riIpKw+MqLKZkz48QQXHucO
	5W+johMpESEVQ9ik/th+yP2h72iEiA==
X-Received: by 2002:a05:6512:a90:b0:5ae:bf45:e3ac with SMTP id
 2adb3069b0e04-5aec742fa0cmr2011370e87.53.1783031427549; Thu, 02 Jul 2026
 15:30:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2288.git.git.1778001976709.gitgitgadget@gmail.com>
 <pull.2288.v2.git.git.1782943303219.gitgitgadget@gmail.com> <akZQmDYe9MtTdGM2@pks.im>
In-Reply-To: <akZQmDYe9MtTdGM2@pks.im>
From: Shardul Natu <shardul.27591@gmail.com>
Date: Thu, 2 Jul 2026 15:30:15 -0700
X-Gm-Features: AVVi8CcbuMf847UYjOmLxsV4TpvyF31LnN34Ui40dhwjPpp1_LRqbbmCMJ-xIV0
Message-ID: <CABw8Y3H7P3JKwaSrUGjifcDh7rMR2nCFgqPjw8q6vfZnLc730w@mail.gmail.com>
Subject: Re: [PATCH v2] Makefile: link osxkeychain & support universal Rust
To: Patrick Steinhardt <ps@pks.im>
Cc: Shardul Natu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Shnatu <snatu@google.com>, 
	Koji Nakamaru <koji.nakamaru@gree.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> "Shardul Natu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Shnatu <snatu@google.com>
> > Signed-off-by: Shardul Natu <snatu@google.com>
>
> You'd want to make sure these two match.

Good catch. Done!

> > This is a highly elegant and native Makefile solution that avoids
> > complex shell scripting in recipes and fully supports macOS Universal
> > Binaries.
>
> You're the second person on this list I saw who calls their own
> creation "elegant" ;-).

Removed! It was AI generated description

> Do we know that leading directories to $(RUST_LIB) target has
> already been created at this point? If not, we may want to have
>
> $(RUST_LIB): $(RUST_MEMBER_LIBS)
> + $(call mkdir_p_parent_template)
> $(QUIET_GEN)\
> if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
> lipo -create $^ -output $@; \
>
> on top.

Added $(call mkdir_p_parent_template).

> > When Rust is enabled, ensure that the git-credential-osxkeychain
> > helper is linked with the necessary Rust libraries.
> >
> > Also, introduce native support for macOS Universal Binaries
> > (multi-architecture builds) in the Git build system by allowing
> > the user to specify a list of target triples in the RUST_TARGETS
> > environment variable.
>
> These are fundamentally unrelated things, aren't they? So I'd argue they
> should be split up into two commits.

You're right; these address two fundamentally different
problems. In v3, I have split this into a two commits:
1. Makefile: add $(RUST_LIB) prerequisite to osxkeychain
2. Makefile: support universal macOS builds via RUST_TARGETS


> I think we could also use an explanation here what the universal binary
> buys us for those who are not deeply familiar with the macOS platform.
> What are they, and why do we want/need to support them?

I have added this background to the relevant commit.


> Can we assume lipo to be generally available on macOS? Also, is it
> sufficient to just do this for the library? I would have expected that
> binaries would also need some treatment there.
>
> In other words: what does it help us to have the Rust treated this way
> if the rest isn't?

Yes, "lipo" is part of the Apple Xcode CLT, which
is already a hard prerequisite for invoking clang or make on macOS.
The reason only Rust needs special treatment in the Makefile is due to
how the respective toolchains handle multi-architecture builds:
1. Apple's C toolchain (clang) natively supports universal builds via
CFLAGS and LDFLAGS. When "-arch x86_64 -arch arm64" is passed, clang
automatically compiles and links universal binaries for all C object
files and executables out of the box.
2. Cargo and rustc, however, do not support multiple "-arch" flags or
emitting universal binaries in a single invocation. Instead, Cargo must
be invoked separately for each target triple ("--target x86_64-apple-darwin=
"
and "--target aarch64-apple-darwin").

By using "lipo" to combine those target-specific Rust static libraries
into a single universal archive at "target/release/libgitcore.a", we
bridge this gap. Once $(RUST_LIB) is a universal archive, the standard C
linker seamlessly links it with the C object files to produce the final
universal Git executables.


On Thu, Jul 2, 2026 at 4:57=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
>
> On Wed, Jul 01, 2026 at 10:01:43PM +0000, Shardul Natu via GitGitGadget w=
rote:
> > From: Shnatu <snatu@google.com>
> >
> > When Rust is enabled, ensure that the git-credential-osxkeychain
> > helper is linked with the necessary Rust libraries.
> >
> > Also, introduce native support for macOS Universal Binaries
> > (multi-architecture builds) in the Git build system by allowing
> > the user to specify a list of target triples in the RUST_TARGETS
> > environment variable.
>
> These are fundamentally unrelated things, aren't they? So I'd argue they
> should be split up into two commits.
>
> I think we could also use an explanation here what the universal binary
> buys us for those who are not deeply familiar with the macOS platform.
> What are they, and why do we want/need to support them?
>
> > To implement this cleanly without complex shell scripting in recipes:
> >   1. We introduce a declarative Make pattern rule (target/%/...) to
> >      compile each target-specific library slice (e.g.,
> >      target/aarch64-apple-darwin/...).
> >   2. We update the $(RUST_LIB) recipe to depend on the list of
> >      compiled target-specific member libraries ($(RUST_MEMBER_LIBS)).
> >   3. On macOS, if multiple targets are specified, we use lipo to
> >      combine them into a single Universal static library at
> >      target/release/libgitcore.a.
> >   4. If only one target is specified, we copy it to the standard
> >      path.
> >   5. We enforce that building for multiple targets requires macOS
> >      (as lipo is only available there), raising a clear make error
> >      on other platforms.
> >
> > This is a highly elegant and native Makefile solution that avoids
> > complex shell scripting in recipes and fully supports macOS Universal
> > Binaries.
>
> As Junio already pointed out this self-praise reads quite weird. I'm
> just going to assume that this is AI-generated fluff.
>
> > diff --git a/Makefile b/Makefile
> > index 1f3f099f5c..8d49ecc897 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -3019,11 +3030,33 @@ scalar$X: scalar.o GIT-LDFLAGS $(GITLIBS)
> >  $(LIB_FILE): $(LIB_OBJS)
> >       $(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
> >
> > +ifndef NO_RUST
> > +ifeq ($(RUST_TARGETS),)
> >  $(RUST_LIB): Cargo.toml $(RUST_SOURCES) $(LIB_FILE)
> >       $(QUIET_CARGO)cargo build $(CARGO_ARGS)
> > +else
> > +ifneq ($(words $(RUST_TARGETS)),1)
> > +ifneq ($(uname_S),Darwin)
> > +$(error Building universal Rust libraries requires macOS (lipo is not =
available on $(uname_S)))
> > +endif
> > +endif
> > +
> > +RUST_MEMBER_LIBS =3D $(foreach target,$(RUST_TARGETS),target/$(target)=
/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME))
> > +$(RUST_MEMBER_LIBS): target/%/$(RUST_BUILD_CONFIG)/$(RUST_LIB_NAME): C=
argo.toml $(RUST_SOURCES) $(LIB_FILE)
> >
> > +     $(QUIET_CARGO)cargo build $(CARGO_ARGS) --target $*
> > +
> > +$(RUST_LIB): $(RUST_MEMBER_LIBS)
> > +     $(QUIET_GEN)\
> > +     if [ $(words $(RUST_TARGETS)) -gt 1 ]; then \
> > +             lipo -create $^ -output $@; \
>
> Can we assume lipo to be generally available on macOS? Also, is it
> sufficient to just do this for the library? I would have expected that
> binaries would also need some treatment there.
>
> In other words: what does it help us to have the Rust treated this way
> if the rest isn't?
>
> Thanks!
>
> Patrick
>
