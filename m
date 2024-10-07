Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7051D0F78
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 10:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728298315; cv=none; b=jRJdLQqm/Ckh8rRoAzhaDRhCnKxBNSw9jnmVInCR4zJfEqEsKSU+/jGrBwRoFYxInraNsttX7EV7KDflha1+kElboTdy5Jz56lPdvU4+r069TG1ipm3+tVPXNIh0CYJaFQ7lztnQp3SWINkQRg0fxFVLSDYIb7VHkZMBqYWKtD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728298315; c=relaxed/simple;
	bh=irTE3wHcNxBtLca4flBokLSZHpJnSbZtEho09/1yo88=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=aiEBCBIIVC3Hy5zlVncczGF/+NhxYhXuiB52i2ZKStBnBttmYBgigM+LwCT1deQkBxlfWh+/2DUrmUyup9KM3YJSc4x9YZ/Ya7Uc/7/UsGZrTgdlZqJfikrqb+YzjcRFUlyvZpFG1zhUbBfyy7hLz35WaeIRtVp4+zp8GLPZiDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fvoJmXIu; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fvoJmXIu"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9951fba3b4so140216066b.1
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 03:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728298312; x=1728903112; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sn1XmCxJ7qBROXa9Ee3U1brOAIvBwLh7kH6sYmrCCyI=;
        b=fvoJmXIudNtFuQ7e9GhYgSWjHiZY/VE2zmU0WJORjwKshfW18Cd9Ct1Ea5Yy6kr+th
         VgzkB5OmxWLzyrXbhoy+RdejqZMX1Xxzy27VUoRVJTMq7wR3D7nRJTpI29ODaPCY1sXd
         nSv3rfMF85Xst86E4ZXFIAot2cTo89SxdOIc8G+Tw/gTIEIJWLq0tYfWd0AdRCoZ5PQF
         4kUFfbiySZE5XaUp/U9FIfKJdmwSKJWjZUsGk0PAVHnY60FIlY/XjGxJRw+HvdOjv8at
         RKLVCl/A+RTIJHmx4OV2yoCVv3rJa91ZjzsxPQFv3WW4EN+G1bq/e7q6KcBhmmZfTtkV
         e1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728298312; x=1728903112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sn1XmCxJ7qBROXa9Ee3U1brOAIvBwLh7kH6sYmrCCyI=;
        b=MVeQAw2tJdF8pXgbhkhk02o3XP8JSE3V/+rQcKncsr/ljy+qK2EEJOUlxzYqUdY5cp
         9BouU1m8tOi3yQOW07xsIgbl3CxnlKGVD+7kPWRwCZR7mPij7XjgMlm+KuSC0Esdcgal
         Kmtd4+9HUQpnGywhwv2fYi63K95000xXHFsczSYgvTzFUl2EfxJaF6c9qgxWUhNEHC0u
         O3UM6NatXAC1dmQcAhEZPCZtWgz7y7Wa4iIBJJlZVBywt46YKpqL0WfKh3ucvc3rhmpN
         GlDSFC+JT+36zdpc9BtZo0g3025XRSkJ8hKyZK/jb4mOgQxZczZ2cNY/NZbNqxSpsP7O
         avOw==
X-Gm-Message-State: AOJu0Yw6O835cXvs+AxPgcT7Cv/43bFWWk5pMZJkXriVjKI0rZF6W7DS
	4Yllmgl4Lk+Uj7fueRxtW2dP6cNMfynkrwDgN9moNnU2VpbpZyJVGzDp7w==
X-Google-Smtp-Source: AGHT+IEbtjwV1yoyUENsMQb0kbkZoUGZvluCxtX39DISiJ6jawNZV7sDwieC30cZBwKRuYau/cV0dg==
X-Received: by 2002:a17:906:fd86:b0:a8d:5184:d94b with SMTP id a640c23a62f3a-a991bff338cmr1166418166b.49.1728298312129;
        Mon, 07 Oct 2024 03:51:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e5ba412sm371809366b.18.2024.10.07.03.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 03:51:50 -0700 (PDT)
Message-Id: <0ce40300fa32bde27c789fae9e0c642498710a25.1728298308.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
References: <pull.1805.v4.git.git.1728296531.gitgitgadget@gmail.com>
	<pull.1805.v5.git.git.1728298308.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 07 Oct 2024 10:51:48 +0000
Subject: [PATCH v5 2/2] t3404: employing test_line_count() to replace test
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Refactor t3404 to replace instances of `test` with `test_line_count()`
for checking line counts. This improves readability and aligns with Git's
current test practices.

Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 t/t3404-rebase-interactive.sh | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index 96a65783c47..1073eb88fa2 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -281,7 +281,8 @@ test_expect_success 'stop on conflicting pick' '
 	test_cmp expect2 file1 &&
 	test "$(git diff --name-status |
 		sed -n -e "/^U/s/^U[^a-z]*//p")" = file1 &&
-	test 4 = $(grep -v "^#" < .git/rebase-merge/done | wc -l) &&
+	grep -v "^#" < .git/rebase-merge/done >actual &&
+	test_line_count = 4 actual &&
 	test 0 = $(grep -c "^[^#]" < .git/rebase-merge/git-rebase-todo)
 '
 
@@ -401,8 +402,8 @@ test_expect_success 'multi-squash only fires up editor once' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count
+	grep ONCE output >actual &&
+	test_line_count = 1 actual
 '
 
 test_expect_success 'multi-fixup does not fire up editor' '
@@ -416,8 +417,7 @@ test_expect_success 'multi-fixup does not fire up editor' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep NEVER output | wc -l) &&
-	test 0 = $count &&
+	! grep NEVER output &&
 	git checkout @{-1} &&
 	git branch -D multi-fixup
 '
@@ -436,8 +436,8 @@ test_expect_success 'commit message used after conflict' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count &&
+	grep ONCE output >actual &&
+	test_line_count = 1 actual &&
 	git checkout @{-1} &&
 	git branch -D conflict-fixup
 '
@@ -456,8 +456,8 @@ test_expect_success 'commit message retained after conflict' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep TWICE output | wc -l) &&
-	test 2 = $count &&
+	grep TWICE output >actual &&
+	test_line_count = 2 actual &&
 	git checkout @{-1} &&
 	git branch -D conflict-squash
 '
@@ -501,8 +501,8 @@ test_expect_success 'squash ignores comments' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count &&
+	grep ONCE output >actual &&
+	test_line_count = 1 actual &&
 	git checkout @{-1} &&
 	git branch -D skip-comments
 '
@@ -519,8 +519,8 @@ test_expect_success 'squash ignores blank lines' '
 	) &&
 	test $base = $(git rev-parse HEAD^) &&
 	git show >output &&
-	count=$(grep ONCE output | wc -l) &&
-	test 1 = $count &&
+	grep ONCE output >actual &&
+	test_line_count = 1 actual &&
 	git checkout @{-1} &&
 	git branch -D skip-blank-lines
 '
-- 
gitgitgadget
