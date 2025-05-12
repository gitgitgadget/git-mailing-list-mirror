Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4291E505
	for <git@vger.kernel.org>; Mon, 12 May 2025 17:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071368; cv=none; b=ivTTOHuUh1E8y11pBj5VQKxIotScJ4uMKH5Ed4xt5qobQJM0ECaOSjtjZHyMfsyHAUuhSVvLTiabDGu1OSuYfX7FOkTZkkkthQL6p12ycHsvd0K5T+02OKSww4eZ2VRaA8p8oCspcPhejEdkF4dMFhGiSxMWYM23wof010EPxUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071368; c=relaxed/simple;
	bh=Ex5NuLhKwsm/XkCphdPJms3lo9N9/lbNp5eqBXOJlfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9Tw42nRbxnu3l/0qjXGqtwnNFTJodtTeEECRtqNnCgwJZ5jLveWs37HYV2Gjrb+dOtm+EcvWgUYf1sVrrULulqb2kMzBhDVIaesdASes5LNnuxYPWJvSBmhEE/+qC2/xc+T51Wc9AIHRy4iM3PPTxQVnllL5N7anUT9c1XS+GM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRbgjajB; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRbgjajB"
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3d93deba52fso13514885ab.0
        for <git@vger.kernel.org>; Mon, 12 May 2025 10:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747071365; x=1747676165; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttQQP44kow//rWypcugOngXfMKxmGPXaG1i+lZ94Y+M=;
        b=fRbgjajBXMAHVqX8ehCG4TjhS3sCkZNAmmzNeHopH5Iq11LNGSjHaHbA+yZvMzSDxs
         l6saqC+buk2zdgidkQ4JW8ZDDR5hjAYlSHYFU2RrVPt+AeeBMjMzirONzWEy9yIuTSqP
         P7gQwOi44LqJHBh2imzWNWrCz+tjnkqjfaCvhohu2wWEmts7REBQGiKdcr6XcOhTTCHE
         Mqivq87a6yuoPiTNwDTvEyRlt5NQHe5zXh3XkodWS1aTpiw0NFhQ3uZ7OQuH3zIb63DY
         CKiFXsGEbdp0rrp6LsfEoDAjnQya6qAiUP7y5Cujw3U8lcJt/RF0kAdthSJMhKCJwqgv
         efxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747071365; x=1747676165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttQQP44kow//rWypcugOngXfMKxmGPXaG1i+lZ94Y+M=;
        b=R4oD6QWaM6P1RPedNUuvIM2ORqBzgNyPFYqrwHHFJRG6SJTiHQs4n5lLyC0CIOlQfZ
         4bZ/aQn0saKjwA7sMcAaukAMj4mRlyURWxNXg3DCDryHnOFxsLEk20ygvlgzOfN1oqPQ
         UMVvcs/MlZkmyLHlHMKMSxci8hkM5D12xRV0AJC2mNehFNPyP5wzQ4ay4SAunZmOoYlp
         6NXSRKwtbX306keaqKk/VQZ0kzJrMqBw9fD/JSBcpLdZh7/mUl32qC+KfA8vmbfCUz82
         R1XMFEaYb4lKv0cEcTLnc67v4B4Y71u9ACmudu3Y0DBh/xZIQ7peQ1aBd64Kd39guY4i
         RADw==
X-Gm-Message-State: AOJu0Yx0ELL9qrFqqNh9mYkHTr+zmPPqJG3ROh8zlZvbMNpp/0UtxfdZ
	RbkeqkjhoUrLlTBvahXnKui0F72WIq7eVb0ptdRlyuAN9RR9ZznFFRsaTDluDVa4LCk/GUFPewv
	XqPNzDm2pS/kqS7MdwTtxzJH+JURzPnVo
X-Gm-Gg: ASbGnctubmgQO0Wm3S4mC6IiH4b9OZi8QVpVxI7FS9+FE7NlkKt+hNMoJpDV6LSngYi
	5Su+mxdmUgmrnfCDros+6yVCI/CdRvPZxMYLJpUH5TRvdwLIVsni4BBE79ORnMF8KmLdrW1O/vI
	OjxkQz0emmbqVKX+TbsTqIX0EcDyNNMr8WaVHzukG7qfN0W9BEe30R3w4D173QQUXLSw==
X-Google-Smtp-Source: AGHT+IH/Nbr/kPG6XWlS5luMFUVXUKsuG3SRaPdv6LYPT5QFodckTNFej7Tdhx28B7Zp39A9TO+5tE8uxL8kv60xTNc=
X-Received: by 2002:a05:6e02:1a8d:b0:3d8:20fb:f060 with SMTP id
 e9e14a558f8ab-3da7e1e2b95mr155811975ab.4.1747071365561; Mon, 12 May 2025
 10:36:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250501225958.2947677-1-gitster@pobox.com> <20250503005814.3030099-1-gitster@pobox.com>
 <20250503005814.3030099-2-gitster@pobox.com>
In-Reply-To: <20250503005814.3030099-2-gitster@pobox.com>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 12 May 2025 10:35:54 -0700
X-Gm-Features: AX0GCFuvWEfiem8O2ST4MH8ueXhRrDPNk86r9VO1FmfneP3Emb2PD620QurXhH0
Message-ID: <CABPp-BH-=J+VEuk-61FkB8ETeUQCZPWysOOSdvg7G0-gBVq7BA@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] you-still-use-that??: help deprecating commands
 for removal
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 2, 2025 at 5:58=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> A command slated for removal like "git pack-redundant" gains a
> command line option "--i-still-use-this", and refuses to work when
> the option is not given.  The message and the instruction upon
> seeing what to do are both rather long, so before letting another
> command to use the same mechanism, factor out the message+die part
> into a small helper function, and use that.
>
> The existing pack-redundant test lacked a test to make sure that we
> require the --i-still-use-this option.  Add one while we are at it.

The "gains a command line option" made me think you were discussing a
change made by this patch, rather than discussing an existing
mechanism.  Could I spitball an alternative?  Maybe something like...


Commands slated for removal, like "git pack-redundant", now require an
explicit --i-still-use-this option to run. This discourages casual use and
surfaces their pending deprecation to users.

The warning message is long, so we factor it into a helper function
(you_still_use_that()) to simplify reuse by other commands.

Also add a missing test to ensure this enforcement works for
"pack-redundant".


>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/pack-redundant.c  | 10 ++--------
>  git-compat-util.h         |  2 ++
>  t/t5323-pack-redundant.sh |  5 +++++
>  usage.c                   | 12 ++++++++++++
>  4 files changed, 21 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
> index 3febe732f8..6dc9e020c7 100644
> --- a/builtin/pack-redundant.c
> +++ b/builtin/pack-redundant.c
> @@ -625,14 +625,8 @@ int cmd_pack_redundant(int argc, const char **argv, =
const char *prefix UNUSED, s
>                         break;
>         }
>
> -       if (!i_still_use_this) {
> -               fputs(_("'git pack-redundant' is nominated for removal.\n=
"
> -                       "If you still use this command, please add an ext=
ra\n"
> -                       "option, '--i-still-use-this', on the command lin=
e\n"
> -                       "and let us know you still use it by sending an e=
-mail\n"
> -                       "to <git@vger.kernel.org>.  Thanks.\n"), stderr);
> -               die(_("refusing to run without --i-still-use-this"));
> -       }
> +       if (!i_still_use_this)
> +               you_still_use_that("git pack-redundant");
>
>         if (load_all_packs)
>                 load_all();
> diff --git a/git-compat-util.h b/git-compat-util.h
> index e123288e8f..21cab99567 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -703,6 +703,8 @@ void warning_errno(const char *err, ...) __attribute_=
_((format (printf, 1, 2)));
>
>  void show_usage_if_asked(int ac, const char **av, const char *err);
>
> +NORETURN void you_still_use_that(const char *command_name);
> +
>  #ifndef NO_OPENSSL
>  #ifdef APPLE_COMMON_CRYPTO
>  #include "compat/apple-common-crypto.h"
> diff --git a/t/t5323-pack-redundant.sh b/t/t5323-pack-redundant.sh
> index 688cd9706c..f2f20cfa40 100755
> --- a/t/t5323-pack-redundant.sh
> +++ b/t/t5323-pack-redundant.sh
> @@ -45,6 +45,11 @@ fi
>  main_repo=3Dmain.git
>  shared_repo=3Dshared.git
>
> +test_expect_success 'pack-redundant needs --i-still-use-this' '
> +       test_must_fail git pack-redundant >message 2>&1 &&
> +       test_grep "nominated for removal" message
> +'
> +
>  git_pack_redundant=3D'git pack-redundant --i-still-use-this'
>
>  # Create commits in <repo> and assign each commit's oid to shell variabl=
es
> diff --git a/usage.c b/usage.c
> index 38b46bbbfe..4aaad2b553 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -372,3 +372,15 @@ void bug_fl(const char *file, int line, const char *=
fmt, ...)
>         trace2_cmd_error_va(fmt, ap);
>         va_end(ap);
>  }
> +
> +NORETURN void you_still_use_that(const char *command_name)
> +{
> +       fprintf(stderr,
> +               _("'%s' is nominated for removal.\n"
> +                 "If you still use this command, please add an extra\n"
> +                 "option, '--i-still-use-this', on the command line\n"
> +                 "and let us know you still use it by sending an e-mail\=
n"
> +                 "to <git@vger.kernel.org>.  Thanks.\n"),
> +               command_name);
> +       die(_("refusing to run without --i-still-use-this"));
> +}
> --
> 2.49.0-601-ga5925c3955

Patch looks good.
