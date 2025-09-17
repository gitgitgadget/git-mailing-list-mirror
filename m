Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D18A945
	for <git@vger.kernel.org>; Wed, 17 Sep 2025 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758096119; cv=none; b=M+t48w0R0xT1uAio1lLzgX6A2ZSAUL2XJ3SEt5ePzfYfv57iI8RPp4iz0OqKrU3eQuvjruy/Ac+0xj8VDkUkrSBEnDsuesWjSyEPNJTV5REpfBiEai5Nm164/8iDaA3cfvmUFtb+ja1fnQ8BNjLM8O4lCq6V0D8M5w/MN7kHALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758096119; c=relaxed/simple;
	bh=j9hIKV4HRA8Hl8M19LrGSFZ9mOGkXd90627ouJ3sxC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T1NnCYlGqyP9shdnTY/6yAM2oAAwxHHXV8xZTup0z5qIJBA3NikY6Dm3B//Z8V/qq6tqBk+ePU6w9HrjTGVY5+3NSzBngS4xaF0XtYmpbva+e17v0Upa0UsEBUe2UV4iKkz+ThvzSGxsOYAYYBT0mbM1px1zZHCB9cbRSYViYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78dfaf6a9b5so436036d6.1
        for <git@vger.kernel.org>; Wed, 17 Sep 2025 01:01:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758096117; x=1758700917;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MPSIUlwktBBZ73X6cnHOmo2JKVmdE4csdIkTnXLb6/I=;
        b=TlY1U9urB4khXes6iYCdC0DAmLQcZFJVC2eM4fguT0oOzinhk4nwOXzpcZl3gPhkc9
         iGFnNrzuuLRk52LeIlZTx7gYgDz+DYciDyl0tfdnquoefOAUQ46Iy8XzhS3iTIicsrHT
         K8Uoe5QewVcNBp5ImWzV3x68HYtBFmk5fkLvVNjfeHZxw2gNpMdmLlkGqXXxDjChQrmu
         69u/NQu8O0ODCQxGoGae1M6JIFQD8hkLEOR0CmlrbQBNnZsRHov/Q/ENkUCglyRUT1Qi
         WffVvsdIVsc3auv/koCA8v3/pCOezZpIMU+JUMjQixRzJ+YfrMKzYlBGlKj2F0doVEwT
         K26A==
X-Gm-Message-State: AOJu0Yyz/z+RTmmD5zfmwMuJoEYif5XMPbcwr9wqtg2hkqBQxLxjeRaz
	2d9ZH2RnngRq7aWz/SeWHJefnF5hstNrkbDM1yATuqmzT44WjzNTHSu1AfM22UZxIKeR9HUXLQH
	opA5G4F+fKsuhQf+6YETphU7A/qg994U=
X-Gm-Gg: ASbGncstn2TizVzAwQmPQzoK/iLFygmidVFchiF0G45pbVd41Sw/ZseHFpecKWc64Np
	RdA4dgGmct81egIX2sC2VeCRAoqZmfbnSU8SkUsoMJISbomT73s1aGIZ9lEgtt4Q5grcSK7S+GG
	xE9qkabLFQTqhUXXQ0rCYMSu+T8SZK8ZsWblIFnvMSKsCYcMjv/yhtyWbtW2PtXrioEpR82BybQ
	kkzXE5rRzwYhDntYDpKwtBKh8Jz/FkIZTvlDzCE
X-Google-Smtp-Source: AGHT+IFiA/BWXLXfvhjfjnCNsBOqvt8UCBQFtiHJUY7jZJSqqQ7bO5aysAUGA+NXAJv3S4q2mlCMxWgRBX/XBQ0B078=
X-Received: by 2002:a05:6214:262b:b0:78b:684e:88ab with SMTP id
 6a1803df08f44-78ecc72a478mr6584826d6.2.1758096116733; Wed, 17 Sep 2025
 01:01:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
 <pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com> <fcdfc55fb7d7da7d65405486f5eec10e5892a028.1758071798.git.gitgitgadget@gmail.com>
In-Reply-To: <fcdfc55fb7d7da7d65405486f5eec10e5892a028.1758071798.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 17 Sep 2025 04:01:45 -0400
X-Gm-Features: AS18NWD52xS5GAQWJhjvXn5MbSuIFa5ZuqT5l0vRL_ieHVvDRXqPQC33Xc7HgHo
Message-ID: <CAPig+cT-2-s-TcZ-2TQujLkn8Eh-EmYa9QWHWpw3iczDuX5mUQ@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] github workflows: install rust
To: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 9:17=E2=80=AFPM Ezekiel Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Prefer using actions-rs/toolchain@v1 where possible to install rustup,
> but for docker targets use a script to install rustup. Consolidate the
> Rust toolchain definitions in main.yaml. Use install-rust-toolchain.sh
> to ensure the correct toolchain is used. Five overrides are used in
> main.yaml:
>
>   * On Windows: Rust didn't resolve the bcrypt library on Windows
>     correctly until version 1.78.0. Also since rustup mis-identifies
>     the Rust toolchain, the Rust target triple must be set to
>     x86_64-pc-windows-gnu for make (win build), and
>     x86_64-pc-windows-msvc for meson (win+Meson build).
>   * MSVC builds: Rearrange PATH to look in /mingw64/bin and /usr/bin
>     last.

Please add an explanation as to why it is necessary to rearrange PATH.
I saw in patch [7/18] that your "build_rust.sh" does the same but the
reason is never spelled out (and it's still a mystery to me).

Also, this patch, [9/18], doesn't seem to touch PATH in the way
described here (unless I somehow overlooked it).

>   * On musl: libc differences, such as ftruncate64 vs ftruncate, were
>     not accounted for until Rust version 1.72.0. No older version of
>     Rust will work on musl for our needs.
>   * In a 32-bit docker container running on a 64-bit host, we need to
>     override the Rust target triple. This is because rustup asks the
>     kernel for the bitness of the system and it says 64, even though
>     the container is 32-bit. This also allows us to remove the
>     BITNESS environment variable in ci/lib.sh.
>
> The logic for selecting library names was initially provided in a patch
> from Johannes, but was reworked and squashed into this commit.
>
> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
> ---
> diff --git a/ci/install-rust-toolchain.sh b/ci/install-rust-toolchain.sh
> @@ -0,0 +1,30 @@
> +#!/bin/sh
> +
> +if [ "$CARGO_HOME" =3D "" ]; then
> +  echo >&2 "::error:: CARGO_HOME is not set"
> +  exit 2
> +fi

Let's follow project coding guidelines for shell scripts:

    if test "$CARGO_HOME" =3D ""
    then
        ..
    fi

or even:

    if test -z "$CARGO_HOME"
    then
        ...
    fi

Same comment applies to the remainder of this script and other scripts
in this patch.

> diff --git a/ci/install-rustup.sh b/ci/install-rustup.sh
> @@ -0,0 +1,25 @@
> +if [ ! -f $CARGO_HOME/env ]; then
> +  echo "PATH=3D$CARGO_HOME/bin:\$PATH" > $CARGO_HOME/env
> +fi

Style: drop space after '>' operator

> diff --git a/ci/lib.sh b/ci/lib.sh
> @@ -1,5 +1,6 @@
>  # Library of functions shared by all CI scripts
>
> +
>  if test true =3D "$GITHUB_ACTIONS"

Do we need the extra blank line introduced above the `if`?
