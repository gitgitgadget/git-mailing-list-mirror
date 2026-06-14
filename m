Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA919CCF5
	for <git@vger.kernel.org>; Sun, 14 Jun 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781420179; cv=pass; b=tgYCdmf2R+IwG2CBjYAW+FAjcCsMxvXKbloNYRzlzojXlebYQNp20+wkoXq1E1P+c5GlTnLY3CbXpSkFo9nJucKWV5DJy7/u4sGKL2E50z4zQk6Jt490ZeOQ7XWtMgdOHsC1YU16yY3b5hHX40MiZH9177CeCJn/U8jehz5HKyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781420179; c=relaxed/simple;
	bh=xT2KYBii5sKVb7xCCfjFzPmYU3LnLnmw/70V3GR1MU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nSmVd8oV3xNZo8gfqjidYhKfn2L/izhURXvG3Z8VgMZJxMglz4CKrVB/n2dOl4jA3tE+XyDfGM+lw/udSYIFWRh7JucB/0kEcOWObaTerb5VBk7Q/zp1dTMw0lf8uacKTkMCa4prQAQKMFe4bxeaJfLCii213r0hO8pP94Uelv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=styvrW0B; arc=pass smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="styvrW0B"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-48761fdc4baso68401b6e.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2026 23:56:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781420176; cv=none;
        d=google.com; s=arc-20240605;
        b=JbQSkoL3c5kGTboxSwQV6+7kDWP1MipIWVH7MvGWm1MNaW+wri3M+8olvnJ/TNj8mA
         e4RGhXLfiHo/JsFArg7EtBnQWeuiXQh0AnqvETeVFO12rTFXjcTIAcJErI5Ou1HX4t5G
         5hm+6CZ1PQjHOvN4Lun2RbOepLRv9TCzPu/sA1xiKdr/YwelM/FWEWwk/yimYQL8+Krv
         yUQuZt5d6QU+R4KDEmmV05nO3RQ8pLP6ghHe1xNY9oQWsqh71CqD5gqYMF1yKIOnvqyg
         0ZlBW9SNHJuf2nbwhm2g0BX9gQdkSo6PUABgqG6KKlsS8yCyf3UY7Bk2YRf3eNMbNUin
         72YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0EdXmL9J/QsEniuPy95/oZGy+to7pCg+xHHIBlieY2s=;
        fh=YsDP8qhdejPnmdlVXvdly/uN84AbM1az0llqI3pfvq0=;
        b=BVj2/WiZfko4rlOOZYo1CLl/2dLGGTVjBdpCiCtaNmf9b5Edn1ahc8z4KnxLJD/2Ch
         FExJ/AGxsIoy3akyCwZYEVNkrQx1J3nuMhR64SIy366qr3NWyNo3yVMbnED39R0aMxVI
         6cpwKlrsGgkPzrig4U0Shd58LY8rR3NjWKZ/XnHN0+NxbKyhBgeycGuNG9wrnI4bT7PN
         AKtJqekTIEI1dm/0U3/VSfQw4EKUhCqI7qTqHVX/kmbFGYvpBgCQ4yTPbiwzECH10xC6
         6gFGB7p0oP6dtrQLPbdjXItxLzEJOiSCZ5UvqRH1m7hyHBUq/h9xM3HSA3+fcniWyRIX
         4HOw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781420176; x=1782024976; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0EdXmL9J/QsEniuPy95/oZGy+to7pCg+xHHIBlieY2s=;
        b=styvrW0BqzXK4ZMB9vOS23qxx1VPfU+vOd/1euDqIA1+lzqvenBDX91ZCBIn3LQCBY
         Z7QIeL5okhDABKZrp6KKG/JZStjnBPl6hXrwFzO6ercA01uZsvgAgWGYYweGd1uwr3tB
         lx5JIYsgJ0WAO3RhekD5SkgAFXSo2EF375B4tNe6ZyIzrbBIoGDWef4Pz6A4nN9BaYKE
         w1eZ3T6W9z8Cm9gLPwwGaTDcOkyc80wf0XNpOxaPtOGN8tNYZPVclEzslsuYzyWdf+1h
         dMaQqnrN8LpdnFoatz+YJtCov4lBuS5pOcsRWH1ibziz9yX91VnL2SvT0e0z5n10TStg
         WOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781420176; x=1782024976;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0EdXmL9J/QsEniuPy95/oZGy+to7pCg+xHHIBlieY2s=;
        b=B5641n6+r+19eImjF098v6RGhGyR9+zZa839BYmesvM6CKjXvNfBWUtpJ4wog7SAjN
         0dAZKMLJd0d0SlhPBQLzAgyTe3zHKLCqOgy4McIBcaQSwdokj0pETG5GWC00+ATk82mw
         pCgFy3XlJuYpGejVXLh2yI+yOLcjPqUomS+CuOVLSlxmP1E/Ne9zfm2AzO1CSr0unrOx
         9xHx/AoPBlFUBAUP0DTbJUcthPUQ5/3FB5C/g7SDy6DbHtmpRVmKrOzSGjclhgKzaolw
         GCg6Cux3a9q7nFXGRJT7WSOtCHDgEvdq3wnTwm11ehtcQ6Veku4CkcoJZinfS03U/cTs
         Gntg==
X-Gm-Message-State: AOJu0YwphBt87X+K7GcY/PGKkksVuO6ulxXBAtnYCfBOHcBXbmvdbVMp
	F4zpSIUZOZ4yFHm/8at5j9KmZ+iWdoEkB0CnmokIo+kiR2g2gHJnduCIll0qePi9GZMjJE0W8XR
	7GMF0IAJqXlUSfKroz2todcR0Xw0mUWzvTq7m
X-Gm-Gg: Acq92OG/C8tRwWCiFFd8SxeKL7CAjbtj/I5ttVmVmnXLyQoEL/1sd9ynvMKnUdbakb/
	xp+IFQjneGE1XZmEeu8c5cCmktNsUQ17qZ/xqqOFmPOI50K0136BPAk2P1cfckAneWdrvvgq3am
	5XDqNGNss4m0r2UniIgHfuzpG7pJBYnQ5STKJVUdGubOnoI0LtAWyzuJrvjNw2IXUjlhroGagJK
	caILUrT+R1SgiMTXMNnOK/EJexmR0PxKnEmff9QFcr4SnDYb/kKUxCywfgQOcmjVk9B643g5/Yf
	PPBoscHSgRkt535kCLAvoPuu7Lp00BExYlifK3DM3NPQQomZw2S+MEGWE14zDP3hlBDl+K6wSjb
	KzG88IKzK35sdLKDB3urd4KTs4g8EkQXobgbM
X-Received: by 2002:a05:6808:1187:b0:486:4ae9:f9a5 with SMTP id
 5614622812f47-48741b883cbmr3994719b6e.38.1781420175568; Sat, 13 Jun 2026
 23:56:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com> <20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
In-Reply-To: <20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 13 Jun 2026 23:56:04 -0700
X-Gm-Features: AVVi8Cd1k6peBHfszavlgdjDbXmzZ8gvduRlbeg3axQWs-IrNTSHb-mBUuxnasc
Message-ID: <CABPp-BGRi2obnqRGEY9pSMyvRbNGs8AdVUpZmr0C6vZSgHb=cg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] replay: offer an option to linearize the commit topology
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jun 10, 2026 at 7:51=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>
> From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>
> One of the stated goals of git-replay(1) is to allow implementing the
> git-rebase(1) functionality on the server side.
>
> The default mode of git-rebase(1) is to act as if `--no-rebase-merges`
> was given. This mode drops merge commits instead of replaying them, and
> linearizes the commit history into a sequence of the
> regular (single-parent) commits.
>
> Add option `--linearize` to git-replay(1) to do the same.

I think this version is nicer overall than the one from my
replay-upstream branch; sorry for repeatedly getting distracted from
that, but this does look nice.

A few small comments:

> Co-authored-by: Toon Claes <toon@iotcl.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Toon Claes <toon@iotcl.com>
> ---
>  Documentation/git-replay.adoc |  5 +++++
>  builtin/replay.c              |  4 ++++
>  replay.c                      | 30 +++++++++++++++++++++++-------
>  replay.h                      |  5 +++++
>  t/t3650-replay-basics.sh      | 26 ++++++++++++++++++++++++++
>  5 files changed, 63 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.ado=
c
> index a32f72aead..41c96c7061 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -88,6 +88,11 @@ incompatible with `--contained` (which is a modifier f=
or `--onto` only).
>  +
>  The default mode can be configured via the `replay.refAction` configurat=
ion variable.
>
> +--linearize::
> +       In this mode, `git replay` imitates `git rebase --no-rebase-merge=
s`,
> +       i.e. it cherry-picks only non-merge commits, each one on top of t=
he
> +       previous one.

The SYNOPSIS block at the top of the file is missing this new flag.

The replay_usage[] variable in cmd_replay is also missing this new flag.

>  <revision-range>::
>         Range of commits to replay; see "Specifying Ranges" in
>         linkgit:git-rev-parse[1]. In `--advance=3D<branch>` or
> diff --git a/builtin/replay.c b/builtin/replay.c
> index 39e3a86f6c..fedfe46dc6 100644
> --- a/builtin/replay.c
> +++ b/builtin/replay.c
> @@ -111,6 +111,8 @@ int cmd_replay(int argc,
>                              N_("mode"),
>                              N_("control ref update behavior (update|prin=
t)"),
>                              PARSE_OPT_NONEG),
> +               OPT_BOOL(0, "linearize", &opts.linearize,
> +                        N_("ignore merge commits instead of replaying th=
em")),

"ignore" feels a bit ambiguous to me.  Can we use "drop" instead,
matching your commit message?

>                 OPT_END()
>         };
>
> @@ -132,6 +134,8 @@ int cmd_replay(int argc,
>                                   opts.contained, "--contained");
>         die_for_incompatible_opt2(!!opts.ref, "--ref",
>                                   !!opts.contained, "--contained");
> +       die_for_incompatible_opt2(!!opts.revert, "--revert",
> +                                 opts.linearize, "--linearize");

Sensible; should the docs mention this incompatibility?  (I'm not sure
myself; just throwing it out as food for thought.)

>
>         /* Parse ref action mode from command line or config */
>         ref_mode =3D get_ref_action_mode(repo, ref_action);
> diff --git a/replay.c b/replay.c
> index 7921d7dba3..81033fb889 100644
> --- a/replay.c
> +++ b/replay.c
> @@ -277,12 +277,16 @@ static struct commit *pick_regular_commit(struct re=
pository *repo,
>                                           struct commit *onto,
>                                           struct merge_options *merge_opt=
,
>                                           struct merge_result *result,
> +                                         struct commit *replayed_base,
>                                           bool reverse,
>                                           enum replay_empty_commit_action=
 empty)
>  {
> -       struct commit *base, *replayed_base;
> +       struct commit *base;
>         struct tree *pickme_tree, *base_tree, *replayed_base_tree;
>
> +       if (replayed_base && reverse)
> +               BUG("Linearizing commits is not supported when replaying =
in reverse");
> +

This is dead code given the die_for_incompatible_opt2 check above,
right?  Just extra defense in depth?

>         if (pickme->parents) {
>                 base =3D pickme->parents->item;
>                 base_tree =3D repo_get_commit_tree(repo, base);
> @@ -291,7 +295,8 @@ static struct commit *pick_regular_commit(struct repo=
sitory *repo,
>                 base_tree =3D lookup_tree(repo, repo->hash_algo->empty_tr=
ee);
>         }
>
> -       replayed_base =3D get_mapped_commit(replayed_commits, base, onto)=
;
> +       if (!replayed_base)
> +               replayed_base =3D get_mapped_commit(replayed_commits, bas=
e, onto);
>         replayed_base_tree =3D repo_get_commit_tree(repo, replayed_base);
>         pickme_tree =3D repo_get_commit_tree(repo, pickme);
>
> @@ -430,12 +435,23 @@ int replay_revisions(struct rev_info *revs,
>         while ((commit =3D get_revision(revs))) {
>                 const struct name_decoration *decoration;
>
> -               if (commit->parents && commit->parents->next)
> -                       die(_("replaying merge commits is not supported y=
et!"));
> +               if (commit->parents && commit->parents->next) {
> +                       if (!opts->linearize)
> +                               die(_("replaying merge commits is not sup=
ported yet!"));
> +                       /*
> +                        * When linearizing, a merge commit itself is not=
 picked,
> +                        * but refs that point to it might need updating.
> +                        */

Is it worth pointing out that last_commit is intentionally not updated
by this code path?  That is implied by your comment, but it takes a
bit of reasoning to get there, and I think it might help future
readers to just explicitly state it.

> +               } else {
> +                       struct commit *to_pick =3D reverse ? last_commit =
: onto;
> +                       last_commit =3D
> +                               pick_regular_commit(revs->repo, commit,
> +                                                   replayed_commits, to_=
pick,
> +                                                   &merge_opt, &result,
> +                                                   opts->linearize ? las=
t_commit : NULL,
> +                                                   reverse, opts->empty)=
;
> +               }
>
> -               last_commit =3D pick_regular_commit(revs->repo, commit, r=
eplayed_commits,
> -                                                 reverse ? last_commit :=
 onto,
> -                                                 &merge_opt, &result, re=
verse, opts->empty);
>                 if (!last_commit)
>                         break;
>
> diff --git a/replay.h b/replay.h
> index 1851a07705..07e6fdcca3 100644
> --- a/replay.h
> +++ b/replay.h
> @@ -62,6 +62,11 @@ struct replay_revisions_options {
>          * Defaults to REPLAY_EMPTY_COMMIT_DROP.
>          */
>         enum replay_empty_commit_action empty;
> +
> +       /*
> +        * Whether to linearize the commits (i.e. drop merge commits).
> +        */
> +       int linearize;
>  };
>
>  /* This struct is used as an out-parameter by `replay_revisions()`. */
> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index 3353bc4a4d..64e0731188 100755
> --- a/t/t3650-replay-basics.sh
> +++ b/t/t3650-replay-basics.sh
> @@ -565,4 +565,30 @@ test_expect_success '--onto with --ref rejects multi=
ple revision ranges' '
>         test_grep "cannot be used with multiple revision ranges" err
>  '
>
> +test_expect_success 'replay merge commit fails' '
> +       echo "fatal: replaying merge commits is not supported yet!" >expe=
ct &&
> +       test_must_fail git replay --ref-action=3Dprint --onto main I..P 2=
>actual &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'replay to rebase merge commit with --linearize' '
> +       git replay --ref-action=3Dprint --linearize --onto main I..topic-=
with-merge >result &&
> +
> +       test_line_count =3D 1 result &&
> +
> +       git log --format=3D%s $(cut -f 3 -d " " result) >actual &&
> +       test_write_lines O N J M L B A >expect &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'replay to rebase merge commit with --linearize down=
 to root commit' '
> +       git replay --ref-action=3Dprint --linearize --onto main A..topic-=
with-merge >result &&

You'd need to drop "A.." to have it go down to the root commit, as
Junio mentioned elsewhere.

> +
> +       test_line_count =3D 1 result &&
> +
> +       git log --format=3D%s $(cut -f 3 -d " " result) >actual &&
> +       test_write_lines O N J I M L B A >expect &&
> +       test_cmp expect actual
> +'
> +
>  test_done

Should there also be a testcase combining --linearize and --advance?

Should there be a test with the incompatibility of --revert &
--linearize?  I think we have a few other tests for incompatible
options.

One additional testing idea, borrowed from an older variant of
this patch I had sitting in a local branch (dscho's original
linearize patch, adapted): in addition to checking specific commit
subjects, it's worth verifying that the linearized chain produces
the *same patches* as the original.  Something along the lines of:

        test_expect_success '--linearize preserves patches' '
                test_when_finished "git update-ref -d refs/heads/merge_I_L"=
 &&
                test_tick &&
                git checkout -b merge_I_L I &&
                git merge --no-edit L &&

                git replay --linearize --onto A B..merge_I_L &&

                # range-diff ignores merges, so the original
                # {I, L, merge} reduces to {I, L} on the LHS,
                # and the replayed chain on the RHS should match.
                git range-diff B..merge_I_L@{1} B..merge_I_L >out &&
                ! test_grep -v "=3D" out &&

                git log --oneline A..merge_I_L >out &&
                test_line_count =3D 2 out
        '

The range-diff check is nice because it asserts patch equivalence
rather than tying the test to a particular replay ordering, which
makes the test less brittle if the rev-walk order ever changes.
Feel free to take, adapt, or ignore.

Anyway, thanks for working on this; looking good.

Elijah
