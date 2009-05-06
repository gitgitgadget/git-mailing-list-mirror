From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: [PATCH] t8005: use egrep when extended regular expressions are required
Date: Wed,  6 May 2009 13:31:42 -0500
Message-ID: <oO0aWq8IlAMsKZ9ZA1BW41Q2yED3E3Gy0etERczi2cjwFaZDei2brNq_BxSt-DnUld4xgNrFZ64@cipher.nrlssc.navy.mil>
Cc: pclouds@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed May 06 20:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1ly9-00074p-UH
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 20:35:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760728AbZEFSfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 14:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759265AbZEFSfi
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 14:35:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:51261 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760396AbZEFSfi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 14:35:38 -0400
Received: by mail.nrlssc.navy.mil id n46IVpEi020104; Wed, 6 May 2009 13:31:51 -0500
X-OriginalArrivalTime: 06 May 2009 18:31:50.0973 (UTC) FILETIME=[EC20A6D0:01C9CE78]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118369>

Not all versions of grep understand backslashed extended regular
expressions.  Possibly only gnu grep does.

Signed-off-by: Brandon Casey <casey@nrlssc.navy.mil>
---
 t/t8005-blame-i18n.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t8005-blame-i18n.sh b/t/t8005-blame-i18n.sh
index 4470a92..fcd5c26 100755
--- a/t/t8005-blame-i18n.sh
+++ b/t/t8005-blame-i18n.sh
@@ -36,7 +36,7 @@ EOF
 test_expect_success \
 	'blame respects i18n.commitencoding' '
 	git blame --incremental file | \
-		grep "^\(author\|summary\) " > actual &&
+		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
 
@@ -53,7 +53,7 @@ test_expect_success \
 	'blame respects i18n.logoutputencoding' '
 	git config i18n.logoutputencoding cp1251 &&
 	git blame --incremental file | \
-		grep "^\(author\|summary\) " > actual &&
+		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
 
@@ -69,7 +69,7 @@ EOF
 test_expect_success \
 	'blame respects --encoding=utf-8' '
 	git blame --incremental --encoding=utf-8 file | \
-		grep "^\(author\|summary\) " > actual &&
+		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
 
@@ -85,7 +85,7 @@ EOF
 test_expect_success \
 	'blame respects --encoding=none' '
 	git blame --incremental --encoding=none file | \
-		grep "^\(author\|summary\) " > actual &&
+		egrep "^(author|summary) " > actual &&
 	test_cmp actual expected
 '
 
-- 
1.6.2.4.24.gde59d2
