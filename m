Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE482367DC
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744397612; cv=none; b=ZORDb7gQPodX4s6C7RDkDHDGBNTUvJ4Q0251TjXRA/QAVB1NPaEODdIbEC04Sb9jtOvL+/4LWgDEA/JldSagCaEA+Z1EwP8EVE3JVtj9n6BbmVqJvRa9SOxajNH8x5/n/seB+kq1Ao/APfXasmPwdLJD9szPuzaTxzDZnqNoV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744397612; c=relaxed/simple;
	bh=tGqDfbVG3e2rLDaAksa4Xcj0Iup3SPp4rx9+nTs+pIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C3cJI8AyfeV+MLzbXzuh5J/sJQzA2LC7HpYx5oNRByuMybflLBjwiFyHjS8YNeTwmkHKTVfOtR0rmYexwGiyDdcuTm9c/THBKKBclIM8pDal4Rw879a1qknEIwMF9S3B5OPLyLON7Fm7p3AJQ3UdE1nFGrcBmr+zEhxIOxJAPl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iO1XZOCB; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iO1XZOCB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso3714255a12.0
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 11:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744397609; x=1745002409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4gKtHXb1L3+S9tMAzCkGMiGIP6M3PLBhipXIaq2aPuI=;
        b=iO1XZOCBRBnbQNv1sVehRkTxp8bPMxmhAYeT1IkNiHDgV5rwQIMwILF7CZRkLSEhJw
         czIVF39odkTrdKiSpBKV89xd9pNOU+KoqfnW3rZ0L8M4+wXdAPTu346CJHJ9I9YjwtVz
         A0L0Yc59dExqWvKasFs4YkE7uEtRgtmrfvC4H7DNymdOtvsm+qNuxyTNR2cUakhqL76v
         2mlJiO9vYHdx0KV4Qeti3x3AFydZNIVnupn9vvCcwHlDAxn+qCcCab9Gqm6tDCcWT9Mt
         h8jzhG1833mISLs51gip72RzsJENDvBkMn9E1ZtctLgyoBPFYkTDaqLfUsONeE7QF2tr
         /+Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744397609; x=1745002409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4gKtHXb1L3+S9tMAzCkGMiGIP6M3PLBhipXIaq2aPuI=;
        b=ksI6mfl6332HUOqd4/BNkZKIonVOFoqtsBpinzzSumdn+xiDOKkVaI1j/TFoBWyHoH
         M3hv/os7iXgqBMxOb8SP47c0OeC5ON6Dvs1bE6TxgIo1SR7j4WjgvYIoB1zv0ItAylff
         vHKjcqA/dd668ULEEmAz/AKPpyODnx4hPuU2p1tYI8MQFV3ckivVKlbkhCD5nSc2c1BR
         5hBavltmm2sE2BfPGmtMGjzX5pA8ydJGrVHrf/BOEqcKhUpMqf6Y5pDTqsSyOaQ91Yc0
         fAo8l3J1bUct447MzrZo4C9x03R34IwUYJS1AukWEaBfIt4gKlOHueOdrMaGycnSZsvp
         RGBQ==
X-Gm-Message-State: AOJu0YzPkxCOiaMti52d/xv7REfpPfcptCoW6YfM5dlzjEfEK/Rzo1Bq
	WHY+NCxXeL2FGs14Chh+ajkcerFdnxJDJ4Nh9l/ABwEKMzZPNdApWDfdRGLuzmxGvm58Xd3H52k
	LfqedusDJtenW0YJd5FAnfekx78w=
X-Gm-Gg: ASbGnctZMqSo6kpZDntQghWdQEBcHTxvRD23+OGSNwMpneUzuD/TK1MKpybTf1+GWTk
	qWE9nHXjtzAtXKOsgWcbZ7RQ+VleAayIrPEjw5re0xzSXpYx9pRAcrcr3SjPAhUM7w1Ba2TMCht
	jvOKOZ4/E2QrR8sJuSz1aX/YD6IZP7EfMjs1cSdVW7aJqtHjXbLaifHigV
X-Google-Smtp-Source: AGHT+IE3OCob6jgGBfX15kOmW2pYBc8ZxqGZ9H8cRbB6LLeFCFZBXHzPfQ/Rva16EJtT9ALi6oM+vfAfqnJeyA5qeus=
X-Received: by 2002:a05:6402:40d5:b0:5e5:437b:74a7 with SMTP id
 4fb4d7f45d1cf-5f36f6441c8mr3517983a12.8.1744397608876; Fri, 11 Apr 2025
 11:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
In-Reply-To: <pull.1899.git.1743719888430.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 11 Apr 2025 14:53:17 -0400
X-Gm-Features: ATxdqUED_FGqJA_NrHaguafyr0rni60dvy-bXBszPQVHK3jrdQn23Cjf2Tn8dKU
Message-ID: <CALnO6CD4ApAC_QqP-XCm0yCo=fx2j8v8Z6ByjUHBYiE=JfZA2w@mail.gmail.com>
Subject: Re: [PATCH] git: add --no-hooks global option
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, james@jamesliu.io, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 6:38=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> Git has several hooks which are executed during certain events as long
> as those hooks are enabled in the hooks directory (possibly moved from
> .git/hooks via the core.hooksPath config option). These are configured
> by the user, or perhaps by tooling the user has agreed to, and are not
> required to operate a Git repository.
>
> In some situations, these hooks have poor performance and expert users
> may want to skip the hooks as they don't seem to affect the current
> situation. One example is a pre-commit hook that checks for certain
> structures in the local changes, but expert users are likely to have
> done the right thing in advance.

Or a pre-push hook that runs tests which, for some reason, are very
slow to execute but which isn't properly shutdown by a normal SIGINT,
messing up my shell.

> I have come across users who have disabled hooks themselves either by
> deleting hooks (supported, safe) or setting 'core.hooksPath' to some
> bogus path (seems unsafe). The supported process is painful to swap
> between the hook-enabled scenario and the hook-disabled scenario.

In my particular case, the tool being used (husky) sets core.hooksPath
to a directory in the repo, so I can go back to using my preferred
hooks simply by unsetting core.hooksPath, which seems safe. But
swapping is still a bit painful, as mentioned.

Worse, every "npm install" in this repo re-enables the hooks, so I
have to remember to reset core.hooksPath :/ When I don't, I spend a
few frustrating minutes getting back to normal. And then I
accidentally train myself to use --no-verify often with this project,
which is IMO a worse state of affairs.

Obviously, this repo's hooks need fixed, but in the interim something
like --no-hooks seems useful to me. Not sure if I count among the
experts or not /shrug.

> To that end, add a new --no-hooks global option to allow users to
> disable hooks quickly. This option is modeled similarly to the
> --no-advice option in b79deeb554 (advice: add --no-advice global option,
> 2024-05-03). This uses a GIT_HOOKS environment variable to communicate
> to subprocesses as well as making this a backwards-compatible way for
> tools to signal that they want to disable hooks.

On a related note: with client-side hooks always being considered
optional, it seems like there ought to be a safe, sane way to turn
them off (rather than remember --no-verify for the various commands,
which is probably the safe, sane way to bypass them on a one-off
basis).

Maybe with this I'll have more ammo to convince folks that their
sanity/security/whatever checks belong in server-side hooks and
optional developer scripts rather than pre-commit hooks.

>
> The critical piece is that all hooks pass through run_hooks_opt() where
> a static int will evaluate the environment variable and store that the
> variable is initialized for faster repeated runs.
>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>     git: add --no-hooks global option
>
>     This is hopefully a helpful feature to more than just the experts I'v=
e
>     been hearing from.
>
>     Thanks,
>
>      * Stolee
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1899%2F=
derrickstolee%2Fno-hooks-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1899/derri=
ckstolee/no-hooks-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1899
>
>  Documentation/git.adoc       | 13 ++++++++++++-
>  environment.h                |  6 ++++++
>  git.c                        |  6 +++++-
>  hook.c                       |  7 +++++++
>  t/t1350-config-hooks-path.sh | 34 ++++++++++++++++++++++++++++++++++
>  5 files changed, 64 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git.adoc b/Documentation/git.adoc
> index 743b7b00e4d..a34c8cfbe78 100644
> --- a/Documentation/git.adoc
> +++ b/Documentation/git.adoc
> @@ -14,7 +14,7 @@ SYNOPSIS
>      [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--no-laz=
y-fetch]
>      [--no-optional-locks] [--no-advice] [--bare] [--git-dir=3D<path>]
>      [--work-tree=3D<path>] [--namespace=3D<name>] [--config-env=3D<name>=
=3D<envvar>]
> -    <command> [<args>]
> +    [--no-hooks] <command> [<args>]
>
>  DESCRIPTION
>  -----------
> @@ -230,6 +230,12 @@ If you just want to run git as if it was started in =
`<path>` then use
>         linkgit:gitattributes[5]. This is equivalent to setting the
>         `GIT_ATTR_SOURCE` environment variable.
>
> +--no-hooks::
> +       Skip running local Git hooks, even if configured locally. Hooks
> +       are an opt-in feature, so be sure that you know the impact of
> +       ignoring hooks when running with this option. This is equivalent
> +       to setting `GIT_HOOKS=3D0` environment variable.
> +
>  GIT COMMANDS
>  ------------
>
> @@ -771,6 +777,11 @@ for further details.
>         not set, Git will choose buffered or record-oriented flushing
>         based on whether stdout appears to be redirected to a file or not=
.
>
> +`GIT_HOOKS`::
> +       If this Boolean environment variable is set to false, then comman=
ds
> +       will ignore any configured hooks as if the `--no-hooks` option wa=
s
> +       provided.
> +
>  `GIT_TRACE`::
>         Enables general trace messages, e.g. alias expansion, built-in
>         command execution and external command execution.
> diff --git a/environment.h b/environment.h
> index 45e690f203f..22ddf201144 100644
> --- a/environment.h
> +++ b/environment.h
> @@ -50,6 +50,12 @@
>   */
>  #define GIT_ADVICE_ENVIRONMENT "GIT_ADVICE"
>
> +/*
> + * Environment variable used to propagate the --no-hooks global option t=
o
> + * the hooks layer and to any child processes.
> + */
> +#define GIT_HOOKS "GIT_HOOKS"
> +
>  /*
>   * Environment variable used in handshaking the wire protocol.
>   * Contains a colon ':' separated list of keys with optional values
> diff --git a/git.c b/git.c
> index 77c43595223..d7ebcf60947 100644
> --- a/git.c
> +++ b/git.c
> @@ -41,7 +41,7 @@ const char git_usage_string[] =3D
>            "           [-p | --paginate | -P | --no-pager] [--no-replace-=
objects] [--no-lazy-fetch]\n"
>            "           [--no-optional-locks] [--no-advice] [--bare] [--gi=
t-dir=3D<path>]\n"
>            "           [--work-tree=3D<path>] [--namespace=3D<name>] [--c=
onfig-env=3D<name>=3D<envvar>]\n"
> -          "           <command> [<args>]");
> +          "           [--no-hooks] <command> [<args>]");
>
>  const char git_more_info_string[] =3D
>         N_("'git help -a' and 'git help -g' list available subcommands an=
d some\n"
> @@ -349,6 +349,10 @@ static int handle_options(const char ***argv, int *a=
rgc, int *envchanged)
>                         setenv(GIT_ADVICE_ENVIRONMENT, "0", 1);
>                         if (envchanged)
>                                 *envchanged =3D 1;
> +               } else if (!strcmp(cmd, "--no-hooks")) {
> +                       setenv(GIT_HOOKS, "0", 1);
> +                       if (envchanged)
> +                               *envchanged =3D 1;
>                 } else {
>                         fprintf(stderr, _("unknown option: %s\n"), cmd);
>                         usage(git_usage_string);
> diff --git a/hook.c b/hook.c
> index b3de1048bf4..b209553d7a8 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -144,6 +144,13 @@ int run_hooks_opt(struct repository *r, const char *=
hook_name,
>
>                 .data =3D &cb_data,
>         };
> +       static int do_run_hooks =3D -1;
> +
> +       if (do_run_hooks < 0)
> +               do_run_hooks =3D git_env_bool(GIT_HOOKS, 1);
> +
> +       if (!do_run_hooks)
> +               goto cleanup;
>
>         if (!options)
>                 BUG("a struct run_hooks_opt must be provided to run_hooks=
");
> diff --git a/t/t1350-config-hooks-path.sh b/t/t1350-config-hooks-path.sh
> index 45a04929170..4c6a0eafe4e 100755
> --- a/t/t1350-config-hooks-path.sh
> +++ b/t/t1350-config-hooks-path.sh
> @@ -48,4 +48,38 @@ test_expect_success 'core.hooksPath=3D/dev/null' '
>         { test /dev/null =3D "$value" || test nul =3D "$value"; }
>  '
>
> +test_expect_success '--no-hooks' '
> +       rm -f actual &&
> +       test_might_fail git config --unset core.hooksPath &&
> +
> +       write_script .git/hooks/pre-commit <<-\EOF &&
> +       echo HOOK >>actual
> +       EOF
> +
> +       echo HOOK >expect &&
> +
> +       git commit --allow-empty -m "A" &&
> +       test_cmp expect actual &&
> +
> +       git --no-hooks commit --allow-empty -m "B" &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'GIT_HOOKS' '
> +       rm -f actual &&
> +       test_might_fail git config --unset core.hooksPath &&
> +
> +       write_script .git/hooks/pre-commit <<-\EOF &&
> +       echo HOOK >>actual
> +       EOF
> +
> +       echo HOOK >expect &&
> +
> +       GIT_HOOKS=3D1 git commit --allow-empty -m "A" &&
> +       test_cmp expect actual &&
> +
> +       GIT_HOOKS=3D0 git commit --allow-empty -m "B" &&
> +       test_cmp expect actual
> +'
> +
>  test_done
>
> base-commit: 5b97a56fa0e7d580dc8865b73107407c9b3f0eff
> --
> gitgitgadget
>


--=20
D. Ben Knoble
