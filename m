From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 5/5] submodule: use git rev-parse -q
Date: Wed,  3 Dec 2008 14:26:52 +0100
Message-ID: <c3a20382adecc78a12c9cf1bff9beb102d323b5e.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
 <4858dc4d5d92276fa96a8fb45b02adaae57dcf26.1228310570.git.vmiklos@frugalware.org>
 <73193271279140eda04ec46097936e64f3c526d6.1228310570.git.vmiklos@frugalware.org>
 <8c4e8eda234e8e37d4a7a3ac43ffc7738e6fac4b.1228310570.git.vmiklos@frugalware.org>
 <b67238b67501272485cc659c11a836f4f96e0d81.1228310570.git.vmiklos@frugalware.org>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 14:28:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7rmT-0000Wy-6u
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 14:28:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183AbYLCN1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Dec 2008 08:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751155AbYLCN1F
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Dec 2008 08:27:05 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46171 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbYLCN04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Dec 2008 08:26:56 -0500
Received: from vmobile.example.net (dsl5401C5DE.pool.t-online.hu [84.1.197.222])
	by yugo.frugalware.org (Postfix) with ESMTPA id E9FB7446CDF;
	Wed,  3 Dec 2008 14:26:52 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id DCDDA19DC74; Wed,  3 Dec 2008 14:26:53 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <b67238b67501272485cc659c11a836f4f96e0d81.1228310570.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1228310570.git.vmiklos@frugalware.org>
References: <cover.1228310570.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102258>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 git-submodule.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 220d94e..2f47e06 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -413,7 +413,7 @@ cmd_summary() {
 
 	test $summary_limit = 0 && return
 
-	if rev=$(git rev-parse --verify "$1^0" 2>/dev/null)
+	if rev=$(git rev-parse -q --verify "$1^0")
 	then
 		head=$rev
 		shift
@@ -464,11 +464,11 @@ cmd_summary() {
 		missing_dst=
 
 		test $mod_src = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse --verify $sha1_src^0 >/dev/null 2>&1 &&
+		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_src^0 >/dev/null &&
 		missing_src=t
 
 		test $mod_dst = 160000 &&
-		! GIT_DIR="$name/.git" git-rev-parse --verify $sha1_dst^0 >/dev/null 2>&1 &&
+		! GIT_DIR="$name/.git" git-rev-parse -q --verify $sha1_dst^0 >/dev/null &&
 		missing_dst=t
 
 		total_commits=
-- 
1.6.0.4
