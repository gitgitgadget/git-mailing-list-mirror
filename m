From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 07/16] t3600 (rm): add lots of missing &&
Date: Fri, 24 Sep 2010 16:22:47 -0600
Message-ID: <1285366976-22216-8-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:22:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGem-0000n6-Rg
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758237Ab0IXWVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:32 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48207 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758260Ab0IXWVb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:31 -0400
Received: by mail-qy0-f174.google.com with SMTP id 36so1937273qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=jgaIFKbu8YV2C30nwc2Cys+77tAaWbRhR3Hp5l2VNtY=;
        b=ThsGbnz7n76QsnuEWGjcI52J0jc0lMgJFexpXFJk1z3F0dJ44gBLinjTVSzSpEki2z
         v2VBKcmTJ8F+Df+wlsihzoZxpnoZJrpLK0yBRSPu6XxjhRlokvHfhBKHKFPtpBgAN1J7
         AweLEc1LU2GFaMVHViQaOdygkI8TT2slNj19U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rTrEk/PH99fx8zJvMac0E3G7TfbWrOfeGwVqvf1jYM4w5ytG6n0Rb3Fp3mA1yW7S/p
         kaG6HRDUkm10qvlNpL3jwmQI2qZPrqEcLCNRc59ZuKP7HSB2+YA9837CUxV8r9dZh6hG
         aez39GDfGU+O6gM6HVpv+YDZDtax2SE5KLZtg=
Received: by 10.220.126.225 with SMTP id d33mr1181543vcs.111.1285366890614;
        Fri, 24 Sep 2010 15:21:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.28
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:30 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157080>

FIXME: I had to modify a few of the tests to make them pass again.  Are my
modifications okay?  Would a different method be preferred?

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3600-rm.sh |   38 +++++++++++++++++---------------------
 1 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index b26cabd..9660ae0 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -38,37 +38,33 @@ test_expect_success \
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
+    'echo content > foo &&
+     git add foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
+    'echo content > foo &&
+     git add foo &&
+     git commit -m foo &&
+     echo "other content" > foo &&
      git rm --cached foo'
 
 test_expect_success \
     'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+     git checkout HEAD -- foo &&
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      test_must_fail git rm --cached foo
 '
 
 test_expect_success \
     'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content > foo
-     git add foo
-     git commit -m foo
-     echo "other content" > foo
-     git add foo
-     echo "yet another content" > foo
+    'git checkout HEAD -- foo &&
+     echo "other content" > foo &&
+     git add foo &&
+     echo "yet another content" > foo &&
      git rm --cached -f foo'
 
 test_expect_success \
@@ -170,7 +166,7 @@ test_expect_success 'but with -f it should work.' '
 	git rm -f foo baz &&
 	test ! -f foo &&
 	test ! -f baz &&
-	test_must_fail git ls-files --error-unmatch foo
+	test_must_fail git ls-files --error-unmatch foo &&
 	test_must_fail git ls-files --error-unmatch baz
 '
 
@@ -183,7 +179,7 @@ test_expect_success 'refuse to remove cached empty file with modifications' '
 
 test_expect_success 'remove intent-to-add file without --force' '
 	echo content >intent-to-add &&
-	git add -N intent-to-add
+	git add -N intent-to-add &&
 	git rm --cached intent-to-add
 '
 
@@ -201,7 +197,7 @@ test_expect_success 'Recursive without -r fails' '
 '
 
 test_expect_success 'Recursive with -r but dirty' '
-	echo qfwfq >>frotz/nitfol
+	echo qfwfq >>frotz/nitfol &&
 	test_must_fail git rm -r frotz &&
 	test -d frotz &&
 	test -f frotz/nitfol
-- 
1.7.3.95.g14291
