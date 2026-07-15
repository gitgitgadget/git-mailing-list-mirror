Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B239431E53
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 16:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784134211; cv=none; b=al4iasA/BaEKFirk2+PYrJJwdhtTmLn102UiJZSmJnDE6W1EHSyBij4dz9U9ZR/S46BTFPBUX8JvW/Dmz6zACDsqFF1eDKkYUohxnZzPX6rhGZ4nNmPwy8/eX07q1t0aIVQ5p4PoOvhqSmZ6ABrFHtY0mXQ0ulD9OT7kQZavE+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784134211; c=relaxed/simple;
	bh=RRJ39jqv7x6Dvkj1PxZdTdf5UFTnGkyX9PuRzd9yPLs=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=sRojBbPTZnDTcepyci0Ghmw/bnOq7axjC5O2rFfdYxKgKrBlMRnH5HJUv/LiRV09wpTNQw/VMFvKizGWdxpkcwhaepfPg5E+v8qtwSSn+RLE985QLeIBhacNbLhIIVzI2kkMKhu8c0vSJ0o/LkY8nmB0qmoAo3k7Pgyt8MfLeUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dU8/UP3M; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dU8/UP3M"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-66810946e63so1553844d50.1
        for <git@vger.kernel.org>; Wed, 15 Jul 2026 09:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784134208; x=1784739008; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zpe7mSG+Nq/jQ4oF0lXUU+bgYgrOhyUgw5vxGDJKWUs=;
        b=dU8/UP3MGRuEneGROb5gUQ+puoobOd2yy1YRhfbzYPzT1pPcdEjceb8m/RbrLniSHT
         C5mZ2sNQEUlstInd7JQ7016D5ZGmXjpkE5Ox+WTuYfG29qW9H+2U5+USC/VbpR2oC3hY
         TWEod/smQm940QI7SEFD8RnGVMG04umJck2DlnH3hGg2X/jdrdoDcI+ocQcB5jB05nTM
         2Ou0Vc/1+tdTG0Ymci/o+xIYiEIcJRbVeW61VGRYtd63Cw8enalr4sIW1pmSp50F+P25
         /tga0++ZYaGe4+4hNS1+IWFE7wAhE6T1Q+k7Eq4qT5BglGBcHYUiGWbhBHCQN83C26+S
         ULCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784134208; x=1784739008;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zpe7mSG+Nq/jQ4oF0lXUU+bgYgrOhyUgw5vxGDJKWUs=;
        b=aCRNDzI4saBzQDmEZ/kdnQKED8Jk9OUuNLYoHmbeR3LGWHSD7tJe0g1oLO9hOUNIVt
         raaIrPsWbADlaFxFxFE6lrmWElv1qwLTxDIzXgnvq6mtotYepZ7q2liGQGcCGw57Q2/9
         0pec7yccHuas/MBh04zOlh0y3iMR6EG1xlTvMYgmVNVA7OuYjijjXPmJ7REwnmyNwPFP
         p6leGEHLExbPty2qPLmE6w5WLIJ9bYEHcUI8my2cpJnpKtazacOAZll2VY2rTfLxiq7j
         Mc1kGYeEG8D+xr2CTMfi0DYKbaIhiD2enkmUqx9IYzPWaoZZYhqi8fhAo71PpkPGgS8S
         PHsg==
X-Gm-Message-State: AOJu0YycDMZdG4K6LLvwBM8YTi7x50yxwzGKnNsQ8ATCwJJo/iC8VX0p
	aiZeD/8uSq5o8j7FfDoFtoC8cY24WSdJzFuQ/Zn6Z7aBhl0B88SYfRq2Ni3Zrw==
X-Gm-Gg: AfdE7cksEcoFLqWgD+apW45ZLfIa2bLc18BQJBj/oOGX/XphYK8V1b5eZGkO+SRwyxW
	xiGWpblx1I7WqDGFLR8hrYqn302EibaRIDa8+nNzkVt81B00cOFW5L4rMcRGB3svtBJrYq2DkZT
	/wRMQ/9CPYQe3gDJ89cIJDeRF5FfDtvaqBnnufDxolLC1aYvLIej8d1Rv4rx8K3K3xxSTwSBxhf
	G9UiYg9obMv82qtsBTO98o5Dh1xaovFVipjab/EYfvUsuug8ctcf7Po69i7FL1yAaaFz23ApA7s
	e03KNFpRFlTpG6fq7a8weLr6ffiTDphA6zYxZq7M9LVTzF8ZbF9phPoLlxZEgrXq6F3wR3Z6h5z
	gEnJqNVN82A9cQnid9vER2A0nsVv/9qJ8Z0m8YA8gPBh8t4IdLDg7aSeUcL6gux0jicn7w0EGoI
	P5hfVrWPJY35uD426yiR/BoVoTVl6zqnCSoHsym0/8hqhZjQwNkBEiitmrJvUQHojDDKBwsTbD2
	pFYCiw1DKlmPfxd97ZCBoj8lKaqC7sM86F7/B1R6NEi/lRU+hLJx/ckLdAv2cJKxAo=
X-Received: by 2002:a53:d04a:0:20b0:651:e1e7:7f50 with SMTP id 956f58d0204a3-66802a1114fmr5188620d50.29.1784134207355;
        Wed, 15 Jul 2026 09:50:07 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90fb:c300:4450:2d21:81ac:e796])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6681fe4b19asm964352d50.17.2026.07.15.09.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 09:50:06 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mv: report missing destination leading directory
Date: Wed, 15 Jul 2026 12:46:44 -0400
Message-Id: <C6C7AB29-7027-467B-8DCC-3443CC356628@gmail.com>
References: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Lucas Zamboni Orioli <lucaszam0@gmail.com>
In-Reply-To: <pull.2356.git.git.1784125963694.gitgitgadget@gmail.com>
To: Lucas Zamboni Orioli via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: iPhone Mail (23D8133)


> Le 15 juil. 2026 =C3=A0 10:51, Lucas Zamboni Orioli via GitGitGadget <gitg=
itgadget@gmail.com> a =C3=A9crit :
>=20
> =EF=BB=BFFrom: Lucas Zamboni Orioli <lucaszam0@gmail.com>
>=20
> When moving a file to a destination whose leading directory does not
> exist, "git mv" fails at the rename(2) syscall with ENOENT. Because
> the error is reported via die_errno() using only the source path:
>=20
>    fatal: renaming 'src' failed: No such file or directory
>=20
> the message misleadingly blames the source, even though it is the
> destination's parent directory that is missing. A user who runs
>=20
>    git mv a/file b/does-not-exist/file
>=20
> is told the problem is with 'a/file', which exists, giving no hint
> that 'b/does-not-exist/' needs to be created first.
>=20
> The checking phase already rejects a missing destination directory
> when the destination ends in a slash, but a destination that names a
> file inside a non-existent directory is not caught and only fails
> later at rename(2). As a result "git mv -n" also fails to detect the
> problem, since the dry run never reaches the syscall and reports a
> move that would not actually succeed.
>=20
> Detect this during the checking phase instead: for entries that will
> be renamed on disk, stat the destination's leading directory and, if
> it is missing, fail with the existing "destination directory does not
> exist" message. Guard the check with the same condition under which
> rename(2) is invoked so that directory moves, whose child entries are
> expanded to paths under a not-yet-created directory, and sparse or
> out-of-cone destinations, which are not written to the worktree, are
> not flagged incorrectly.

I suppose this still allows a TOCTOU issue where the check succeeds and (wit=
h lucky timing) the destination then disappears?

In that case, I think a worthwhile additional change would also be for the e=
rror message to diagnose which file is missing (or at least include both sou=
rce and destination).

Now, without checking I somehow doubt whether rename(2) tells us which entry=
 is missing. Worse, if we check afterwards, we could have a =C2=AB TOUTOC =C2=
=BB :p where the entry reappears to confuse the error diagnosis.

So perhaps

    fatal: renaming A -> B failed: no such file or directory

taking some inspiration from the -i modes of cp, mv?

> This gives a clear message and lets "git mv -n" report the failure.
>=20
> Signed-off-by: Lucas Zamboni Orioli <lucaszam0@gmail.com>
> ---
>    mv: report missing destination leading directory
>=20
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2356=
%2FZamboniL%2Fmv-detect-non-existing-target-folder-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2356/Za=
mboniL/mv-detect-non-existing-target-folder-v1
> Pull-Request: https://github.com/git/git/pull/2356
>=20
> builtin/mv.c  | 21 +++++++++++++++++++++
> t/t7001-mv.sh | 14 ++++++++++++++
> 2 files changed, 35 insertions(+)
>=20
> diff --git a/builtin/mv.c b/builtin/mv.c
> index e03823370c..a95531f0b2 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -444,6 +444,27 @@ dir_check:
>            goto act_on_entry;
>        }
>=20
> +        /*
> +        * If we are going to move SRC to DST on disk, DST's leading
> +        * directories must already exist.
> +        */
> +        if (!(modes[i] & (INDEX | SPARSE | SKIP_WORKTREE_DIR)) &&
> +                !(dst_mode & (SKIP_WORKTREE_DIR | SPARSE))) {
> +                char *dst_dir =3D xstrdup(dst);
> +                char *slash =3D strrchr(dst_dir, '/');
> +
> +                if (slash) {
> +                        struct stat dir_st;
> +                        *slash =3D '\0';
> +                        if (lstat(dst_dir, &dir_st) < 0 && errno =3D=3D E=
NOENT) {
> +                                free(dst_dir);
> +                                bad =3D _("destination directory does not=
 exist");
> +                                goto act_on_entry;
> +                        }
> +                }
> +                free(dst_dir);
> +        }
> +
>        if (ignore_sparse &&
>            (dst_mode & (SKIP_WORKTREE_DIR | SPARSE)) &&
>            index_entry_exists(the_repository->index, dst, strlen(dst))) {
> diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
> index 920479e925..8a45997b33 100755
> --- a/t/t7001-mv.sh
> +++ b/t/t7001-mv.sh
> @@ -114,6 +114,20 @@ test_expect_success 'clean up' '
>    git reset --hard
> '
>=20
> +test_expect_success 'moving to non-existent destination parent directory'=
 '
> +    git reset --hard &&
> +    mkdir -p from &&
> +    echo content >from/file &&
> +    git add from/file &&
> +    test_must_fail git mv from/file no-such-dir/file 2>actual &&
> +    test_grep "destination directory does not exist" actual
> +'
> +
> +test_expect_success 'mv --dry-run detects non-existent destination parent=
 directory' '
> +    test_must_fail git mv -n from/file no-such-dir/file 2>actual &&
> +    test_grep "destination directory does not exist" actual
> +'
> +
> test_expect_success 'moving to existing untracked target with trailing sla=
sh' '
>    mkdir path1 &&
>    git mv path0/ path1/ &&
>=20
> base-commit: 55526a18268bbc1ddaf8a6b7850c33d984eac9e9
> --
> gitgitgadget
>=20
