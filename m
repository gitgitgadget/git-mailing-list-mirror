Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF27368279
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768235815; cv=none; b=Y2qNrBwsMv5nEpA+ZNM6KJ/lYcaQc2q2NtVpUlJXqo3l8lVFZsARhXz3yVVfuqpHtX8Fd2YaoIXCphuttfhWjCudF7UC6p6njnbIrjUn2j3gqwECbpxyowmxH31xzdXkiflWa/Tg/Y5vUUy4WiQn0GAUxQ8/5hEHW+C3RaEmXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768235815; c=relaxed/simple;
	bh=By9lTbWTFGsYIQRlXqkrdY+XJFXzBdk9Bqzd/ho7WnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgAJyjSLmomR3v5CX76e1IUFtljdKUaQ2scq9+ld0rRtt3xa6EhNG4pIPntNlGHi0h2CNXkkVXd3ofKNmrSkCEotVrVFd/TXe6F1Eu2DpeEUU7I4Vj+2yJc8L2sQGa+vM6l4Y7umFRgPoGJrS1Rcr+Lqb9H22D6hFZiLukTufCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bZ8o8IZo; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bZ8o8IZo"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a137692691so43857325ad.0
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 08:36:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768235814; x=1768840614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWbbW836ubCW9g1F/Shehh1idI2VxLiJfNwzRMeDUng=;
        b=bZ8o8IZo+/bBqfc96mCH5Gfxa/zX7swi2KCKxZcN9KABTlou39htjlmIZyiI9uoOEW
         SNBTNGgahSjyh0bWlGXVNUKFHjpinsebQimkve3oI+pmlJ0pITJ8Wazq84piOTAasD36
         kInvYuilvS+S8JSPPOVnVl+UcJjOA2ffQG5lSwvj8/4fKwOfCT9n8TLfP71s3BqMK0OO
         Q/wAMfGLqwIoK4zA+OSLBbOoAD4NnMDXDXNO+/4aF2KfcsLlcKouZyfRksilbLpLWjVR
         IKYroBprNA7qqQqrYImwigsk79yYv9toaU2uQSXGqWGis9QjdlYpc+GmyE+tmh/r8bIo
         Vjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768235814; x=1768840614;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWbbW836ubCW9g1F/Shehh1idI2VxLiJfNwzRMeDUng=;
        b=NJVN5Ca4HuMOVPCID9fFo7yqfKYrLFo9He3F9x3OoSdqvh5ACR6m07GKFuCieYRdox
         CCvbKiT5JEQKjbeksP9E8zB7SrGUb7K5GAL3jutFs56sheGZWz3RzJIhew+KrjOL4jhi
         3eFwggul5O2OS2zK5vp1HmmXv/mExEJE9efi7GqzqtsP5LJ1uthk0Qb3NkkO4kwaTq14
         V4rDRvwHmE12ZTJfebia0ShPqlRQ4ZgINt2Xam0ta7FHVAGpfAPGUM7308u2M/fWTY3P
         k9ZMzDLiJI2I16Po/T+Lv3cTx45INqq0aGan6RTx8w3296ISWLa0yVmOjhLIWBnbNV7D
         JwLw==
X-Gm-Message-State: AOJu0YwcpEMsxLLv/NrDVWxP248au5U/OseeasvMbhe05DZ7sZveLruQ
	5xPIlfJZtOI6DscFPD58M9qnLldjXysenCyTY3amMvc6MxVpuQuB9By9+2KE8X7n
X-Gm-Gg: AY/fxX7kWUUP3nc5oXSZz82kVwP3Eycws0dI8Ed1l8c0uw6OJJmvbUg9YSTo4u3BDuk
	o1+cD7a6AH0WiiMgMGECr7W2SrTKJN0jTvJ+XvuL0zCJF46c+GDGkYVVzsqiuE7LkAlviuLQpIQ
	lFLhTUUCDT20BuyUAV80vh331aHAH576oC/Rokv3yQ1r70miUR3U5xegFOuSa4vo4qwbHSjWTu8
	zKvDU8wevTD3dOS7stqUbGP1UFP0CsZSANpXTIrfl6fXbvn/NbQadK/lpTcC40DDzy7V0GAbP3c
	unlYpMFL7W6USlLt5Fubjvh3KC9S0lUagqqKzndTQ8Hyg/iG0rySbUq70n4kkNtn3ochNZ6wkXf
	8k0IqfCx/n5wlb0HBXOyw/eW5m+fg8YT9pGmICXHYupXmlfFOUNNCQkRU7ESxjieJ5NkgD1mB4I
	aI2u7w+A+fRkMG2bWgOJIlFbdXE3vbAfUJY016bg8ffV8=
X-Google-Smtp-Source: AGHT+IGGXIC9apT9m6Rxeui4ovYEPOHcvr0w45qE/dp1n0SMCvWisBgomnGd58spSHA65mo63ATMHA==
X-Received: by 2002:a17:902:c406:b0:2a0:9923:6954 with SMTP id d9443c01a7336-2a3ee48fbf3mr158070045ad.27.1768235813432;
        Mon, 12 Jan 2026 08:36:53 -0800 (PST)
Received: from d ([49.43.40.217])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cb2c04sm183006655ad.53.2026.01.12.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 08:36:53 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: deveshigurgaon@gmail.com,
	sunshine@sunshineco.com,
	pushkarkumarsingh1970@gmail.com,
	gitster@pobox.com
Subject: [PATCH v3 1/2] t5403:introduce check_post_checkout helper function
Date: Mon, 12 Jan 2026 16:36:42 +0000
Message-ID: <20260112163643.231-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260112163643.231-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
 <20260112163643.231-1-deveshigurgaon@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The test file repeatedly uses the same four-line pattern to validate
post-checkout hook arguments: read the args file, then test each of
the three values individually.

Introduce a check_post_checkout helper function that encapsulates this
pattern. This patch does not change test behavior; it prepares the
code for improvement in the next step.

Additionally, the 'post-checkout hook is triggered by clone' test is
improved to validate the hook arguments (old ref, new ref, and flag)
rather than just checking that the hook file was created.

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 49 ++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 21 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1462e3365b..7bdea25107 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,6 +9,17 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+# Usage: check_post_checkout <file> <old-ref> <new-ref> <flag>
+#
+# Verify that the post-checkout hook arguments in <file> match the expected
+# values: <old-ref> for the previous HEAD, <new-ref> for the new HEAD, and
+# <flag> indicating whether this was a branch checkout (1) or file checkout (0).
+check_post_checkout () {
+	test "$#" = 4 || BUG "check_post_checkout takes 4 args"
+	read old new flag <"$1" &&
+	test "$old" = "$2" && test "$new" = "$3" && test "$flag" = "$4"
+}
+
 test_expect_success setup '
 	test_hook --setup post-checkout <<-\EOF &&
 	echo "$@" >.git/post-checkout.args
@@ -23,29 +34,30 @@ test_expect_success setup '
 test_expect_success 'post-checkout receives the right arguments with HEAD unchanged ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
 	git checkout main &&
-	read old new flag <.git/post-checkout.args &&
-	test $old = $new && test $flag = 1
+	check_post_checkout .git/post-checkout.args \
+		"$(git rev-parse HEAD)" "$(git rev-parse HEAD)" 1
 '
 
 test_expect_success 'post-checkout args are correct with git checkout -b ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
 	git checkout -b new1 &&
-	read old new flag <.git/post-checkout.args &&
-	test $old = $new && test $flag = 1
+	check_post_checkout .git/post-checkout.args \
+		"$(git rev-parse HEAD)" "$(git rev-parse HEAD)" 1
 '
 
 test_expect_success 'post-checkout receives the right args with HEAD changed ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
+	old=$(git rev-parse HEAD) &&
 	git checkout two &&
-	read old new flag <.git/post-checkout.args &&
-	test $old != $new && test $flag = 1
+	check_post_checkout .git/post-checkout.args \
+		"$old" "$(git rev-parse HEAD)" 1
 '
 
 test_expect_success 'post-checkout receives the right args when not switching branches ' '
 	test_when_finished "rm -f .git/post-checkout.args" &&
 	git checkout main -- three.t &&
-	read old new flag <.git/post-checkout.args &&
-	test $old = $new && test $flag = 0
+	check_post_checkout .git/post-checkout.args \
+		"$(git rev-parse HEAD)" "$(git rev-parse HEAD)" 0
 '
 
 test_rebase () {
@@ -55,10 +67,8 @@ test_rebase () {
 		git checkout -B rebase-test main &&
 		rm -f .git/post-checkout.args &&
 		git rebase $args rebase-on-me &&
-		read old new flag <.git/post-checkout.args &&
-		test_cmp_rev main $old &&
-		test_cmp_rev rebase-on-me $new &&
-		test $flag = 1
+		check_post_checkout .git/post-checkout.args \
+			"$(git rev-parse main)" "$(git rev-parse rebase-on-me)" 1
 	'
 
 	test_expect_success "post-checkout is triggered on rebase $args with fast-forward" '
@@ -66,10 +76,8 @@ test_rebase () {
 		git checkout -B ff-rebase-test rebase-on-me^ &&
 		rm -f .git/post-checkout.args &&
 		git rebase $args rebase-on-me &&
-		read old new flag <.git/post-checkout.args &&
-		test_cmp_rev rebase-on-me^ $old &&
-		test_cmp_rev rebase-on-me $new &&
-		test $flag = 1
+		check_post_checkout .git/post-checkout.args \
+			"$(git rev-parse rebase-on-me^)" "$(git rev-parse rebase-on-me)" 1
 	'
 
 	test_expect_success "rebase $args fast-forward branch checkout runs post-checkout hook" '
@@ -79,10 +87,8 @@ test_rebase () {
 		git checkout two  &&
 		rm -f .git/post-checkout.args &&
 		git rebase $args HEAD rebase-fast-forward  &&
-		read old new flag <.git/post-checkout.args &&
-		test_cmp_rev two $old &&
-		test_cmp_rev three $new &&
-		test $flag = 1
+		check_post_checkout .git/post-checkout.args \
+			"$(git rev-parse two)" "$(git rev-parse three)" 1
 	'
 
 	test_expect_success "rebase $args checkout does not remove untracked files" '
@@ -109,7 +115,8 @@ test_expect_success 'post-checkout hook is triggered by clone' '
 	echo "$@" >"$GIT_DIR/post-checkout.args"
 	EOF
 	git clone --template=templates . clone3 &&
-	test_path_is_file clone3/.git/post-checkout.args
+	check_post_checkout clone3/.git/post-checkout.args \
+		"$(test_oid zero)" "$(git -C clone3 rev-parse HEAD)" 1
 '
 
 test_done
-- 
2.52.0.230.gd8af7cadaa

