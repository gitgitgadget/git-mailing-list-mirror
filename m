Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB430313545
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454411; cv=none; b=FQSmmB+mTnjnRr33U+jE/eLVEl72jCIQ+ZNbbKpEqtds2x2+mNrNXusXcICdq1h6CsB/XqEA8hqaKnwIXO2Xu9JwqoGmFfYn81Jc8TLtb3hZt16ugIYTD6w83iMyXhWjbGVl5pAge9ktM+E6t1ovh3VaX5ML08yXPLx/4y27FlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454411; c=relaxed/simple;
	bh=/G43//ChhZQP/ob3Oc5yfcUuoklfp3xkav4rZQ7g+wE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RxFJ3pFdjlUmrIjzgVTPNOKGrl8S6D+PDOXHfu2NHp1eJbFkehmKc+8qc8YF6LXocHmRcf/9mmW6KZFRH/0eHQSGc+gkyDAbZhx+vD0Iu7w45WX6YiAGxQhtl/f50jdzy3Gai2W3zbC2gLkY8vXDoIzAzWt2IOIITGImsNcAexI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=qGUsR8WT; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="qGUsR8WT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774454407;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JCdX3F1xqVxQeWOUZl1dTO8fu8yTNSWGRoxCCOpvU8w=;
	b=qGUsR8WTbC9xQFTzpI8arEu49M9gcZhaWXuLfkx8FoRJfCcpGC8vb2mwj0Eq3aFfi4l7s3
	EuA+FSG4PLjaai6noFJG0bnx+5FQlJjqhnnxdWt59ASd0rBEIGh4RDDXYLJSAlPasN74ER
	jb/MEP/Eb71KQ+7HunbOwvNPvuGDNUQ=
From: Toon Claes <toon@iotcl.com>
Date: Wed, 25 Mar 2026 16:59:30 +0100
Subject: [PATCH v2 2/3] replay: use stuck form in documentation and help
 message
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260325-toon-replay-arbitrary-ref-v2-2-553038702c9c@iotcl.com>
References: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
In-Reply-To: <20260325-toon-replay-arbitrary-ref-v2-0-553038702c9c@iotcl.com>
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
 Documentation/git-replay.adoc | 23 ++++++++++++-----------
 builtin/replay.c              |  4 ++--
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 6698cfc047..7e749a0477 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -9,7 +9,8 @@ git-replay - EXPERIMENTAL: Replay commits on a new base, works with bare repos t
 SYNOPSIS
 --------
 [verse]
-(EXPERIMENTAL!) 'git replay' ([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) [--ref-action[=<mode>]] <revision-range>...
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
@@ -79,7 +80,7 @@ The default mode can be configured via the `replay.refAction` configuration vari
 
 <revision-range>::
 	Range of commits to replay; see "Specifying Ranges" in
-	linkgit:git-rev-parse[1]. In `--advance <branch>` mode, the
+	linkgit:git-rev-parse[1]. In `--advance=<branch>` mode, the
 	range should have a single tip, so that it's clear to which tip the
 	advanced <branch> should point. Any commits in the range whose
 	changes are already present in the branch the commits are being
@@ -126,7 +127,7 @@ EXAMPLES
 To simply rebase `mybranch` onto `target`:
 
 ------------
-$ git replay --onto target origin/main..mybranch
+$ git replay --onto=target origin/main..mybranch
 ------------
 
 The refs are updated atomically and no output is produced on success.
@@ -134,14 +135,14 @@ The refs are updated atomically and no output is produced on success.
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
@@ -153,7 +154,7 @@ What if you have a stack of branches, one depending upon another, and
 you'd really like to rebase the whole set?
 
 ------------
-$ git replay --contained --onto origin/main origin/main..tipbranch
+$ git replay --contained --onto=origin/main origin/main..tipbranch
 ------------
 
 All three branches (`branch1`, `branch2`, and `tipbranch`) are updated
@@ -164,7 +165,7 @@ commits to replay using the syntax `A..B`; any range expression will
 do:
 
 ------------
-$ git replay --onto origin/main ^base branch1 branch2 branch3
+$ git replay --onto=origin/main ^base branch1 branch2 branch3
 ------------
 
 This will simultaneously rebase `branch1`, `branch2`, and `branch3`,
@@ -175,7 +176,7 @@ that they have in common, but that does not need to be the case.
 To revert commits on a branch:
 
 ------------
-$ git replay --revert main topic~2..topic
+$ git replay --revert=main topic~2..topic
 ------------
 
 This reverts the last two commits from `topic`, creating revert commits on
diff --git a/builtin/replay.c b/builtin/replay.c
index 1a04f33390..a5f81b67d4 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -83,8 +83,8 @@ int cmd_replay(int argc,
 
 	const char *const replay_usage[] = {
 		N_("(EXPERIMENTAL!) git replay "
-		   "([--contained] --onto <newbase> | --advance <branch> | --revert <branch>) "
-		   "[--ref-action[=<mode>]] <revision-range>..."),
+		   "([--contained] --onto=<newbase> | --advance=<branch> | --revert=<branch>)\n"
+		   "[--ref-action=<mode>] <revision-range>"),
 		NULL
 	};
 	struct option replay_options[] = {

-- 
2.53.0.310.g728cabbaf7

