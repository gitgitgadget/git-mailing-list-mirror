Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A1637CD5A
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 18:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249438; cv=none; b=Y+13WXiHHd6gQpTbIFVimR9SKPkvcPNMybThL2UuOlbW4zrL9DdkV22LuuyvbThXO1M6a4eerA3ddj14YK4CiN3Qk9lt0Bn37FnLCGTYZnRJFgJ+xt+fVh76TqDtEO3qCOGVq3A4N0/ARDtaXQnBKsKP9GacdMvjefkVZjLLXnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249438; c=relaxed/simple;
	bh=FTr+XlJPDBOhT/jKrjNVtouYTZSCaKK8fk4WOJ879Ik=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Ao9WwREiOdW6cKPX+Ndad0E/tJtSgz5ucsL2kp7rI/5801zzsmUHuqNCEgzWJTN3w9S6sSmyUUpvUG69QYVq7cn4Ff1Twd95G69rz56Cr5Gnwas39wGduN+lqnkvBmkGjB8pJNu5ow+FedCoawWCeHOs/CjxTk+HunnvzMNWQzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsDmBido; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsDmBido"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6b14b207e05so154799eaf.3
        for <git@vger.kernel.org>; Thu, 20 Aug 2026 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787249435; x=1787854235; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=d+XCLCd8kBsU1r9zXhGHuE55pUgQCYRoUevFXn/DV+g=;
        b=RsDmBidoyDw1OBmSTA7ZKVMXTC3VcmwZPyT6cFBQU/ATHjI/A+O7UR+PKlMZK4j0ZB
         S4XdPS7hLl7Z4L/+OwMWWLy4Gxt7YueV7qSE9wiBaVWI9OoecBMRg2gOyIFHZtpWfHDM
         g0AZeit6Biur+Aht4tLw2prN4acksbYUtmV1mff0IKAIXCnLxJQR/6SqRk4WtXFGNdR4
         WuSjzh8oMJt9JhrgqreMakDwF2LGzpoBxnQ8X2Xql3/RNYz88OsveHU7qT9l7yY9zB50
         9WNgsLaLMhmrrJqJVh39CHK1ZNBHGkuzK+5OZ6d/sSU+MF+FJwCMnJyhIAgqGXFAVQl/
         3/PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787249435; x=1787854235;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+XCLCd8kBsU1r9zXhGHuE55pUgQCYRoUevFXn/DV+g=;
        b=T7WmZ6F1FMbGB/wpJMQCBPhmIn3DvNqQ1lmA0qML5f/xBwCiDPULBQb/zPCk2z5hVd
         uS35CbUi/1/btKgTudf1TlsdIFxUFxEulC5n9co56dKe8YY/lMARStfywYBcha7vz67a
         LTLy0OErOo2x5Tr0zi+wUXLBYWpV3twErPl++kTvd8Bb/8TDbmBhUPQWJR0xKSaO4Ra8
         8VtrKRN1W5Wj79Kq9QYZOorRHzBK6jAwX+pUYxSXlKlCUfYOxMchCDxmdBK3KP8pIORA
         9lTCN7oYng/T0iTy2R3KTP51vta7ubOEQetSm99Gb7T/H94voR8uUgGgBmY/ex8tcw72
         fmRg==
X-Gm-Message-State: AOJu0YwVY9FNqv5RCBzIZ25kFvpRbussae92Gp7wvSN5J1MQ2shgj3BR
	JqiaryFB2kIww0XTk/WUn8I9AA+O8eiUVHMeGEID6JXSCoQeGtvJ16KtEogQtA==
X-Gm-Gg: AR+sD11VWldZlZnwbZFFP+cc57wZ8XCwdTY9KXfWKpADtvRmkbUtc8s/ToNS5Bhk51A
	ugV3+TY/8V2ClgJ/4OKKKViLzwJX8QTAoUisA620RIo3kIL8dq5najljnnvsA0XK8tXQBBof1DI
	RXBdx4Lb18ECGvQMv6EdQbZeEgseuW5TomXDbmVfrwznFTwq/r1L0PRVUPCZ8vY8uwceMRXVTAg
	5GqBNqYxO/Vyre0WeEI60Vdx4o7+hc1ksVNfSd2ixxIMEl92/hQ4twLoeTYNaDCU3t7EwyGuPf0
	kGICRnGIR37Jww4PJXnb2Wr9N2bAebb83i55WJh51wdiaazvDvCHEelTFwsZ8eCb1p6QaVRtcJ2
	3FwfFBzhvcmucHr+mXyVKtnWlj+yzu8tE3MrdyY6xM+QMiH7g/3/kfp5/tgXp3C4U/pW9Z6uiAu
	8u3S5hwTvU6aVT8vMnTA5TgJI3/IeRxcIhjwgyT0BtL+RPc9nj5A1AkgNR2Eh1ybob
X-Received: by 2002:a05:6820:1ca1:b0:6a1:4507:3544 with SMTP id 006d021491bc7-6b1593ee73dmr537696eaf.28.1787249434678;
        Thu, 20 Aug 2026 11:10:34 -0700 (PDT)
Received: from [127.0.0.1] ([52.230.251.200])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4632a6ca866sm2256607fac.6.2026.08.20.11.10.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 11:10:33 -0700 (PDT)
Message-Id: <pull.2337.v14.git.git.1787249432.gitgitgadget@gmail.com>
In-Reply-To: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
References: <pull.2337.git.git.1781465141.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Aug 2026 18:10:24 +0000
Subject: [PATCH v14 0/8] history: add squash subcommand to fold a range
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Matt Hunter <m@lfurio.us>,
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Tuomas Ahola <taahol@utu.fi>,
    Harald Nordgren <haraldnordgren@gmail.com>

Adds git history squash <revision-range> to fold a range of commits.

Changes in v14:

 * Update commit message trailers.
 * Simplify rev-parse and tr complexity in the tests.

Changes in v13:

 * Split the squash implementation into five patches covering parsing, range
   validation, branch protection, commit creation, and message editing.
 * Print the sorted names of local branches that prevent a squash, with
   clearer advice for --update-refs=head.
 * Isolate --no-edit behavior from the final patch that enables default
   editor-based message combining.

Changes in v12:

 * Incorporated fixups from Phillip:
   * Reworks range validation into a single walk that rejects roots and
     multiple tips while preserving every parent when squashing into a
     merge.
   * Resolves fixup!, squash! and amend! targets directly, preserving
     message intent and safely consolidating related markers.
   * Builds the editor template from the exact selected revisions, including
     exclusions, while retaining --no-edit behavior.
   * Protects descendant local branches while leaving tags and
     remote-tracking refs unchanged.

Changes in v11:

 * Make message editing the default with the autosquash-style template, add
   --no-edit instead of squash-specific --reedit-message.
 * Validate one actual boundary and tip, rejecting root-reaching and
   multi-tip ranges.
 * Protect only interior local branches, leaving tags and remote-tracking
   refs unchanged.
 * Move sequencer preparation before squash and fold the later
   message-editing patch into the feature commit.

Changes in v10:

 * Record the full revision expression in squash reflog.
 * Preserve the boundary-walk invariant when sanitizing rev-list options.
 * Clarify amend! and --reedit-message documentation.

Changes in v9:

 * Use the last amend! targeting the oldest folded commit as the default
   squashed message. Ignore amend! markers targeting later commits while
   selecting that replacement message.
 * Improve tests.

Changes in v8:

 * --reedit-message now builds the same editor template as git rebase -i
   --autosquash: fixup!, squash! and amend! commits are grouped under the
   commit they target instead of shown in commit order, and an amend!
   replaces its target's message.
 * A fixup!, squash! or amend! is refused only when its target is outside
   the range, so several fixups for an in-range commit fold together. A
   range that is entirely markers for one below-range target is combined
   into a single commit, keeping the last amend! message.
 * Merges inside the range are folded when the range has a single base, with
   no dedicated opt-in flag, --ancestry-path ensures only commits descended
   from the base are folded, and a range reaching more than one base is
   rejected.
 * Rev-list options are accepted and sanitized the way git replay does,
   forcing the walk order back with a warning, which also fixes git history
   squash -- --reverse slipping past the previous option check.
 * Kept this as an explicit squash subcommand rather than making
   --reedit-message the default or renaming the command.

Changes in v7:

 * --reedit-message now builds the same editor template git rebase -i shows
   for a squash (a combination of N commits banner with each folded message
   under its own header) and follows autosquash for markers: a fixup!
   message falls out (commented under a will be skipped header), while a
   squash! or amend! keeps its body with only the marker subject commented
   so its remark can be reworded in. Only the message text is affected,
   every commit's changes are always folded in.
 * Reuse git rebase -i's squash-message code: a preparatory sequencer:
   commit extracts the banner, header and marker-comment helpers so both
   rebase and git history squash build the identical template from one
   source.
 * Refuse a range whose oldest commit is a fixup!, squash! or amend!, since
   the marker's target cannot be inside the range.
 * Reorder the squash usage so dashed options come before <revision-range>,
   and spell out HEAD instead of @ in the documentation and examples.
 * Expand the squash commit message and documentation with this overview,
   and scope the merge limitation so it no longer contradicts squash folding
   a single-base interior merge.

Changes in v6:

 * git history squash now accepts multiple revision arguments, read like the
   arguments to git-rev-list, so a compound range such as @~3.. ^topic
   works.
 * The base to reparent onto is now the oldest in-range commit's parent; a
   boundary other than that base means the range has more than one base and
   is rejected. This also fixes the earlier overly-restrictive handling of
   merges and side branches.
 * A single-commit range (e.g. @^!) is rejected with "nothing to squash"
   (this also covers the @^!-style example that previously succeeded
   silently).
 * Commit messages reworded: the squash commit now gives an overview of
   fixup!/squash!/amend! handling, rewording, merge-parent and ref behavior.

Changes in v5:

 * The range walk now uses --ancestry-path, so only commits descended from
   the base are folded; a single revision such as HEAD or HEAD~1 is now
   rejected as "not a <base>..<tip> range" rather than treated as a squash
   down to the root.
 * This adopts the --ancestry-path suggestion; the multi-base rejection is
   unchanged, so a side branch that forked before the base and merged in is
   still refused.
 * Added tests covering more merge topologies: two interior merges, a nested
   merge, an octopus merge, an octopus arm forked before the base, a merge
   among the descendants replayed above the range, and a ref pointing at an
   interior merge commit.

Changes in v4:

 * git history squash now detects when another ref points at a commit inside
   the range being folded and refuses, with an advice.historyUpdateRefs hint
   to use --update-refs=head.
 * A merge inside the range is folded fine as long as the range has a single
   base; a range with merge commit at the tip or base also folds correctly.
   Only a range with more than one base is rejected.

Changes in v3:

 * Moved the feature out of git rebase and into a new git history squash
   <revision-range> subcommand, per the list discussion. git rebase --squash
   is dropped.
 * Takes an arbitrary range (git history squash @~3.., git history squash
   @~5..@~2), folding it into the oldest commit and replaying any
   descendants on top.
 * Implemented as a single tree operation rather than picking each commit,
   so there are no repeated conflict stops (addresses Phillip's efficiency
   point).
 * A merge inside the range is folded fine, only a range with more than one
   base is rejected.
 * --reedit-message seeds the editor with every folded-in message, not just
   the oldest.

Harald Nordgren (8):
  history: extract helper for a commit's parent tree
  history: give commit_tree_ext a message template
  sequencer: share the squash message marker helpers and flags
  history: add skeleton for squash subcommand
  history: validate squash revision ranges
  history: protect branches when squashing a range
  history: create squashed commits without editing
  history: support editing squashed commit messages

 Documentation/config/advice.adoc |   4 +
 Documentation/git-history.adoc   |  59 +-
 advice.c                         |   1 +
 advice.h                         |   1 +
 builtin/history.c                | 720 +++++++++++++++++++++++--
 object.h                         |   1 +
 sequencer.c                      |  70 +--
 sequencer.h                      |  30 ++
 t/meson.build                    |   1 +
 t/t3455-history-squash.sh        | 886 +++++++++++++++++++++++++++++++
 10 files changed, 1702 insertions(+), 71 deletions(-)
 create mode 100755 t/t3455-history-squash.sh


base-commit: 18e66859d87fb4b76599f73460b54f0848c76b16
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2337%2FHaraldNordgren%2Frebase-fixup-fold-v14
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2337/HaraldNordgren/rebase-fixup-fold-v14
Pull-Request: https://github.com/git/git/pull/2337

Range-diff vs v13:

 1:  b175bdca54 = 1:  19c5e311a3 history: extract helper for a commit's parent tree
 2:  965074f9e8 = 2:  aadb7a5df4 history: give commit_tree_ext a message template
 3:  cdbdd766b2 = 3:  e1621f656e sequencer: share the squash message marker helpers and flags
 4:  f7d953b081 ! 4:  016ae0fd42 history: add skeleton for squash subcommand
     @@ Commit message
          Keep this step limited to defining the revision input contract so graph
          validation and the rewrite can be added independently.
      
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 5:  dbbf66ba02 ! 5:  4992d14ce4 history: validate squash revision ranges
     @@ Commit message
          parents will be preserved and the single tip whose tree will be used by
          the rewrite.
      
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 6:  e71a8adfbe ! 6:  b862a5b4c3 history: protect branches when squashing a range
     @@ Commit message
          Add advice.historyUpdateRefs for the hint that points to
          --update-refs=head.
      
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
 7:  8b3551d0d4 ! 7:  03528d3b34 history: create squashed commits without editing
     @@ Commit message
          applicable amend! body supplying the message.
      
          Inspired-by: Sergey Chernov <serega.morph@gmail.com>
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ t/t3455-history-squash.sh: test_expect_success 'errors on a single revision that
      +	test_commit WIP &&
      +
      +	cat >msg <<-EOF &&
     -+	amend! $(git rev-parse HEAD^ | tr a-f A-F)
     ++	amend! $(git rev-parse --short HEAD^)
      +
      +	The third reword
      +
 8:  821217ed7c ! 8:  98aa3922cb history: support editing squashed commit messages
     @@ Commit message
          unless a preceding squash! requires both bodies. This keeps message
          editing aligned with the marker validation used by the no-edit path.
      
     +    Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      

-- 
gitgitgadget
