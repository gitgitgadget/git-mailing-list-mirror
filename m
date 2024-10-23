Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D27B1AB6F1
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 12:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729685484; cv=none; b=Tg1qBd3L6eQyywyQIJQYbB8CQs39vDe6fd3zgaMG6jvD7c8BmbCd7aQTAwnE7iFZGERpWpcnTdhbdMR+vvu2WNoFbip/2XXaxcu8XZh0w+Bky/ecEjSRB+vZgm+wsSmwzfQDjstc7/x6nnbRtiTzuXcofNRGCiyO6l4KvICp884=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729685484; c=relaxed/simple;
	bh=jXNRoXZxMh8m85UlmkzeYHWs92yFe3jAmJq8Zy2DWVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QJqTO3Fdj2pHpoaytYAkRqS4KF9O9cZmsyuktEgl/SqSWMkWRGc/SET8i6bQGe0U4t6pRMcJq2VSUwQqYrKFVcAydLnCt29O6Qk4vlhA42uVmCp/LpFvsNZXRsjBOS6PgdwADqUvx3D6pDmMD16KGU+sDVGVWN8e4dDnru//QLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cEZbu2fy; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEZbu2fy"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4315eac969aso5739435e9.1
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 05:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729685480; x=1730290280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4Gun0ThqNehbN78XjbxW/TVsq64QEsMTrLgiVcxt+8=;
        b=cEZbu2fyeYkD9GJWpU6ANegfEnqYMGvHh/DASX9vLhrWnCVZleGj0/eRiqDAUmrPPm
         ts4PNaK3p58xyO4ojTBp4FLN3v4pRO6Zp0CqvhtpVXpG+CZURV7Ixh/RRiioEwZTFWkL
         JpUYFsuQN8aref6YAldE53xRNGBxzsG9vL+IcyDk+n7yxVTSos6TzO12CvY1ofO6nutv
         NSmu0Rn4hlJNQ6XFzuf8wDIlmwqGPOmnT3ovrvzBFgIvY25szt5LKs6ADGBq8QzzF8I6
         tHi/f53i/BepznSaKOdVoRfONQyo6iunKbbMF9VXSonbblTl/vVlh9YIVdni9bz/oaKI
         c/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729685480; x=1730290280;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4Gun0ThqNehbN78XjbxW/TVsq64QEsMTrLgiVcxt+8=;
        b=hgrUrEWp8G+4OTuDCPuvU0O1CTD7Hdi1s6MInb+lP/Wqm4WsXTnKlTqEmkWwuUJCFa
         O6xe2JtBuOyJ2ZBGFegWBBBSZAj/QJ+umWIr0uW7N+pVdqzetjCB8AvHoloY2JKm9W0G
         6gNgQr0jctkLXOl8FfH0YzRnvxHsn1DBWmKa5VhrAHJtxdv7PTLkPFX+razpdigVWmmU
         u4EqMwSU60/kTNncaWcFn6dpwtu0fPd//QyJwUN+ujvH5/5eeXf5Z9O0jQsQOEcq2GOc
         iFoh79Qxzx3tebe0iKo046XiKvYOuMSvn/JKw2WaNkQW3hT70nx+UB7vpjcFOXCuZ7DG
         xF1w==
X-Gm-Message-State: AOJu0YwWj6z5tnt+Y0GQKGR28YYkYzUT9mzXkIRDbsM5E2cNexJi6sYH
	5yQ56jIXZGrxLBXrv/5jrGL2PfQTOZv3DwCU7D+cpdRfYz/AQjpnlCE46I9gmqir/Q==
X-Google-Smtp-Source: AGHT+IGH79AU+/T83Z6RL9EWPoWTlrNdw1jvHYaODnWSHtSxTHcnLGcbkv8PdLDi9UNVFkXXU2hXLQ==
X-Received: by 2002:a05:600c:4ec7:b0:42c:baf1:4c7 with SMTP id 5b1f17b1804b1-4317bd7701cmr41933765e9.4.1729685480219;
        Wed, 23 Oct 2024 05:11:20 -0700 (PDT)
Received: from localhost.localdomain ([154.118.59.16])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37ee0b9bb42sm8713594f8f.98.2024.10.23.05.11.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 05:11:19 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	kristofferhaugsbakk@fastmail.com,
	me@ttaylorr.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH Outreachy] t9101: ensure no whitespace after redirect
Date: Wed, 23 Oct 2024 13:11:12 +0100
Message-ID: <20241023121113.915310-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This change updates the script to conform to the coding
standards outlined in the Git project's documentation. According to the
guidelines in Documentation/CodingGuidelines under "Redirection
operators", there should be no whitespace after redirection operators.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/t9101-git-svn-props.sh | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index 52046e60d5..b2ee626b9a 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -21,32 +21,32 @@ a_empty_cr=
 a_empty_crlf=
 
 cd import
-	cat >> kw.c <<\EOF
+	cat >>kw.c <<\EOF
 /* Somebody prematurely put a keyword into this file */
 /* $Id$ */
 EOF
 
-	printf "Hello\r\nWorld\r\n" > crlf
+	printf "Hello\r\nWorld\r\n" >crlf
 	a_crlf=$(git hash-object -w crlf)
-	printf "Hello\rWorld\r" > cr
+	printf "Hello\rWorld\r" >cr
 	a_cr=$(git hash-object -w cr)
-	printf "Hello\nWorld\n" > lf
+	printf "Hello\nWorld\n" >lf
 	a_lf=$(git hash-object -w lf)
 
-	printf "Hello\r\nWorld" > ne_crlf
+	printf "Hello\r\nWorld" >ne_crlf
 	a_ne_crlf=$(git hash-object -w ne_crlf)
-	printf "Hello\nWorld" > ne_lf
+	printf "Hello\nWorld" >ne_lf
 	a_ne_lf=$(git hash-object -w ne_lf)
-	printf "Hello\rWorld" > ne_cr
+	printf "Hello\rWorld" >ne_cr
 	a_ne_cr=$(git hash-object -w ne_cr)
 
 	touch empty
 	a_empty=$(git hash-object -w empty)
-	printf "\n" > empty_lf
+	printf "\n" >empty_lf
 	a_empty_lf=$(git hash-object -w empty_lf)
-	printf "\r" > empty_cr
+	printf "\r" >empty_cr
 	a_empty_cr=$(git hash-object -w empty_cr)
-	printf "\r\n" > empty_crlf
+	printf "\r\n" >empty_crlf
 	a_empty_crlf=$(git hash-object -w empty_crlf)
 
 	svn_cmd import --no-auto-props -m 'import for git svn' . "$svnrepo" >/dev/null
@@ -57,10 +57,10 @@ test_expect_success 'checkout working copy from svn' 'svn co "$svnrepo" test_wc'
 test_expect_success 'setup some commits to svn' '
 	(
 		cd test_wc &&
-		echo Greetings >> kw.c &&
+		echo Greetings >>kw.c &&
 		poke kw.c &&
 		svn_cmd commit -m "Not yet an Id" &&
-		echo Hello world >> kw.c &&
+		echo Hello world >>kw.c &&
 		poke kw.c &&
 		svn_cmd commit -m "Modified file, but still not yet an Id" &&
 		svn_cmd propset svn:keywords Id kw.c &&
@@ -75,7 +75,7 @@ test_expect_success 'fetch revisions from svn' 'git svn fetch'
 name='test svn:keywords ignoring'
 test_expect_success "$name" \
 	'git checkout -b mybranch remotes/git-svn &&
-	echo Hi again >> kw.c &&
+	echo Hi again >>kw.c &&
 	git commit -a -m "test keywords ignoring" &&
 	git svn set-tree remotes/git-svn..mybranch &&
 	git pull . remotes/git-svn'
@@ -106,8 +106,8 @@ done
 
 
 cd test_wc
-	printf '$Id$\rHello\rWorld\r' > cr
-	printf '$Id$\rHello\rWorld' > ne_cr
+	printf '$Id$\rHello\rWorld\r' >cr
+	printf '$Id$\rHello\rWorld' >ne_cr
 	a_cr=$(printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin)
 	a_ne_cr=$(printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin)
 	test_expect_success 'Set CRLF on cr files' \
@@ -126,7 +126,7 @@ b_ne_cr="$(git hash-object ne_cr)"
 test_expect_success 'CRLF + $Id$' "test '$a_cr' = '$b_cr'"
 test_expect_success 'CRLF + $Id$ (no newline)' "test '$a_ne_cr' = '$b_ne_cr'"
 
-cat > show-ignore.expect <<\EOF
+cat >show-ignore.expect <<\EOF
 
 # /
 /no-such-file*
@@ -153,7 +153,7 @@ no-such-file*
 ' . &&
 		svn_cmd commit -m 'propset svn:ignore'
 	) &&
-	git svn show-ignore > show-ignore.got &&
+	git svn show-ignore >show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
 "
 
-- 
2.47.0.86.g15030f9556

