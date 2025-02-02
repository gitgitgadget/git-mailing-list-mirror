Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50ACD1CDA2F
	for <git@vger.kernel.org>; Sun,  2 Feb 2025 12:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738498182; cv=none; b=TY8R1cqQ2zpehSLrSQ/s0YCEANTBVjChSW9Wmt3GNVsfAZgbNdgRvbrwtKIXI9i8Q6X+cwvmb/98wsY1ZHSsHXkmozD3uAvKwLeECsvZlG4hUESrJjRb1ULAtIa/FtuUotfF2zrLsVn3l6IG7CIy8tXxVZVRopqhkPBXHwH4juQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738498182; c=relaxed/simple;
	bh=z09vNCfTwIvzHMStuoGQByS5ZMSF0coCpC7JuZglBq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nui/vttqOu1lbTOdMNOzhrna3lXGvIw4veKR9wcPaObejJOKjJmVDRbaeaS2ZhaJv7KlNUf3bBNGxtpA8ip77x5wfNP06twWvpzdKSMid9CnvD/CtuCTiXgSVenWcDyEA4ZYTNhsDMTtf2XqOgcnTnwaQsZI1lkeL3V1RoiTa4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H1vIWwnr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H1vIWwnr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-216728b1836so56766915ad.0
        for <git@vger.kernel.org>; Sun, 02 Feb 2025 04:09:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738498180; x=1739102980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9VWn0nUPss7jmyvUjESt3K3puGK8DOax26a6HQ7S+RE=;
        b=H1vIWwnrRLVfKVRerMX4bA9DrH+9z48j4tI6uT6qXE435+v86kH060XRTxE6CwoeuH
         XoKi/MM5c61j8CKkJU+lEVxMabwu6raFoO1detUCi1boEL2KxK9nSvpJP31vWjAWsPKV
         6K6IXyHbemoLLRmOlUCD1HZ8LkW4CY2nxcvx4MZ2BR66GSlagG2zIKTyuBERqgjpJnK6
         xcduWyENUhUeQ0sLMfrqYbGJCxmA88hge8W2SfFS6Z1SFjAQ7/7/TZ9qxeJzEbppKJRI
         SOVROFB7gbUPUrxFKLjAiOBFmDAkoi3znB7JYZRK8Xflbcok+iUNGIs21yhi329XxU3I
         YnuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738498180; x=1739102980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9VWn0nUPss7jmyvUjESt3K3puGK8DOax26a6HQ7S+RE=;
        b=h8LI70soUF6O6pbMZIEOoI43ls98q8KONDygmS0xBJpsphX69/2WjioFlbJ1t18Zjh
         5qxbN9pssvOiIvRoKmfDIyMw4FzMCXXRe+DxG/m9XJHZjksMN5qRp5TcDDlJhZcO+oAH
         UPUbu90rMtP02mQWpnJ3PKvTja5UCv0UjWdS4qrZiRYBUssXpfbISZLiF8MmRYKhxGDa
         8I9izKuBmWhhfVPb0N45y8UckYTVpOy6qsacPKgqYr5qFb9nOZ90neAlY4R2glFAUJdF
         RsGI7p2L/xcHaY/aTBQRCT3lq5jIoqYfvrPAmsplImvxF5XqRixKI9h1ipmKpsZB8+bI
         poDg==
X-Gm-Message-State: AOJu0Yyzlp24ad30ruvyB2QY81px135wttjaeKQB+7JlEi777iJ1PTN1
	fDdVl8vASiU5AaLLjNH/J7ru2/elbVNxvTPIW3vM3iLDiqH5rI1FZXACzqrsHRGDTA==
X-Gm-Gg: ASbGncsWddGVIz0o+aqAPzFtnJyfPgerZY16rxhLs2NG3kmCvUlqEASb5d51Rcml9bh
	QrIY6seTcBY7swB66FQpdlqqNgSRA9K10rbHRnkZLqh4m59eQyAIkCBYmSTKeBzoAQzxCJtXSza
	EUM049YKbEDqTBaCeeeKN8KjFqE7G/bKHqIMnWE8KO+sDOWalO/EXUT2CDYxHBYhvdJYnxgosIg
	8icVtk2omJ30VCj0iopSoHvv25/oP+cTLGNfs1FeASODBmISZatP6Kb1QtkLAfdz/jxwwo5FKJp
	vbSQsUlfdKVqU6q9p5sdlRc096tKGOXk
X-Google-Smtp-Source: AGHT+IGom50g6/VcXERkftocTlEk1Nv7F5b9JEOLLspmMZ/Iy1AngBPt7WcYy4BkT3y6i5RCShQdDw==
X-Received: by 2002:a05:6a21:516:b0:1e1:9f57:eab4 with SMTP id adf61e73a8af0-1ed7a5f9036mr28950984637.16.1738498180129;
        Sun, 02 Feb 2025 04:09:40 -0800 (PST)
Received: from bl4ze-rig.iitr.ac.in ([103.37.201.222])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe631bf73sm6452720b3a.36.2025.02.02.04.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2025 04:09:39 -0800 (PST)
From: ayu-ch <ayu.chandekar@gmail.com>
To: git@vger.kernel.org
Cc: =gitster@pobox.com,
	Ayush Chandekar <ayu.chandekar@gmail.com>
Subject: [PATCH] t6423: fix suppression of Git’s exit code in tests
Date: Sun,  2 Feb 2025 17:39:26 +0530
Message-ID: <20250202120926.322417-1-ayu.chandekar@gmail.com>
X-Mailer: git-send-email 2.48.GIT
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ayush Chandekar <ayu.chandekar@gmail.com>

Some test in t6423 supress Git's exit code, which can cause test
failures go unnoticed. Specifically using git <subcommand> |
<other-command> masks potential failures of the Git command.

This commit ensures that Git's exit status is correctly propogated by:
- Avoiding pipes that suppress exit codes.

Signed-off-by: Ayush Chandekar <ayu.chandekar@gmail.com>
---
 t/t6423-merge-rename-directories.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t6423-merge-rename-directories.sh b/t/t6423-merge-rename-directories.sh
index 88d1cf2cde..94080c65d1 100755
--- a/t/t6423-merge-rename-directories.sh
+++ b/t/t6423-merge-rename-directories.sh
@@ -5071,7 +5071,8 @@ test_expect_success '12i: Directory rename causes rename-to-self' '
 		test_path_is_file source/bar &&
 		test_path_is_file source/baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual &&
+		uniq <actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
@@ -5129,7 +5130,8 @@ test_expect_success '12j: Directory rename to root causes rename-to-self' '
 		test_path_is_file bar &&
 		test_path_is_file baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual &&
+		uniq <actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
@@ -5187,7 +5189,8 @@ test_expect_success '12k: Directory rename with sibling causes rename-to-self' '
 		test_path_is_file dirA/bar &&
 		test_path_is_file dirA/baz &&
 
-		git ls-files | uniq >tracked &&
+		git ls-files >actual &&
+		uniq <actual >tracked &&
 		test_line_count = 3 tracked &&
 
 		git status --porcelain -uno >actual &&
-- 
2.48.GIT

