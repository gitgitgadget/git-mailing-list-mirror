From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 11/11] t6050-replace: use some long option names
Date: Sat, 31 Aug 2013 21:12:14 +0200
Message-ID: <20130831191215.26699.76207.chriscool@tuxfamily.org>
References: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 21:14:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqcV-0001Jf-1F
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 21:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754837Ab3HaTNj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 15:13:39 -0400
Received: from [194.158.98.15] ([194.158.98.15]:48176 "EHLO mail-2y.bbox.fr"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754766Ab3HaTNf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Aug 2013 15:13:35 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id C0B267B;
	Sat, 31 Aug 2013 21:12:55 +0200 (CEST)
X-git-sha1: 2b49a6bac2bcc3c53f599698e1e8d883cd5c6833 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130831190528.26699.33964.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233541>

So that they are tested a litlle bit too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 0b07a0b..5dc26e8 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -122,9 +122,9 @@ test_expect_success '"git replace" listing and deleting' '
      test "$HASH2" = "$(git replace -l)" &&
      test "$HASH2" = "$(git replace)" &&
      aa=${HASH2%??????????????????????????????????????} &&
-     test "$HASH2" = "$(git replace -l "$aa*")" &&
+     test "$HASH2" = "$(git replace --list "$aa*")" &&
      test_must_fail git replace -d $R &&
-     test_must_fail git replace -d &&
+     test_must_fail git replace --delete &&
      test_must_fail git replace -l -d $HASH2 &&
      git replace -d $HASH2 &&
      git show $HASH2 | grep "A U Thor" &&
@@ -147,7 +147,7 @@ test_expect_success '"git replace" resolves sha1' '
      git show $HASH2 | grep "O Thor" &&
      test_must_fail git replace $HASH2 $R &&
      git replace -f $HASH2 $R &&
-     test_must_fail git replace -f &&
+     test_must_fail git replace --force &&
      test "$HASH2" = "$(git replace)"
 '
 
@@ -278,7 +278,7 @@ test_expect_success 'replaced and replacement objects must be of the same type'
 
 test_expect_success '-f option bypasses the type check' '
 	git replace -f mytag $HASH1 2>err &&
-	git replace -f HEAD^{tree} HEAD~1 2>err &&
+	git replace --force HEAD^{tree} HEAD~1 2>err &&
 	git replace -f HEAD^ $BLOB 2>err
 '
 
-- 
1.8.4.rc1.31.g530f5ce.dirty
