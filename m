Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0339484A3E
	for <git@vger.kernel.org>; Tue, 17 Jun 2025 02:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750129161; cv=none; b=fKK8FL/33g98qrhUxKMmzhzzSW75P/YllFGCxCrjhlOQAovgwGCutbBPgZDOQIpHrdVn0/UIzYgTf9FZPfVFWTi8fGqaRxHKP53ujS00DUg1BHfkihVeMrBokvD2rwQr8V2UKiPaKWux9PGyoM65WUzgPt/yxp0UTqQMg+txhpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750129161; c=relaxed/simple;
	bh=wbvNUMqaEItXXFU5fV5JiPlkabP4XJyF/54F6y+IaWw=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=cxGF5Q5hPAbDERUsabQUndYYnsInzwbwGr2BV24vYjWdQu4ci8jYOxQKsmI9suGtXrVMMuP8RBqTyv0nClMJQO8f2Ykxwzh3YrU1fUHxVxjJdUSeIOTy3ZQbAktbKLScVfRzmSuj9gRqJrYzxijWBkto4QRQju4KBbeWByBpjM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7rfYqRu; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7rfYqRu"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b26f5f47ba1so4268173a12.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 19:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750129159; x=1750733959; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5b5jqbFWjESqxkL/fUyC7q9gNJG+3ju0XQS7C/wunx4=;
        b=Q7rfYqRuy2Vzm8dXaPjWmGuy1jqDzmCh9kCRAtgQaY+KOZpkr1ZJLvPSZbzNBfTCfC
         tcC/q3iUpRt2PBCKDL/OO2ik4F/CuFMfE4eRB/1FHBCzrVBbqt276lYP743rXLSuTcN+
         izwYQE1V+xl8iDWkx9FY1P15883OYt1dWaDfk0uYWRegXAj7LU9hm55/Vuw64hGSgvYX
         l3rsN+ToMWHMowZ0788TEOCUDhDGkDqadDNuLrLcb7VTXcd3oPMzcaPjua1n0NuYWD/o
         MKNSUCE8GJJgXHQsmvXkqtPU/UEwvtOC9n9UBQv1FWUBEalugJjktkvyRqSSMZ9sWiap
         6yHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750129159; x=1750733959;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5b5jqbFWjESqxkL/fUyC7q9gNJG+3ju0XQS7C/wunx4=;
        b=wMxxuktdjRVHFphI3ciPw+em/6/LUHuOeTUGqeqKQeD3KTTbicH8aWEuwMUy0mkEmN
         cyp0cPbK2vAhFDB2j3ONiquyYOA91nJIQVA5sTJMGgLp9w0EKhkBKFi1HNvOz4WvebRi
         626XasU+mzDxhLjWPLmvfdf+5Fs6vVwKyCkFxWHbUPuqCPPtgokLjPpqJvHgmz4WdkWw
         zjzupDknE0QpOgP6MFEgzxh8KRaribu2MGhs0AOxRFUHQJx5EYRK8q/tA8V/p+mH5Au8
         8+LcFjDKIRGJk9dtwfmmSxWJJA0y6pAmhcssEQeflZ4QT3tStuo5z+UD1+PaORamwTqJ
         OcsQ==
X-Gm-Message-State: AOJu0YyHnIi3VRyeeDFFC40Xpo7QFzFivzDpIX6CKrF84BPSEI6yeVhf
	Jax/HZ+Zy69reUnGIKTs0Hm1HBbwhyaWJaL/k06bkKqrpclVFzTW8BHkMODLGnoOrhLXw0RG
X-Gm-Gg: ASbGnctO6ADmKrLq8KHbQbyfW9C7tT9jXNE0MBMUoZuPl7Kfl1oo5jZBJFB1/sIGJhV
	V1eqdXUgl+yimkUSvZiW4liWMW0AzODBAX6hX9v0o9D30bPR178bQG7y+UHZlg8L3raGZIxBoC0
	ZqG6/4oCCFb4O9l9YxqD1v1VhCFa8i0yz+tvLY7BXpsKyQ2og4hvA7XTF+DEDpFWrG0benrNcEJ
	+Vj8AKliiH/XxWCcyB+AFuNM5tcyflzmPv1vJ358NJKfADp1sMd/D5Ts4xVSdMfGkruQRSyY8mo
	WJAGnAMjvHUaE2zG4d4FNWB6CnHDLHc5ss+BTpHamTQNDEXk7n0FOuFnRlsPc2zwnzpD9r+LmPx
	RODrWWR3dm339vOvZWvtBKtqq0Xn9OoI176ZJfJ7ly9ehyaXV+qt2UQxpCwiN/FrZ
X-Google-Smtp-Source: AGHT+IFHySrzzjQ8+cFFDCmg3s0RzTuQ/WdkHbOSI2JcDOm1GzJIuiEDAT7oMRD2oY5bZjfG/KnDFg==
X-Received: by 2002:a17:90b:3148:b0:313:31ca:a69 with SMTP id 98e67ed59e1d1-313f1daa79emr21365758a91.18.1750129159015;
        Mon, 16 Jun 2025 19:59:19 -0700 (PDT)
Received: from smtpclient.apple (n058152022104.netvigator.com. [58.152.22.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31427e7d69fsm347737a91.26.2025.06.16.19.59.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Jun 2025 19:59:18 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH 4/6] submodule--helper: improve logic for fallback remote
 name
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
Date: Tue, 17 Jun 2025 10:58:46 +0800
Cc: git@vger.kernel.org,
 Jacob Keller <jacob.keller@gmail.com>,
 Junio C Hamano <gitster@pobox.com>,
 Patrick Steinhardt <ps@pks.im>
Content-Transfer-Encoding: quoted-printable
Message-Id: <90B8957C-9469-4D46-9026-46407AD2EC1B@gmail.com>
References: <20250610-jk-submodule-helper-use-url-v1-0-6d14c1504e91@gmail.com>
 <20250610-jk-submodule-helper-use-url-v1-4-6d14c1504e91@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)

Jacob Keller <jacob.e.keller@intel.com> writes=EF=BC=9A
>=20
> From: Jacob Keller <jacob.keller@gmail.com>
>=20
> The repo_get_default_remote() function in submodule--helper currently
> tries to figure out the proper remote name to use for a submodule =
based
> on a few factors.
>=20
> First, it tries to find the remote for the currently checked out =
branch.
> This works if the submodule is configured to checkout to a branch
> instead of a detached HEAD state.
>=20
> In the detached HEAD state, the code calls back to using "origin", on
> the assumption that this is the default remote name. Some users may
> change this, such as by setting clone.defaultRemoteName, or by =
changing
> the remote name manually within the submodule repository.
>=20
> As a first step to improving this situation, refactor to reuse the =
logic
> from remotes_remote_for_branch(). This function uses the remote from =
the
> branch if it has one. If it doesn't then it checks to see if there is
> exactly one remote. It uses this remote first before attempting to =
fall
> back to "origin".
>=20
> To allow using this helper function, introduce a repo_default_remote()
> helper to remote.c which takes a repository structure. This helper =
will
> load the remote configuration and get the "HEAD" branch. Then it will
> call remotes_remote_for_branch to find the default remote.

Just a thought: since repo_default_remote() is only used within
repo_get_default_remote(), and the two have very similar names,
do you think it might be clearer to inline the former into the latter?

> This method allows re-using the same existing logic as other flows,
> rather than duplicating it in submodule--helper.c.
>=20
> This isn't a perfect solution for users who change remote names, but =
it
> should help in cases where the remote name is changed but users =
haven't
> added any additional remotes.
>=20
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> remote.h                    |  2 ++
> builtin/submodule--helper.c | 18 +++---------------
> remote.c                    | 25 ++++++++++++++++++++-----
> t/t7406-submodule-update.sh | 29 +++++++++++++++++++++++++++++
> 4 files changed, 54 insertions(+), 20 deletions(-)
>=20
> diff --git a/remote.h b/remote.h
> index =
7e4943ae3a70ecefa3332d211084762ca30b59b6..ef0de4aa64e9ccd32cc2eea076c00386=
dcba1161 100644
> --- a/remote.h
> +++ b/remote.h
> @@ -338,6 +338,8 @@ const char *remote_for_branch(struct branch =
*branch, int *explicit);
> const char *pushremote_for_branch(struct branch *branch, int =
*explicit);
> char *remote_ref_for_branch(struct branch *branch, int for_push);
>=20
> +const char *repo_default_remote(struct repository *repo);
> +
> /* returns true if the given branch has merge configuration given. */
> int branch_has_merge_config(struct branch *branch);
>=20
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index =
9e8cdfe1b2a8c2985d9c1b8ad6f1b0d1f9401714..ef3ff65a80f398c5ac35660288290ad9=
2c7132c7 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -43,8 +43,6 @@ typedef void (*each_submodule_fn)(const struct =
cache_entry *list_item,
>=20
> static int repo_get_default_remote(struct repository *repo, char =
**default_remote)
> {
> - char *dest =3D NULL;
> - struct strbuf sb =3D STRBUF_INIT;
> struct ref_store *store =3D get_main_ref_store(repo);
> const char *refname =3D refs_resolve_ref_unsafe(store, "HEAD", 0, =
NULL,
>      NULL);
> @@ -52,23 +50,13 @@ static int repo_get_default_remote(struct =
repository *repo, char **default_remot
> if (!refname)
> return die_message(_("No such ref: %s"), "HEAD");
>=20
> - /* detached HEAD */
> - if (!strcmp(refname, "HEAD")) {
> - *default_remote =3D xstrdup("origin");
> - return 0;
> - }
> -
> - if (!skip_prefix(refname, "refs/heads/", &refname))
> + if (strcmp(refname, "HEAD") &&
> +    !skip_prefix(refname, "refs/heads/", &refname))
> return die_message(_("Expecting a full ref name, got %s"),
>   refname);
>=20
> - strbuf_addf(&sb, "branch.%s.remote", refname);
> - if (repo_config_get_string(repo, sb.buf, &dest))
> - *default_remote =3D xstrdup("origin");
> - else
> - *default_remote =3D dest;
> + *default_remote =3D xstrdup(repo_default_remote(repo));
>=20
> - strbuf_release(&sb);
> return 0;
> }
>=20
> diff --git a/remote.c b/remote.c
> index =
1035f0cd32d034cce05bd2a3d829ec90795ff4e2..fcda185ecfab5102afbe8918fed65c74=
971ef8c2 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1759,20 +1759,35 @@ static void set_merge(struct repository *repo, =
struct branch *ret)
> }
> }
>=20
> -struct branch *branch_get(const char *name)
> +static struct branch *repo_branch_get(struct repository *repo, const =
char *name)
> {
> struct branch *ret;
>=20
> - read_config(the_repository, 0);
> + read_config(repo, 0);
> if (!name || !*name || !strcmp(name, "HEAD"))
> - ret =3D the_repository->remote_state->current_branch;
> + ret =3D repo->remote_state->current_branch;
> else
> - ret =3D make_branch(the_repository->remote_state, name,
> + ret =3D make_branch(repo->remote_state, name,
>  strlen(name));
> - set_merge(the_repository, ret);
> + set_merge(repo, ret);
> return ret;
> }
>=20
> +struct branch *branch_get(const char *name)
> +{
> + return repo_branch_get(the_repository, name);
> +}
> +
> +const char *repo_default_remote(struct repository *repo)
> +{
> + struct branch *branch;
> +
> + read_config(repo, 0);
> + branch =3D repo_branch_get(repo, "HEAD");
> +
> + return remotes_remote_for_branch(repo->remote_state, branch, NULL);
> +}
> +
> int branch_has_merge_config(struct branch *branch)
> {
> return branch && !!branch->merge;
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> index =
c562bad042ab2d4d0f82cb8b57a1eadbe24044d1..748b529745a5121f121768bb4e0cbc11=
bc833ea4 100755
> --- a/t/t7406-submodule-update.sh
> +++ b/t/t7406-submodule-update.sh
> @@ -1134,6 +1134,35 @@ test_expect_success 'setup clean recursive =
superproject' '
> git clone --recurse-submodules top top-clean
> '
>=20
> +test_expect_success 'submodule update with renamed remote' '
> + test_when_finished "rm -fr top-cloned" &&
> + cp -r top-clean top-cloned &&
> +
> + # Create a commit in each repo, starting with bottom
> + test_commit -C bottom rename_commit &&
> + # Create middle commit
> + git -C middle/bottom fetch &&
> + git -C middle/bottom checkout -f FETCH_HEAD &&
> + git -C middle add bottom &&
> + git -C middle commit -m "rename_commit" &&
> + # Create top commit
> + git -C top/middle fetch &&
> + git -C top/middle checkout -f FETCH_HEAD &&
> + git -C top add middle &&
> + git -C top commit -m "rename_commit" &&
> +
> + # rename the submodule remote
> + git -C top-cloned/middle remote rename origin upstream &&
> +
> + # Make the update of "middle" a no-op, otherwise we error out
> + # because of its unmerged state
> + test_config -C top-cloned submodule.middle.update !true &&
> + git -C top-cloned submodule update --recursive 2>actual.err &&
> + cat >expect.err <<-\EOF &&
> + EOF
> + test_cmp expect.err actual.err
> +'
> +
> test_expect_success 'submodule update should skip unmerged submodules' =
'
> test_when_finished "rm -fr top-cloned" &&
> cp -r top-clean top-cloned &&
>=20
> --=20
> 2.48.1.397.gec9d649cc640
>=20
>=20

