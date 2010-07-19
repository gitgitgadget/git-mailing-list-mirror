From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
Subject: [PATCH 2/2] Improve "move the whole tree into a subdirectory" example.
Date: Tue, 20 Jul 2010 00:17:18 +0300
Message-ID: <1279574238-16649-2-git-send-email-ville.skytta@iki.fi>
References: <1279574238-16649-1-git-send-email-ville.skytta@iki.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 19 23:17:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OaxiK-0001K9-1H
	for gcvg-git-2@lo.gmane.org; Mon, 19 Jul 2010 23:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966815Ab0GSVRV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jul 2010 17:17:21 -0400
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:36254 "EHLO
	filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966797Ab0GSVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jul 2010 17:17:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri5.pp.htv.fi (Postfix) with ESMTP id AD9B35A60F1
	for <git@vger.kernel.org>; Tue, 20 Jul 2010 00:17:19 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
	by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
	with ESMTP id vQ927TWtvFcI for <git@vger.kernel.org>;
	Tue, 20 Jul 2010 00:17:19 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs181085020.pp.htv.fi [82.181.85.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp5.welho.com (Postfix) with ESMTPS id 46FE55BC003
	for <git@vger.kernel.org>; Tue, 20 Jul 2010 00:17:19 +0300 (EEST)
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1279574238-16649-1-git-send-email-ville.skytta@iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151285>

Using "/" as the sed substitution delimiter is less likely to clash
with desired subdirectory names than "-".
---
 Documentation/git-filter-branch.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 020028c..a90e2dd 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -354,11 +354,12 @@ git filter-branch ... C..H --not D
 git filter-branch ... D..H --not C
 ----------------------------------------
 
-To move the whole tree into a subdirectory, or remove it from there:
+To move the whole tree into a subdirectory named newsubdir, or remove
+it from there:
 
 ---------------------------------------------------------------
 git filter-branch --index-filter \
-	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
+	'git ls-files -s | sed "s/\t\"*/&newsubdir\//" |
 		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
 			git update-index --index-info &&
 	 mv $GIT_INDEX_FILE.new $GIT_INDEX_FILE' HEAD
-- 
1.7.1.1
