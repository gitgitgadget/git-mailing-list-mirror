Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7025108
	for <git@vger.kernel.org>; Wed, 17 Jan 2024 19:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705521168; cv=none; b=sxoSN1chYI5yNvIMlFVKWtqlk0n8tWcb9IURIzXgd1ZlRNw28bLA5tRqqXqgMXYb6vOBIJDjYhoN8tktxdYe6JItkZnigpSnDwzyMKHOMshLJSdAagcyRJ2VQ5HV8Vg4lDreiN64fqzCYKxG663KiMtZPRgAx2i0+wrsnyd30Ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705521168; c=relaxed/simple;
	bh=kVBWg0FrE1EkJ8+I5HaO6rlFyN/QYxi2uO0NTIL0Arw=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:
	 Message-ID:In-Reply-To:References:From:Date:Subject:Fcc:
	 Content-Type:Content-Transfer-Encoding:MIME-Version:To:Cc; b=Gm2klxeKOg91HC4wyzAAteGKlB+gWlJcoVpgQwF1xPHH2r5f1hLHEJwvBqZsdJZYKYCr1lB3BW1lKfNM3aZldXd6FwatyUtU3vFu/kbO5vJMrCyJPjaUErvv2fZeyy4CAdhLg66jUIL26uX/Poox19a1kixtsmqrOUtsJO9RZC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4ctK0da; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4ctK0da"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-337c5eb1bddso628747f8f.3
        for <git@vger.kernel.org>; Wed, 17 Jan 2024 11:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705521165; x=1706125965; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e0bQEqAyF1h03Cm8B3/26JgNIdeTN4kBfNthesT/pps=;
        b=e4ctK0daBfuEE04t5aEduMqCgqDWNo0Tp7ha81uuH/4ehT0y7BsSuZ12OfONIvzyXa
         hLUwhD/9TVDMtSe6jX3oOuK/tLNOs0g1gQu5P6czAx99eUZ1bT1K9f2vrZQwDl9dbUH5
         Z08PW7OUoQeyvPRCpuiqnymOSMJKkJO0msZOF8jNrrRqNgTn7hd0cVHeD5VJHg7Qb/PZ
         /hVoA/n9qe4n4puuM+bteEzYQLTeI5iBBkFaEFAEe/PLCgkT9FInrQw3aqO4/6B5ZX2G
         PdKQ6UgeKjoL/JwmVjN7io4gwIm4YZw1jv9z4WCjMJrZEPp/Vc1zvBFgvEbk+O9/QCjO
         Laew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705521165; x=1706125965;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e0bQEqAyF1h03Cm8B3/26JgNIdeTN4kBfNthesT/pps=;
        b=Ht/1aKxW6Mb+B1zqgzlu5UOzM9OmjMM2U6MIJsVyRzPbk1UEm6q7mAOgfB0TP+uGMU
         7DSs1rt/0uEADbov15cpSytBMWJ1EYeuu8mseCP7iGySFGKO6QlOC6RHvjDhDgj7VgHO
         9hG+ucxICi3RP0nbppEkkqFkC3x9qIJfcaMya35tX5ZGEUhT8wul6CEq5QNRyMZuejs5
         tVwMYxVK0nrMQOqxa1Pj13N2bQhL2S1q7ZwBuLEmxFiOaZEA6qhRWof4xy6Xa57GKNFV
         1bFxP3ykYh6lEdDTh/DH2zXjZs+IpX1iGT4ZnVhgWHfpNJc1tZgJ3qqStdvgopDEWFBW
         Lrmg==
X-Gm-Message-State: AOJu0YyyejmMdg8CZIwihSaagUugmHzJytDXHa5ZHj9DcLlbAOtLypkl
	oLBeZSf6MV36bWdM3kW7ClPPcoouRi0=
X-Google-Smtp-Source: AGHT+IF66xHuSCjg07kN2M7G51e8l/6ZJsSmscuQQMNYeMaQrXyfG+pGmdl1GaK677hZM3cFRa4GAQ==
X-Received: by 2002:adf:ed04:0:b0:337:c3cc:5b80 with SMTP id a4-20020adfed04000000b00337c3cc5b80mr687544wro.123.1705521164729;
        Wed, 17 Jan 2024 11:52:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7-20020a5d5747000000b00337be1c7d2fsm2360890wrw.58.2024.01.17.11.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 11:52:44 -0800 (PST)
Message-ID: <56a9c8f20dd7c8f3e9401b2bd3929fb9c53c7d27.1705521155.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Jan 2024 19:52:33 +0000
Subject: [PATCH 10/12] t3903: move reffiles specific tests to t0600
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
Cc: John Cai <johncai86@gmail.com>,
    John Cai <johncai86@gmail.com>

From: John Cai <johncai86@gmail.com>

Move this test into t0600 with other reffiles specific tests since it
modifies reflog refs manually and thus is specific to the reffiles
backend.

This change also consolidates setup_stash() into test-lib-functions.sh

Signed-off-by: John Cai <johncai86@gmail.com>
---
 t/t0600-reffiles-backend.sh | 27 +++++++++++++++++++++++
 t/t3903-stash.sh            | 43 -------------------------------------
 t/test-lib-functions.sh     | 16 ++++++++++++++
 3 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 704b73fdc54..bee61b2d19d 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -527,4 +527,31 @@ test_expect_success SYMLINKS 'ref resolution not confused by broken symlinks' '
        test_must_fail git rev-parse --verify broken
 '
 
+test_expect_success 'drop stash reflog updates refs/stash with rewrite' '
+	git init repo &&
+	(
+		cd repo &&
+		setup_stash
+	) &&
+	echo 9 >repo/file &&
+
+	old_oid="$(git -C repo rev-parse stash@{0})" &&
+	git -C repo stash &&
+	new_oid="$(git -C repo rev-parse stash@{0})" &&
+
+	cat >expect <<-EOF &&
+	$(test_oid zero) $old_oid
+	$old_oid $new_oid
+	EOF
+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	test_cmp expect actual &&
+
+	git -C repo stash drop stash@{1} &&
+	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
+	cat >expect <<-EOF &&
+	$(test_oid zero) $new_oid
+	EOF
+	test_cmp expect actual
+'
+
 test_done
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 34faeac3f1c..0b0e7b19fdc 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -42,22 +42,6 @@ diff_cmp () {
 	rm -f "$1.compare" "$2.compare"
 }
 
-setup_stash() {
-	echo 1 >file &&
-	git add file &&
-	echo unrelated >other-file &&
-	git add other-file &&
-	test_tick &&
-	git commit -m initial &&
-	echo 2 >file &&
-	git add file &&
-	echo 3 >file &&
-	test_tick &&
-	git stash &&
-	git diff-files --quiet &&
-	git diff-index --cached --quiet HEAD
-}
-
 test_expect_success 'stash some dirty working directory' '
 	setup_stash
 '
@@ -200,33 +184,6 @@ test_expect_success 'drop stash reflog updates refs/stash' '
 	test_cmp expect actual
 '
 
-test_expect_success REFFILES 'drop stash reflog updates refs/stash with rewrite' '
-	git init repo &&
-	(
-		cd repo &&
-		setup_stash
-	) &&
-	echo 9 >repo/file &&
-
-	old_oid="$(git -C repo rev-parse stash@{0})" &&
-	git -C repo stash &&
-	new_oid="$(git -C repo rev-parse stash@{0})" &&
-
-	cat >expect <<-EOF &&
-	$(test_oid zero) $old_oid
-	$old_oid $new_oid
-	EOF
-	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
-	test_cmp expect actual &&
-
-	git -C repo stash drop stash@{1} &&
-	cut -d" " -f1-2 repo/.git/logs/refs/stash >actual &&
-	cat >expect <<-EOF &&
-	$(test_oid zero) $new_oid
-	EOF
-	test_cmp expect actual
-'
-
 test_expect_success 'stash pop' '
 	git reset --hard &&
 	git stash pop &&
diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b5eaf7fdc11..68a6c8402d0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1958,3 +1958,19 @@ test_trailing_hash () {
 		test-tool hexdump |
 		sed "s/ //g"
 }
+
+# Stash some changes
+setup_stash() { echo 1 >file &&
+	git add file &&
+	echo unrelated >other-file &&
+	git add other-file &&
+	test_tick &&
+	git commit -m initial &&
+	echo 2 >file &&
+	git add file &&
+	echo 3 >file &&
+	test_tick &&
+	git stash &&
+	git diff-files --quiet &&
+	git diff-index --cached --quiet HEAD
+}
-- 
gitgitgadget

