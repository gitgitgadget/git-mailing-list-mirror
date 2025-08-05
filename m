Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603C0200127
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 22:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431626; cv=none; b=CY1dHi8o9c4p4uKIbEXs5IoVwQcdjdZpQgblOp5UqLwey5a2+28Loz0tbnUCmTSqNGJck42/zuVaCBytfciV26RME63zzDX8YoAZRKBMCtSqmiWTgctlDjv+ljU/6+6KB1NPhX3DlcbVOgFVOkH1CFDJdHLZ8AxSGsf5q0Nqz6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431626; c=relaxed/simple;
	bh=IhFLTZQj2qLpIVd9UcAIEBYVlJhiiMDAnxL7hIRERLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rRXv+oZDQ/5m3bi3rr95Be1KaSn/DssUle6JkTs5ZEENqK7dpnwpvJ9wEjuZs9ZhtTbzmWrEYM1/BwFGNofQxmSHiI7o/GpCgsZbMEq9XHt8cESP0dLvO6w9AESV/357tVZXVM8aCv20WsuKYu/zT3SUrpTu3H2J8cS8HB7/YUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SGxNE7SG; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SGxNE7SG"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-741a5e8fa94so1094637a34.2
        for <git@vger.kernel.org>; Tue, 05 Aug 2025 15:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754431623; x=1755036423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5iGpS3N2hCNAiJIPgrA2TaiIGABHcXgrBHtzzaSyDXY=;
        b=SGxNE7SGeMJzy2OL2nzVR+Wk7uAl1p1DQQ3xHS6OxwAk1YHeEAfP1dPwwdTRYZwwb5
         wgbuY1GqnmdoIbK2yfbnlxafFD5yQ8wqjCXJMS0mdcMoREnYiBBBCbETuOFoeoYzNios
         XeHhz96NCpK8gCQP8ThlXlZZQsy5gJ/LFNhHZH8niEXf6fVJvaf4iBzcLKLA2lOsphkj
         45dgMousax9p1G3Zznz2HLg+qpzVHflkyNC10V1yakbiw8hZg2kcGW2z2RpVpd+y7JS5
         4oYBcS2b4s5HBAxGGMie2OS6eXrcAfajD43uiKw42bNx/pX7oPYHoRFN/c1+MSsHS0Uy
         NS4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754431623; x=1755036423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5iGpS3N2hCNAiJIPgrA2TaiIGABHcXgrBHtzzaSyDXY=;
        b=Sw4kZA3WAkV/Ap3QM6A4ibqJcQl9kSlI/Xph1tfK4dzWErGBTpjV4tHuwvdO11dMHF
         PZnkVY5vdl258ncyPPIN1U0jcSzsVyKQc253ynqtpgXB5vNdEYPXJEMD+Ehi0gDz18Lx
         RElYKWXvFoo/i/Gf/oq/Z3c0uJV8hJGINQCOz80BS5++Csvbud90au9KnTiwhKYZ7VSb
         NbKWx0KGZtWB9jTUSAlAtYZ0vwriKKem5W04Gg6ufJdn8Nih1p3BqPnkn2y2JvsDDU+i
         SB64UzwgB1g48/3co0xo99495SWLtEcPdhqOTcuL0QW5BfYGqax+wco0c6EB9aBixEph
         AabA==
X-Gm-Message-State: AOJu0YwDq6XcyanAxP2DQsDpaYCT6NZUZn7/gsUujrHOopomIIWeOt/n
	h507zitN8vYqcCSM7m+aDPLhNIW7WIL55ZF6cIqVChZcj1xFRBmKmjxi8+8zy9xqG/1lYa8HA8F
	1ACipYExwK6Q2Zgmv9e+lKFMG7nd5nYnF8zvT
X-Gm-Gg: ASbGncvsePsbAxn+yutAEMteNDleK1EIwwYhTjLO8dNbs+J/boZ1Uw1PzGObgaZOK1n
	LODVuPZ4PRnYP8ZTxg4YoqCbk2wSvdihaCkagCkEt4r8GIi+VC0wwwICgScADA2YN35ddW5ry+1
	q5LXXgfbk0GTn+Jwag2c0keNyzwA25fVo3GWxK/sUUKK5xQ0tUuSWjRMh+mrIITg/ay70/l6m4W
	ZWkRb7oaOx0LvgNILLWgs0vN1AHlkXewv2HY3ld
X-Google-Smtp-Source: AGHT+IFqGa5wKxjJRouzWx9Be5KeJhSgLp40Mm0WZ0Wurgs5xNAsxMdy+/1bsVDPhfnSVC0OnzlMkkPKgK2yZaMHHJU=
X-Received: by 2002:a05:6808:4f2c:b0:433:fd5b:ca78 with SMTP id
 5614622812f47-4357a0ae231mr504045b6e.31.1754431623207; Tue, 05 Aug 2025
 15:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1941.git.1751973594.gitgitgadget@gmail.com>
 <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com> <221f3e5fb0c56b75f8fbfa9f4aa34ae93fad0cdb.1752716054.git.gitgitgadget@gmail.com>
In-Reply-To: <221f3e5fb0c56b75f8fbfa9f4aa34ae93fad0cdb.1752716054.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Aug 2025 15:06:52 -0700
X-Gm-Features: Ac12FXxZwaN3GffW_E07X7OFyShsdVjfCxJgCUL52tmgnMYVUc2OZNWaJV6FyoI
Message-ID: <CABPp-BGQmoPQ9TOLjZPpPPEJ__0rsHgRMJ-nkiW4GcQjPCvaBA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] sparse-checkout: match some 'clean' behavior
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
> The 'git sparse-checkout clean' subcommand is somewhat similar to 'git
> clean' in that it will delete files that should not be in the worktree.
> The big difference is that it focuses on the directories that should not
> be in the worktree due to cone-mode sparse-checkout. It also does not
> discriminate in the kinds of files and focuses on deleting entire
> directories.
>
> However, there are some restrictions that would be good to bring over
> from 'git clean', specifically how it refuses to do anything without the
> '-f'/'--force' or '-n'/'--dry-run' arguments. The 'clean.requireForce'
> config can be set to 'false' to imply '--force'.
>
> Add this behavior to avoid accidental deletion of files that cannot be
> recovered from Git.

I'm a bit surprised by this.  Given that the only kinds of files that
this command cleans out are untracked and ignored files, and Junio's
comments about clean.requireForce over in
https://lore.kernel.org/git/xmqqv7o2togi.fsf@gitster.g/, I thought his
comments could be interpreted as not wanting clean.requireForce to
apply in more places.  Did I misunderstand?

Alternatively, maybe you thought that there were files other than
untracked and ignored which `sparse-checkout clean` would clean up,
and it was because of those files that we wanted the extra protection?
 (In that case, it'd make sense, but it seems to go against what was
demonstrated in the final testcase of the previous patch.)

> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  Documentation/git-sparse-checkout.adoc |  9 ++++
>  builtin/sparse-checkout.c              | 15 +++++-
>  t/t1091-sparse-checkout-builtin.sh     | 66 +++++++++++++++++++++++++-
>  3 files changed, 87 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-sparse-checkout.adoc b/Documentation/git-s=
parse-checkout.adoc
> index 6db88f00781d..823a66c40bc5 100644
> --- a/Documentation/git-sparse-checkout.adoc
> +++ b/Documentation/git-sparse-checkout.adoc
> @@ -119,6 +119,15 @@ all sparsity paths.
>         This command can be used to be sure the sparse index works
>         efficiently, though it does not require enabling the sparse index
>    feature via the `index.sparse=3Dtrue` configuration.
> ++
> +To prevent accidental deletion of worktree files, the `clean` subcommand
> +will not delete any files without the `-f` or `--force` option, unless
> +the `clean.requireForce` config option is set to `false`.
> ++
> +The `--dry-run` option will list the directories that would be removed
> +without deleting them. Running in this mode can be helpful to predict th=
e
> +behavior of the clean comand or to determine which kinds of files are le=
ft
> +in the sparse directories.
>
>  'disable'::
>         Disable the `core.sparseCheckout` config setting, and restore the
> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index 6fe6ec718fe3..fe332ff5f941 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -931,6 +931,7 @@ static char const * const builtin_sparse_checkout_cle=
an_usage[] =3D {
>  };
>
>  static const char *msg_remove =3D N_("Removing %s\n");
> +static const char *msg_would_remove =3D N_("Would remove %s\n");
>
>  static int sparse_checkout_clean(int argc, const char **argv,
>                                    const char *prefix,
> @@ -939,8 +940,12 @@ static int sparse_checkout_clean(int argc, const cha=
r **argv,
>         struct strbuf full_path =3D STRBUF_INIT;
>         const char *msg =3D msg_remove;
>         size_t worktree_len;
> +       int force =3D 0, dry_run =3D 0;
> +       int require_force =3D 1;
>
>         struct option builtin_sparse_checkout_clean_options[] =3D {
> +               OPT__DRY_RUN(&dry_run, N_("dry run")),
> +               OPT__FORCE(&force, N_("force"), PARSE_OPT_NOCOMPLETE),
>                 OPT_END(),
>         };
>
> @@ -954,6 +959,13 @@ static int sparse_checkout_clean(int argc, const cha=
r **argv,
>                              builtin_sparse_checkout_clean_options,
>                              builtin_sparse_checkout_clean_usage, 0);
>
> +       repo_config_get_bool(repo, "clean.requireforce", &require_force);
> +       if (require_force && !force && !dry_run)
> +               die(_("for safety, refusing to clean without one of --for=
ce or --dry-run"));
> +
> +       if (dry_run)
> +               msg =3D msg_would_remove;
> +
>         if (repo_read_index(repo) < 0)
>                 die(_("failed to read index"));
>
> @@ -977,7 +989,8 @@ static int sparse_checkout_clean(int argc, const char=
 **argv,
>
>                 printf(msg, ce->name);
>
> -               if (remove_dir_recursively(&full_path, 0))
> +               if (dry_run <=3D 0 &&
> +                   remove_dir_recursively(&full_path, 0))
>                         warning_errno(_("failed to remove '%s'"), ce->nam=
e);
>         }
>
> diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout=
-builtin.sh
> index a48eedf766d2..69f5a6dcc689 100755
> --- a/t/t1091-sparse-checkout-builtin.sh
> +++ b/t/t1091-sparse-checkout-builtin.sh
> @@ -1056,12 +1056,29 @@ test_expect_success 'clean' '
>         touch repo/deep/deeper2/file &&
>         touch repo/folder1/file &&
>
> +       test_must_fail git -C repo sparse-checkout clean 2>err &&
> +       grep "refusing to clean" err &&
> +
> +       git -C repo config clean.requireForce true &&
> +       test_must_fail git -C repo sparse-checkout clean 2>err &&
> +       grep "refusing to clean" err &&
> +
> +       cat >expect <<-\EOF &&
> +       Would remove deep/deeper2/
> +       Would remove folder1/
> +       EOF
> +
> +       git -C repo sparse-checkout clean --dry-run >out &&
> +       test_cmp expect out &&
> +       test_path_exists repo/deep/deeper2 &&
> +       test_path_exists repo/folder1 &&
> +
>         cat >expect <<-\EOF &&
>         Removing deep/deeper2/
>         Removing folder1/
>         EOF
>
> -       git -C repo sparse-checkout clean >out &&
> +       git -C repo sparse-checkout clean -f >out &&
>         test_cmp expect out &&
>
>         test_path_is_missing repo/deep/deeper2 &&
> @@ -1077,16 +1094,61 @@ test_expect_success 'clean with staged sparse cha=
nge' '
>
>         git -C repo add --sparse folder1/file &&
>
> +       cat >expect <<-\EOF &&
> +       Would remove deep/deeper2/
> +       EOF
> +
> +       git -C repo sparse-checkout clean --dry-run >out &&
> +       test_cmp expect out &&
> +       test_path_exists repo/deep/deeper2 &&
> +       test_path_exists repo/folder1 &&
> +       test_path_exists repo/folder2 &&
> +
>         # deletes deep/deeper2/ but leaves folder1/ and folder2/
>         cat >expect <<-\EOF &&
>         Removing deep/deeper2/
>         EOF
>
> +       # The previous test case checked the -f option, so
> +       # test the config option in this one.
> +       git -C repo config clean.requireForce false &&
>         git -C repo sparse-checkout clean >out &&
>         test_cmp expect out &&
>
>         test_path_is_missing repo/deep/deeper2 &&
> -       test_path_exists repo/folder1
> +       test_path_exists repo/folder1 &&
> +       test_path_exists repo/folder2
> +'
> +
> +test_expect_success 'clean with merge conflict status' '
> +       git clone repo clean-merge &&
> +
> +       echo dirty >clean-merge/deep/deeper2/a &&
> +       touch clean-merge/folder2/extra &&
> +
> +       cat >input <<-EOF &&
> +       0 $ZERO_OID     folder1/a
> +       100644 $(git -C clean-merge rev-parse HEAD:folder1/a) 1 folder1/a
> +       EOF
> +       git -C clean-merge update-index --index-info <input &&
> +
> +       git -C clean-merge sparse-checkout set deep/deeper1 &&
> +
> +       test_must_fail git -C clean-merge sparse-checkout clean -f 2>err =
&&
> +       grep "failed to convert index to a sparse index" err &&

Oh, interesting...with merge conflicts you at least get an error that
it can't convert, whereas when there are tracked files (whether with
staged changes or unstaged changes or no changes), you don't?  That
seems to at least be good for the merge conflicts case, but it seems
like there's something to fix with the non-conflicted tracked files.
But that's kind of tangential to this patch.

> +       mkdir -p clean-merge/folder1/ &&
> +       echo merged >clean-merge/folder1/a &&
> +       git -C clean-merge add --sparse folder1/a &&
> +
> +       # deletes folder2/ but leaves staged change in folder1
> +       # and dirty change in deep/deeper2/
> +       cat >expect <<-\EOF &&
> +       Removing folder2/
> +       EOF
> +
> +       git -C clean-merge sparse-checkout clean -f >out &&
> +       test_cmp expect out
>  '
>
>  test_done
> --
> gitgitgadget

Patch appears to correctly implement what was stated in the commit message.
