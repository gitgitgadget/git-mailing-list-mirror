Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E992829A1
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 03:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750045215; cv=none; b=U3g5Zmq0fjqy63EqzbzL7jE5eL5ptsGXLove3YOqg/LWDu3voHsoioXG4b2n63dMPTHAL9CW4DEjd0O67XRxnX2QPuFcqxPVciOT/JXriWWarp5cQfN4wAiVLWmYrqQxZLW4cCL8q2s+0N2I4qdkXYF/x99jh+fpsfqdbT03RZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750045215; c=relaxed/simple;
	bh=hBB+U1Ggzk6jwg/+ofvg54BM9ZZizj108ApaWYyUjRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmuC6BRN017zl9rdBteBpYuDf36cCuTKMeMmJ65oNPU0To8dB+xCZLlWeK0vYhaEKx18MvAUhfQOYzCYe4XIzJtC9TykGOfcXZIgDOfTej7BDVmLfZT6Yy/SLyEZMV2Wfssf/smvNL7bJh3zSJkSEaxEr21/3TqTMhmHyDD8JHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6fb0f72c515so1518086d6.1
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 20:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750045208; x=1750650008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4H3mxrOySMDRrEkq7hIJsdK7dqe5N05YjOBP1Z5XrQ=;
        b=rYscR7gOyi8hX401dIuqgHK9mMuexbZoFcnmcI5F9J1j7FcUopXsivs+dcdIdCMdAe
         1Wuz/ar6plCxShKtIWx5i9Tw9TOLLB5dNobxhPD0yjBusr4M3pHgLTK4/iAU2jEPXIgJ
         bdkgGeYqRgJgGpajnnm9LhSuXIUAyzbZZEqEJ/v5/sADtuO2WZpGCVYy08ryqwdDM2do
         7ZtOZv8cEBOGr9PfMG2UVxcDn0H4OO7r1MWHq9lGb+QL6Q5NDFY+nxk2pj3G3ggsGaMo
         BIEXQx0SpNqONYzDNsLnFG6XkG49UmA0K2/IZVVdLu8/Gf5T06CSZ3JhHbJSzTCMAYU4
         xZnQ==
X-Gm-Message-State: AOJu0YztM0xfJ2BAUUg1DiZX0kNCv6MVUmHcfq/eUbmQ/LbseOf/DrXV
	7XBq+eNpi7ltn+wX3v9nJJxmzMcTOZiSe3/VGmR8orjD/+vwlr3FOxQe6G9Sr6ItYEn8qoSvuRe
	uYMrhhIPlMxOF22yrYTiCeqd26r7FGiU=
X-Gm-Gg: ASbGnctAD+a9YrS4fqNIjpf38zM4yCDkBDWwMI7qm0aIOsMq5nFKMOPBq/QZbIpbrSK
	YuEioUXXrJy7jJHt8LVttjCSEh3LgdhEeth2gV12rtNWY2JCZvf/MDx+JjNA2xZ/7e7aQ7SlxHS
	lavp7bJzuwkq789e71tpszAUdWcijF4VWgUzTY6kBd2Q==
X-Google-Smtp-Source: AGHT+IErzy5Sd8SLOlvwFKF4as9gRintqZPDbq1d/i2RHPck6l9fx7aMR76zyCVWN1XpBUA6VPd8sK8E+pntYEL2h/8=
X-Received: by 2002:a05:6214:3d87:b0:6fa:be81:e18f with SMTP id
 6a1803df08f44-6fb4725df27mr53334866d6.0.1750045207609; Sun, 15 Jun 2025
 20:40:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616020827.10820-1-rodmichelassi@gmail.com>
In-Reply-To: <20250616020827.10820-1-rodmichelassi@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 15 Jun 2025 23:39:56 -0400
X-Gm-Features: AX0GCFtVXXzZapEdtK_rXcDaBypgiD-BE2NpCRWgfZ3SPivJINVXHq1jQ_INb1U
Message-ID: <CAPig+cT1VfY8QiUvrrV3-obTBP1439b6iwaebJtGwML5MScnQA@mail.gmail.com>
Subject: Re: [PATCH] replace 'test -[efd]' with 'test_path_is_[file,dir,executable]'
To: Rodrigo Michelassi <rodmichelassi@gmail.com>
Cc: git@vger.kernel.org, icaselli@usp.br
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for the patch. See below for some comments...

On Sun, Jun 15, 2025 at 10:08=E2=80=AFPM Rodrigo Michelassi
<rodmichelassi@gmail.com> wrote:
> From: rodrigocmichelassi <rodmichelassi@gmail.com>

The From: header name/address should match your Signed-off-by:
trailer, so you'll probably need to adjust your mailer settings.

> replace 'test -[efd]' with 'test_path_is_[file,dir,executable]'

Let's prefix the subject with the area you're touching. In this case,
the test number would be appropriate, so:

    t2400: replace 'test -[efd]' with test_path_* calls

> 'test_path_is_file', 'test_path_is_dir' and 'test_file_is_executable' are=
 modern path checking methods in Git's development. Replace the basic shell=
 commands 'test -f', 'test -d' and 'test -e', respectively, with this appro=
ach

A better way to convince reviewers that this is a good idea is to
explain why these functions are superior. In this case, it's because
they emit useful diagnostic information when they detect a failing
condition, whereas `test` itself does not.

Please wrap the commit message at about the 72-column mark.

> Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>
>
> Co-authored-by: Isabella Caselli <icaselli@usp.br>
> Signed-off-by: Isabella Caselli <icaselli@usp.br>

You'll probably want to order these trailers like this:

    Co-authored-by: Isabella Caselli <icaselli@usp.br>
    Signed-off-by: Isabella Caselli <icaselli@usp.br>
    Signed-off-by: Rodrigo Michelassi <rodmichelassi@gmail.com>

> diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
> @@ -42,8 +42,8 @@ test_expect_success '"add" using - shorthand' '
>  test_expect_success '"add" refuses to checkout locked branch' '
>         test_must_fail git worktree add zere main &&
> -       ! test -d zere &&
> -       ! test -d .git/worktrees/zere
> +       ! test_path_is_dir zere &&
> +       ! test_path_is_dir .git/worktrees/zere

Take a look at the definition of `test_path_is_dir` from
t/test-lib-functions.sh to see why this change is undesirable:

    test_path_is_dir () {
        test "$#" -ne 1 && BUG "1 param"
        if ! test -d "$1"
        then
            echo "Directory $1 doesn't exist"
            false
        fi
    }

The test wants to assert that those directories do *not* exist, which
means that if `git worktree add` is working correctly, then the
directories indeed will not exist. However, `test_path_is_dir` is
going to complain that they don't exist, which is the opposite of what
we want. So, even though the test will continue to pass following this
change (due to the negation `!`), it's going to be spewing unwanted
and confusing error messages.

What you want instead is a test_path_* function which asserts that a
path does not exist. Probably the closest we have is
`test_path_is_missing` which seems a good semantic match for what this
test intends with regards to those directories.

> @@ -474,7 +474,7 @@ test_expect_success 'local clone --shared from linked=
 checkout' '
>  test_expect_success '"add" worktree with --no-checkout' '
>         git worktree add --no-checkout -b swamp swamp &&
> -       ! test -e swamp/init.t &&
> +       ! test_path_is_executable swamp/init.t &&

If you look at the definition of `test_path_is_executable` in
t/test-lib-functions.sh, you'll see that this change is similarly
undesirable.

The same comments apply to several other changes in this patch.
