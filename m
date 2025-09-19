Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE75239E60
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 20:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758312678; cv=none; b=nC0YRHbCS1muDJbQM78ycM9KHZ5lI4AwTCVvRBVslMvKMgfIZXOb5QqYtvjE0aPCWPatpCwJ6LtPe+dW6sU/IXr4HpmL/VmxI952QJOXR+02t9KEYAciu++ENm9TVABp/VdFPqO5IvqTev/zDkl0SJgXOVrTTdiSlrffxnwkVw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758312678; c=relaxed/simple;
	bh=TfM7l5LHCQX0/iOkqHO6/lhVzu+FyPqtaRhMqw+GGZA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZKPZSUdgkVxQfa8U0VcfEoqnpN2eEogKSTUTzp0A4qHe3UOCvhQPFqvv8D8n/0yqqtt7K7v1SyGV8Y2VbcBHYZSUTXjj1anJFuDoCHQbPcpZ5xW9Xlo+pDd9G5+hhx0mGfa3ge+EabRM1lMd4fKr3+kqEjTSBbrxofJXkVmkGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BU5TWcMY; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BU5TWcMY"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3618e9ef33bso21006681fa.0
        for <git@vger.kernel.org>; Fri, 19 Sep 2025 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758312675; x=1758917475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaZb9EZo0emi7pUpheqCyr1q/S+FZEGAxE5dcVE9giI=;
        b=BU5TWcMYWnuiKFeBBUra7SB0FrrBGbHOHOtUChkvmCbM94PHA/UqiDVkmlC/r8Xy0A
         E/RGE7PLAUOaTLyKRnakz2fj0FbBvhu9lPTetaHVAmZ7OwdZD1t9eMr9XpaPyU+oHbVO
         lm/6hnizq4VdemsgwdfJhYA1ayHE0rnWUtb9oYJ5hXfdSE5x8UICE1pLtexc90yi1mHA
         D07HTv03tbOL2dBLqIqI1i5xgJOez0rqlKihOPZ7ByC8i2qk+XBlDlzH0W6K2qvj4o55
         3D+8xier4mvC6s022AoTmT8/YTFwHAsWUFXezOk1IGvtCVH/U3PUpLBqKntbJMPpj11j
         T02A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758312675; x=1758917475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaZb9EZo0emi7pUpheqCyr1q/S+FZEGAxE5dcVE9giI=;
        b=SxQqZLfGE8Tw61Z2rnzB026hqXeh4HGwktkS08KsrQFrw20X6FVyNwzLSM7n+1Ogny
         RVZZnaSN1zJZ3vAlM9sv2G3KRdInyJjiR7mVgFXTFCtv490n9LrZn2Z3NOFLYUNt0JmI
         MoZ7kkPNpITgAkhzF+ZLMik7KttKNYnEyD0I4TbGq8tTQ+qEX1+AhIMEnjrG0sq+BtMY
         MEGnKhKwn+9RSQK75pOe6EqJcuAwXx8Kh0s9v9LGMZe65mUzk0ZMMTKx+prNc58/Vhgj
         yp5wHYLWKI0izjqpSmNSSsSHn8aYR+qVH431wmvw1WhS+XZEqAXKCkdIsJWzpk2stwIa
         Aqsw==
X-Forwarded-Encrypted: i=1; AJvYcCXslyVV6rMzZg8DqJWJUNxpG2yYI3DCoBfXlD3vtvbxvJFqXsffBQQV+G6ZBydjnvzTF5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTKTpVibWheCQzkHzbfunOm+MRGv4eFboOQMBFcMOXp4bZu8An
	q5bevd/e7jv4amjP0UFcJf2rHNHTfEDgLZl8nmuB7S7LGBkUmJIb6LwSRVlcFJ2EGgFOF41aGYw
	eb538z/No4SRVI3Ow6PAVvx5P2dfLMgc=
X-Gm-Gg: ASbGncuwrFlWiIMmbwblOPLwM9NQEOMA7kka9uluS2NcZ9VyUDu7aJWADfuYWIm3Bl/
	r7ZNUZKIHzbU/p9S/boz8OcIRlVqitqpEhSY2++HMSKkspyGfLlVQxNZJUTukWxbUjutfC+7ECA
	kRO+0beY1PCjeWkI4eS26TEIPubd7pxE5kpQ8zn8gIJBSs2SLqwbxvaJ6+xVB6pI0vihLjcaABv
	bGyBhP7
X-Google-Smtp-Source: AGHT+IGC2g4HYABicsRNQFF99A3TBYVlJtCqsozLY+Q8My2eHJztoib6EGreL313r1VY77nTylXNZi3aM32tKiSUtK8=
X-Received: by 2002:a05:651c:2359:10b0:357:ccfc:64ac with SMTP id
 38308e7fff4ca-361680754afmr22827151fa.4.1758312674552; Fri, 19 Sep 2025
 13:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
 <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com>
In-Reply-To: <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 19 Sep 2025 14:11:01 -0600
X-Gm-Features: AS18NWDHeOBpdLBIRuwDeWZxQCb8H77xK_1frv39n_wEHPq4QIG-DpaocVxycKg
Message-ID: <CAH=ZcbBBkk2B3PxKf54MRnAmURMK8W7ofFZBRS=ZzkuDNWsY9w@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] build: introduce rust
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 2:26=E2=80=AFAM Eric Sunshine <sunshine@sunshineco.=
com> wrote:
> Is ".idea" directory detritus from your chosen editor? If so, it
> probably ought not be added to this list since we don't otherwise
> ignore detritus from foreign tools such as that.

Yes. I use the Jetbrains IDE's CLion and RustRover for C and Rust
respectively. Jetbrains has an IDE for MANY languages and all of them
use .idea/ as the folder for IDE specific configuration. I'm fine with
keeping it out of .gitignore, but I wanted to know what the community
thought. Which I should have made it more clear that this patch series
was more of an RFC than proposed code to be merged.

> > diff --git a/Makefile b/Makefile
> > @@ -916,6 +924,51 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
> > +RUST_CRATES :=3D
> > +.PHONY: compile_rust rustclean
>
> This is an extremely tiny nit, but multi-word target names in the Git
> Makefile are almost universally spelled with a hyphen rather than an
> underscore, so "compile-rust" would be more consistent and
> appropriate.
>
> > +$(GIT_BUILD_DIR)/lib%.a:
> > +       ./build_rust.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*
>
> I wonder if this should follow the convention of most (but not quite
> all) other local shell script invocations in the Makefile of
> referencing SHELL_PATH; for instance:
>
>     $(QUIET_GEN)$(SHELL_PATH) ./build_rust.sh ...etc...
>
> with or without the $(QUIET_GEN) bit.
>
> > diff --git a/build_rust.sh b/build_rust.sh
> > @@ -0,0 +1,60 @@
> > +if [ "$dir_git_root" =3D "" ]; then
> > +  echo "did not specify the directory for the root of git"
> > +  exit 1
> > +fi
>
> Let's follow project style conventions for shell scripts:
>
>     if test "$dir_git_root" =3D ""
>     then
>         ...
>     fi
>
> or even:
>
>     if test -z "$dir_git_root"
>     then
>         ...
>     fi
>
> Same comment applies to the rest of the script.
>
> Also, should the above error message be sent to stderr rather than
> stdout? (Genuine question since I'm not sure if other scripts are
> necessarily consistent in that regard.)
>
> > +if [ "$rust_build_profile" =3D "release" ]; then
> > +  rust_args=3D"--release"
> > +  export RUSTFLAGS=3D''
> > +elif [ "$rust_build_profile" =3D "debug" ]; then
> > +  rust_args=3D""
> > +  export RUSTFLAGS=3D'-C debuginfo=3D2 -C opt-level=3D1 -C force-frame=
-pointers=3Dyes'
> > +else
> > +  echo "illegal rust_build_profile value $rust_build_profile"
> > +  exit 1
> > +fi
>
> For maximum portability, we don't use the:
>
>     export FOO=3Dbar
>
> idiom in this project. Instead, do this:
>
>     FOO=3Dbar
>     export FOO
>
> The same comment applies to the remainder of the patch, as well.
>
> Also, the empty-string assignments to RUSTFLAGS and rust_args above
> inconsistently use a mix of single and double quotes. However, we also
> usually just assign nothingness in such cases rather than an empty
> string:
>
>     RUSTFLAGS=3D
>     export RUSTFLAGS
>     ...
>     rust_args=3D

I'll try to keep these in mind for the future.

> > +if rustup show active-toolchain | grep windows-msvc; then
> > +  libfile=3D"${crate}.lib"
> > +  PATH=3D"$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/b=
in)$" | paste -sd: -):/mingw64/bin:/usr/bin"
> > +fi
>
> Please add either an in-code comment or a sentence/paragraph to the
> commit message explaining why this PATH munging is needed.

I will amend the commit with something like:
On windows when building with msvc using shell scripts it looks for
link in /mingw64/bin|/usr/bin when it actually needs to look somewhere
else for the msvc linker program. Since removing these from PATH would
break everything else in the shell; move them to be at the end of
PATH.

> > +cd $dir_rust && cargo clean && pwd && USE_LINKING=3D"false" cargo buil=
d -p $crate $rust_args; cd $dir_git_root
>
> When formatted like this, it is very easy to overlook the fact that
> the final `cd` is (correctly) not &&-chained with the preceding
> commands. Reformatting it like this would help:
>
>     cd $dir_rust &&
>         cargo clean &&
>         pwd &&
>         USE_LINKING=3D"false" cargo build -p $crate $rust_args
>     cd $dir_git_root
>
> Alternatively, use a subshell and drop the final `cd`:
>
>     (
>         cd $dir_rust &&
>         cargo clean &&
>         pwd &&
>         USE_LINKING=3D"false" cargo build -p $crate $rust_args
>     )
>
> By the way, is the `pwd` command needed? What is its purpose?
>
> > +rm $dst 2>/dev/null
>
> I think we typically use `rm -f` without redirect to /dev/null to do
> the "right thing".
>
> > +echo mv $src $dst
> > +mv $src $dst

pwd was for debugging and I forgot to take it out. I'll clean up my script.
