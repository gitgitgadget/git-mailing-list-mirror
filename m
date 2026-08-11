Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF1040D564
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 06:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786430170; cv=none; b=EOk5h8ifSVGl8GDRLE6IE78riOVeX79//slF/zcFY47uvc2n58Ecic2n4qjzD7DVuoUv+nWFcCCpEStj84gpLHc2ZyaDvIkl4s3+02dL9lpzPb8LC6Sa7Yj1J4gRGUtQ1R2OLJjRiMzaDZlGhM9rIVypGPJImJf6QmJUNVAKUT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786430170; c=relaxed/simple;
	bh=oAY8yf20uwBajUmqrYKKLcVo8w8yExzz+A5KboK52cU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=lBStFGm1kiXgNeor/i4pERc8bp6/GlFNNgLnUTD/4Q48men00IyMjg9lKYkrjzIZ80YpRD1E3YNeWAMMo5BF20gP1d5kYRUbRDztAY+TZJ8OpS62Tb308K3Jy/ksqALoL5UZHClabfK8k8lmYl4m2Greu+7XnOXH29ifByx3Oag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtVUkpoG; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtVUkpoG"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e65e18969so46294785a.1
        for <git@vger.kernel.org>; Mon, 10 Aug 2026 23:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786430157; x=1787034957; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uZ8OjUX4bTwhteasIe1Rr4W8BHlSoE0rpdqPEnqRpr8=;
        b=TtVUkpoGPVOTXPKtnXy+PuH3XB3triFmNUrtCcCG+ThpSprqti4RDY6wNCPDnTc1jU
         MkiQdC0wvMbR8OnzU69jiolRheYlQVgQq5vYTBM4ICAdfp/uzZCyiK7FNJlG8ym8pDR5
         xLXLlYG5ArNyipVbCM+AjzdBdQMUShb1jtrAPbCkdS9Fu8QJiAGSwS0K2mIfNdObzSsL
         mdbtOkFkMwkqsYfkhKzvb18a1C20HMLkhfs8sUh400N9+FsNf9AYiBABvlYPXnmdOEPK
         WLbAFN2KuqqRcelDU+OAq8CGFHJMRqJcJetLqSRb1UJIXnSsLczUaOmj+OeHc7XnRQDC
         XMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786430157; x=1787034957;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uZ8OjUX4bTwhteasIe1Rr4W8BHlSoE0rpdqPEnqRpr8=;
        b=IiTlp9wzuVvkFawTxxmV3ybRGnB4gSiq85Qh2pBoq5QSShOUY+9RX1ZCdfyROBGL68
         /cfch5nI8m/l26GWtk9+MvHQzhfOy/VrOOPMASIzt68WBmHsruykmOZteq0f8oKlO4OM
         rqn1V1ugTicH9lgA5b28nsApYV8N69T2/fT9h2dCwoYl3xaePpqimlO+REvvopDpEGR7
         Zvc6zMWIuqH6L4m22WK6EK9P9EdwuuyeHIvTGiqpXdAufdwkqOXFpC9EsbfwZc4EoQdv
         7HCOZFu/DNLAfaf/EcBK0nbrBYBk2GYggk2Z37I9fn2rKWygKmqUVr7ieNB92WIcrJkR
         ZVcg==
X-Gm-Message-State: AOJu0YxWbUJIV+hFr1Q/36t1xAK1n39ZHbphdI2JjEtf/Dn7PF+STTGT
	mdoOCTv+M6esMMhpeJd/iTTB8ggwBRJHVF21VFMfISFJNrfw8l4qBGLmmnM0fA==
X-Gm-Gg: AR+sD11Befo+QCb1VDfB3xRiVaNlUvopUr/Y2s3p/aD4NQgYGBwEjj2eW0yh2tVf2vJ
	bGFtKSooorahu0yHEcmJQYBPiCCE5WEuZ1AOUAR8CG/VCBzszGjx0HGX9bKiu8o4kKb/uFxkW9E
	RmhrpL2OoWFRSbe6r+3dsIV+8fGfZ7HUcJHMDZ3d2k1DTs2mwDjBIJvPqJoWbrNYRVVfaJWuARX
	Lly3Vhehd1jZGZ+HLFVcvNPimmN7fBrXjwZkbVCLv3H7wQ5v1ymoo6sUfLqYMQQw/ADEL93+T4M
	rQdmAWUI3CedRxJ9M656U/wfz7ZlDDSfDSQcnGWOKwHyMFdgfjj827AeRtuC4nbAFyd0haB8Xpt
	mOObxEkXcgMYeRVyG/IB9kG6rz+RaJ1In+RI4waVz7Tq0dx4s/g/lBS+1kt0zI5K9FYrxsJmB8K
	NbhA1i0cA0BONRT6EQ929lXG7UvS0Wx8sSbEf1zVnFSaumMuXBeUWh+Iwg7lvR/BhBtIceGzAvD
	w==
X-Received: by 2002:a05:620a:7002:b0:915:5216:e5bf with SMTP id af79cd13be357-936a96079c3mr48228385a.22.1786430156966;
        Mon, 10 Aug 2026 23:35:56 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.151.83])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-936a85fab4bsm45792485a.41.2026.08.10.23.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 23:35:56 -0700 (PDT)
Message-Id: <pull.2197.v4.git.1786430155244.gitgitgadget@gmail.com>
In-Reply-To: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
References: <pull.2197.git.1786177301832.gitgitgadget@gmail.com>
From: "Yoichi NAKAYAMA via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 11 Aug 2026 06:35:54 +0000
Subject: [PATCH v4] worktree add: improve message for ambiguous remote branch
 name
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
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Yoichi Nakayama <yoichi.nakayama@gmail.com>,
    "D. Ben Knoble" <ben.knoble@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>,
    Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

From: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>

When the user runs 'git worktree add ../foo-dir bar-topic' command
that does not exactly say which remote they want to work with, and
there is no local branch named bar-topic, we try to guess which remote
by passing bar-topic then create a new branch named bar-topic which
tracks the remote branch.

If there are multiple remotes that have branch named bar-topic, we
silently gave up, leaving the variable 'branch' intact.  Then we
entered the conditional clause 'if (!opts.orphan &&
!lookup_commit_reference_by_name(branch))' and triggered "invalid
reference" error.  This error message did not contain enough
information to resolve the issue where the remote could not be
guessed.

To improve the situation, we display a hint and a descriptive error
message and die immediately when multiple matching branches are found.

Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
---
    worktree add: improve message for ambiguous remote branch name

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2197%2Fyoichi%2Fimprove-worktree-add-error-message-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2197/yoichi/improve-worktree-add-error-message-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/2197

Range-diff vs v3:

 1:  1b9364da7e ! 1:  f7c413b588 worktree add: improve message for ambiguous remote branch name
     @@ Metadata
       ## Commit message ##
          worktree add: improve message for ambiguous remote branch name
      
     -    When the user runs 'git worktree add x y' command that does not
     -    exactly say which remote they want to work with, and there is no local
     -    branch named y, we try to guess which remote by passing y then create
     -    a new branch named y which tracks the remote branch.
     +    When the user runs 'git worktree add ../foo-dir bar-topic' command
     +    that does not exactly say which remote they want to work with, and
     +    there is no local branch named bar-topic, we try to guess which remote
     +    by passing bar-topic then create a new branch named bar-topic which
     +    tracks the remote branch.
      
     -    If there are multiple remotes that have branch named y, we silently
     -    gave up, leaving the variable branch intact.  This later causes
     -    creating local branch and worktree not happen, and we end up with
     -    passing an non-existing branch to lookup_commit_reference_by_name(),
     -    triggering "invalid reference" error and die.
     +    If there are multiple remotes that have branch named bar-topic, we
     +    silently gave up, leaving the variable 'branch' intact.  Then we
     +    entered the conditional clause 'if (!opts.orphan &&
     +    !lookup_commit_reference_by_name(branch))' and triggered "invalid
     +    reference" error.  This error message did not contain enough
     +    information to resolve the issue where the remote could not be
     +    guessed.
      
     -    To resolve this issue, display a hint and a descriptive error message
     -    and die immediately when multiple mathing branches are found.
     +    To improve the situation, we display a hint and a descriptive error
     +    message and die immediately when multiple matching branches are found.
      
          Signed-off-by: Yoichi NAKAYAMA <yoichi.nakayama@gmail.com>
      


 builtin/worktree.c      | 23 ++++++++++++++++++++++-
 t/t2400-worktree-add.sh |  4 ++--
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/worktree.c b/builtin/worktree.c
index 654d27c3e1..b29c3a3755 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -64,6 +64,19 @@
 	"\n" \
 	"    git worktree add --orphan %s\n")
 
+#define WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT \
+	_("Matched multiple remote tracking branches, you can list them by:\n" \
+	"\n" \
+	"    git branch -r --list \"*/%s\"\n" \
+	"\n" \
+	"If you meant to create a worktree from a remote tracking branch on,\n" \
+	"e.g. 'origin', you can do so by:\n" \
+	"\n" \
+	"    git worktree add -b %s %s origin/%s\n" \
+	"\n" \
+	"If you'd like to always prefer some remote, e.g. 'origin',\n" \
+	"consider setting checkout.defaultRemote=origin in your config.")
+
 static const char * const git_worktree_usage[] = {
 	BUILTIN_WORKTREE_ADD_USAGE,
 	BUILTIN_WORKTREE_LIST_USAGE,
@@ -904,10 +917,18 @@ static int add(int ac, const char **av, const char *prefix,
 
 		commit = lookup_commit_reference_by_name(branch);
 		if (!commit) {
-			remote = unique_tracking_name(branch, &oid, NULL);
+			int num_matches = 0;
+			remote = unique_tracking_name(branch, &oid, &num_matches);
 			if (remote) {
 				new_branch = branch;
 				branch = new_branch_to_free = remote;
+			} else if (num_matches > 1) {
+				if (!opts.quiet)
+					advise_if_enabled(ADVICE_CHECKOUT_AMBIGUOUS_REMOTE_BRANCH_NAME,
+							  WORKTREE_ADD_AMBIGUOUS_REMOTE_BRANCH_NAME_HINT_TEXT,
+							  branch, branch, path, branch);
+				die(_("'%s' matched multiple (%d) remote tracking branches"),
+				    branch, num_matches);
 			}
 		}
 
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index 87b926728a..5c105cf252 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -624,12 +624,12 @@ test_expect_success '"add" <path> <branch> dwims' '
 test_expect_success '"add" <path> <branch> dwims with checkout.defaultRemote' '
 	test_when_finished rm -rf repo_upstream repo_dwim foo &&
 	setup_remote_repo repo_upstream repo_dwim &&
-	git init repo_dwim &&
 	(
 		cd repo_dwim &&
 		git remote add repo_upstream2 ../repo_upstream &&
 		git fetch repo_upstream2 &&
-		test_must_fail git worktree add ../foo foo &&
+		test_must_fail git worktree add ../foo foo 2>error.actual &&
+		test_grep "matched multiple (2) remote tracking branches" error.actual &&
 		git -c checkout.defaultRemote=repo_upstream worktree add ../foo foo &&
 		git status -uno --porcelain >status.actual &&
 		test_must_be_empty status.actual

base-commit: 010afd3166ddc64c9863b1506f12cbcdda0d4ea1
-- 
gitgitgadget
