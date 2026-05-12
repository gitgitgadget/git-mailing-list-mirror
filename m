Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A32399354
	for <git@vger.kernel.org>; Tue, 12 May 2026 22:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778623892; cv=none; b=L6GABaLZGg0ckNJtYqJ6xel6AYf2LxSJxSV4mhHX8D33Zt1m8iPxWLNb0kbJgswlv1kQlE6IULs3+EA6INw3tXQDzpmucPtRzTvU13wzi8gaU4D31MHDFkYFjeBBX/beRKvsppHJjK8TwCSk8A+/4BaUa4IwCCoKXDrXadltxbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778623892; c=relaxed/simple;
	bh=YUfjXSBAOtHBxf+q4FhuWJMbTVD7yAeGDTBmq6dMhSw=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=mjG0Lc6Q+GOTB8ytHz+VCRt4ewgQTRhWW3sYsDG+7nAfPRlXzdk9222v2FbnLZUi0pTzR7Q4oIBj1saJPty5r8R2JUgPH27dhKiYP9qinfFmyzECiPqN2aoqWc4t42L256R/i1dqc++VEE800u6o1+GB/CC8Oj3vRmXIENTjjdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TtY0cauS; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TtY0cauS"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90ea08cc5ceso98506385a.2
        for <git@vger.kernel.org>; Tue, 12 May 2026 15:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778623889; x=1779228689; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h0HbFlKKDdRuNbHE1Jn4aAOEczmHWHLH0Oxbc2Rpf9U=;
        b=TtY0cauSMZ0aZOwUMyz16xwbW+M6Ym+o6N+O1Crxybfbn/tjOkVeDXOIGRClUl0Txh
         q1I3QjL89NCWtmPuznF6lfRx/UqTN6d4jKkRWk1kVl0d4IUVRTxOtoB34PGkNEszNv1v
         5Mx6Cp+vb9p80wJJd7DzBvjh9fDfSL0563/rmtBAkhOGdMqIk90ZXU5JJ5XiD/0bOW+2
         6ztpaFBk0Ubjsdwt2hP4LuCwPUcN4FeF44whZTv7HEXuhA9a9gZPcENSVrOupKOUmqYs
         eFnfr9i7GQoTyLe76s+nNZ/k5WWE9Lp+ldlroA9Q9ur0jFHSc9rQlMQceskU1P8XB0nI
         VENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778623889; x=1779228689;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h0HbFlKKDdRuNbHE1Jn4aAOEczmHWHLH0Oxbc2Rpf9U=;
        b=mn3KplKW8wXIyyOrgZHk/vA9hy/YvGCZ3A9vFrCm37w9ehrshkiSUnCMRk7ZBML1C7
         nnjHrgDlooCqFYARUDh0j22zt2EtxXs6xqM7OHgV6l+xDSxubt308ORpO6TQK1NacNWd
         05j466+X/NsPOQJdD7uFA7ixGYW9s69LUQqg+UM5A9QI6Q+TLGaxTdlS5Nqt6zC8sObB
         g4F+PmHPUUEMUllI+KAtCOjOBS9qwq+EbLtAgd8+v0QX/87eNpQO0V9QhYStOk5E12bQ
         Y3iHYiXcx8NgGm995C877y/wcbigW0bx1oALvKbT58XSNtqeU5HrTXdVjWUd1vt7uXop
         rNAA==
X-Gm-Message-State: AOJu0Yzd8IPo+P9LLNjUQQq+ytgD5YN3UCLaubyI8lMUd0O/R0QqDG5q
	osRRfj6TigO686OoVeLZBn0fbceygkOcPbiXc6t50aro6JIGAw+OjYQHeTkSYA==
X-Gm-Gg: Acq92OEss+NFkRUCFr3ibRJF6tj9SC5/2Mwc99vARoj+r/l9JcGG9f+z+lYaIytO70v
	l14OMZfs6h60SiNw97jetxhNrp/fCSvxlPBBfXMFQjfUIuNqLyF78L6a+gD+KDH15IM1oF+UoC7
	BuLFx2qsT8dYYoYShTmHdFtt4fKFWcwGHi8CLCqlSp9Vaul58OFqPrZdROm/meU/6XTVOLfaUFD
	M+MottBAhje86j6jxozYcDqXQgGxBRTrv6tMJCmwYzw94Dr48MdbWO+9n1gXyiBbEwNJCIb0lks
	StJP6mkh0ov3WjMZiBOmhoeZmBkb2kVRT1ALN3UhDcF2JwIg7ywaDxpYLRU3HbbA1/QWYaCGEGy
	bDJXVdtj561AwfGHiDtnmaVhw88ul5I9RexAHFCUFahb07G+EcknS1zq9tPB1gdS2QQMP+I4QiB
	VK3wr6On/aj9LjX1ySpvTdrBqAifWX
X-Received: by 2002:a05:620a:2909:b0:8cd:b44d:b1c0 with SMTP id af79cd13be357-90f8ad05595mr138757685a.53.1778623889354;
        Tue, 12 May 2026 15:11:29 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.200.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c9229c8sm3818645085a.36.2026.05.12.15.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 15:11:28 -0700 (PDT)
Message-Id: <pull.2301.git.git.1778623888178.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 22:11:28 +0000
Subject: [PATCH] remote: qualify "git pull" advice for non-upstream branches
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
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

When "git status" reports the local branch is behind or has diverged
from the push branch, the advice suggested a bare "git pull". That
follows the upstream, which may live on a different remote, so emit
"git pull <remote> <branch>" instead.

Also enable the pull and divergence advice for push-branch
comparisons; they were previously only set for the upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    remote: qualify "git pull" advice for non-upstream branches

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2301%2FHaraldNordgren%2Fstatus-pull-advice-qualified-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2301/HaraldNordgren/status-pull-advice-qualified-v1
Pull-Request: https://github.com/git/git/pull/2301

 remote.c                 | 47 +++++++++++++++++++++++++++++++---------
 t/t6040-tracking-info.sh | 41 +++++++++++++++++++++++++++++++++++
 2 files changed, 78 insertions(+), 10 deletions(-)

diff --git a/remote.c b/remote.c
index a664cd166a..d1e09079cb 100644
--- a/remote.c
+++ b/remote.c
@@ -2267,6 +2267,8 @@ static void format_branch_comparison(struct strbuf *sb,
 				     bool up_to_date,
 				     int ours, int theirs,
 				     const char *branch_name,
+				     const char *push_remote_name,
+				     const char *push_branch_name,
 				     enum ahead_behind_flags abf,
 				     unsigned flags)
 {
@@ -2302,9 +2304,15 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "and can be fast-forwarded.\n",
 			   theirs),
 			branch_name, theirs);
-		if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git pull\" to update your local branch)\n"));
+		if (use_pull_advice && advice_enabled(ADVICE_STATUS_HINTS)) {
+			if (push_remote_name && push_branch_name)
+				strbuf_addf(sb,
+					_("  (use \"git pull %s %s\" to update your local branch)\n"),
+					push_remote_name, push_branch_name);
+			else
+				strbuf_addstr(sb,
+					_("  (use \"git pull\" to update your local branch)\n"));
+		}
 	} else {
 		strbuf_addf(sb,
 			Q_("Your branch and '%s' have diverged,\n"
@@ -2315,9 +2323,15 @@ static void format_branch_comparison(struct strbuf *sb,
 			       "respectively.\n",
 			   ours + theirs),
 			branch_name, ours, theirs);
-		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS))
-			strbuf_addstr(sb,
-				_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		if (use_divergence_advice && advice_enabled(ADVICE_STATUS_HINTS)) {
+			if (push_remote_name && push_branch_name)
+				strbuf_addf(sb,
+					_("  (use \"git pull %s %s\" if you want to integrate the remote branch with yours)\n"),
+					push_remote_name, push_branch_name);
+			else
+				strbuf_addstr(sb,
+					_("  (use \"git pull\" if you want to integrate the remote branch with yours)\n"));
+		}
 	}
 }
 
@@ -2355,6 +2369,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		int ours, theirs, cmp;
 		int is_upstream, is_push;
 		unsigned flags = 0;
+		const char *push_remote_name = NULL;
+		const char *push_branch_name = NULL;
 
 		full_ref = resolve_compare_branch(branch,
 						  branches.items[i].string);
@@ -2396,13 +2412,24 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (reported)
 			strbuf_addstr(sb, "\n");
 
-		if (is_upstream)
+		if (is_upstream || is_push) {
 			flags |= ENABLE_ADVICE_PULL;
-		if (is_push)
+			if (show_divergence_advice)
+				flags |= ENABLE_ADVICE_DIVERGENCE;
+		}
+		if (is_push) {
 			flags |= ENABLE_ADVICE_PUSH;
-		if (show_divergence_advice && is_upstream)
-			flags |= ENABLE_ADVICE_DIVERGENCE;
+			push_remote_name = pushremote_for_branch(branch, NULL);
+			if (push_remote_name &&
+			    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
+			    skip_prefix(push_branch_name, push_remote_name, &push_branch_name) &&
+			    *push_branch_name == '/')
+				push_branch_name++;
+			else
+				push_remote_name = NULL;
+		}
 		format_branch_comparison(sb, !cmp, ours, theirs, short_ref,
+					 push_remote_name, push_branch_name,
 					 abf, flags);
 		reported = 1;
 
diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
index 0242b5bf7a..3199063762 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -529,6 +529,7 @@ test_expect_success 'status.compareBranches with diverged push branch' '
 
 	Your branch and ${SQ}origin/feature8${SQ} have diverged,
 	and have 1 and 1 different commits each, respectively.
+	  (use "git pull origin feature8" if you want to integrate the remote branch with yours)
 
 	nothing to commit, working tree clean
 	EOF
@@ -646,4 +647,44 @@ test_expect_success 'status.compareBranches with remapped push and upstream remo
 	test_cmp expect actual
 '
 
+test_expect_success 'status.compareBranches with behind push branch suggests qualified pull' '
+	test_config -C test push.default current &&
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test status.compareBranches "@{upstream} @{push}" &&
+	git -C test checkout -b feature13 upstream/main &&
+	(cd test && advance work13) &&
+	git -C test push origin &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature13
+	Your branch is up to date with ${SQ}upstream/main${SQ}.
+
+	Your branch is behind ${SQ}origin/feature13${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin feature13" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'status.compareBranches with remapped push and behind push branch' '
+	test_config -C test remote.pushDefault origin &&
+	test_config -C test remote.origin.push refs/heads/feature14:refs/heads/remapped14 &&
+	test_config -C test status.compareBranches "@{push}" &&
+	git -C test checkout -b feature14 upstream/main &&
+	(cd test && advance work14) &&
+	git -C test push &&
+	git -C test reset --hard HEAD^ &&
+	git -C test status >actual &&
+	cat >expect <<-EOF &&
+	On branch feature14
+	Your branch is behind ${SQ}origin/remapped14${SQ} by 1 commit, and can be fast-forwarded.
+	  (use "git pull origin remapped14" to update your local branch)
+
+	nothing to commit, working tree clean
+	EOF
+	test_cmp expect actual
+'
+
 test_done

base-commit: 29bd7ed5127255713c1ac2f43b7c6f257d7b4594
-- 
gitgitgadget
