Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D22EB32E732
	for <git@vger.kernel.org>; Wed, 28 Jan 2026 21:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769636410; cv=pass; b=mn36MC34LyktNqfaFUyKkylIHlAmTLgD0oGqKwLK5MNGSyjKeVYjlu+h2NqLKnN6BcxMDV3IG2P2xHR9Fyh7J0bhxbMy3U0MN3wGtch7neRHNd5+5TqnrPrA19+AxpL0ui2yROFsT9Kqhp4FSg1jmx7qiNTShQ8HnrEogo30Icc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769636410; c=relaxed/simple;
	bh=p/taxJLAtQep2vugKs67EtqBxEOiI+1DrwGYhxby+4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jmzgacB/rHfY/P9Aii83reqqn2hPpJiURMNpG1PGBsLSXCCgZs6TMRRcP7DZ5ABNMgR64Al93kRPcHCSoS2pHsp1RujrmFvwDIah+ZUyw4aNfqJh+XCAuZlo+NrBAkEeEqXUSWbsEP36Fd2cJ4vTXeYiT5z3JRIvDDxkSXhgNWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=NW0OnQR7; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="NW0OnQR7"
ARC-Seal: i=1; a=rsa-sha256; t=1769636393; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Cx/V0s53ECWcSlBBbF6dgMOSfUNIhkgK1KQklG4uGXLdLHpgOeoRK1oyZU5LilZVys/3utZM5D7ezH1s61Pe46VzSv/6cfm855WF7TCAlwyxxvFRhGmZ5w87oX4SHR3aeRitNoZUQpPmOd+JYGCvRZDfM8v0Yao9zXplVRXBgjg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769636393; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=98LHmeuRBaUWeFWZsqST6kSl6IjseCUkABxdHpyPpZA=; 
	b=eT91RJOGHpqPSgUX2u5+okK8BvLUqtNZRMN5JWAx/mhHk3I/rh7Q8NCHy1bSLjWF1mX0Unz9qBoClsKxFF1Ys0bnqD7sg7OKH5CR3XgRY775e4mDH2Q/7+ius4KRw8Ze8RxHuMUtE0/b08ZH8J5IFfhtEvA5oViK/V39Ebt5uVk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769636393;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=98LHmeuRBaUWeFWZsqST6kSl6IjseCUkABxdHpyPpZA=;
	b=NW0OnQR7ReXwcWmiXTGymZKWwkMw6Nmv/kxwebCd/Oieg2z6XWDDO8zNlIbIrsM9
	55I/KtkU1/emFLShuoowX9awS8AEzMpU71Nl7SfHZR5GRf1LdZJDMraX4D9rmVJL6XR
	0/NNp5549tisvwmKIY7VfOdT/xMS5ROehguWcm0c=
Received: by mx.zohomail.com with SMTPS id 1769636391077323.8517311439741;
	Wed, 28 Jan 2026 13:39:51 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v8 01/12] t1800: add hook output stream tests
Date: Wed, 28 Jan 2026 23:39:16 +0200
Message-ID: <20260128213927.3026875-2-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260128213927.3026875-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260128213927.3026875-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Lack of test coverage in this area led to some regressions while
converting the remaining hooks to the newer hook.[ch] API.

Add some tests to verify hooks write to the expected output streams.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 t/t1800-hook.sh | 137 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 137 insertions(+)

diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
index 4feaf0d7be..ed28a2fadb 100755
--- a/t/t1800-hook.sh
+++ b/t/t1800-hook.sh
@@ -184,4 +184,141 @@ test_expect_success 'stdin to hooks' '
 	test_cmp expect actual
 '
 
+check_stdout_separate_from_stderr () {
+	for hook in "$@"
+	do
+		# Ensure hook's stdout is only in stdout, not stderr
+		test_grep "Hook $hook stdout" stdout.actual || return 1
+		test_grep ! "Hook $hook stdout" stderr.actual || return 1
+
+		# Ensure hook's stderr is only in stderr, not stdout
+		test_grep "Hook $hook stderr" stderr.actual || return 1
+		test_grep ! "Hook $hook stderr" stdout.actual || return 1
+	done
+}
+
+check_stdout_merged_to_stderr () {
+	for hook in "$@"
+	do
+		# Ensure hook's stdout is only in stderr, not stdout
+		test_grep "Hook $hook stdout" stderr.actual || return 1
+		test_grep ! "Hook $hook stdout" stdout.actual || return 1
+
+		# Ensure hook's stderr is only in stderr, not stdout
+		test_grep "Hook $hook stderr" stderr.actual || return 1
+		test_grep ! "Hook $hook stderr" stdout.actual || return 1
+	done
+}
+
+setup_hooks () {
+	for hook in "$@"
+	do
+		test_hook $hook <<-EOF
+		echo >&1 Hook $hook stdout
+		echo >&2 Hook $hook stderr
+		EOF
+	done
+}
+
+test_expect_success 'client hooks: pre-push expects separate stdout and stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote &&
+	git remote add origin remote &&
+	test_commit A &&
+	setup_hooks pre-push &&
+	git push origin HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_separate_from_stderr pre-push
+'
+
+test_expect_success 'client hooks: commit hooks expect stdout redirected to stderr' '
+	hooks="pre-commit prepare-commit-msg \
+		commit-msg post-commit \
+		reference-transaction" &&
+	setup_hooks $hooks &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git checkout -B main &&
+	git checkout -b branch-a &&
+	test_commit commit-on-branch-a &&
+	git commit --allow-empty -m "Test" >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr $hooks
+'
+
+test_expect_success 'client hooks: checkout hooks expect stdout redirected to stderr' '
+	setup_hooks post-checkout reference-transaction &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git checkout -b new-branch main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-checkout reference-transaction
+'
+
+test_expect_success 'client hooks: merge hooks expect stdout redirected to stderr' '
+	setup_hooks pre-merge-commit post-merge reference-transaction &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	test_commit new-branch-commit &&
+	git merge --no-ff branch-a >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-merge-commit post-merge reference-transaction
+'
+
+test_expect_success 'client hooks: post-rewrite hooks expect stdout redirected to stderr' '
+	setup_hooks post-rewrite reference-transaction &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git commit --amend --allow-empty --no-edit >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-rewrite reference-transaction
+'
+
+test_expect_success 'client hooks: applypatch hooks expect stdout redirected to stderr' '
+	setup_hooks applypatch-msg pre-applypatch post-applypatch &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git checkout -b branch-b main &&
+	test_commit branch-b &&
+	git format-patch -1 --stdout >patch &&
+	git checkout -b branch-c main &&
+	git am patch >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr applypatch-msg pre-applypatch post-applypatch
+'
+
+test_expect_success 'client hooks: rebase hooks expect stdout redirected to stderr' '
+	setup_hooks pre-rebase &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git checkout -b branch-d main &&
+	test_commit branch-d &&
+	git checkout main &&
+	test_commit diverge-main &&
+	git checkout branch-d &&
+	git rebase main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-rebase
+'
+
+test_expect_success 'client hooks: post-index-change expects stdout redirected to stderr' '
+	setup_hooks post-index-change &&
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	oid=$(git hash-object -w --stdin </dev/null) &&
+	git update-index --add --cacheinfo 100644 $oid new-file \
+	    >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr post-index-change
+'
+
+test_expect_success 'server hooks expect stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init --bare remote-server &&
+	git remote add origin-server remote-server &&
+	cd remote-server &&
+	setup_hooks pre-receive update post-receive post-update &&
+	cd .. &&
+	git push origin-server HEAD:new-branch >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr pre-receive update post-receive post-update
+'
+
+test_expect_success 'server push-to-checkout hook expects stdout redirected to stderr' '
+	test_when_finished "rm -f stdout.actual stderr.actual" &&
+	git init server &&
+	git -C server checkout -b main &&
+	test_config -C server receive.denyCurrentBranch updateInstead &&
+	git remote add origin-server-2 server &&
+	cd server &&
+	setup_hooks push-to-checkout &&
+	cd .. &&
+	git push origin-server-2 HEAD:main >stdout.actual 2>stderr.actual &&
+	check_stdout_merged_to_stderr push-to-checkout
+'
+
 test_done
-- 
2.52.0.732.gb351b5166d.dirty

