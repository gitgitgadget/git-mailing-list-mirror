Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C95225A38
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 00:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765844490; cv=none; b=iEyLXyVWAxFthm80Cm6Y8mdKskPCCLVREfjShMoI9RVFan4RlCm6lg9f3qQvpBUr10V0O4IB5O3u+7na7kvSh1Vn/IhkQIDqpfX2BqEtSNDalRfBMv/X+7D54XlyccsyToSPEyXVkF8Bza3AqjES0nEYyYNkiFZKSMtnoko2xLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765844490; c=relaxed/simple;
	bh=j5p3uvmLSdT5P2AWZv3ZpmaJiQYRWz8XAJsriUcpP7g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fs3vOkv6OmoKTPOSF+uA1/TN5/TwgQr/2DrVzPSX2D2VEB8WKR7HK9cpokUOP/7GlZxMpoBkvurm48kr/uT/3tux45OLJW9g1rKxUu/ur/ncUmmGHFnd/h8FgcOnNMcyl/qN42YcXKB0RZn82gEeUwOc/TOsNsMIQJ8PCVPlmnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQZaJDiW; arc=none smtp.client-ip=209.85.161.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQZaJDiW"
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-65968986a0cso2503918eaf.3
        for <git@vger.kernel.org>; Mon, 15 Dec 2025 16:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765844487; x=1766449287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZXtOqYAUZJLtHBWZ87PqtbNhKR+rYOChqL2ZoAtDaE=;
        b=UQZaJDiWhW8ew9uteQ52a3Tho73gcKfU+UQwdTAGwFjQIZUTeMVUJQeuCaO7V2al+Z
         xPIBUsdiZxmrjTdYxYCRpJVF44Eqc/t33vftoE7QkGYrF2l/VNCSMxjb3Oo3ua5nHWYz
         9fe3BbmdVhIr4G+YPfxBH5kyBJeZX1Zt95QUnCwyISB7FxpOySlN6PL1CttxcdvMUWVp
         BZ++GW8+Vc269i9MPAuXGcHyIesFUQjtIMH7i0tksW/t7cWKu7xBRclPiLpB/8NDPCJl
         /7VXaI2fynSy4JIu/dKxViRV5lHVXHG3eSnBB2X2qJX/08Pg9QqDhCB6eBznXr8fBuDO
         tGFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765844487; x=1766449287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cZXtOqYAUZJLtHBWZ87PqtbNhKR+rYOChqL2ZoAtDaE=;
        b=sm/1I+enhY+vzWyvuj74zd/BTibIuY0QMZ+CeFFWYGU+lsy7VFTPbwac+mZwYH0dOu
         gwtA/OwVM2tEeP6ejr3wzhNVFouAYNdDbAV279RBvZieMGird+YHFUkegghq2ht4pVy/
         t3pxldNmSCs0gKIc+PvYfnCtuMqbSHgSGaZlWFHs9yxPJQ5qxMj4f0tSPolWqkBBsUCH
         8+sg+UkSwR0tOTHZJh2z/6Vjt25bsVL+kTSwL/FtZfH1jbv1vOjE6KLuXZevmKDeXIZe
         gXrESUFO4N0FOnA8qxD/BgPNpino+aHH/v9Qlk5GRdb3z9gN1kyZZB+G0nV+5qYTcaLN
         sukw==
X-Gm-Message-State: AOJu0Yy7iUs6TYPLj9b9lG9rZ8UJ1KyflR9mau9FqoSqz6X4S1nAPG0S
	a0qB6ZACm5Ry9mmmSIlpUUwxkqjRaHBE3GsIvONiQ5QLQ0wJ9oDTL3imYB8M8/pcJ6k4erK8J9U
	3ECQYTVaNLq/q369isC7+gxzffgbXA1DD/w==
X-Gm-Gg: AY/fxX5j432z8rEA1yBwEIHyAVZHgALTUvt520gwRwV5bHsi8fBc+ZEK0oMplzWsXkS
	f0N/9S4rSHQOXe2GhMR9/309tgrrtzeI0DHSfgFoIfYwc3EH1h00Q5/OZsmhrfXAe/WcYINH3zX
	wNJsXoVeQIKSlD7xSNc5upWNcEKeGN24izXY8zUx5R/zW7W35ewknNqK+mbJZOexEJe6eheFhnV
	QwvcG6QSKOjGH90yzEzn+8rbRcPOsEFRDF5rb9ftb7bhsW/VWTU+jg0AZaTivkyxdp5GapcNeIt
	QYxOyWTW0p4i/qWh6t8I2kOSShVA
X-Google-Smtp-Source: AGHT+IFXF3OQzziUd0mCPXMJIzBL6dsObjFufoBGZ3WINCeqNN/0WFWXAoaKmqiCQFGxc9Oo263LZ5H+M/MycNEObNw=
X-Received: by 2002:a05:6820:80ca:b0:65b:2935:f934 with SMTP id
 006d021491bc7-65b4523d179mr5653692eaf.49.1765844487371; Mon, 15 Dec 2025
 16:21:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
 <9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <9a81644a0ec670261a85c155fa32e5a1f4576ef4.1765793254.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 15 Dec 2025 16:21:16 -0800
X-Gm-Features: AQt7F2ptnXkJ6FBY6dq1HakeGh2bObLmXa2aqKSaEKhD3-TRriFg91gCVra76Cg
Message-ID: <CABPp-BEDB5y7WnHj_omETTbp+Eim+k8u12cv_9zEj1gB4Dw=jA@mail.gmail.com>
Subject: Re: [PATCH v2] replay: drop commits that become empty
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 15, 2025 at 2:07=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the changes in a commit being replayed are already in the branch
> that the commits are being replayed onto then "git replay" creates an
> empty commit. This is confusing because the commit message no longer
> matches the contents of the commit. Drop the commit instead. Commits
> that start off empty are not dropped. This matches the behavior of
> "git rebase --reapply-cherry-pick --empty=3Ddrop" and "git cherry-pick
> --empty-drop".
>
> If a branch points to a commit that is dropped it will be updated to
> point to the last commit that was not dropped. This can been seen
> in the new test where "topic1" is updated to point to the rebased
> "C" as "F" is dropped because it is already upstream. While this is
> a breaking change "git replay" is marked as experimental to allow
> improvements like this that change the behavior.
>
> Helped-by: Elijah Newren <newren@gmail.com>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Changes since v1:
>
>  - modified test to update refs as suggested by Elijah. I've kept
>    --ancestry-path --branches rather than switching to --contained as
>    I think it is useful to have test coverage for those options and it
>    means we can check that empty commits are dropped with out replying
>    on --contained working.

Fair enough.

> This patch is based on ps/history
>
> I think dropping commits that become empty is the sensible default,
> if it turns out that some users are relying on the current behavior
> we can add an option to retain the empty commits.
>
> Base-Commit: d37c42ea661434c347d2047f01b338341099fa60
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay=
-drop-commits-that-become-empty%2Fv2
> View-Changes-At: https://github.com/phillipwood/git/compare/d37c42ea6...9=
a81644a0
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-drop=
-commits-that-become-empty/v2
>
>  Documentation/git-replay.adoc |  4 +++-
>  replay.c                      | 10 +++++++---
>  t/t3650-replay-basics.sh      | 21 +++++++++++++++++++++
>  3 files changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.ado=
c
> index dcb26e8a8e8..96a3a557bf3 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -59,7 +59,9 @@ The default mode can be configured via the `replay.refA=
ction` configuration vari
>         be passed, but in `--advance <branch>` mode, they should have
>         a single tip, so that it's clear where <branch> should point
>         to. See "Specifying Ranges" in linkgit:git-rev-parse[1] and the
> -       "Commit Limiting" options below.
> +       "Commit Limiting" options below. Any commits in the range whose
> +       changes are already present in the branch the commits are being
> +       replayed onto will be dropped.
>
>  include::rev-list-options.adoc[]
>
> diff --git a/replay.c b/replay.c
> index 13983dbc566..2864c213993 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -88,12 +88,12 @@ struct commit *replay_pick_regular_commit(struct repo=
sitory *repo,
>                                           struct merge_result *result)
>  {
>         struct commit *base, *replayed_base;
> -       struct tree *pickme_tree, *base_tree;
> +       struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>
>         base =3D pickme->parents->item;
>         replayed_base =3D mapped_commit(replayed_commits, base, onto);
>
> -       result->tree =3D repo_get_commit_tree(repo, replayed_base);
> +       replayed_base_tree =3D repo_get_commit_tree(repo, replayed_base);
>         pickme_tree =3D repo_get_commit_tree(repo, pickme);
>         base_tree =3D repo_get_commit_tree(repo, base);
>
> @@ -103,13 +103,17 @@ struct commit *replay_pick_regular_commit(struct re=
pository *repo,
>
>         merge_incore_nonrecursive(merge_opt,
>                                   base_tree,
> -                                 result->tree,
> +                                 replayed_base_tree,
>                                   pickme_tree,
>                                   result);
>
>         free((char*)merge_opt->ancestor);
>         merge_opt->ancestor =3D NULL;
>         if (!result->clean)
>                 return NULL;
> +       /* Drop commits that become empty */
> +       if (oideq(&replayed_base_tree->object.oid, &result->tree->object.=
oid) &&
> +           !oideq(&pickme_tree->object.oid, &base_tree->object.oid))
> +               return replayed_base;
>         return replay_create_commit(repo, result->tree, pickme, replayed_=
base);
>  }
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index cf3aacf3551..9d4b0dd1a77 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -25,6 +25,8 @@ test_expect_success 'setup' '
>         git switch -c topic3 &&
>         test_commit G &&
>         test_commit H &&
> +       git switch -c empty &&
> +       git commit --allow-empty --only -m empty &&
>         git switch -c topic4 main &&
>         test_commit I &&
>         test_commit J &&
> @@ -106,6 +108,25 @@ test_expect_success 'using replay on bare repo to pe=
rform basic cherry-pick' '
>         test_cmp expect result-bare
>  '
>
> +test_expect_success 'commits that become empty are dropped' '
> +       # Save original branches
> +       git for-each-ref --format=3D"update %(refname) %(objectname)" \
> +               refs/heads/ >original-branches &&
> +       test_when_finished "git update-ref --stdin <original-branches &&
> +               rm original-branches" &&
> +       # Cherry-pick tip of topic1 ("F"), from the middle of A..empty, t=
o main
> +       git replay --advance main topic1^! &&
> +
> +       # Replay all of A..empty onto main (which includes topic1 & thus =
F
> +       # in the middle)
> +       git replay --onto main --branches --ancestry-path=3Dempty ^A \
> +               >result &&
> +       git log --format=3D"%s%d" L..empty >actual &&
> +       test_write_lines >expect \
> +               "empty (empty)" "H (topic3)" G "C (topic1)" "F (main)" "M=
 (tag: M)" &&
> +       test_cmp expect actual
> +'
> +
>  test_expect_success 'replay on bare repo fails with both --advance and -=
-onto' '
>         test_must_fail git -C bare replay --advance main --onto main topi=
c1..topic2 >result-bare
>  '

I like the minor edits Junio suggested, but otherwise this version
looks good to me.  Thanks!
