From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 11/11] t6050-replace: use some long option names
Date: Tue, 03 Sep 2013 09:10:25 +0200
Message-ID: <20130903071026.29838.37918.chriscool@tuxfamily.org>
References: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Philip Oakley <philipoakley@iee.org>,
	Thomas Rast <trast@inf.ethz.ch>, Johannes Sixt <j6t@kdbg.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:17:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGkrs-0008AL-Nw
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:17:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550Ab3ICHRa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:17:30 -0400
Received: from mail-2y.bbox.fr ([194.158.98.15]:45667 "EHLO mail-2y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932542Ab3ICHRV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:17:21 -0400
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-2y.bbox.fr (Postfix) with ESMTP id 090CE7D;
	Tue,  3 Sep 2013 09:17:21 +0200 (CEST)
X-git-sha1: 5bf34fff3186254d7254583675d10ddf98df989b 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20130903070551.29838.43576.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233692>

So that they are tested a little bit too.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t6050-replace.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index 622b751..1fe5c1b 100755
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
 	git replace -f mytag $HASH1 &&
-	git replace -f HEAD^{tree} HEAD~1 &&
+	git replace --force HEAD^{tree} HEAD~1 &&
 	git replace -f HEAD^ $BLOB
 '
 
-- 
1.8.4.rc1.31.g530f5ce.dirty
