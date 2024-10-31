Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CF7195F17
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367972; cv=none; b=ShA83ovwh73LPiXfDbFV4xwXLVGj4KLC8xDOqo0j02t3GjE/pINcTWBeH0NwC3DjyNDWKo5FB3YBowir2S2jYilbhfv4PNEN0zO0hFMeZQZLhpHjvJN+He/SeexRWPXGSEskCpLr8gaYj7/uQH6FplEnOCIbyRZOjZtkSelEaLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367972; c=relaxed/simple;
	bh=pckznnRcluQUP6DSKh/PVYFv11LZuTMSdbELeZfTTyo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D/F3LFYqMJ4Mb4TRNLERXfXzKsbQTNSbnybWkxMHeKbM6p+tf3XxCCj3sMn50k1WKyakTFKg8d77CuX557cMwr18kxx0YA7EjiXi3vM6SU4MYglb53L2kuz+TlkueiSmzY/PCWgvkyBdWR+4TXCUHWe19DUJIG7IFkZqMeWFFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mASj3XGa; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mASj3XGa"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9a0f198d38so109757266b.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367968; x=1730972768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2tQKXVruoheor86m/Ttwxt1F2OBeRSpBGTHemUPNvc=;
        b=mASj3XGak/kpn3vP6PXzoef8nARX+h45l7QSQSguW8/LdCt7qOuNS0qJfgKBEdz1gC
         wnuZ6jYn8TtiC/3QNDAITMFyn6FjDB9b2Sh2kUIBEHZoE9zVeTzZUBPCTyL0P51J3xqX
         U9HuVgVU0Reb+I4c3cOIWcAHLnACwPoNXBpK6PIu/PlMjpHEcEtNNsRBWffAh7bXzZxt
         tSdTQaQ+61pOha+u4GhRd8hvMt6EDLc1bw3wsM7DbO0lROpYMim6M/FMBXSJ7uQM0LwS
         ViP60rzsfoP+xQV2Inwt/4tHYu0LvxU1mIhWGm5lx+iTdceufx+gtm4bajxw/QXLepbu
         xmxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367968; x=1730972768;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2tQKXVruoheor86m/Ttwxt1F2OBeRSpBGTHemUPNvc=;
        b=PahK2VH0Qn16ZnfqvkoJLZrzU6kNU4BCP/i86VYKIF/Iaoe/EVFjP+02bUNMfJyzah
         1/wTUEjySBPr/ks7c9+tb+QsZXQfJAylmwX0Tif1NLUYtEndpzx0Ekb4KAJfSF7PJiwf
         CExrfpLJlkyufiKtPOX3WGEEZ26+35Kr0+9ayeAMlwgK52xJGF7VRc72ZKY18XaMXY/i
         BwXdqfxRxN9FURCHQVdpSTusTjN72yPt550YRn2qhrUKpw0bVpXjp02gGgPBSP4r21tn
         3u778alcrqNy5MXFQzJcd9VLrWCxlLN9fwmDkVNXwSYc3oabYu8u0ep98zGGdkWFWveW
         LWoA==
X-Gm-Message-State: AOJu0YwaQJLGYj1WdN6EG0wW46V9IBttI8Ng5ZI+kqhQFa7ents8kgAA
	jwvcOCVU4AtnKUmxb2bvG3iusRcD+NB4FRy/TiR3q+gx8rlhwLWAs55aSODOrRGV5w==
X-Google-Smtp-Source: AGHT+IEi86lT3pOGI7bfTsamE0EKXFe5Fy1ttpP/KwDofYTZlcnwDhoCB9XTd/1bUlFfi1R0NI7cYw==
X-Received: by 2002:a17:906:c112:b0:a99:40e6:157c with SMTP id a640c23a62f3a-a9de5cfea69mr1915131766b.4.1730367967594;
        Thu, 31 Oct 2024 02:46:07 -0700 (PDT)
Received: from localhost.localdomain ([41.217.65.66])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-a9e56684988sm46239166b.215.2024.10.31.02.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:46:07 -0700 (PDT)
From: Seyi Kuforiji <kuforiji98@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	phillip.wood@dunelm.org.uk,
	kristofferhaugsbakk@fastmail.com,
	me@ttaylorr.com,
	Seyi Kuforiji <kuforiji98@gmail.com>
Subject: [PATCH] t9101: Refactor test_expect_success format
Date: Thu, 31 Oct 2024 10:45:53 +0100
Message-ID: <20241031094554.68916-1-kuforiji98@gmail.com>
X-Mailer: git-send-email 2.47.0.86.g15030f9556
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The current script uses an outdated formatting style for
test_expect_success blocks, where each argument is separated by a
backslash and newline. This style can lead to readability issues and
makes it harder to maintain the script.

The modern style consolidates
the multi-line command arguments into a single quoted block, which
improves readability, maintainability, and aligns the code with current
coding standards.

Signed-off-by: Seyi Kuforiji <kuforiji98@gmail.com>
---
 t/t9101-git-svn-props.sh | 48 ++++++++++++++++++++++------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/t/t9101-git-svn-props.sh b/t/t9101-git-svn-props.sh
index b2ee626b9a..792f7896e4 100755
--- a/t/t9101-git-svn-props.sh
+++ b/t/t9101-git-svn-props.sh
@@ -73,12 +73,13 @@ test_expect_success 'initialize git svn' 'git svn init "$svnrepo"'
 test_expect_success 'fetch revisions from svn' 'git svn fetch'
 
 name='test svn:keywords ignoring'
-test_expect_success "$name" \
-	'git checkout -b mybranch remotes/git-svn &&
+test_expect_success "$name" '
+	git checkout -b mybranch remotes/git-svn &&
 	echo Hi again >>kw.c &&
 	git commit -a -m "test keywords ignoring" &&
 	git svn set-tree remotes/git-svn..mybranch &&
-	git pull . remotes/git-svn'
+	git pull . remotes/git-svn
+'
 
 expect='/* $Id$ */'
 got="$(sed -ne 2p kw.c)"
@@ -94,10 +95,11 @@ test_expect_success "propset CR on crlf files" '
 	 )
 '
 
-test_expect_success 'fetch and pull latest from svn and checkout a new wc' \
-	'git svn fetch &&
-	 git pull . remotes/git-svn &&
-	 svn_cmd co "$svnrepo" new_wc'
+test_expect_success 'fetch and pull latest from svn and checkout a new wc' '
+	git svn fetch &&
+	git pull . remotes/git-svn &&
+	svn_cmd co "$svnrepo" new_wc
+'
 
 for i in crlf ne_crlf lf ne_lf cr ne_cr empty_cr empty_lf empty empty_crlf
 do
@@ -110,15 +112,17 @@ cd test_wc
 	printf '$Id$\rHello\rWorld' >ne_cr
 	a_cr=$(printf '$Id$\r\nHello\r\nWorld\r\n' | git hash-object --stdin)
 	a_ne_cr=$(printf '$Id$\r\nHello\r\nWorld' | git hash-object --stdin)
-	test_expect_success 'Set CRLF on cr files' \
-	'svn_cmd propset svn:eol-style CRLF cr &&
-	 svn_cmd propset svn:eol-style CRLF ne_cr &&
-	 svn_cmd propset svn:keywords Id cr &&
-	 svn_cmd propset svn:keywords Id ne_cr &&
-	 svn_cmd commit -m "propset CRLF on cr files"'
+	test_expect_success 'Set CRLF on cr files' '
+		svn_cmd propset svn:eol-style CRLF cr &&
+		svn_cmd propset svn:eol-style CRLF ne_cr &&
+		svn_cmd propset svn:keywords Id cr &&
+		svn_cmd propset svn:keywords Id ne_cr &&
+		svn_cmd commit -m "propset CRLF on cr files"
+	'
 cd ..
-test_expect_success 'fetch and pull latest from svn' \
-	'git svn fetch && git pull . remotes/git-svn'
+test_expect_success 'fetch and pull latest from svn' '
+	git svn fetch && git pull . remotes/git-svn
+'
 
 b_cr="$(git hash-object cr)"
 b_ne_cr="$(git hash-object ne_cr)"
@@ -141,7 +145,7 @@ cat >show-ignore.expect <<\EOF
 /deeply/nested/directory/no-such-file*
 EOF
 
-test_expect_success 'test show-ignore' "
+test_expect_success 'test show-ignore' '
 	(
 		cd test_wc &&
 		mkdir -p deeply/nested/directory &&
@@ -155,7 +159,7 @@ no-such-file*
 	) &&
 	git svn show-ignore >show-ignore.got &&
 	cmp show-ignore.expect show-ignore.got
-"
+'
 
 cat >create-ignore.expect <<\EOF
 /no-such-file*
@@ -170,7 +174,7 @@ cat >create-ignore-index.expect <<EOF
 100644 $expectoid 0	deeply/nested/directory/.gitignore
 EOF
 
-test_expect_success 'test create-ignore' "
+test_expect_success 'test create-ignore' '
 	git svn fetch && git pull . remotes/git-svn &&
 	git svn create-ignore &&
 	cmp ./.gitignore create-ignore.expect &&
@@ -179,7 +183,7 @@ test_expect_success 'test create-ignore' "
 	cmp ./deeply/nested/directory/.gitignore create-ignore.expect &&
 	git ls-files -s >ls_files_result &&
 	grep gitignore ls_files_result | cmp - create-ignore-index.expect
-	"
+'
 
 cat >prop.expect <<\EOF
 
@@ -207,7 +211,7 @@ test_expect_success 'test propget' '
 	test_propget svn:ignore nested/ ../prop.expect &&
 	test_propget svn:ignore ./nested ../prop.expect &&
 	test_propget svn:ignore .././deeply/nested ../prop.expect
-	'
+'
 
 cat >prop.expect <<\EOF
 Properties on '.':
@@ -225,12 +229,12 @@ Properties on 'nested/directory/.keep':
   svn:entry:uuid
 EOF
 
-test_expect_success 'test proplist' "
+test_expect_success 'test proplist' '
 	git svn proplist . >actual &&
 	cmp prop.expect actual &&
 
 	git svn proplist nested/directory/.keep >actual &&
 	cmp prop2.expect actual
-	"
+'
 
 test_done
-- 
2.47.0.86.g15030f9556

