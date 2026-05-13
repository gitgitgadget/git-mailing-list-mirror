Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E8C39EF2B
	for <git@vger.kernel.org>; Wed, 13 May 2026 09:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778665821; cv=none; b=LsGqo0VJ/1Tjg2oKddesYOF+WJ2zzg4bMK9xEy0NNkiuhYYXVOshSQCF5SSSbXJqCd2+ThN8g+N3flympbF7zerYf46N0tbJfKINUPjOdQQ/+v6jyv7L9M17Qz1x7VwlIW8UdvX52FtcM+qN75uTeg9attI4Isvz4Q0cX/oFWxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778665821; c=relaxed/simple;
	bh=zCQeGoGyJh0pCxnDRG1lgB3gQvU8/4VGon1Rl9IBz68=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ZmqxXMtDXZzWxfaOLxq4JQ7/8JPPM4aPra85kdcjyF1s2ZI5thrf/CGoaeXzVdHtx3KpakVqZJiVfQMHWR1S3Y3EcZI7Mt8wsz1pmA/UoT60pT//crFJlltTGIdHmKhV0HSgGyzGeh5qRs4pe3+yFUXp50VhyFCQ8v2OOme82PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXg+YKCg; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXg+YKCg"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f3c623322bso10978087eec.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 02:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778665814; x=1779270614; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bZ0GddvZ8Fsqtwub+cNjkXa2OIrPFEHtslOvVK9tgg=;
        b=gXg+YKCgO2FOC5Oe3K7D1yCIxRorOPkAgng4XpjHwF8z4EAfkNvG0d7pxo+RW1C0lo
         th/4NP1lvGdkBz8iiBYLNj5bCIMyMz7KDY1uhg8JE30daNlxmDsFWLRyqNOLplYe5j0/
         ebs2h7ljlO1iZYVMZtcD6lxKPhJBEJY7vcLjAccv5LlNCXVACAAEp79DH+n8gUnuq2SL
         Xxq2PntGx3X2khPhn/OjCNCYsbPlNel2Jbb9xdjvMvwzn48DHQCUEXE8oQ2vlZP2aPc+
         1JQWwtkMl8tFFVNfYZJdhFS0UQfkZPUJV2g/F3CFxkjWkqme4ndYjbDmVHLWC0JHh2cP
         D9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778665814; x=1779270614;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9bZ0GddvZ8Fsqtwub+cNjkXa2OIrPFEHtslOvVK9tgg=;
        b=Lj/dH3Fm/9zMUUuTfQUDY3K8cc2DRUuN7JdGFGP4jB4jsj/mIVc8mYFoDKm439ggZB
         tBylyx9R+UcAaFY6wNkijVMh45CMxwE1pyE4OVoADrUOQRt3iRLQ9bJPfES6Wpbb+v6P
         BDODOgWwI60UFZtwfAZK2H742m+5bCwr6A+S+7SVVLQVtHO4l3xI4kz0thNFq1PtL9Sj
         glCLjxV2CRoXjAHX2NhhzUo5IOwftIgqxuYWhjLzN51FXizD5J6DCwQe+fpi/yCuL+C4
         pUCiBDANNYVOuWBnW1GANv0VPhm4asFHvk4AhEmBt2vZXFA0KM5Q3nnmgQA/AEk1x2df
         C5Ag==
X-Gm-Message-State: AOJu0YxszgGBaISdb5e52EtDNKBGplGHETEmGd60VHtr0c0I8WdbAd1d
	TF+vfPlvixyQC8Mn7W2PCNtpI6eyn9/h8tTKGIGS6V2/AksrgdJXudcVDibPpg==
X-Gm-Gg: Acq92OHI/et1QkZxiiwH7cyxJ9eMruHQBDakB3ZAi4JMuhrkJefwLK2dB6sRLoTdEST
	qrzX2+9HLvS90mFAGYD5SuLbVl1Noc8lEVJJTBOjGJzrqtg437DPsWCzhoG4DLJnwLAOIFTWFZk
	2od9F62o7dsvg37l4HyHC+qhcom9bZd+kWZqA0SYj6B4XVY7JwLQFaSX+yUPr51aDxVebAgjvKn
	4zCbJfNZDmo+tgzkRa71igSo9ThCYG6Qmu4C+Llks7lFycFbTjRuXgo8tyicdTizTIvaDKrEixw
	QtQe/Ijq0487TUo5LUgq6DTMdayo/sydQUNYl8Z9csFOKKxpO0HHeXtsYm9perTXmK3XLHQvQ1q
	azz8sKW8BbgigANBaAkCLKzyln3wf1+T1c+gOazHzOdLXyiq6GO4IFxiqVYVGnU5sQhF8DXZCg5
	5xvPe8BJ1WpVQrpePu0t7AUtwEzw==
X-Received: by 2002:a05:7301:22af:b0:2ea:ed3e:13b7 with SMTP id 5a478bee46e88-30153ade874mr1067567eec.7.1778665814199;
        Wed, 13 May 2026 02:50:14 -0700 (PDT)
Received: from [127.0.0.1] ([52.161.178.34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e381c9sm21256407eec.26.2026.05.13.02.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:50:13 -0700 (PDT)
Message-Id: <pull.2301.v2.git.git.1778665812261.gitgitgadget@gmail.com>
In-Reply-To: <pull.2301.git.git.1778623888178.gitgitgadget@gmail.com>
References: <pull.2301.git.git.1778623888178.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 May 2026 09:50:12 +0000
Subject: [PATCH v2] remote: qualify "git pull" advice for non-upstream
 branches
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

When "git status" reports the local branch is behind the push
branch, the advice suggested a bare "git pull". That follows the
upstream, which may live on a different remote, so emit
"git pull <remote> <branch>" instead.

Also enable the pull advice for push-branch comparisons; it was
previously only set for the upstream.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
    remote: qualify "git pull" advice for non-upstream branches
    
    Remove the message only when diverged from push-branch, because it was
    in the way when I used it now on my real branch.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2301%2FHaraldNordgren%2Fstatus-pull-advice-qualified-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2301/HaraldNordgren/status-pull-advice-qualified-v2
Pull-Request: https://github.com/git/git/pull/2301

Range-diff vs v1:

 1:  0a06883cc8 ! 1:  1f06873f82 remote: qualify "git pull" advice for non-upstream branches
     @@ Metadata
       ## Commit message ##
          remote: qualify "git pull" advice for non-upstream branches
      
     -    When "git status" reports the local branch is behind or has diverged
     -    from the push branch, the advice suggested a bare "git pull". That
     -    follows the upstream, which may live on a different remote, so emit
     +    When "git status" reports the local branch is behind the push
     +    branch, the advice suggested a bare "git pull". That follows the
     +    upstream, which may live on a different remote, so emit
          "git pull <remote> <branch>" instead.
      
     -    Also enable the pull and divergence advice for push-branch
     -    comparisons; they were previously only set for the upstream.
     +    Also enable the pull advice for push-branch comparisons; it was
     +    previously only set for the upstream.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       			strbuf_addstr(sb, "\n");
       
      -		if (is_upstream)
     -+		if (is_upstream || is_push) {
     ++		if (is_upstream || is_push)
       			flags |= ENABLE_ADVICE_PULL;
      -		if (is_push)
     -+			if (show_divergence_advice)
     -+				flags |= ENABLE_ADVICE_DIVERGENCE;
     -+		}
     +-			flags |= ENABLE_ADVICE_PUSH;
     + 		if (show_divergence_advice && is_upstream)
     + 			flags |= ENABLE_ADVICE_DIVERGENCE;
      +		if (is_push) {
     - 			flags |= ENABLE_ADVICE_PUSH;
     --		if (show_divergence_advice && is_upstream)
     --			flags |= ENABLE_ADVICE_DIVERGENCE;
     ++			flags |= ENABLE_ADVICE_PUSH;
      +			push_remote_name = pushremote_for_branch(branch, NULL);
      +			if (push_remote_name &&
      +			    skip_prefix(full_ref, "refs/remotes/", &push_branch_name) &&
     @@ remote.c: int format_tracking_info(struct branch *branch, struct strbuf *sb,
       
      
       ## t/t6040-tracking-info.sh ##
     -@@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with diverged push branch' '
     - 
     - 	Your branch and ${SQ}origin/feature8${SQ} have diverged,
     - 	and have 1 and 1 different commits each, respectively.
     -+	  (use "git pull origin feature8" if you want to integrate the remote branch with yours)
     - 
     - 	nothing to commit, working tree clean
     - 	EOF
      @@ t/t6040-tracking-info.sh: test_expect_success 'status.compareBranches with remapped push and upstream remo
       	test_cmp expect actual
       '


 remote.c                 | 44 ++++++++++++++++++++++++++++++++--------
 t/t6040-tracking-info.sh | 40 ++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 9 deletions(-)

diff --git a/remote.c b/remote.c
index a664cd166a..e096fdb674 100644
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
@@ -2396,13 +2412,23 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb,
 		if (reported)
 			strbuf_addstr(sb, "\n");
 
-		if (is_upstream)
+		if (is_upstream || is_push)
 			flags |= ENABLE_ADVICE_PULL;
-		if (is_push)
-			flags |= ENABLE_ADVICE_PUSH;
 		if (show_divergence_advice && is_upstream)
 			flags |= ENABLE_ADVICE_DIVERGENCE;
+		if (is_push) {
+			flags |= ENABLE_ADVICE_PUSH;
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
index 0242b5bf7a..b686bf356a 100755
--- a/t/t6040-tracking-info.sh
+++ b/t/t6040-tracking-info.sh
@@ -646,4 +646,44 @@ test_expect_success 'status.compareBranches with remapped push and upstream remo
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

base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
-- 
gitgitgadget
