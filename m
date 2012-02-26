From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 1/2] git-p4: remove bash-ism in t9809
Date: Sun, 26 Feb 2012 10:37:26 -0500
Message-ID: <1330270647-8817-2-git-send-email-pw@padd.com>
References: <1330270647-8817-1-git-send-email-pw@padd.com>
Cc: Vitor Antunes <vitor.hda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 26 16:38:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1gAl-0004sC-Am
	for gcvg-git-2@plane.gmane.org; Sun, 26 Feb 2012 16:38:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751199Ab2BZPh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Feb 2012 10:37:59 -0500
Received: from honk.padd.com ([74.3.171.149]:34121 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751159Ab2BZPhu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2012 10:37:50 -0500
Received: from arf.padd.com (unknown [50.55.145.32])
	by honk.padd.com (Postfix) with ESMTPSA id B807724A6;
	Sun, 26 Feb 2012 07:37:49 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 96E41313D8; Sun, 26 Feb 2012 10:37:47 -0500 (EST)
X-Mailer: git-send-email 1.7.9.2.288.g74b75
In-Reply-To: <1330270647-8817-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191565>

Plain old $# works to count the number of arguments in
either bash or dash, even if the arguments have spaces.

Based-on-patch-by: Vitor Antunes <vitor.hda@gmail.com>
Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/t9809-git-p4-client-view.sh |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9809-git-p4-client-view.sh b/t/t9809-git-p4-client-view.sh
index ae9145e..18d93e4 100755
--- a/t/t9809-git-p4-client-view.sh
+++ b/t/t9809-git-p4-client-view.sh
@@ -31,7 +31,7 @@ client_view() {
 #
 check_files_exist() {
 	ok=0 &&
-	num=${#@} &&
+	num=$# &&
 	for arg ; do
 		test_path_is_file "$arg" &&
 		ok=$(($ok + 1))
-- 
1.7.9.2.288.g74b75
