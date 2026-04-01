Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6431E98FF
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775076932; cv=none; b=XF/k+Zh2coznIeMcPnNAB+xpkoXZwFmJ1ApyQCVOsIwgctiojyFamcman0JrKULWaS/gUGbBmFmx7m05sxTf8qVUDP7vCelOIjBlEsA2eoJJzotiEKorjfRcGmKz1p0ZMo60dy3iaiko7PZ2gYMMY4HEe/Vn8wP3DW13bWQZJjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775076932; c=relaxed/simple;
	bh=VM5RiQx2pRyqivLj7vA2W949erwGtgWf2p7f1gbcd5g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kctrrfTRjyhquhi5aZkah+IrE/Za+/TcIL98zXKbosa1Ia11D5zo883DOM8Sr5xsDOSTSHgC0TUKNyKjvAS7rI3dusB9SOxWSy0CE9f4UUUDT0oHa9RB5bDsk1cgBOfZY1/nasEzRd2NTGeavZlk08wHZgcsOM9FMdoUReoU4UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YcxQ83+g; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YcxQ83+g"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775076928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8TQQo428RObnmardGw+ptX6QbwGpwlaYwyZtOvBPQlQ=;
	b=YcxQ83+gVmscErI2fo0YV9KmJkpmBChFLbIT3abC0OLu+QoyjKgYkS5cwj4MqLUyVmaaoh
	hJHCaA7opYTnQdAwaLcz7ucPdhpZCsYsln86jj1tu1pezq4uqjJpS6ReaGxxMI5Tc8Ort2
	aGKIMEe2Ulr7jUXWlZ0WNGDGLqOmFaw=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 01 Apr 2026 22:55:11 +0200
Subject: [PATCH v3 2/3] replay: use stuck form in documentation and help
 message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-toon-replay-arbitrary-ref-v3-2-a0b4fabb34b3@iotcl.com>
References: <20260401-toon-replay-arbitrary-ref-v3-0-a0b4fabb34b3@iotcl.com>
In-Reply-To: <20260401-toon-replay-arbitrary-ref-v3-0-a0b4fabb34b3@iotcl.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>, 
 Siddharth Asthana <siddharthasthana31@gmail.com>, 
 Yee Cheng Chin <yeecheng.chin@gmail.com>, Toon Claes <toon@iotcl.com>
X-Migadu-Flow: FLOW_OUT

gitcli(7) suggests to use stuck form. Change the documentation strings
to use this form.

While at it, reorder them to match the order in the docs.

Signed-off-by: Toon Claes <toon@iotcl.com>
---
 Documentation/git-replay.adoc | 25 +++++++++++++------------
 builtin/replay.c              |  4 ++--
 2 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 997097e420..5bb478c281 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,7 +9,8 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>
+(EXPERIMENTAL!) 'git replay' ([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)
+			     [--ref-action=<mode>] <revision-range>
 
 DESCRIPTION
 -----------
@@ -26,7 +27,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 OPTIONS
 -------
 
---onto <newbase>::
+--onto=<newbase>::
 	Starting point at which to create the new commits.  May be any
 	valid commit, and not just an existing branch name.
 +
@@ -34,7 +35,7 @@ When `--onto` is specified, the branch(es) in the revision range will be
 updated to point at the new commits, similar to the way `git rebase --update-refs`
 updates multiple branches in the affected range.
 
---advance <branch>::
+--advance=<branch>::
 	Starting point at which to create the new commits; must be a
 	branch name.
 +
@@ -42,7 +43,7 @@ The history is replayed on top of the <branch> and <branch> is updated to
 point at the tip of the resulting history. This is different from `--onto`,
 which uses the target only as a starting point without updating it.
 
---revert <branch>::
+--revert=<branch>::
 	Starting point at which to create the reverted commits; must be a
 	branch name.
 +
@@ -79,8 +80,8 @@ The default mode can be configured via the `replay.refAction` configuration vari
 
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
-	linkgit:git-rev-parse[1]. In `--advance <branch>` or
-	`--revert <branch>` mode, the range should have a single tip,
+	linkgit:git-rev-parse[1]. In `--advance=<branch>` or
+	`--revert=<branch>` mode, the range should have a single tip,
 	so that it's clear to which tip the advanced or reverted
 	<branch> should point. Any commits in the range whose changes
 	are already present in the branch the commits are being
@@ -127,7 +128,7 @@ EXAMPLES
 To simply rebase `mybranch` onto `target`:
 
 ------------
-$ git replay --onto target origin/main..mybranch
+$ git replay --onto=target origin/main..mybranch
 ------------
 
 The refs are updated atomically and no output is produced on success.
@@ -135,14 +136,14 @@ The refs are updated atomically and no output is produced on success.
 To see what would be updated without actually updating:
 
 ------------
-$ git replay --ref-action=print --onto target origin/main..mybranch
+$ git replay --ref-action=print --onto=target origin/main..mybranch
 update refs/heads/mybranch ${NEW_mybranch_HASH} ${OLD_mybranch_HASH}
 ------------
 
 To cherry-pick the commits from mybranch onto target:
 
 ------------
-$ git replay --advance target origin/main..mybranch
+$ git replay --advance=target origin/main..mybranch
 ------------
 
 Note that the first two examples replay the exact same commits and on
@@ -154,7 +155,7 @@ What if you have a stack of branches, one depending upon another, and
 you'd really like to rebase the whole set?
 
 ------------
-$ git replay --contained --onto origin/main origin/main..tipbranch
+$ git replay --contained --onto=origin/main origin/main..tipbranch
 ------------
 
 All three branches (`branch1`, `branch2`, and `tipbranch`) are updated
@@ -165,7 +166,7 @@ commits to replay using the syntax `A..B`; any range expression will
 do:
 
 ------------
-$ git replay --onto origin/main ^base branch1 branch2 branch3
+$ git replay --onto=origin/main ^base branch1 branch2 branch3
 ------------
 
 This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
@@ -176,7 +177,7 @@ that they have in common, but that does not need to be the case.
 To revert commits on a branch:
 
 ------------
-$ git replay --revert main topic~2..topic
+$ git replay --revert=main topic~2..topic
 ------------
 
 This reverts the last two commits from `topic`, creating revert commits on
diff --git a/builtin/replay.c b/builtin/replay.c
index 85aa9fa0a4..fbfeb780b6 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -84,8 +84,8 @@ int cmd_replay(int argc,
 
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
-		   "[--ref-action[=<mode>]] <revision-range>"),
+		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
+		   "[--ref-action=<mode>] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {

-- 
2.53.0.310.g728cabbaf7

