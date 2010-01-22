From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH] merge-tree: remove unnecessary call of git_extract_argv0_path
Date: Fri, 22 Jan 2010 12:47:59 +0100
Message-ID: <1264160879-26079-1-git-send-email-j6t@kdbg.org>
References: <4B596519.8060508@viscovery.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 22 12:48:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYHzx-0001uS-N5
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 12:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754755Ab0AVLsR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 06:48:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753605Ab0AVLsR
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 06:48:17 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:48528 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789Ab0AVLsQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jan 2010 06:48:16 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NYHzm-000692-D4; Fri, 22 Jan 2010 12:48:10 +0100
Received: from srv.linz.viscovery (srv.linz.viscovery [192.168.1.4])
	by theia.linz.viscovery (Postfix) with ESMTP id 1234E1660F;
	Fri, 22 Jan 2010 12:48:10 +0100 (CET)
Received: by srv.linz.viscovery (Postfix, from userid 1000)
	id A608FFA4B; Fri, 22 Jan 2010 12:48:09 +0100 (CET)
X-Mailer: git-send-email 1.6.6.1.372.g084d
In-Reply-To: <4B596519.8060508@viscovery.net>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137756>

This call should have been removed when the utility was made a builtin by
907a7cb.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
 builtin-merge-tree.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/builtin-merge-tree.c b/builtin-merge-tree.c
index 8e16c3e..a4a4f2c 100644
--- a/builtin-merge-tree.c
+++ b/builtin-merge-tree.c
@@ -345,8 +345,6 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	if (argc != 4)
 		usage(merge_tree_usage);
 
-	git_extract_argv0_path(argv[0]);
-
 	buf1 = get_tree_descriptor(t+0, argv[1]);
 	buf2 = get_tree_descriptor(t+1, argv[2]);
 	buf3 = get_tree_descriptor(t+2, argv[3]);
-- 
1.6.6.1.372.g084d
