From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 07/16] t4019 (diff-wserror): add lots of missing &&
Date: Sat, 25 Sep 2010 13:06:58 -0600
Message-ID: <1285441627-28233-8-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:06:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza4s-0005Xq-4i
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756653Ab0IYTFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:45 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41285 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756596Ab0IYTFm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:42 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so931665pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=71ImvwPjZ6qRZ+lckFOmIhl5y+TB7mKC5MTmXvnjTk4=;
        b=fN+qdbo8EMZK7qfQHvWySTz2F6b6KzuWYtefv5ObygVUUJUmcU4Pldo8+fekT9ceKv
         riN+vqX47JQc4ohexW4NyAAzIGiXFR4jrm6e4Z08M0xl4eBpmli4mCHPe3oNXzSsbqXI
         jBN6oFX5M9b8VrhKrxkt80pS1ltCoajxrMp2w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=FiUz/u9llB5dY9/hUqQObcu1JqFJa/sxFUtFAX0+RvO5wU1don6/HN0DXqJBBtlE4y
         r3Ej/hzWwCTaYb40e7rswhTLJrHFn+M8Op5yRNiwicoRpQxJCnKedJFOaKI8FrFC9i28
         UhULIyAiKhBNZqjeP45LSF5jVohk/TDERyEh0=
Received: by 10.114.120.9 with SMTP id s9mr5670938wac.100.1285441541744;
        Sat, 25 Sep 2010 12:05:41 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.38
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157179>

Also add a test_might_fail in front of the final git_config --unset
core.whitespace as that value may have already been unset previously.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4019-diff-wserror.sh |   52 +++++++++++++++++++++++-----------------------
 1 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/t/t4019-diff-wserror.sh b/t/t4019-diff-wserror.sh
index f6d1f1e..2557ec7 100755
--- a/t/t4019-diff-wserror.sh
+++ b/t/t4019-diff-wserror.sh
@@ -40,7 +40,7 @@ prepare_output () {
 
 test_expect_success default '
 
-	prepare_output
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -52,8 +52,8 @@ test_expect_success default '
 
 test_expect_success 'without -trail' '
 
-	git config core.whitespace -trail
-	prepare_output
+	git config core.whitespace -trail &&
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -65,9 +65,9 @@ test_expect_success 'without -trail' '
 
 test_expect_success 'without -trail (attribute)' '
 
-	git config --unset core.whitespace
-	echo "F whitespace=-trail" >.gitattributes
-	prepare_output
+	git config --unset core.whitespace &&
+	echo "F whitespace=-trail" >.gitattributes &&
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -79,9 +79,9 @@ test_expect_success 'without -trail (attribute)' '
 
 test_expect_success 'without -space' '
 
-	rm -f .gitattributes
-	git config core.whitespace -space
-	prepare_output
+	rm -f .gitattributes &&
+	git config core.whitespace -space &&
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -93,9 +93,9 @@ test_expect_success 'without -space' '
 
 test_expect_success 'without -space (attribute)' '
 
-	git config --unset core.whitespace
-	echo "F whitespace=-space" >.gitattributes
-	prepare_output
+	git config --unset core.whitespace &&
+	echo "F whitespace=-space" >.gitattributes &&
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -107,9 +107,9 @@ test_expect_success 'without -space (attribute)' '
 
 test_expect_success 'with indent-non-tab only' '
 
-	rm -f .gitattributes
-	git config core.whitespace indent,-trailing,-space
-	prepare_output
+	rm -f .gitattributes &&
+	git config core.whitespace indent,-trailing,-space &&
+	prepare_output &&
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -121,9 +121,9 @@ test_expect_success 'with indent-non-tab only' '
 
 test_expect_success 'with indent-non-tab only (attribute)' '
 
-	git config --unset core.whitespace
-	echo "F whitespace=indent,-trailing,-space" >.gitattributes
-	prepare_output
+	git config --unset core.whitespace &&
+	echo "F whitespace=indent,-trailing,-space" >.gitattributes &&
+	prepare_output &&
 
 	grep Eight error >/dev/null &&
 	grep HT normal >/dev/null &&
@@ -135,9 +135,9 @@ test_expect_success 'with indent-non-tab only (attribute)' '
 
 test_expect_success 'with cr-at-eol' '
 
-	rm -f .gitattributes
-	git config core.whitespace cr-at-eol
-	prepare_output
+	rm -f .gitattributes &&
+	git config core.whitespace cr-at-eol &&
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -149,9 +149,9 @@ test_expect_success 'with cr-at-eol' '
 
 test_expect_success 'with cr-at-eol (attribute)' '
 
-	git config --unset core.whitespace
-	echo "F whitespace=trailing,cr-at-eol" >.gitattributes
-	prepare_output
+	git config --unset core.whitespace &&
+	echo "F whitespace=trailing,cr-at-eol" >.gitattributes &&
+	prepare_output &&
 
 	grep Eight normal >/dev/null &&
 	grep HT error >/dev/null &&
@@ -179,11 +179,11 @@ test_expect_success 'trailing empty lines (2)' '
 '
 
 test_expect_success 'do not color trailing cr in context' '
-	git config --unset core.whitespace
+	test_might_fail git config --unset core.whitespace &&
 	rm -f .gitattributes &&
 	echo AAAQ | tr Q "\015" >G &&
 	git add G &&
-	echo BBBQ | tr Q "\015" >>G
+	echo BBBQ | tr Q "\015" >>G &&
 	git diff --color G | tr "\015" Q >output &&
 	grep "BBB.*${blue_grep}Q" output &&
 	grep "AAA.*\[mQ" output
-- 
1.7.3.95.g14291
