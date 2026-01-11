Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E12C238C08
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 07:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768116614; cv=none; b=tUEf59q133D7Fhe0hNg35Y8kH4wDGcaZowxl1gxI6fkByKbpy6MBoDNcNebUt3AzFsAfbUFYVouCbqv8oL7hAuieTOydh1I5O0jYApeBs8hJ6YlothdEVuBgdw5saWFoedzG704LM+IMMkpEXqepihbpK7AR5Cc8jNy5ZTt4IV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768116614; c=relaxed/simple;
	bh=pmHcVnMhETITZvBKt3eF8vP4DjNyi4cA5hLQ3OXbLyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=refOVBTBce1sCdh2arK2v/Z27XGyqJL2q/FlkBeWks4aUJIMr7M5zi0H2ybJCV1rxun/Yx+o7H60DazFg+9bjWoUtI05oejrFo/fyjAD0PkPVUEyeBNLib3DpPzmHlKhOq7p/TCACpoLbGCEE56LhcNXn6BQuI5ywBa88+5GYls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O+OrUAIS; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O+OrUAIS"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-bbf2c3eccc9so1734041a12.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 23:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768116610; x=1768721410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ar29bfA/Ewj+GQ2TNhPyV8FIfCkNHA891lFDKES/fdY=;
        b=O+OrUAISD3oQH1w8/iK0R093/t6WgMSyK7KCFqtarnOxl7bG2XSRC/l4eYfkVKLaHy
         MM7dgdGH6u7KZsMEa0tyRtdkK0SpTW848ncKqSMqmr8jhAayWTIBe0P8fNsvqkOoidaV
         sn7dMp+mVxXUVb8L2/iwHKpkIOeItx1T6u5xEOcKcfd7p0bw2cgg+dSySxdfVtNkzZvK
         EvPMKMgTptyM58t7uduSzx3jAnfzU+OTXOzWFG2FU4HNfxqkNJKG2uLLvXfxk3lP8yd5
         GxsnaLvW3MZsgLoj/ointv75r9jShueuhDKUUW4p0pJlwIkk+mK7LKOLk2d9V4IZqwTQ
         v4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768116610; x=1768721410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ar29bfA/Ewj+GQ2TNhPyV8FIfCkNHA891lFDKES/fdY=;
        b=qpHRzK1/h4KFJC6u7vJQRXAfBzv+YK0PvVSe9xnZNhgccY2M40ymCL/k76OSwPMEpk
         5rDkGWf+xp/PijyeyjH4tFyUwVyEoRAJULb+ObgyC4B1v38lxRExXFZRT8Z3poAIRv01
         9tdrX02F4ZbsjQcZ2mKwifWuPlXA5IFg4OMBoiv37ZwhlWRUSr0ukRLqcTUncn/ewoTd
         fIyuP0dR9XNC/ayAg+SAdL16W+5NMXOve/fwycgaNKqlW1ZqfFOt83qDymvVGgx3t0RP
         Ivpr4MzMe8l1D203wGYSCxOiGFOripk8hOhvC6EDsdCUul4aR5S/bAs44ZdCI5oBulT9
         s6sA==
X-Gm-Message-State: AOJu0YwNUU4qjFWYW3x4TIHcdsIDIHMRk49c20QPaTsyx8XbiHpFLanA
	pL2wLF8EZvHpj0hmmY1l+EkCQEmSb+zwlwJtaniLYtF+xGSyd70l78ftj6oPhEMh
X-Gm-Gg: AY/fxX7DEEGkqJ6YAjXCjg6aZzs774lzHnQa94lNUIwIxrklwbqZV5/fLrsVlO51dLR
	9uEOUX1iTponjFE6V07DV8U9zBxHTFaa5cZHbj7jFSlYnm4BzK66l2bAYS8tJ0yq42yWuP2Ompf
	jD89SAC4Z/bIIOzbTqukzieRN1VihcSe6O8DBbvAKn1PVNtcJyAuuQiI/Adj642Wvy1FzfIktzX
	0sz/yAR7/UD+Ele9hiATZmL2nFcLWJ7rkUSN0r2WPPu4o5+4xhYwjWtS2vMWauJcRuOAGPKrPgd
	ZBF9yzB6tHw63xOypTMhlsqz5YcXA9WjOWO1LckunnN5J+tlpdHCi9oh9SzASodc72M5rcHb72o
	cFqAM7xo3vPbF/j/c4TqSP6oxdwKmUr9F7Syp+jgyaKxS+J6NXIiV2ABQBNy8HrPrwqcMUVRahW
	oRC+wog0HfBcdIFm3c0Hl951VQFCiKHUmU
X-Google-Smtp-Source: AGHT+IGD1p7hQw6N9k+U9AWeVQLzsGwWJStuuOfiqXmO+MZ0TXBAXharhxoHenzzczCpb67W2g/9JQ==
X-Received: by 2002:a05:6a20:3d95:b0:35d:3533:3dd2 with SMTP id adf61e73a8af0-3898e64dc17mr14295866637.0.1768116609776;
        Sat, 10 Jan 2026 23:30:09 -0800 (PST)
Received: from d ([49.43.40.217])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c4cc8d292fcsm14177619a12.20.2026.01.10.23.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 23:30:09 -0800 (PST)
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
To: git@vger.kernel.org
Cc: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Subject: [PATCH 1/2] t5403:introduce check_post_checkout helper function
Date: Sun, 11 Jan 2026 07:29:49 +0000
Message-ID: <20260111072950.9463-2-deveshigurgaon@gmail.com>
X-Mailer: git-send-email 2.52.0.230.gd8af7cadaa
In-Reply-To: <20260111072950.9463-1-deveshigurgaon@gmail.com>
References: <20260111072950.9463-1-deveshigurgaon@gmail.com>
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

Signed-off-by: Deveshi Dwivedi <deveshigurgaon@gmail.com>
---
 t/t5403-post-checkout-hook.sh | 45 +++++++++++++++++++----------------
 1 file changed, 24 insertions(+), 21 deletions(-)

diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
index 1462e3365b..63a2221441 100755
--- a/t/t5403-post-checkout-hook.sh
+++ b/t/t5403-post-checkout-hook.sh
@@ -9,6 +9,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+# Helper function to check post-checkout hook arguments
+check_post_checkout () {
+	test "$#" = 4 || BUG "check_post_checkout takes 4 args"
+	read old new flag <"$1" &&
+	test "$old" = "$2" && test "$new" = "$3" && test "$flag" = "$4"
+}
+
 test_expect_success setup '
 	test_hook --setup post-checkout <<-\EOF &&
 	echo "$@" >.git/post-checkout.args
@@ -23,29 +30,30 @@ test_expect_success setup '
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
@@ -55,10 +63,8 @@ test_rebase () {
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
@@ -66,10 +72,8 @@ test_rebase () {
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
@@ -79,10 +83,8 @@ test_rebase () {
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
@@ -109,7 +111,8 @@ test_expect_success 'post-checkout hook is triggered by clone' '
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

