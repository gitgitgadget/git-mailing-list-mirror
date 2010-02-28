From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 03/12] pick: make check_parent function extern
Date: Sun, 28 Feb 2010 23:21:58 +0100
Message-ID: <20100228222208.2260.99542.chriscool@tuxfamily.org>
References: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Paolo Bonzini <bonzini@gnu.org>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 23:24:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlrYP-0006mf-Hh
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 23:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032141Ab0B1WWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 17:22:50 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48503 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032120Ab0B1WWs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 17:22:48 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 07170818096;
	Sun, 28 Feb 2010 23:22:38 +0100 (CET)
Received: from style.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id F0BED8180AC;
	Sun, 28 Feb 2010 23:22:35 +0100 (CET)
X-git-sha1: e38dabdf45d9e1f1fa5e90bd26063403bcaf6136 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100228222038.2260.25016.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141288>

as it will be used outside pick.c in a later patch

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 pick.c |    2 +-
 pick.h |    1 +
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/pick.c b/pick.c
index 40673ca..078b78d 100644
--- a/pick.c
+++ b/pick.c
@@ -59,7 +59,7 @@ static struct tree *empty_tree(void)
 	return tree;
 }
 
-static int check_parent(struct commit *commit, int mainline, int flags,
+int check_parent(struct commit *commit, int mainline, int flags,
 			struct commit **parent)
 {
 	if (!commit->parents) {
diff --git a/pick.h b/pick.h
index 7a74ad8..39af1de 100644
--- a/pick.h
+++ b/pick.h
@@ -9,5 +9,6 @@
 /* We don't need a PICK_QUIET. This is done by
  *	setenv("GIT_MERGE_VERBOSITY", "0", 1); */
 extern int pick_commit(struct commit *commit, int mainline, int flags, struct strbuf *msg);
+extern int check_parent(struct commit *commit, int mainline, int flags, struct commit **parent);
 
 #endif
-- 
1.7.0.321.g2d270
