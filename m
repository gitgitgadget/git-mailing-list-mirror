Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB64217F505
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 17:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604547; cv=none; b=tSCSyyQ6gPXlcvGaEaf0FH02VDd/aiJ2Xk5MxnLYE6glqEKJydqEjM5V4dgjdyCnr6CwJowBRpVjKQQsnTxRQKc/u8d12kogww4bUd0MQ5K++3eRQ4chRao384xH1OdfiKh0u1tDTHj1r77jnfRaH1ZlFBy9VyBXtWeoPHY5AZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604547; c=relaxed/simple;
	bh=paJveZDcbGVBMLV8JJYuuHTuj+aVEzGKQBavLGN9REM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ba6JaqFtL8s3bsmsetX0tev5PS/CRH95G32p1gw5o43CmH4aBIHS1ifdUJsgpbc2oaDcyoAH8HyDqs2zX7+aYot2tVz6SwR61ykAzRy9jCF3q1OH0ePX4haMX9DFKgSSW8hPki+9vFjQD4mJKVparKvWb7FmUX90rskguHyrKPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtwajdNC; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtwajdNC"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-720c2db824eso821152b3a.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 09:15:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731604545; x=1732209345; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIJp1pTxifD91vkvjwLE9iVleWuMfYTuhc6kABmzr/Q=;
        b=NtwajdNCZ7Og8MDK0gpyT8rxL3xSoCCtx/mRlUIu35y1eHClEpeH2yE1tWODLlVlNu
         nNsY4PkT/hglBBppknZj7GrVtvvCdY21HzBFN0wNxJmS3GMUJ0N44L9kgZGdZl+uvHW2
         M6SUh0GG+HkdWz1PNSho1KToimDef9lZjybls5wQFWYfAxnhbAwi7JCh3mlHrYjMMH6z
         u8gAu7dxMy9aq1GRawWZ/E1OPxtb9jhs1Tson4xyH5q+FaUuwuYfy3Ky1/HT9oBQIToN
         KnT7MJ4rpFmP3uBADJYdRXSkvlwFxdNigF3fTXn6pdiMfqybKTpBqZFIe7/DrxKowBi7
         g0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604545; x=1732209345;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QIJp1pTxifD91vkvjwLE9iVleWuMfYTuhc6kABmzr/Q=;
        b=EWOEu6iwN0pU2Cc27WriwWfrARxkPT2uNMC6+jQpg5DpnNnxsZA+m4mBsv61mymKPO
         9K0XGJ+XJkBHTh6jaC4YuefdKpjNVXcMnmxQhBwGg6LbWD+PZgC2xH6UqZ1f4lIvt60i
         aP+iHjyuC9nXrchpzp2901v1oYwToJhWhCevF8/jdu5z12vdl7/zYn56i4Bem3AdSC3D
         bv54deuR/8z3kPjy52bOu6DlvNhSIMaHENA1fg+PlrZFQVcCHbRb2h6r/e/PUWzr9LSi
         cC27rOu/sbXeQwT+lBlkNH/slVsHLf7v122wJLs/pQFdmuA+Lq0wYMQG6f5uQti9eU3s
         ZuPw==
X-Gm-Message-State: AOJu0YyHvim2IcHirpdnszYUu/7BU8MasKhpMl09BzS02Iq5k4e40jQ4
	VVC3y+26P9l34JfxC3KVWOQtbc3zakWCzMLwQZy8wQo8GhtT6xO5KbwDIw==
X-Google-Smtp-Source: AGHT+IE2322An+GKLhrcaTQ+Xl8Rm7kjoQnb3ZwH33LF/FcSK9JvR+y1doMYrcirnAaoSBb2o8DOvw==
X-Received: by 2002:a05:6a00:80c:b0:71e:68ae:aaed with SMTP id d2e1a72fcca58-7241325f63fmr31228153b3a.1.1731604544568;
        Thu, 14 Nov 2024 09:15:44 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a9bab91sm1539883b3a.149.2024.11.14.09.15.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:15:44 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Cc: Jiang Xin <zhiyou.jx@alibaba-inc.com>,
	Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v2 1/6] t5548: new test cases for push --porcelain and --dry-run
Date: Fri, 15 Nov 2024 01:15:32 +0800
Message-Id: <7cedfd718c4f2d6fed7420a3341e82c9287d2085.1731603991.git.zhiyou.jx@alibaba-inc.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
References: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com> <cover.1731603991.git.zhiyou.jx@alibaba-inc.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Refactor t5548 and add new test cases for git-push with both --porcelain
and --dry-run flags in order to cover the issues reported by Patrick.

When executing git-push(1) with the "--porcelain" flag, then we will
print updated references in a machine-readable format that looks like
this:

To destination
=   refs/heads/noop:refs/heads/noop [up to date]
!   refs/heads/rejected:refs/heads/rejected [rejected] (atomic push failed)
!   refs/heads/noff:refs/heads/(off (non-fast-forward)
Done

The final "Done" stanza was introduced via 77555854be (git-push: make
git push --porcelain print "Done", 2010-02-26), where it was printed
"unless any errors have occurred". For the purpose of the "Done" line,
knowing a ref will be rejected in a --dry-run does not count as an
error. Actual rejections in non --dry-run pushes do count as errors.

The new test cases will be used in the next commit to protect the above
behaviors of porcelain output of git push.

Reported-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 t/t5548-push-porcelain.sh | 338 ++++++++++++++++++++++++++++----------
 1 file changed, 250 insertions(+), 88 deletions(-)

diff --git a/t/t5548-push-porcelain.sh b/t/t5548-push-porcelain.sh
index ecb3877aa4..ca5cf684bc 100755
--- a/t/t5548-push-porcelain.sh
+++ b/t/t5548-push-porcelain.sh
@@ -4,6 +4,9 @@
 #
 test_description='Test git push porcelain output'
 
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
@@ -56,10 +59,10 @@ format_and_save_expect () {
 }
 
 setup_upstream_and_workbench () {
-	# Upstream  after setup : main(B)  foo(A)  bar(A)  baz(A)
-	# Workbench after setup : main(A)
+	# Upstream  after setup: main(B) foo(A) bar(A) baz(A)
+	# Workbench after setup: main(A)               baz(A) next(A)
 	test_expect_success "setup upstream repository and workbench" '
-		rm -rf upstream.git workbench &&
+		rm -rf upstream.git upstream-backup.git workbench &&
 		git init --bare upstream.git &&
 		git init workbench &&
 		create_commits_in workbench A B &&
@@ -68,19 +71,29 @@ setup_upstream_and_workbench () {
 			# Try to make a stable fixed width for abbreviated commit ID,
 			# this fixed-width oid will be replaced with "<OID>".
 			git config core.abbrev 7 &&
-			git remote add origin ../upstream.git &&
 			git update-ref refs/heads/main $A &&
+			git update-ref refs/heads/baz $A &&
+			git update-ref refs/heads/next $A &&
+			git remote add origin ../upstream.git &&
 			git push origin \
 				$B:refs/heads/main \
 				$A:refs/heads/foo \
 				$A:refs/heads/bar \
 				$A:refs/heads/baz
 		) &&
+		git clone --mirror upstream.git upstream-backup.git &&
 		git -C "workbench" config advice.pushUpdateRejected false &&
 		upstream=upstream.git
 	'
 }
 
+restore_upstream () {
+	test -n "$upstream" &&
+	rm -rf "$upstream" &&
+	git clone --mirror upstream-backup.git "$upstream" &&
+	git -C "$upstream" config http.receivepack true
+}
+
 run_git_push_porcelain_output_test() {
 	case $1 in
 	http)
@@ -96,19 +109,46 @@ run_git_push_porcelain_output_test() {
 	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
 	# Refs of workbench: main(A)                  baz(A)  next(A)
 	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
-	test_expect_success "porcelain output of successful git-push ($PROTOCOL)" '
-		(
-			cd workbench &&
-			git update-ref refs/heads/main $A &&
-			git update-ref refs/heads/baz $A &&
-			git update-ref refs/heads/next $A &&
-			git push --porcelain --force origin \
-				main \
-				:refs/heads/foo \
-				$B:bar \
-				baz \
-				next
-		) >out &&
+	test_expect_success "git-push --porcelain --dry-run ($PROTOCOL)" '
+		test_must_fail git -C workbench push --porcelain --dry-run origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# push             : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git-push --porcelain --dry-run --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --dry-run --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
 		> To <URL/of/upstream.git>
@@ -121,39 +161,137 @@ run_git_push_porcelain_output_test() {
 		EOF
 		test_cmp expect actual &&
 
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git-push --porcelain --dry-run --atomic ($PROTOCOL)" '
+		test_must_fail git -C workbench push --porcelain --dry-run --atomic origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[rejected] (atomic push failed)
+		> !	(delete):refs/heads/foo	[rejected] (atomic push failed)
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> !	refs/heads/next:refs/heads/next	[rejected] (atomic push failed)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# push             : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git-push --porcelain --dry-run --atomic --force ($PROTOCOL)" '
+		git -C workbench push --porcelain --dry-run --atomic --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
+		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
+	'
+
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git-push --porcelain ($PROTOCOL)" '
+		test_when_finished restore_upstream &&
+		test_must_fail git -C workbench push --porcelain origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> Done
+		EOF
+		test_cmp expect actual &&
+
 		git -C "$upstream" show-ref >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
 		<COMMIT-B> refs/heads/bar
 		<COMMIT-A> refs/heads/baz
-		<COMMIT-A> refs/heads/main
+		<COMMIT-B> refs/heads/main
 		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
 	'
 
-	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
-	# git-push         : main(B)  bar(A)  NULL    next(A)
-	test_expect_success "atomic push failed ($PROTOCOL)" '
-		(
-			cd workbench &&
-			git update-ref refs/heads/main $B &&
-			git update-ref refs/heads/bar $A &&
-			test_must_fail git push --atomic --porcelain origin \
-				main \
-				bar \
-				:baz \
-				next
-		) >out &&
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git-push --porcelain --force ($PROTOCOL)" '
+		test_when_finished restore_upstream &&
+		git -C workbench push --porcelain --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
-		To <URL/of/upstream.git>
-		> =	refs/heads/next:refs/heads/next	[up to date]
-		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
-		> !	(delete):refs/heads/baz	[rejected] (atomic push failed)
-		> !	refs/heads/main:refs/heads/main	[rejected] (atomic push failed)
-		Done
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
 		EOF
 		test_cmp expect actual &&
 
@@ -168,34 +306,60 @@ run_git_push_porcelain_output_test() {
 		test_cmp expect actual
 	'
 
-	test_expect_success "prepare pre-receive hook ($PROTOCOL)" '
-		test_hook --setup -C "$upstream" pre-receive <<-EOF
-		exit 1
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git push --porcelain --atomic ($PROTOCOL)" '
+		test_when_finished restore_upstream &&
+		test_must_fail git -C workbench push --porcelain --atomic origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		format_and_save_expect <<-EOF &&
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[rejected] (atomic push failed)
+		> !	(delete):refs/heads/foo	[rejected] (atomic push failed)
+		> !	refs/heads/main:refs/heads/main	[rejected] (non-fast-forward)
+		> !	refs/heads/next:refs/heads/next	[rejected] (atomic push failed)
+		> Done
 		EOF
+		test_cmp expect actual &&
+
+		git -C "$upstream" show-ref >out &&
+		make_user_friendly_and_stable_output <out >actual &&
+		cat >expect <<-EOF &&
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
+		<COMMIT-B> refs/heads/main
+		EOF
+		test_cmp expect actual
 	'
 
-	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
-	# git-push         : main(B)  bar(A)  NULL    next(A)
-	test_expect_success "pre-receive hook declined ($PROTOCOL)" '
-		(
-			cd workbench &&
-			git update-ref refs/heads/main $B &&
-			git update-ref refs/heads/bar $A &&
-			test_must_fail git push --porcelain --force origin \
-				main \
-				bar \
-				:baz \
-				next
-		) >out &&
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "git push --porcelain --atomic --force ($PROTOCOL)" '
+		test_when_finished restore_upstream &&
+		git -C workbench push --porcelain --atomic --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
-		To <URL/of/upstream.git>
-		> =	refs/heads/next:refs/heads/next	[up to date]
-		> !	refs/heads/bar:refs/heads/bar	[remote rejected] (pre-receive hook declined)
-		> !	:refs/heads/baz	[remote rejected] (pre-receive hook declined)
-		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
-		Done
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		>  	<COMMIT-B>:refs/heads/bar	<COMMIT-A>..<COMMIT-B>
+		> -	:refs/heads/foo	[deleted]
+		> +	refs/heads/main:refs/heads/main	<COMMIT-B>...<COMMIT-A> (forced update)
+		> *	refs/heads/next:refs/heads/next	[new branch]
+		> Done
 		EOF
 		test_cmp expect actual &&
 
@@ -210,39 +374,39 @@ run_git_push_porcelain_output_test() {
 		test_cmp expect actual
 	'
 
-	test_expect_success "remove pre-receive hook ($PROTOCOL)" '
-		rm "$upstream/hooks/pre-receive"
-	'
-
-	# Refs of upstream : main(A)  bar(B)  baz(A)  next(A)
-	# Refs of workbench: main(B)  bar(A)  baz(A)  next(A)
-	# git-push         : main(B)  bar(A)  NULL    next(A)
-	test_expect_success "non-fastforward push ($PROTOCOL)" '
-		(
-			cd workbench &&
-			test_must_fail git push --porcelain origin \
-				main \
-				bar \
-				:baz \
-				next
-		) >out &&
+	# Refs of upstream : main(B)  foo(A)  bar(A)  baz(A)
+	# Refs of workbench: main(A)                  baz(A)  next(A)
+	# git-push         : main(A)  NULL    (B)     baz(A)  next(A)
+	test_expect_success "pre-receive hook declined ($PROTOCOL)" '
+		test_when_finished restore_upstream &&
+		test_hook --setup -C "$upstream" pre-receive <<-EOF &&
+			exit 1
+		EOF
+		test_must_fail git -C workbench push --porcelain --force origin \
+			main \
+			:refs/heads/foo \
+			$B:bar \
+			baz \
+			next >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		format_and_save_expect <<-EOF &&
-		To <URL/of/upstream.git>
-		> =	refs/heads/next:refs/heads/next	[up to date]
-		> -	:refs/heads/baz	[deleted]
-		>  	refs/heads/main:refs/heads/main	<COMMIT-A>..<COMMIT-B>
-		> !	refs/heads/bar:refs/heads/bar	[rejected] (non-fast-forward)
-		Done
+		> To <URL/of/upstream.git>
+		> =	refs/heads/baz:refs/heads/baz	[up to date]
+		> !	<COMMIT-B>:refs/heads/bar	[remote rejected] (pre-receive hook declined)
+		> !	:refs/heads/foo	[remote rejected] (pre-receive hook declined)
+		> !	refs/heads/main:refs/heads/main	[remote rejected] (pre-receive hook declined)
+		> !	refs/heads/next:refs/heads/next	[remote rejected] (pre-receive hook declined)
+		> Done
 		EOF
 		test_cmp expect actual &&
 
 		git -C "$upstream" show-ref >out &&
 		make_user_friendly_and_stable_output <out >actual &&
 		cat >expect <<-EOF &&
-		<COMMIT-B> refs/heads/bar
+		<COMMIT-A> refs/heads/bar
+		<COMMIT-A> refs/heads/baz
+		<COMMIT-A> refs/heads/foo
 		<COMMIT-B> refs/heads/main
-		<COMMIT-A> refs/heads/next
 		EOF
 		test_cmp expect actual
 	'
@@ -264,10 +428,8 @@ start_httpd
 setup_upstream_and_workbench
 
 test_expect_success "setup for http" '
-	git -C upstream.git config http.receivepack true &&
 	upstream="$HTTPD_DOCUMENT_ROOT_PATH/upstream.git" &&
-	mv upstream.git "$upstream" &&
-
+	restore_upstream &&
 	git -C workbench remote set-url origin $HTTPD_URL/smart/upstream.git
 '
 
-- 
2.47.0.rc1.21.g81e7bd6151

