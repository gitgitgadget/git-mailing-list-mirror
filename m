Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B035959
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 22:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754432566; cv=none; b=Dszb+E1p4GFV2F0AcJ7Q0MpYbZ9D1LrOWw1XaNWly7quei9EC2YCs7q4ZGD3r8bKB9ojq90QCsqoumH+WspcD/Kbg2VyhKl9sG/QgqhK9qAIwhWhlnbhR3qfDXqN42fsQIi0b9mx/GUBWL+cOlQxBQy2sPzsEK0A5h+Izgh7udk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754432566; c=relaxed/simple;
	bh=Ly3VPRPARvZMDEXS50hIF0HX704I+ZzTXZNeyKAuwKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J4Kw7vMi4NUplXdDoIG2W1L3o6NFjwHihGuQVedTBrdnOxnKCjUGZG0+ZjmbPwmiDA2ecRxf0FzOvgU15qfqSR9JNJCk5/DA9FqMsQF91fa21TLpyo9jWnkrueu3V3Th7xhbudhMNV5lJKGCeGWSsIXhSybY7ZFbVkbvJPpJx9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aknDgfVK; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aknDgfVK"
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3e3f378ea68so41857285ab.1
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754432564; x=1755037364; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s0QT5W6k309J8XNRh+829hSUJw/27Q0oGMl9yrw5cLU=;
        b=aknDgfVKRkCtYJIBf4HrLzvgwwqLAd/AHvnyuWPG+BNwXypVqYVdxkv+296LlM4L7N
         Gb2GdbHTJc2i8NGyxbrZNgrs7vPU1AgXxTHtNAjeBQlVQVDeU67DLSVRYz9INbOu03jn
         3gPkuHK4aWstvcK7q8kD48+rkMEc3c/PgxzoRLdjsyDsO/XvMy2NP+b0G20cK02SwtHy
         79ai9ln7YQwfEIlelnTjkYBC8z0LJVgNHTr3dep3LEu4QHYx13QNkLitLreyD4DmoB4N
         Me5cIlhWlQm+0WPRC/rTHwzXrGQmiHBt93syp30XvxY0H4Y3RrdZHJzVmDF+jVQRJiJv
         d18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754432564; x=1755037364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s0QT5W6k309J8XNRh+829hSUJw/27Q0oGMl9yrw5cLU=;
        b=ZLNBteMQj4VdIZdEjF9Srn9T0QYTsqUIcqHSjKTP/CwULbJ2Dd3Gk3krssSg1s4JVb
         Lnl4R2cNamRAAc7/JwojQAMwr+3oN4RDwSQcgsAbj9EioXDEQmp1JegwB3HOSX/ZJcvd
         y9awa9Y2xE9dRov7mL6QSJdSeia0FkPVITH1pe85OuastHl78UQdpLWs3NOPr6ivgBXi
         dtEFJYfzjELeif2h7pnvT1Zt7TjAoiI05db9Lq/K8CehWB7i8ElQavOmSHcqEOP5bTQa
         CUbtdk8dvl0NO1T8SPXNAWS9kzBRgiJGGnZKtjIxDJXEQst8UBPHD+nCATjOOaOU8UYp
         m0Vg==
X-Gm-Message-State: AOJu0YzJw03bcQalE2A1rmxoPMeI5qoLVt6eMDO3j3+yMMeZJE/7zpxW
	nabl1qvM5HM+giP3qL/fEvz4RAtH15XE73jhQU/TioCaDrvYkny83nmyGwNMse2Ibl2pI/bP7UG
	Ce1RYj00Qw81m3PdLJrRgjX5JxSZrRF8=
X-Gm-Gg: ASbGnctpCjlsKRd/wwKJGk5vomSYJr4TGUt2C6So26sB2eScuOAwm8bohMBMsqPfomj
	RVKZ797X6XdVL1a21vKRZnAJgJDh7InmIW1hvkVKJ30/gUA0Alh47N5eR468cp0Dym121AA6Jks
	kCffM+S/DJWJJnjXgq0a/YZl+UpJyD2eBwZv13xIW++lVgQ2s9cSS/73al6Lvrc347rloRJ9TMS
	Pcrs5FQDhzqTwHv3dybVJqD17lDTf4BKU4q/fXZ
X-Google-Smtp-Source: AGHT+IEyxUDCa50mmp5LPcRPgAz9GDYvhT8hBO7emk4tixA3RmS83kbZiQ3NcwWLTyNzTXW7AXmVDL50BU/YD5tgFsw=
X-Received: by 2002:a05:6e02:1543:b0:3e4:23b:498f with SMTP id
 e9e14a558f8ab-3e51b8ec64emr4608395ab.14.1754432563544; Tue, 05 Aug 2025
 15:22:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <f464bb5ed6be91940c3abb54b77cb7b9d893bd67.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <f464bb5ed6be91940c3abb54b77cb7b9d893bd67.1752716054.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 15:22:32 -0700
X-Gm-Features: Ac12FXz7gW1hffjK53z8qBDVdSkQEdgElTOZuj-4Aff4YInWmJ2U7HYK6ZlopJE
Message-ID: <CABPp-BFaPG1YpGOcTm=aX6n1XZ3upQ4iYB=nNND4bvsNZ=CqqQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/8] sparse-checkout: add --verbose option to 'clean'
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Patrick Steinhardt <ps@pks.im>, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 6:34=E2=80=AFPM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
> The 'git sparse-checkout clean' subcommand is focused on directories,
> deleting any tracked sparse directories to clean up the worktree and
> make the sparse index feature work optimally.
>
> However, this directory-focused approach can leave users wondering why
> those directories exist at all. In my experience, these files are left
> over due to ignore or exclude patterns, Windows file handles, or
> possibly merge conflict resolutions.

Seems reasonable.  And based on your previous testcases, it might not
even be merge conflict resolutions, but just someone placing a
(possibly-modified) copy of a tracked file back into the directory.

(I've seen folks do that, so it's not "just" your testcase doing
something unusual.)

> Add a new '--verbose' option for users to see all the files that are
> being deleted (with '--force') or would be deleted (with '--dry-run').

Does that answer the users' question?  You said above in your
experience it came from a few different reasons; will users want to
know which reason(s) for which files, or will they only want to know
the files that are present?


> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-sparse-checkout.adoc |  5 +++++
>  builtin/sparse-checkout.c              | 28 ++++++++++++++++++++++++--
>  t/t1091-sparse-checkout-builtin.sh     | 14 ++++++++++---
>  3 files changed, 42 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-s=
parse-checkout.adoc
> index 823a66c40bc5..604f53f77caf 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -128,6 +128,11 @@ The `--dry-run` option will list the directories tha=
t would be removed
>  without deleting them. Running in this mode can be helpful to predict th=
e
>  behavior of the clean comand or to determine which kinds of files are le=
ft
>  in the sparse directories.
> ++
> +The `--verbose` option will list every file within the directories that
> +are considered for removal. This option is helpful to determine if those
> +files are actually important or perhaps to explain why the directory is
> +still present despite the current sparse-checkout.
>
>  'disable'::
>         Disable the `core.sparseCheckout` config setting, and restore the
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index fe332ff5f941..f38a0809c098 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -930,6 +930,26 @@ static char const * const builtin_sparse_checkout_cl=
ean_usage[] =3D {
>         NULL
>  };
>
> +static int list_file_iterator(const char *path, const void *data)
> +{
> +       const char *msg =3D data;
> +
> +       printf(msg, path);
> +       return 0;
> +}
> +
> +static void list_every_file_in_dir(const char *msg,
> +                                  const char *directory)
> +{
> +       struct strbuf path =3D STRBUF_INIT;
> +
> +       strbuf_addstr(&path, directory);
> +       fprintf(stderr, "list every file in %s\n", directory);
> +
> +       for_each_file_in_dir(&path, list_file_iterator, msg);
> +       strbuf_release(&path);
> +}
> +
>  static const char *msg_remove =3D N_("Removing %s\n");
>  static const char *msg_would_remove =3D N_("Would remove %s\n");
>
> @@ -940,12 +960,13 @@ static int sparse_checkout_clean(int argc, const ch=
ar **argv,
>         struct strbuf full_path =3D STRBUF_INIT;
>         const char *msg =3D msg_remove;
>         size_t worktree_len;
> -       int force =3D 0, dry_run =3D 0;
> +       int force =3D 0, dry_run =3D 0, verbose =3D 0;
>         int require_force =3D 1;
>
>         struct option builtin_sparse_checkout_clean_options[] =3D {
>                 OPT__DRY_RUN(&dry_run, N_("dry run")),
>                 OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
> +               OPT__VERBOSE(&verbose, N_("report each affected file, not=
 just directories")),
>                 OPT_END(),
>         };
>
> @@ -987,7 +1008,10 @@ static int sparse_checkout_clean(int argc, const ch=
ar **argv,
>                 if (!is_directory(full_path.buf))
>                         continue;
>
> -               printf(msg, ce->name);
> +               if (verbose)
> +                       list_every_file_in_dir(msg, ce->name);
> +               else
> +                       printf(msg, ce->name);
>
>                 if (dry_run <=3D 0 &&
>                     remove_dir_recursively(&full_path, 0))
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index 69f5a6dcc689..9a89b902c3f5 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -1052,9 +1052,9 @@ test_expect_success 'check-rules null termination' =
'
>
>  test_expect_success 'clean' '
>         git -C repo sparse-checkout set --cone deep/deeper1 &&
> -       mkdir repo/deep/deeper2 repo/folder1 &&
> +       mkdir -p repo/deep/deeper2 repo/folder1/extra/inside &&
>         touch repo/deep/deeper2/file &&
> -       touch repo/folder1/file &&
> +       touch repo/folder1/extra/inside/file &&
>
>         test_must_fail git -C repo sparse-checkout clean 2>err &&
>         grep "refusing to clean" err &&
> @@ -1071,7 +1071,15 @@ test_expect_success 'clean' '
>         git -C repo sparse-checkout clean --dry-run >out &&
>         test_cmp expect out &&
>         test_path_exists repo/deep/deeper2 &&
> -       test_path_exists repo/folder1 &&
> +       test_path_exists repo/folder1/extra/inside/file &&
> +
> +       cat >expect <<-\EOF &&
> +       Would remove deep/deeper2/file
> +       Would remove folder1/extra/inside/file
> +       EOF
> +
> +       git -C repo sparse-checkout clean --dry-run --verbose >out &&
> +       test_cmp expect out &&
>
>         cat >expect <<-\EOF &&
>         Removing deep/deeper2/
> --
> gitgitgadget

You stated in the commit message that "users wonder...why those
directories exist at all."  Presuming that listing files is sufficient
to answer those users questions, this patch looks good to me.  I'm
unsure if that answers the question, or if some kind of classification
of the files would also be wanted (ignored, untracked, conflicted,
tracked-with-unstaged-changes, tracked-wtih-no-changes,
tracked-with-staged-changes).  Maybe the answer is we start with this
and wait for user feedback and only add more if there's demand, but if
so it might be nice to state as much in the commit message.
