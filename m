Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5664B25783C
	for <git@vger.kernel.org>; Fri, 15 Aug 2025 16:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276761; cv=none; b=g4uRUTcWPiJlcJoTSFpH62U3SJObCCvEZyajzBZYId40SfnFYirKir4/rktJ/i3iCdg9E3oILB44Tp0b9BvOxZMw04nfwakSTqJzcOnuUuN6OvbjgAuOEWoCYdhtH1yEmUqHW8jZHW1DADclNYQ+hI+SQVfR9G6iTt+VhpKIMIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276761; c=relaxed/simple;
	bh=rVDsaG5MA8HhUzZILDYXmViA+ryPa29ZJo90/haaGJE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=E2wMZhYYhtd1l2CDCZMjKNejms0tyu/gxPZTVa0kBaAWt1G9u9WNa1n0YNBYn5hO48Frv6rcVLiiMKS1pRG9p2QLoVNRV+RONFJSfAPZg2Mu1AlFtN7knDUxVNfg7sjpmxic+//FPDreY7NLABX85IRQ7ncAAqZ9DvHw8jVyNAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2EXUg8p; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2EXUg8p"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b9edf4cf6cso1935062f8f.3
        for <git@vger.kernel.org>; Fri, 15 Aug 2025 09:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755276757; x=1755881557; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IHQ6zpM5zd6LNFR0lQAPfEFY9oG+SRQ+N2zGxfAwkJ0=;
        b=F2EXUg8p7RPY9upJGvzBufu+8EzqLHN+lWRcNs8y/fEU/A5ymCJq4Ayy2xsphUWoxa
         eN2IB8DRl1LJ3ohxudntewuKcvycaqjbriQu2W7ifcSpxAKwWd1JKmmx5HYwUO2NClWY
         RlGjdxAC8Gqufy43tS75UC8WJhUMBCwekNyiXeu4oBXSkcDrX1QGBAvN4hoJymIi+X4j
         uFoPgQZeVgYv9awFgSRxHzyE9580KaCdedsSCFs9TeqLVfoxKgJCkN2CgavrxDXL9Stp
         mBJWIjyhVahI4mvUkIFzJETAAVtoEF905KlcMkd3ItydeTjjma54JJCQZgxdLFakMkP+
         8csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755276757; x=1755881557;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IHQ6zpM5zd6LNFR0lQAPfEFY9oG+SRQ+N2zGxfAwkJ0=;
        b=vKAVSIEtnYW5N8fQgQIFefnB8CzDIYhUX0GRwKfgTp67hai5zfO2KfA/ZhfmTSFwJb
         S0IjSj+8H4sWI2q3LQ6sQNuDZKW70//dwXk8eX+hz/pkJogepYxMikS0tg4NkblNLjLM
         qRj9pWVe9sPrWDtKpv3EX4NApc0HnyvORm27nVx1Io4sSn5ZbAmQmjV/ZewCB06ss/Zi
         Sx0mbTr52LXKtgfQQzrSElH5JWfoFewSVnaJ94h6fOWjVZXqxZOoBnf626KseJzrj8go
         RuiEYbYllkaY6w6hK2C9jDJopqchgvUop0McwO/02eLN9KI/pUgQzoJEew3ohMZv9Jn7
         uc6g==
X-Gm-Message-State: AOJu0YywIZWguaVtGEyHZkmoX13CGC6GPAzgOxx+oIfgQwBr5oHTbpqg
	8jewGdouDoaPf/wSWm94Q/e/QIeHi0euXee7E16AaJCppkNYNMK69/dns8Nf2A==
X-Gm-Gg: ASbGnctafjbSz8wfu9453LOXjvFoVeUyHNc2XUjy10F4MNDRRocKbRf4jTY7ZCm2QkE
	rxolZXKNVrVP2P/Mkk4vBwUPNLXzoZZ0DyvpKwbuNnldSNLKiNG4QsvyHncqQBFFjFIoaZ+xvrC
	kDR++PDnBupGCSNeg4ZHpe7Ps4Wk1TzBvM+Z9PebZELwqvC9wVXLwhZ+p1PiF3pnDzHr1msfObA
	0LUTdY3BaqS+2jT/js51sWN4somjkT8kFOrCQBggiOCNj6BnJnt/hG2sooOKTBnJbqu7V9tHtX5
	9eeIYNWkpfBAjQtQRpiQLnmv7l/A2y1daZxyVOmhz3dZ5L3qU5ZD5as8IgefOw3o/EI5+c3a+kS
	XatSGSyV4g4t+FaWs70DVw67jKfUamEhMs2I4yzwmS+Mq
X-Google-Smtp-Source: AGHT+IE4Yqfj7iFq2KU6wXaDXsb1pQOB11h2L12EpzVi4smXT0LzcS9SgLpBE3Tis8lurrEv1gOJdw==
X-Received: by 2002:a05:6000:40cd:b0:3b7:75e8:bd17 with SMTP id ffacd0b85a97d-3bb6646e7acmr2232882f8f.8.1755276757250;
        Fri, 15 Aug 2025 09:52:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45a1ce9758asm62766675e9.15.2025.08.15.09.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Aug 2025 09:52:36 -0700 (PDT)
Message-Id: <cb85642bb9df3fcf9792fd18f2dcf448839eae2c.1755276751.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
References: <pull.1949.v7.git.1755006568.gitgitgadget@gmail.com>
	<pull.1949.v8.git.1755276750.gitgitgadget@gmail.com>
From: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 15 Aug 2025 16:52:30 +0000
Subject: [PATCH v8 5/5] doc: git-rebase: update discussion of internals
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
 Documentation/git-rebase.adoc | 61 +++++++++++------------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index d041d87f270b..2a44f8a0ceda 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -68,51 +68,26 @@ linkgit:git-config[1] for details) and the `--fork-point` option is
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
+1. Make a list of all commits on your current branch since it branched
+   off from `<upstream>` that do not have an equivalent commit in
+   `<upstream>`.
+2. Check out `<upstream>` with the equivalent of
+   `git checkout --detach <upstream>`.
+3. Replay the commits, one by one, in order. This is similar to running
+   `git cherry-pick <commit>` for each commit. See REBASING MERGES for how merges
+   are handled.
+4. Update your branch to point to the final commit with the equivalent
+   of `git checkout -B <branch>`.
 
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
