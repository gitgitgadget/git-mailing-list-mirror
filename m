Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69112E3B03
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754949087; cv=none; b=Yr+K2uWIxVab4G87ZJHplt3WpmuNX9jxQnclsPbrXc4Ah45n+VDG3pBqUYDjAMZ6H1gp7rcTjDdZxWVqGffV5A2+EDyd1G9Eyggg1dIqGHxCTIDctasM+mZTqfV0LdBb8QjmDFRal99Sm96jwu03P6/1EWV1g9xHgZXImVFstd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754949087; c=relaxed/simple;
	bh=/L2x1quh6674/PPnRG1iOT+A+4B1gY+2drumySVAM5I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=jSvHmDSJUfXDd914p6HFx61on9S408/Jli7ATSVTN+bxP19VQsl5Ne9CeTO4hDlDQEXIuYHpKdZiEVaIHMxHklK1CnHYZfFD0AWRyfkK6Este492VQ/aAwbF2PUxDFkT+wP0YsediWKl2wEaJKZO2/RlU+X0BXYD6Dkv7UP6NhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCw+2YdK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCw+2YdK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b79bddd604so2819263f8f.0
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 14:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754949084; x=1755553884; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q15pV1bmixgYZFee0z9Y2pbaqHIz1Zd2CxJ1bjPSnD0=;
        b=mCw+2YdKVrhQ7UYnQHuy+sNbmz2c2wPF1RczZ8Rg/qKXRg9LCY2aYkaHgAYcqr0SHK
         hgmJ5THIGHOy6qDYEo0ddiihog3bnI66msScpIkIkO9kEzUG4TCdqmPhFc76gSnGdQOE
         zc1c1B9vOEd3cBjBewNNEbWF9Jn9C5AhoFWkiunqcfWLHnGt7ZPCh4M1I3syoUUCKBTm
         skWbkP8HrUVEnU9/hQOSOeg3zdll768UrmF+oVQe+/qTwP1NuW80b4CA90NhbCBFpSAe
         EK2DBExt0ZP3LpcypnqgYHjoCzsggpyP1hqXL3k4+Vl71FL+OvnXcaRU1/KOovW+L5/3
         d+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754949084; x=1755553884;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q15pV1bmixgYZFee0z9Y2pbaqHIz1Zd2CxJ1bjPSnD0=;
        b=O/x+Dca5E+KW30qu9bMsHpPdGQQ6Kqm08X7Qsyma2kmYDmqFFIZxLsRIfIYsSwz+7Y
         zwBiFBG0345J56n92wXuOwuhnj0/2lforMNsTrmQXIt6I34h3NQ3d/NS99b2XPcfCL7g
         ztfZAslnYPYp8qeksFAU3sX1MYdDGvioRD1wXsjAz6yhkI/9rap2fZZbmBFr/3BJrtk/
         KphMBu+qbPLKQTwJAGtV26rVrxHdu7E+3SCWb0lvBtC354REG94NymUqPXsh5/BisjDP
         a260SSRuMpE8K1KYaDTGBSnEqxYJMR7axymEerAiUVIK6/zhIeVk85I7n9tP7hH6KsXp
         k2cA==
X-Gm-Message-State: AOJu0Yx6vy7/OcHg2h9C8rGpH3tSJYW21hvee/eVaLaKgxSw2IPUwMqL
	3SluzbcJtH47z6Y4xnTyoCwC35INSpsNHny7utPUgdEgyE1t9h46WAd43Dk21Q==
X-Gm-Gg: ASbGncs57FKfnoD5reDmKgVcVs9LBCn1qHqJZW7HMxIxMMr+tNv2kZzjRJjwX7E10en
	N/ae65CQXpAm5IrUyj+Jkjg0athku1C+p3uWA53dMU2q406Kvh1l99slrg7s2dsp5RnEGf0BUwH
	ok1zShC6O5IuQ6DyLbEcizB6/n2Ny0O2muHer1IPv5a5hLqd6/iUKH75y5AZe9j0clsTFd2aMc3
	1ZJRvDIzP0QXs+TRg77QtKl9QoKVdfnl5iXc5ue2m3CD6J7/e/+BXzgrkjJ2aD/2YwDYoP/wAaB
	jgMxr4idW95/ojcte5CijHAeNOsDl/IPXRzUYBOwI6raje1ka5tKPM2rjjVeUvzbQjQn0c8h3h3
	lVLR3TKIxDToS5ht/DE06jek=
X-Google-Smtp-Source: AGHT+IEUO4pwXCvfOjzVkqOqfB7hA2RzOX+MIOMYRz5E/411xcUCXg3sj3KBtfccHqKZdWNZA9NfNA==
X-Received: by 2002:a05:6000:4383:b0:3b8:d337:cc33 with SMTP id ffacd0b85a97d-3b91100a9f9mr1067806f8f.28.1754949083548;
        Mon, 11 Aug 2025 14:51:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a119e96dfsm1042475e9.2.2025.08.11.14.51.23
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 14:51:23 -0700 (PDT)
Message-Id: <9c7f2716bc8dca2a73f7c8a994ccb8ed4a66fd9a.1754949075.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
References: <pull.1949.v5.git.1754943127.gitgitgadget@gmail.com>
	<pull.1949.v6.git.1754949075.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 11 Aug 2025 21:51:15 +0000
Subject: [PATCH v6 5/5] doc: git-rebase: update discussion of internals
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
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Karthik Nayak <karthik.188@gmail.com>,
    Julia Evans <julia@jvns.ca>,
    Julia Evans <julia@jvns.ca>

From: Julia Evans <julia@jvns.ca>

- make it clearer that we're talking about a multistep process
- give a more technically accurate description how rebase works with the
  merge backend.
- condense the explanation of how git rebase skips commits with the same
  textual changes into a single bullet point and remove the explanatory
  diagram. Lots of things which are more complicated are already being
  explained without a diagram.
- remove the explanation of how exactly `--fork-point` and `--root`
  work since that information is in the OPTIONS section
- put all discussion of `ORIG_HEAD` inside the note

Signed-off-by: Julia Evans <julia@jvns.ca>
---
 Documentation/git-rebase.adoc | 63 +++++++++++------------------------
 1 file changed, 20 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index d041d87f270b..d4fc80ebb20c 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -68,51 +68,28 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
 assumed.  If you are currently not on any branch or if the current
 branch does not have a configured upstream, the rebase will abort.
 
-All changes made by commits in the current branch but that are not
-in `<upstream>` are saved to a temporary area.  This is the same set
-of commits that would be shown by `git log <upstream>..HEAD`; or by
-`git log 'fork_point'..HEAD`, if `--fork-point` is active (see the
-description on `--fork-point` below); or by `git log HEAD`, if the
-`--root` option is specified.
-
-The current branch is reset to `<upstream>` or `<newbase>` if the
-`--onto` option was supplied.  This has the exact same effect as
-`git reset --hard <upstream>` (or `<newbase>`). `ORIG_HEAD` is set
-to point at the tip of the branch before the reset.
+Here is a simplified description of what `git rebase <upstream>` does:
+
+1. Make a list of all new commits on your current branch since it branched
+   off from `<upstream>`. This is the same set of commits that would be shown
+   by `git log  <upstream>..HEAD`. You can use `--fork-point` or  `--root` to
+   change how this list of commits is constructed.
+2. Check whether any of those commits are duplicates of commits already
+   in `<upstream>` and remove them from the list.
+3. Check out `<upstream>` with the equivalent of `git checkout --detach <upstream>`.
+4. Replay the commits, one by one, in order. This is similar to running
+   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
+   are handled.
+5. Update your branch to point to the final commit with the equivalent
+   of `git checkout -C <branch>`.
 
 [NOTE]
-`ORIG_HEAD` is not guaranteed to still point to the previous branch tip
-at the end of the rebase if other commands that write that pseudo-ref
-(e.g. `git reset`) are used during the rebase. The previous branch tip,
-however, is accessible using the reflog of the current branch
-(i.e. `@{1}`, see linkgit:gitrevisions[7]).
-
-The commits that were previously saved into the temporary area are
-then reapplied to the current branch, one by one, in order. Note that
-any commits in `HEAD` which introduce the same textual changes as a commit
-in `HEAD..<upstream>` are omitted (i.e., a patch already accepted upstream
-with a different commit message or timestamp will be skipped).
-
-If the upstream branch already contains a change you have made (e.g.,
-because you mailed a patch which was applied upstream), then that commit
-will be skipped and warnings will be issued (if the 'merge' backend is
-used).  For example, running `git rebase master` on the following
-history (in which `A'` and `A` introduce the same set of changes, but
-have different committer information):
-
-------------
-          A---B---C topic
-         /
-    D---E---A'---F master
-------------
-
-will result in:
-
-------------
-                   B'---C' topic
-                  /
-    D---E---A'---F master
-------------
+When starting the rebase, `ORIG_HEAD` is set to point to the commit at the tip
+of the to-be-rebased branch. However, `ORIG_HEAD` is not guaranteed to still
+point to that commit at the end of the rebase if other commands that change
+`ORIG_HEAD` (like `git reset`) are used during the rebase. The previous branch
+tip, however, is accessible using the reflog of the current branch (i.e. `@{1}`,
+see linkgit:gitrevisions[7].
 
 MODE OPTIONS
 ------------
-- 
gitgitgadget
