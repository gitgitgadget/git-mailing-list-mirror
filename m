Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73D3EE1F8
	for <git@vger.kernel.org>; Wed, 23 Sep 2026 17:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185708; cv=pass; b=phzhH+WH8WFE1UHm6kEXJjhJNyZE3VrLpCmF5M5NWfjiFFJU9KLVmQcYaBjMGNgVlkkKLHFrpk5BQy9HFuM+t/627kRvc+lcCTfzihUYUY5SoERbtPh3W7waZDNZ1FGdLTTRbAZ7JHQrowWTzaVY5aLxTddGEq8l+68wIEHA2ag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185708; c=relaxed/simple;
	bh=ONM0jym6zr1WhE7Fmkz4x2C5CQO6D1fkaNfXehydIyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CO1VHfaZKuROJN7O5K06TpZhYpXs4/djQeFORE2ANDPbFQUiLFl/FkL3B9vsMnl9jZfJzj+6MFjGO4ag8m+ElkmozxvAC/WkP1dysvAFDCPeMw9f6qlK+6vd5NFqG4KITft6xQC4/9gjh4Fiz2totiMm0w81v716vkX8WN8Q5M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0vtLv+W; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0vtLv+W"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccde2b71so875011fac.0
        for <git@vger.kernel.org>; Wed, 23 Sep 2026 10:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790185706; cv=none;
        d=google.com; s=arc-20260327;
        b=fl5wZ4GhfhIoRCwZ4fwRMCqnqejOgdPKqFZI8Qtb3WGL7jeUupiKRJdgQ4JkKD0PWq
         TqjTcsoG92BVYIwhD5ybF0QThfNPXApsHuavcjW5MnDdksV/xbDc3nhmmk/dNtmTBk73
         NyOrO63LVXwYjxjoNxzD4x+N45H52K3WUx4yFSf/DxOEPnR7s5VNDtUDb/gdWVcBLdpg
         EpvcVq8TCD7vC0sdcaHES8MC/iM4SdpV0ZaL38RRf/hAhz3mS0Jf45FT0RJBA7GHcF4/
         0Wf8aTqmhxfzsyHCCoSBY1nE2z1y/oBeU8HvVfQhDzzi2OJfpjUdJ62ogjbBsAw5W87C
         OvzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oNzSn2zQjz825agFp6I9EFgDb8HCgJGRxH9UlA3Xw8E=;
        fh=4ryOG4wBbIqKixWzeKd5dc717SQGdNJth+KYU2DAukY=;
        b=QhAa7y4t7FMoALRtGW8CmptrfDkOStw+BjJCCe5mVc80wCypcJnL0yaIGRxYbP/KMt
         SKUfDMAhov7RSTmxjd1DWI9Ly8cSaJeFKmczSz3XoxSGJrhjTFZrRO+ZDkD4vFESOOEw
         RATS57FaFp6U74NFaAMDzn0nJvY6sf4ap4vO8CkBQNR6gaGhOetR9qtpRY6n5gyMg7i+
         jEYjyXxBHa2k/sTlJxYmW6nrxXDcu2SHoLKwN7uzNN6uJGMgUld866NNVFp4J+y7nNLK
         7bHux/7jFFt4bW9xeQJdyYNiMdmSADpBEqO1t5RfWDKDMosjc7oB8EdKL0NP6IAHCoR2
         sNVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790185706; x=1790790506; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oNzSn2zQjz825agFp6I9EFgDb8HCgJGRxH9UlA3Xw8E=;
        b=m0vtLv+W+gNAAvFS7GJ3u4i6HJcgXa5MqacUypFG1Bd6X9yrnYqwvMtKxaGxL8m7Ga
         rBauW6Ysg09n8hVUxE3y75TXaWoaUCnBwD4sFvP9rOiFUcwqUh6Ac2HjUG4NMUyMkm3I
         kimdosbD0WG7IN/+6B4Itajbu3n8DMAp/mcEGmcFhjicxk3h5Nu6DzkdHC+5G7DLG6aX
         KxnrOhvjfwkp0SHeXr5kbgcS4AN8tk6umDRWG9hF/Qz12PZSoUmf3wKrjNZN5uEtk9rB
         wtpIf16PZ1yGP7pmQt6vlgQmsI12rMccBGc3Cz0o08cT6sYJ0aTNnzT/fucYDqUaqQiO
         dDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185706; x=1790790506;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNzSn2zQjz825agFp6I9EFgDb8HCgJGRxH9UlA3Xw8E=;
        b=YpR2cFP5eyfF2i48oAu5JjNDZK1b8G4QvQSn3UeazGumNEkkMwr98TefS/v7yUFXuO
         fTZr/pvOrzZEXy022oG67TDvV2fQXBIOgnM61TNOYh5Ki/yJTWNKEtuIoPt+nJTRFPsQ
         dXxMraH5WEATHSwxUpIzH6zgDEeE+SSJGYQJZaYHwwHTnArbI/e5mABU4gMayxnCbswX
         62pBODTs/emTd2XbcfXtBZwwSX7Fu9NgnByk06Bgu20FcWoAlHH1LPirhNWq9xCCd+hF
         jMuDL9mqNImWl4JH80gkuCA41yLjL02xHk2UFzfUmyiIEK/HUakw3pYXJwH2I56K1AD9
         QNJA==
X-Gm-Message-State: AFuF++ngkH++70WsF24NjnCtDxwhJj5xIwMISEFHweaSNHIjon8+tSpN
	ckTz9Fl5uRDqeHJw/u6TMVbm5tXB6C2WqfWdTI4yPOZQnDknLKvjVCSsOIhDWOBDVZ67eJ0/Tq+
	UXWrrfBLHY3fW1cRQfFNbs3mq+hQp//weeUKO
X-Gm-Gg: AYBFou2gQvk35/p3057Lbj1AITeNvaKrg6rvPd0UaO5rSGDEZ+Dh3eVD8X9G3PVkKcd
	HlWNbsRmXeX3oIw5D4b2N7nCiSmjx8fEex4TyUoTtJza3lqJfdAho4WNxPAiwSzNmPJejgWBFQ6
	XxAbzd2xUiJyyZsfxm8BKwA0Nu1RvrWjwuXlaIU+05kIrFlbLi3blF9Hr6c6scHKEz2yIa8pr+d
	92SQeaO3tNF5MhQrBcG4fE5spxTAO6DPo/YGI+g00qRmyJqrocDfHph8MRJ4Td4p2CbrnYwx4fJ
	qY0i0Q0NbrvGr1+PwCV7ANg8+V1g81wJ0GiIXp3w1+oPkYPXH8GC1d1ErBr/rCc2KFkw2iz9H0s
	5cYp+WtC0Ld1zxjLdCQP0T+hMrMzEtMlVkXIdTU1O9pI2UmrWpBJuW6/K00ViEtm/SKNPS7Yr
X-Received: by 2002:a05:6820:f031:b0:6cd:3fdc:5ff8 with SMTP id
 006d021491bc7-6d2d2920118mr2951007eaf.73.1790185705853; Wed, 23 Sep 2026
 10:48:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
In-Reply-To: <20260923-pks-rebase-conflict-bug-v1-1-3d3ccf5022bc@pks.im>
From: Elijah Newren <newren@gmail.com>
Date: Wed, 23 Sep 2026 10:48:14 -0700
X-Gm-Features: AclHuK9R1PFnYhS2D0yzbPTBhZIaFLjAZ6dpl7IMZwKjpaMJcQwTxUd2Tf5Ikjc
Message-ID: <CABPp-BFadjqtOB_9cYkrs9UBgTp0hQxu4oiV_yqzYOuiu6g45w@mail.gmail.com>
Subject: Re: [PATCH REGRESSION] builtin/rebase: allow user to amend committed
 conflicts again
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Wed, Sep 23, 2026 at 6:16=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
>
> In 6257588252 (commit: refuse to amend during conflict resolution,
> 2026-09-01), we have introduced logic to git-commit(1) that makes it
> refuse creating a commit in some cases. This was done to remove a set of
> common foot guns.
>
> One of these foot guns is when the user is performing an interactive
> rebase that stops at a conflict. Most of the time when we stop at a
> specific commit we want the user to amend the HEAD commit, so they have
> been trained to use `git commit --amend`. But when there's a conflict,
> they are instead supposed to commit it directly without amending the
> HEAD commit. So to remove that common pit fall, git-commit(1) now
> refuses amending in that situation.

Are they supposed to commit it directly?  The conflict advice tells
them to stage the resolution and run "git rebase --continue".  In
fact, there appear to be a number of problems with using a plain "git
commit"; more on that below.

> The logic that detects this scenario checks whether the file
> "rebase-merge/stopped-sha" exists, while "rebase-merge/amend" doesn't.
> And this is exactly the case when git-rebase(1) has stopped at such a
> conflicting commit.
>
> But there's one problem here: this state persists even after the user
> has already committed the resolved conflict, and consequently they still

After reading ahead, should this be "...has already committed the
resolved conflict via a plain 'git commit'"?  Resolving it via "git
rebase --continue" doesn't have this problem.

> cannot amend after they have done so. This is overly restrictive though,
> as it's quite likely that a user may want to change the resolved commit
> once again.

Oof.  Thanks for finding and reporting this.

> Ideally, we'd be able to easily check whether HEAD has already been
> updated to have the resolved conflict. But it seems like we do not have
> sufficient information to determine the original state of HEAD when the
> interactive rebase has stopped, so this is not a workable solution.
>
> Instead, use the existence of "MERGE_MSG" to figure out whether the user
> has already resolved and committed the conflict. It feels somewhat fishy
> to base our decisions on the existence of that particular file, as it
> really is only a proxy for what we are actually after. But the whole way
> that we track rebase state is somewhat iffy in the first place.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> Hi,
>
> this is a regression caused by 6257588252 (commit: refuse to amend
> during conflict resolution, 2026-09-01). Ideally, we should probably fix
> it before we release Git 2.56.
>
> I'm not particularly happy with the proposed fix -- it feels quite fishy
> to use the existence of MERGE_MSG as a proxy for whether or not the user
> has already committed the resolved conflict. I couldn't come up with a
> better proxy though, so if you have one please let me know.

Yeah, I'm also a bit worried about using MERGE_MSG here.  In particular,

    git reset

removes MERGE_MSG without moving HEAD.  With this patch, a subsequent

    git commit --amend -a

is therefore allowed while the conflict resolution is still
uncommitted, bringing back the foot-gun that 6257588252 was trying to
prevent.

For the short-term 2.56, we could either revert that series (it's a
long-standing bug after all) and try again after the release.
Alternatively, we could record HEAD when the sequencer stops, perhaps
in rebase-merge/stopped-head, and then reject the amend while HEAD
still equals stopped-head and allow it once a plain commit has
advanced HEAD.  stopped-sha would remain until rebase --continue,
since it is needed for the rewritten-commit mapping and fixup/squash
bookkeeping.

Longer term, I wonder whether plain "git commit" should be rejected
while resolving conflicts for rebase, am, cherry-pick, and revert,
with users directed to the corresponding "--continue" command.  Plain
commit has a surprising collection of behaviors:

  * During am or an apply-backend rebase, it ignores final-commit and
author-script, losing the original message, author, and author date.
The corresponding --continue will report "No changes - did you forget
to use 'git add'?" even though the user already added and committed
the resolution.  Amid the generic recovery advice, the user must infer
that the corresponding "--skip" is now needed to bypass the patch that
their manual commit already handled.

  * During a merge-backend rebase, it reads MERGE_MSG, so the message
survives, but the original author and author date do not.

  * It may bypass sequencer options such as explicit signing and
date-handling options.

  * --abort behavior then varies by operation: rebase returns to the
original commit (orig-head), `am` leaves you at the manual commit, and
cherry-pick and revert refuse to rewind because HEAD moved.

Having the operation own both the commit and its state transition
seems much easier to reason about.  I would leave "git merge" as an
exception, given the very long-standing "resolve, add, commit"
workflow, but I think plain "git commit" should eventually be
disallowed as a way to resolve conflicts for other commands.

That's post-2.56 work.  For now I think either reverting (and trying
again after the release), or recording HEAD in stopped-head seems
preferable to relying on MERGE_MSG.

Thoughts?
