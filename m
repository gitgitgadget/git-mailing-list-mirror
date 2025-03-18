Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940492F37
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742303478; cv=none; b=AOWSTypbsUCO7hPePwQIjI8TKUtGn95FSM6WTbTo/jRKiLYK7Lb0E7I9R5HmD9WBwaw6P2rEXixLQ/jlGQhTTzf2z7y7QKtBck1vN0ouKYcG3dmLcHFQArY6vhZjs0gAM/mfUbEhSbZpCD6bfTd9ZEyUVkL9cW3g6Y4MtE8+ShE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742303478; c=relaxed/simple;
	bh=7mPfS5cq5st3zc0RU1KvQmECFkzTfRJEgL0nEzhCvoo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U4bUCuHthHOmcC98Oo8AzJEyDgSUrMOA0ugQnRrbf91XbZbJ/eqKu06nxs/wkL0YZNA+/V1DcZZ7IJ30cs38kdvK6QHs3BVBNv98ixjHyZRj8EeP3xM0+/8LFzxlzC2p5cyy4tAb0ZGgePhGke96OaqTHaGJpHOFOxjL3DjW/3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aynp.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aynp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225df540edcso76162565ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 06:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742303476; x=1742908276;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Axh9l3SRJfNfLD9/e00Dqb4WAems+mXMOEVSh7UhBHI=;
        b=XG7oe74hxqSaiTtRq6VGXYQrNJxa4w9ehL67A2ATK4aGQWcQP9tiGvtBXpdkJQTG5n
         QRqbD9gklXd4y7/Ck35N+WjnoxEH1qgh3hP9McxHSBdCJRY57i+p/PnEBpx8pxNkgcgt
         Q2axbA1tvm6OXlSWIEt5XIJNRiuUT8PGD6l4k4eQPMy5svgUH4Tv0rJVZQSNNOafRvjs
         d6AVX7/YNPW3IAiinsHs4RaUWHIIqQ2JNM+zEL6dLUuMHhDV7S6R8e+3pacntMZTyPWg
         SAZ6jIBQGrcDcj3dC3mFn4RpmrNZRacgISo+Uuu10rpZYdWf6bQ33KOChwHEVhYH8fBi
         rniA==
X-Forwarded-Encrypted: i=1; AJvYcCXbjD6DdPr7g5rb0SXx10mjrgxQRzwybH8bH+wBMYLOC+gePyCzWNq0jKhqJa18PgsUVX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdrkiKSGrrrXPqDdhcLmCjT4EmXTRlRnhSJwEOGPdTF8aY7Xba
	ocAdEOWNNw2pwDttwr8G1Z/pqushFgtaOSNtz2DULOqsdMi6d2yU
X-Gm-Gg: ASbGnculCuD9A8N+y4VeEVPAFWGcAUnN+nRaR7623WBQQSXVVYqTC4bmSRf37w3J/wC
	gj3xna/WN7TozWWVuebRwHhsds0l2aPdR4/HQCPpBeDSWkLJKv/EAOFTwhYSISNZ4xWGFSIgFZQ
	xc1O2e4LWVPZdvGhOtOnZw4CVTD5NUauxbmi7iLKCcjm0RUKNSmyhCN8+jDlb56c3hbnMjUCkEG
	HOaeRyh3klMZnSg0zeRP0LsrgnT7Mun8wom4UCKM8HrcruQqr5hcWee+gXAO2PnpPtXh9h4Fnei
	QU/QxbZ/46b7TrMYor/bRWoqR9hOfONcvW7pelPEmcdcmIj0c437A8LrupHX033PGwUc/sU4fXw
	aifQVPZHgwamPiPOm9cU=
X-Google-Smtp-Source: AGHT+IH/eTIHlVgJYPyTiesmXTHhiiRb3I6MIn4U0/GjaQAT5U+5j0xuz7N1df48dmtJ3TmvLa0Ebg==
X-Received: by 2002:aa7:9312:0:b0:736:bced:f4cf with SMTP id d2e1a72fcca58-737575391e1mr5608219b3a.0.1742303475674;
        Tue, 18 Mar 2025 06:11:15 -0700 (PDT)
Received: from L6X9J4F4CV.flets-east.jp ([2405:6580:9580:2e00:f08d:22ea:59aa:bc50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73711529526sm9440399b3a.24.2025.03.18.06.11.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 06:11:15 -0700 (PDT)
From: Aryan Pathania <contact@aynp.dev>
To: ps@pks.im,
	gitster@pobox.com,
	git@vger.kernel.org
Cc: Aryan Pathania <contact@aynp.dev>
Subject: [GSoC PATCH v2] Use `test_path_*` helper functions instead of `test -[efd]`.
Date: Tue, 18 Mar 2025 22:10:33 +0900
Message-Id: <20250318131033.48691-1-contact@aynp.dev>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250308090358.25429-1-contact@aynp.dev>
References: <20250308090358.25429-1-contact@aynp.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change testcase `gitcvs.enabled = false` to check for missing path
instead of a missing file. The change is justified as new assertion is
stronger.

All other testcases remain equivalent.
---
 t/t9400-git-cvsserver-server.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e499c7f955..4ddde382e8 100755
--- a/t/t9400-git-cvsserver-server.sh
+++ b/t/t9400-git-cvsserver-server.sh
@@ -254,7 +254,7 @@ test_expect_success 'gitcvs.enabled = false' \
      true
    fi &&
    grep "GITCVS emulation disabled" cvs.log &&
-   test ! -d cvswork2'
+   test_path_is_missing cvswork2'
 
 rm -fr cvswork2
 test_expect_success 'gitcvs.ext.enabled = true' '
@@ -276,7 +276,7 @@ test_expect_success 'gitcvs.ext.enabled = false' '
 		true
 	fi &&
 	grep "GITCVS emulation disabled" cvs.log &&
-	test ! -d cvswork2
+	test_path_is_missing cvswork2
 '
 
 rm -fr cvswork2
@@ -285,7 +285,7 @@ test_expect_success 'gitcvs.dbname' '
 	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs.%a.%m.sqlite &&
 	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
 	test_cmp cvswork cvswork2 &&
-	test -f "$SERVERDIR/gitcvs.ext.main.sqlite" &&
+	test_path_is_file "$SERVERDIR/gitcvs.ext.main.sqlite" &&
 	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"
 '
 
@@ -296,8 +296,8 @@ test_expect_success 'gitcvs.ext.dbname' '
 	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
 	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
 	test_cmp cvswork cvswork2 &&
-	test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
-	test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
+	test_path_is_file "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
+	test_path_is_missing "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
 	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs1.ext.main.sqlite"
 '
 
@@ -346,7 +346,7 @@ test_expect_failure "cvs update w/o -d doesn't create subdir (TODO)" '
 	git push gitcvs.git >/dev/null &&
 	cd cvswork &&
 	GIT_CONFIG="$git_config" cvs -Q update &&
-	test ! -d test
+	test_path_is_missing test
 '
 
 cd "$WORKDIR"
@@ -379,7 +379,7 @@ test_expect_success 'cvs update (delete file)' '
 	cd cvswork &&
 	GIT_CONFIG="$git_config" cvs -Q update &&
 	test -z "$(grep testfile1 CVS/Entries)" &&
-	test ! -f testfile1
+	test_path_is_missing testfile1
 '
 
 cd "$WORKDIR"
-- 
2.39.5 (Apple Git-154)

