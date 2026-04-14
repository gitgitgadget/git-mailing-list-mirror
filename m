Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F5F3BB57
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 14:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776176342; cv=none; b=Tf9ewR3IFNa0pvpp5uM0NWFY4rK01H9pQ4ynwgn/7ifcE85HSxYl4F35kSfO8q/DgFlGpNev93B09w3qFbPzvYtOWtzoGpx8NLO3t918ncWaZ+b4mhVcufTqqV1cSA9c8BHmikQeZ29tKB8MRQtxmDmVzUHenvf4lEcAw/bKVO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776176342; c=relaxed/simple;
	bh=icG7JULuLtkOJ30YQoZIct2gBOEnJrCh2tk6bZt+bOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qETtGx1ZLj/0J4/kVV+wM/tv+4Lzrrn2oP2eHc6kabZAYQLnpVJql4kELpbDFRTexCKpDdEXd8OQFYPToKPG6WGxolYMcAU/JeBJmhOVIgOMyC8fO/K0OqPtLqXr+SG5crLaqleb0o19hRZdK7OdZXMXR4G4pbJi5uLunJfO/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KaRejJMJ; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KaRejJMJ"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82cd5c07f93so2473816b3a.1
        for <git@vger.kernel.org>; Tue, 14 Apr 2026 07:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776176340; x=1776781140; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Yn4RIxGbdFcaFoildEH3jozObbRaTT+YBVGVFqJl/8=;
        b=KaRejJMJDOPIfTJpU6lI8UZCxAXJGdZ7Hd9oNAS/HNgTsCc74zvxdiT57P3/N2z27J
         OOZx5vQZgUS702nuMM/+xqLyxyTh4TL+hoAzzw20Aqkho2ukccyWFOiu9Qdh9hZQPmG3
         iBfX/4C5Wi6g+bKZ8xHP4ulPoJm9PPu5HJ9dIUnOV1w+Z8gcDzwbtJg89vjKNl3+rTs9
         6+8I6f5DjEJrTxTTKlRIw2UlVXWkzMAVwfmKUD+4g1z1HC+JcLhdZgdDA1FQ6fWsq2b9
         pm882dO0e6jqjaBkQnfFC5pFvU/ID48QCM6dhNmjVYb/cMOnJuKTssHNV8ZpuOYtrROB
         F2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776176340; x=1776781140;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Yn4RIxGbdFcaFoildEH3jozObbRaTT+YBVGVFqJl/8=;
        b=QqAElnOaStzc4PpAxvQe5eqCG4Mzgf5B+fawJ8BUoA4R+hpAW+/U6jnhcOn3q9Zbwi
         P6VUoJAY1MuXoOSDaE1gu4F0Gv2XpRUHCJFrfregw6KKUSo8X3q8rCSrAjOA8o8INz2a
         eHK3kcGOyhgdRiKTYgtSbrKtLboCLXaErhiBfGGg/JlgLw7lt8jPBqWxL6iQUDch7rjS
         q1I8m0JLH28sqwWzhxInCS8RnqsLgX6Y0N6Y3up0kC4+j3If1S3VpE35o7lOYE1pNgJE
         gjuTP0dvXFHWM9RDzp9cCc2RdLX1ebgNlvkqD1JcfhMvX9inuNNwvq2cVjWQhGrhEoI+
         qQcw==
X-Gm-Message-State: AOJu0YxImaxeNtl8yAq8u7imzFbKtJS4Genz6P/ejfmsJQeycOw8STv5
	lKf88ZkU1bFeV2ycOKXAZO6YXes3Fvegbr2fIqT3tA5hORJg01ngfM2WY8Ehng==
X-Gm-Gg: AeBDietuhuJISktELfG997Gu69ml5yYJdsCq6u0K4GHSfCkOR9pJyZZDg743FCsSV/e
	L+YWUfvBAeQrkpkfDHsKbaLEThVOW1ZXR+h3lc9m3xeesW1c68vGRs+6sJgYAw9b0WpCIEeZGJL
	aBHmyuEyv4rHmGt4PGwPhNf7GX8bHnYa6cEFbV3EKqCFau0UjXaJbDdHcLSdtsM0D4ELQygNjmM
	w7SxL+lXt8YkMULyDb5CZ5l1Tb4OPjl7wdkn4XdDWNH2z01W/N2Fv8Q8b3a1AWmE0cS3r9FmiKY
	vf6kl2wNePVPF75pdNr/ZLyOgbFgZrxKZg/jJMGhIEU6PWNb/4xkO/AWoOH+2sVrcNeB4aJvdBL
	fGnV5wnk334QTFIWBI5LOHJigOAUkGTCW4EDcPKhpHj8MSClVkaKoBFgnJtmKGxNpfmPpj/6Swm
	ftFHTBdQcK1eTbpiLqu9AzcqyuN+C3IYbUDy5fPLrX6P+cMrHtDUzzAnXexR1QIdu8aEFBJ+QPd
	inHajrJzn0wy5F7FplW30ZQKa7dWAzTsCmdlihVyvbxqpy2nE7Cu0K4hF8VHBfVeA==
X-Received: by 2002:a05:6a00:94fa:b0:82f:592f:2eda with SMTP id d2e1a72fcca58-82f592f35c4mr2072151b3a.43.1776176339605;
        Tue, 14 Apr 2026 07:18:59 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:79f3:3c56:74cd:64f0:3838:afaa])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c30ee32sm15145048b3a.7.2026.04.14.07.18.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 14 Apr 2026 07:18:59 -0700 (PDT)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	abdobngad@gmail.com,
	ps@pks.im,
	bence@ferdinandy.com,
	john.a.passaro@gmail.com,
	r.siddharth.shrimali@gmail.com
Subject: [PATCH 3/3] t7004: avoid subshells to capture git exit codes
Date: Tue, 14 Apr 2026 19:48:28 +0530
Message-ID: <20260414141828.27576-4-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
References: <20260414141828.27576-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Several tests in t7004 use the 'test$(git ...) = ...' or the '! (git ...)'
subshell pattern. This swallows git's exit code. If git crashes
(e.g. segmentation fault) the crash would go undetected, and the test
would fail due to a mismatch or an inverted exit code.

Modernize these tests by directly writing output to files(actual) and
verifying them with 'test_cmp' or 'test_grep'. Replace subshell
negations with 'test_must_fail'. This way, if git crashes, the test
fails immediately and clearly instead of hiding the error behind a
string mismatch.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
 t/t7004-tag.sh | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 4fdd47cd21..e8c59c9105 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -155,8 +155,10 @@ test_expect_success 'Multiple -l or --list options are equivalent to one -l opti
 '
 
 test_expect_success 'listing all tags if one exists should output that tag' '
-	test $(git tag -l) = mytag &&
-	test $(git tag) = mytag
+	git tag -l >actual &&
+	test_grep "^mytag$" actual &&
+	git tag >actual &&
+	test_grep "^mytag$" actual
 '
 
 # pattern matching:
@@ -166,11 +168,15 @@ test_expect_success 'listing a tag using a matching pattern should succeed' '
 '
 
 test_expect_success 'listing a tag with --ignore-case' '
-	test $(git tag -l --ignore-case MYTAG) = mytag
+	echo mytag >expect &&
+	git tag -l --ignore-case MYTAG >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'listing a tag using a matching pattern should output that tag' '
-	test $(git tag -l mytag) = mytag
+	echo mytag >expect &&
+	git tag -l mytag >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'listing tags using a non-matching pattern should succeed' '
@@ -427,8 +433,12 @@ test_expect_success 'listing tags -n in column with column.ui ignored' '
 
 test_expect_success 'a non-annotated tag created without parameters should point to HEAD' '
 	git tag non-annotated-tag &&
-	test $(git cat-file -t non-annotated-tag) = commit &&
-	test $(git rev-parse non-annotated-tag) = $(git rev-parse HEAD)
+	echo commit >expect &&
+	git cat-file -t non-annotated-tag >actual &&
+	test_cmp expect actual &&
+	git rev-parse HEAD >expect &&
+	git rev-parse non-annotated-tag >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'trying to verify an unknown tag should fail' '
@@ -1517,11 +1527,11 @@ test_expect_success GPG 'verify signed tag fails when public key is not present'
 '
 
 test_expect_success 'git tag -a fails if tag annotation is empty' '
-	! (GIT_EDITOR=cat git tag -a initial-comment)
+	test_must_fail env GIT_EDITOR=cat git tag -a initial-comment
 '
 
 test_expect_success 'message in editor has initial comment' '
-	! (GIT_EDITOR=cat git tag -a initial-comment >actual)
+	test_must_fail env GIT_EDITOR=cat git tag -a initial-comment >actual
 '
 
 test_expect_success 'message in editor has initial comment: first line' '
-- 
2.51.2

