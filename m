Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 922743093AD
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758097590; cv=none; b=uXzAQ7a4S0qbeZFrCzgGPO/t4lktr0Gl9RzwyGY0d811LnIK2uVdWSA1egfryV0HQ3jwwHIbVJanw4ll/MKnn/fhNAf8fzITqm5Nr0ap3VF7RsJxcb/qtYOaollOT3v6XEnLhmIvy+/Ti7GFcMEvhDgy4R7zVHaUaDHvfCx+xCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758097590; c=relaxed/simple;
	bh=EM7T3U6/eta7rHzjnCHDVY5+0lEZxaUvfvAUrzacTlg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lMXJcnbuIr82t0H6uXYGdEAAUpXWqeVgeLRgHtd8ZZmuuuoNeut1eCoUqHXu80QeklILH+CtZNexSDh7aUEp7OGdTXOTzhG+GtbH2BwWpG3w730Gylta+nH9wywqbkN1xPtbiVxjdJCwLD6/qnIfQg/C73/buRLCwLgTd+J4P2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-78def53f3abso1183116d6.3
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758097587; x=1758702387;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8fi6s2wOfZvPN3ZcpEhyxIYh5DUN/c7/6KcOR0cxxms=;
        b=U2Xhbhn7SGH2pz+sx8HPN02Jl8+yL1Lxd6oPjw3IKr/Udwhrbnrh4yBMgbtHxVJF9K
         UpmGGrUIM+o7/0WjXfn4XCUsUcV7Y4w3zHR2ARdMvLLaZL//9O9WGts1kdidNfnG7dTU
         ix4M1zGm25XKgt2quUjBMGuxy9IDq82DNb6Cm17z0IzzS8JGGL2WEaO+PovyQOVuZLD8
         YPXS6nWNfs/fJa90qyEn0y2vi5ulpm+NAnrewrboSo8WpBGuUUzvT9CHBH18o0Gb3lyR
         sFgFF3LiSA11KMiUmejSNXAPjia79F4BIaqwUhUbmX2EPaK/GdDNpbtSfMt9vIdRszjZ
         Wftg==
X-Gm-Message-State: AOJu0YwFGl1yqnoxfO4JXoH0bGnlPGlrXp7TXzyzDDRdWLH88kCzQD3z
	VPF6GClhRX6Wtj64TNd6Fzufg7jRyuWoooPZpVO8Nskv8r8RUhl8F0KlHMPezSJaHfbI+dATJ5S
	fgVHqCK3TK1Ul54B/Ov+eCfGfPMf2apo=
X-Gm-Gg: ASbGnct9fwFnPXTcoPL24V3SXl4d77WUAZjuVH4bgq8qGArf6YJUk5jwHseiQt/0QVs
	pNjZi27/eG4GvUy5liN8qpWkTcSmyfH/0P+HF4x43E3CW2/Riy8JcVyPGRm7us+VgAGlGDAcjKr
	VOn7kR+msh+oHN+oMY0ynUDwxqwW/Cv4SKWKa3E9DLr7TbnL5+2pdXWxJUbzBhrrzTA2XLO4vu9
	9hIcHaDDv8wz1TthNq119QQ3aelBkQRs43sgnSQ
X-Google-Smtp-Source: AGHT+IGzooqRkpc+4KsLvNFT9JrsxBmHfMY6FlhEI5g3LtSZvVM4jWibENFvwmtmyNBSNCYpd68ER2LTKCtd0apbZnM=
X-Received: by 2002:a05:6214:2526:b0:78d:8414:e4b8 with SMTP id
 6a1803df08f44-78ec981826bmr7407416d6.0.1758097587255; Wed, 17 Sep 2025
 01:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <6032a8740c0ba72420f42c3d8d801e1bdeec12d0.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 04:26:16 -0400
X-Gm-Features: AS18NWAwGhUsyYzG0u3orTrIzefSrrjOHlrQ1_9r1r4xqogoh2gXjYYT0ZufkZ4
Message-ID: <CAPig+cS_=YTBaCjn8-Th3yn3_k+a8_pMOmdv_Dq4S0tfp8BRCg@mail.gmail.com>
Subject: Re: [PATCH v2 07/18] build: introduce rust
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Upcoming patches will simplify xdiff, while also porting parts of it to
> Rust. In preparation, add some stubs and setup the Rust build. For now,
> it is easier to let cargo build rust and have make or meson merely link
> against the static library that cargo builds. In line with ongoing
> libification efforts, use multiple crates to allow more modularity on
> the Rust side. The xdiff and ivec crates are the focal point for this
> series.
>
> cbindgen will be used to generate header files for each Rust crate for
> C interoperability.
>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> diff --git a/.gitignore b/.gitignore
> @@ -254,3 +254,6 @@ Release/
>  /contrib/buildsystems/out
>  /contrib/libgit-rs/target
>  /contrib/libgit-sys/target
> +.idea/
> +/rust/target/
> +/rust/Cargo.lock

Is ".idea" directory detritus from your chosen editor? If so, it
probably ought not be added to this list since we don't otherwise
ignore detritus from foreign tools such as that.

> diff --git a/Makefile b/Makefile
> @@ -916,6 +924,51 @@ TEST_SHELL_PATH =3D $(SHELL_PATH)
> +RUST_CRATES :=3D
> +.PHONY: compile_rust rustclean

This is an extremely tiny nit, but multi-word target names in the Git
Makefile are almost universally spelled with a hyphen rather than an
underscore, so "compile-rust" would be more consistent and
appropriate.

> +$(GIT_BUILD_DIR)/lib%.a:
> +       ./build_rust.sh $(GIT_BUILD_DIR) $(RUST_BUILD_MODE) $*

I wonder if this should follow the convention of most (but not quite
all) other local shell script invocations in the Makefile of
referencing SHELL_PATH; for instance:

    $(QUIET_GEN)$(SHELL_PATH) ./build_rust.sh ...etc...

with or without the $(QUIET_GEN) bit.

> diff --git a/build_rust.sh b/build_rust.sh
> @@ -0,0 +1,60 @@
> +if [ "$dir_git_root" =3D "" ]; then
> +  echo "did not specify the directory for the root of git"
> +  exit 1
> +fi

Let's follow project style conventions for shell scripts:

    if test "$dir_git_root" =3D ""
    then
        ...
    fi

or even:

    if test -z "$dir_git_root"
    then
        ...
    fi

Same comment applies to the rest of the script.

Also, should the above error message be sent to stderr rather than
stdout? (Genuine question since I'm not sure if other scripts are
necessarily consistent in that regard.)

> +if [ "$rust_build_profile" =3D "release" ]; then
> +  rust_args=3D"--release"
> +  export RUSTFLAGS=3D''
> +elif [ "$rust_build_profile" =3D "debug" ]; then
> +  rust_args=3D""
> +  export RUSTFLAGS=3D'-C debuginfo=3D2 -C opt-level=3D1 -C force-frame-p=
ointers=3Dyes'
> +else
> +  echo "illegal rust_build_profile value $rust_build_profile"
> +  exit 1
> +fi

For maximum portability, we don't use the:

    export FOO=3Dbar

idiom in this project. Instead, do this:

    FOO=3Dbar
    export FOO

The same comment applies to the remainder of the patch, as well.

Also, the empty-string assignments to RUSTFLAGS and rust_args above
inconsistently use a mix of single and double quotes. However, we also
usually just assign nothingness in such cases rather than an empty
string:

    RUSTFLAGS=3D
    export RUSTFLAGS
    ...
    rust_args=3D

> +if rustup show active-toolchain | grep windows-msvc; then
> +  libfile=3D"${crate}.lib"
> +  PATH=3D"$(echo $PATH | tr ':' '\n' | grep -Ev "^(/mingw64/bin|/usr/bin=
)$" | paste -sd: -):/mingw64/bin:/usr/bin"
> +fi

Please add either an in-code comment or a sentence/paragraph to the
commit message explaining why this PATH munging is needed.

> +cd $dir_rust && cargo clean && pwd && USE_LINKING=3D"false" cargo build =
-p $crate $rust_args; cd $dir_git_root

When formatted like this, it is very easy to overlook the fact that
the final `cd` is (correctly) not &&-chained with the preceding
commands. Reformatting it like this would help:

    cd $dir_rust &&
        cargo clean &&
        pwd &&
        USE_LINKING=3D"false" cargo build -p $crate $rust_args
    cd $dir_git_root

Alternatively, use a subshell and drop the final `cd`:

    (
        cd $dir_rust &&
        cargo clean &&
        pwd &&
        USE_LINKING=3D"false" cargo build -p $crate $rust_args
    )

By the way, is the `pwd` command needed? What is its purpose?

> +rm $dst 2>/dev/null

I think we typically use `rm -f` without redirect to /dev/null to do
the "right thing".

> +echo mv $src $dst
> +mv $src $dst
