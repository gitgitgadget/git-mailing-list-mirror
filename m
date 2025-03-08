Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182A1891A8
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 09:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741424662; cv=none; b=OiaCTg3lQ6GtKlzeDpmNBtbQ0c9RoPW9yK4SaCLOhPDPU5YYJaRhtAkCwqAbQE3FfcoI2BgjLnN2etEiD6/vgtGjTLTiGkkMR84UncLrmtoGVfjv0rmPkpRKSD7iYmAAEq2jR9V0umiP7OXLA/YYiIeMnDUeYjLDEBbMH0PMLgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741424662; c=relaxed/simple;
	bh=bVsM5iic+aR4X/xK9j4mQcE9vpLY88AztfN7US7suiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IvErFMGgTrMx0+emH/lJj4CP5JJH6QCSkF+dh5ck2v03Sclv2PZjc5DZtvViKgYGyG3/kkf6EnrLlU4vIo/SJ3xIL0GM72ULnj5Mg+UiQOpQeDgdm5YU6mPwof1tOin4cjsPpI6ZsgoNqDCbZ8riXqv9fv9ceOp229aCV+v6TBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aynp.dev; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=aynp.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2239aa5da08so43431305ad.3
        for <git@vger.kernel.org>; Sat, 08 Mar 2025 01:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741424659; x=1742029459;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1XoVyYhouY45nzsXIQbXW1kvJ2EPPxr9Ni/O2dcbZ3E=;
        b=T6bmnxG7j4vewe/5iaexn8UFEXK6AAnlB/4MgQ08JtAor1naoQjGjzIZsFctedyS9C
         Yg7d7EgMHVD9sRicNZDKypXxv2wMd1RBZuKgPMu804vJe61wDCGXRQ2kxK4GdvPH1S46
         O3lXXgAmkVYYYuzXKaTQjPnT8rPWDBQ5jf1C+E6ZcxUOqgu/RE/hMY8H6SBtk9uacZky
         /Icfrmsmb9zWrF/ktny+A06gZMVjwvwIFiPjnhE0q8ZmnRVcBc+HS+P8mtv8JVNXqZX1
         huvAJZ+BPDk0LvaYNGB+crdX+ruczY+mL7b43AsCV2alNCol6MFAEJdFVEmIiJEEn676
         5iZw==
X-Gm-Message-State: AOJu0YxUPz93+AozkU7dr1ocLAHk+Hzp7fgXzm2YrtmQy+QtNNm37XVD
	sc8uvhPPj7cl4WKczI4xFoOaUx/ReRhGOI0k7Xrc5zXFwuL9UOVDeARPrFuna5viMA==
X-Gm-Gg: ASbGncvsoR3QsEkUIh9vzPHL8hXn3lDyfkVlNcXXVhhromslo2qliERYUdH2EOk0Wnq
	4rZaAdKcqj6CBKArHjCI5BKwFFJSE8eXXh94v/yIHE/12reCR0MCLchKIVOq/iOwKmN3CzX3llg
	EbbWGOSv6NJ83nysM1BtgEtMbJbAVTLtppGbQJ7QfL9vcAEbggxnFp1zarFfmj5EPtbCsRoCdB/
	aMoqQ0rvMXZqedoTLuOPCtd6u0ri+3JAlYfsmqgV7Szm9dScsI5KuQ3t5Cf3PX3EQmAdx3ADnfk
	Vq+2bJQ1mr2/M60rKx4BK3WqdaV0ND4m9eeWLDgE9eWkU5RGDkTvNzqjfdC/w0oMXd1j474w8dq
	Yvvujn+EO
X-Google-Smtp-Source: AGHT+IFbNkVLPPfe3pICY+EhVoT+5DQsjZajY2SC3Ak7Pj19cFelqrhJbiCy98J5QJC8z9RtQeGNgw==
X-Received: by 2002:a05:6a21:103:b0:1f3:3c5d:cd7e with SMTP id adf61e73a8af0-1f544b229eemr12215497637.24.1741424659347;
        Sat, 08 Mar 2025 01:04:19 -0800 (PST)
Received: from L6X9J4F4CV.flets-east.jp ([2405:6580:9580:2e00:5475:f9d8:3afa:33f3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810768a8sm3620894a12.4.2025.03.08.01.04.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 08 Mar 2025 01:04:18 -0800 (PST)
From: Aryan Pathania <contact@aynp.dev>
To: git@vger.kernel.org
Cc: Aryan Pathania <contact@aynp.dev>
Subject: [GSoC PATCH] t9400: prefer test_path_* helper functions
Date: Sat,  8 Mar 2025 18:03:58 +0900
Message-Id: <20250308090358.25429-1-contact@aynp.dev>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

use `test_path_*` instead of `test -[efd]` to avoid false complaints and
output when running the script with `-v` or `-x`

Signed-off-by: Aryan Pathania <contact@aynp.dev>
---
 t/t9400-git-cvsserver-server.sh | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
index e499c7f955..6c7cb1964c 100755
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
+	test_path_is_file_not_symlink "$SERVERDIR/gitcvs.ext.main.sqlite" &&
 	cmp "$SERVERDIR/gitcvs.main.sqlite" "$SERVERDIR/gitcvs.ext.main.sqlite"
 '
 
@@ -296,8 +296,8 @@ test_expect_success 'gitcvs.ext.dbname' '
 	GIT_DIR="$SERVERDIR" git config gitcvs.dbname %Ggitcvs2.%a.%m.sqlite &&
 	GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 main >cvs.log 2>&1 &&
 	test_cmp cvswork cvswork2 &&
-	test -f "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
-	test ! -f "$SERVERDIR/gitcvs2.ext.main.sqlite" &&
+	test_path_is_file_not_symlink "$SERVERDIR/gitcvs1.ext.main.sqlite" &&
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

