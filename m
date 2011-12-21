From: =?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>
Subject: [PATCH] clone: don't say <branch> when we mean <remote>
Date: Wed, 21 Dec 2011 18:14:09 +0000
Message-ID: <1324491249-5357-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 21 19:14:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RdQgE-0001Eo-CV
	for gcvg-git-2@lo.gmane.org; Wed, 21 Dec 2011 19:14:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753509Ab1LUSOO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Dec 2011 13:14:14 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:47672 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751730Ab1LUSON (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Dec 2011 13:14:13 -0500
Received: from beez.lab.cmartin.tk (145.Red-81-38-112.dynamicIP.rima-tde.net [81.38.112.145])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id B39AE461B4
	for <git@vger.kernel.org>; Wed, 21 Dec 2011 19:14:05 +0100 (CET)
Received: (nullmailer pid 5393 invoked by uid 1000);
	Wed, 21 Dec 2011 18:14:09 -0000
X-Mailer: git-send-email 1.7.8.352.g876a6f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187574>

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---

The manpage says <name> which might actually be a better word to use
everywhere, but having <branch> instead of <remote> can only lead to
confusion.

Looking through blame, the second line survived a typo fix and was
introduced in 2008 when clone was made a builtin. The script used to
say <name>. So it's clearly nothing urgent, but it bugged me, so I'm
sending a patch.

 builtin/clone.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index efe8b6c..e85ee69 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -84,8 +84,8 @@ static struct option builtin_clone_options[] =3D {
 		   "directory from which templates will be used"),
 	OPT_CALLBACK(0 , "reference", &option_reference, "repo",
 		     "reference repository", &opt_parse_reference),
-	OPT_STRING('o', "origin", &option_origin, "branch",
-		   "use <branch> instead of 'origin' to track upstream"),
+	OPT_STRING('o', "origin", &option_origin, "remote",
+		   "use <remote> instead of 'origin' to track upstream"),
 	OPT_STRING('b', "branch", &option_branch, "branch",
 		   "checkout <branch> instead of the remote's HEAD"),
 	OPT_STRING('u', "upload-pack", &option_upload_pack, "path",
--=20
1.7.8.352.g876a6f
