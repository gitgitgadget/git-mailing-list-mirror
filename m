Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDAB2D47E4
	for <git@vger.kernel.org>; Fri, 28 Nov 2025 08:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764317181; cv=none; b=Q3OdYgZAqYauPcRqQXBgEejRiTSUt4JRNR376a0VHl15rhHI8NzjpCX8p+TlxbCuPOcTSFVTaVL6NjBsTlCbDLB2VoPmyeLNWLZUpeQKB2XE0JJ4VKPGcTiTk8FTZp7SaEmr63zlOZKpK8Iva2hyrjprc1WJuIPz+rRF5KT0VB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764317181; c=relaxed/simple;
	bh=1UDaX8JYDBb2e97RRkHx8jqyyKfdNw/A9wjIdJw8/HU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H63PeDVCBWqy57qFnEg4pZ5YOrGCmizowsGM1jqFRwLPR6Mws7VHPTUmDgJUd8hchfCYKl+E5/nxOrqJFAj8kxO/kKGngJPS9oR1ljrFS6oKhk7qcNvuARN1EfuRcduIBcmPODViB5AsDJzb2wxdo5YTqxZ0M/UGAUCGjYoNxi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyMaAx68; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyMaAx68"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-94895f6b144so70816539f.0
        for <git@vger.kernel.org>; Fri, 28 Nov 2025 00:06:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764317178; x=1764921978; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UA/SgyyGoWuQGOFHwLiAbyLJgJtNNxvVOikgqgurO3Y=;
        b=NyMaAx686j0zzXxNhhOzRpV8UgXRQ9JbQl+7cPB5CRjElvBbGdXSCpgMjj62jnIhgr
         Y0FtkfXU7mcq0vPOkwMCmRzLcTOzOdhDmjWKrzCxHQJ2kzdrNcGkC2ohxWS7L7Td3ds0
         gjpQ+C89H0qu3ERCNPDRCnTZKz3slGY76XhQTu3RQBxmERnEzx70LlyKcNfKcDR06/kT
         LZLFKbWEjFeeYxVDJ+f0Z83Su80XNhD0y5LSAkB3fut8uN4zHBALMChXDTnOp3qW1/2L
         UA4uHFf6mJx4nXQl1Mkixt74J1xgZxgqjUDuFnOQPWhCEga0lIGbNTf1NYX1O/BIHXnM
         S/cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764317178; x=1764921978;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UA/SgyyGoWuQGOFHwLiAbyLJgJtNNxvVOikgqgurO3Y=;
        b=BuCStISE9z7+pjViDi/ceY0T2QeRBxPoRmizpWs7WnhM9j5FGd5j4Yu4xiXWht9cvK
         pr9DhkpNFU7tLN3zjUAv/cZ2K1l2JwzO9LqKkESd35Ujmv5ylYmYexxHtfPFLWFg7Qgm
         Zea8GjgCTG81G/D15DYxxLw6rIZGwv4fVxvP8tMm7Upqx6We/PqGG//XWUK6HErFdhsm
         6XNhtrqOoeP6oEWY/kG03O96roBc7tJOcIuQH5X7ejq+LLD3qc/kaOpulK9tS9dlEwB1
         3Z3QZXuRnA1e4J82zQOrgHv/uxUA7GA5yEPbp/VOLJAnWV+KhJNzRgmM9VXah3asGkme
         Bmqw==
X-Gm-Message-State: AOJu0YxIWiIgCRERK02nPToPKrnH3YqKnTPhKQIyavUCm+1/Rw3ZMtDy
	U0KXH1hgY5YrZQv3UIWWrPe2S123Xzt2xmzC80G3b7SSFeeCUtWbrNd1JyCAyfEdXBgVuhHk3qf
	DUbKLRk/Y2IKiFuuklJxsz7lfXRxLnTfCUQ==
X-Gm-Gg: ASbGncuN1ixTzCrPHELJsYD+lL9XRgYODw9gd/UA8TbrddG5I68YuTxFP9S7c/5MQLw
	7Lr/JRhH4OeYHDM2FhkcFMZgKPRipn4z079AF3lktzz4wbckJwVgnPn9y43YrYN6xXUZDtGDe6o
	M442Jgx0ecYWWXOuzZvZFGRe1jLlI1BYZq9UOtcqckhAugd1RAEdl0nBn/2rlRzaWffsJBnH/kJ
	xjnQr1NKZfID38N4wRRknLeauKb/fU5KtGb8Kk9MZBTLogFsVJQKdhKrUAZNIv7PaBC4o1j7YQ1
	zoANJJ0yvNMzhmCQwciRQMFfKcEx
X-Google-Smtp-Source: AGHT+IFlivvzkKzWixLNgXZQAeOAxCvWnVCUwogxm57Ux5Yzfd9IylawCgnUiQHndopYJulivR2lF3ubUWT+ejSfeyg=
X-Received: by 2002:a05:6638:a38e:b0:573:5038:cee6 with SMTP id
 8926c6da1cb9f-5b999747535mr7902511173.12.1764317178383; Fri, 28 Nov 2025
 00:06:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
In-Reply-To: <8a2a1215306452147cc7b803530ab2429bf57f15.1764260150.git.phillip.wood@dunelm.org.uk>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 28 Nov 2025 00:06:07 -0800
X-Gm-Features: AWmQ_bkDHhQWg3Ik-oTnHwFMoK4BKcYI8ieDT9lmwwQl12cIAuSwPsI589kAqp8
Message-ID: <CABPp-BEZFPmLnEtnD0WaNbkZ5uE7q5T6uKJQRUvtq+L=C1o9wg@mail.gmail.com>
Subject: Re: [PATCH] replay: drop commits that become empty
To: Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 27, 2025 at 8:16=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If the changes in a commit being replayed are already in the branch
> that the commits are being replayed onto then "git replay" creates an
> empty commit. This is confusing because the commit message no longer
> matches the contents of the commit. Drop the commit instead. Commits
> that start off empty are not dropped.

Yeah, I've got a commit in my local branch that does the same thing.

It feels like there should be a paragraph break in here somewhere, but
maybe that's just me?  Pretty minor either way.

> This matches the behavior of
> "git rebase --reapply-cherry-pick --empty=3Ddrop" and "git cherry-pick
> --empty-drop". If a branch points to a commit that is dropped it will
> be updated to point to the last commit that was not dropped. This can
> been seen in the new test where "topic1" is updated to point to the
> rebased "C" as "F" is dropped because it is already upstream. While
> this is a breaking change "git replay" is marked as experimental to
> allow improvements like this that change the behavior.

Yep.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
> Elijah - I'm not really clear why we were setting result->tree before
> calling merge_incore_nonrecursive(), was it just for convenience to
> avoid declaring a local variable or have I missed something?

I don't know the reason.  That traces back to a commit with
Christian's Co-authored-by, so it may have been either him or me that
introduced it.  My original work on replay was on a branch that I long
ago rebased on top of the version Christian submitted, and the old
history is no longer reachable from my local reflog, so I don't have a
way to narrow down who of us did it.  If it was him, he may be able to
answer.  If it was me, I've long since forgotten.  I think using a
temporary, as you've done, is better.

> This patch is based on ps/history
>
> I think dropping commits that become empty is the sensible default,
> if it turns out that some users are relying on the current behavior
> we can add an option to retain the empty commits.

I fully agree.

> Base-Commit: 4ac8283def34401e50908903b89fa22498bb23a2
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Freplay=
-drop-commits-that-become-empty%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/4ac8283de...8=
a2a12153
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/replay-drop=
-commits-that-become-empty/v1
>
>  Documentation/git-replay.adoc |  4 +++-
>  replay.c                      | 10 +++++++---
>  t/t3650-replay-basics.sh      | 25 +++++++++++++++++++++++++
>  3 files changed, 35 insertions(+), 4 deletions(-)
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
> index 58fdc20140b..7cd7206eee5 100644
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

Makes sense; your version is similar but slightly cleaner than my
local implementation of the same thing.  Plus you have a test, which I
hadn't added yet.

> diff --git a/t/t3650-replay-basics.sh b/t/t3650-replay-basics.sh
> index cf3aacf3551..d73ab16908a 100755
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
> @@ -106,6 +108,29 @@ test_expect_success 'using replay on bare repo to pe=
rform basic cherry-pick' '
>         test_cmp expect result-bare
>  '
>
> +test_expect_success 'commits that become empty are dropped' '

This test is a bit more complicated than normal, and might benefit
from a comment or two.

> +       git replay --ref-action=3Dprint --advance main topic1^! >result &=
&
> +       ONTO=3D$(cut -f 3 -d " " result) &&

You're basically cherry-picking one commit from the middle of A..empty
(namely the tip of topic1) onto main, without updating any refs...

> +       git replay --ref-action=3Dprint --onto $ONTO \
> +               --branches --ancestry-path=3Dempty ^A >result &&

...and here you replay the range A..empty onto what would have been
the new main, but since one of those commits were already
cherry-picked, you expect that one to be dropped.

Since "empty" has no descendant commits or branches, the flags
    --branches --ancestry-path=3Dempty ^A
feel like a more complicated way of saying
   --contained A..empty

> +       # Write the new value of refs/heads/empty to "new-empty" and
> +       # generate a sed script that annotates the output of
> +       # `git log --format=3D"%H %s"` with the updated branches
> +       SCRIPT=3D"$(sed -e "
> +               /empty/{
> +                       h
> +                       s|^.*empty \([^ ]*\) .*|\1|wnew-empty
> +                       g
> +               }
> +               s|^.*/\([^/ ]*\) \([^ ]*\).*|/^\2/s/\\\$/ (\1)/|
> +               \$s|\$|;s/^[^ ]* //|" result)" &&
> +       git log --format=3D"%H %s" --stdin <new-empty >actual.raw &&
> +       sed -e "$SCRIPT" actual.raw >actual &&
> +       test_write_lines >expect \
> +               "empty (empty)" "H (topic3)" G "C (topic1)" F M L B A &&
> +       test_cmp expect actual

After digging around for a while (my sed-fu is far weaker than yours),
this feels like you are going out of your way to avoid changing any
branches, but then trying to figure out what the branch changes would
have been.  Would it be simpler to remove the --ref-action=3Dprint
flags, check directly what changes were made, and use a
test_when_finished to reset the branches back to their starting point
at the end?  That'd change this test to something like:

test_expect_success 'commits that become empty are dropped' '
    # Save original branches
    git for-each-ref --format=3D"update %(refname) %(objectname)"
refs/heads/ >original-branches &&
    test_when_finished "git update-ref --stdin <original-branches &&
rm original-branches" &&

    # Cherry-pick tip of topic1 ("F"), from the middle of A..empty, to main
    git replay --advance main topic1^! &&

    # Replay all of A..empty onto main (which includes topic1 & thus F
in the middle)
    git replay --onto main --contained A..empty &&

    # Check that "F" was applied first, then "C", and that "F" wasn't
applied twice.  Also, that topic1 now points to "C".
    git log --format=3D"%s%d" L..empty >actual &&
    test_write_lines >expect \
        "empty (empty)" "H (topic3)" G "C (topic1)" F "M (main)" &&
    test_cmp expect actual
'
