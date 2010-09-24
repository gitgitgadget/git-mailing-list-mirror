From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 08/16] t4019 (diff-wserror): add lots of missing &&
Date: Fri, 24 Sep 2010 16:22:48 -0600
Message-ID: <1285366976-22216-9-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGen-0000n6-DO
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758266Ab0IXWVf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:35 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48207 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753710Ab0IXWVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:33 -0400
Received: by mail-qy0-f174.google.com with SMTP id 36so1937273qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=8SdTeh/XmZbPLMBKPeoiAnSQt1GhDqgzLQaSGYIC2mo=;
        b=EXd+Rh6kZHteZXybo3iTZjClE583e1hfIFtnTmdb+pkqxIavuJFxJpgLWpjBPQzXCm
         zpXb6bPWyynsBxYSfKIDPWxNhYBE4btV1hb+XT+eO3sJ5hGy/WN47GME1PPWCIEsZ+O7
         0ADUKm/XBKzCQQRXWeIvJcDTGbi3Ox0DC9NNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=do+J4DVFdj4AwAOAoLmVVkBCMV77iNGVKXgcNEnvKbPhUMZO9TQrhA7v21TT5Rk8U4
         NrE+oOzOyI1usuhnHcO1Qk9G4s9/2o1hFlttxSTia0AW7G2nLTpkTym3ziDHtuDJSdpJ
         VAcXmd5ulndQgcSf1GJeHNTMQ9V7T0Hlz+R7w=
Received: by 10.220.34.13 with SMTP id j13mr1124456vcd.176.1285366892747;
        Fri, 24 Sep 2010 15:21:32 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.30
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157079>

FIXME: I had to add a test_might_fail in front of the final git_config
--unset as well.  Is it intended that it be okay for it to fail?

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
