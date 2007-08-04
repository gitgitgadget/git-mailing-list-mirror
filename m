From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] checkout-index needs a working tree
Date: Sat, 4 Aug 2007 23:20:07 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708042319470.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 05 00:20:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHRzQ-0002OJ-0c
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 00:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762841AbXHDWUl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 18:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762478AbXHDWUl
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 18:20:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:56071 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762190AbXHDWUk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 18:20:40 -0400
Received: (qmail invoked by alias); 04 Aug 2007 22:20:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 05 Aug 2007 00:20:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18vRr1kQoQv9sGkAYIV1Up/+pPnGpChPGSQ5IhWhv
	BJ/88s9h89LI4o
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54914>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This fixes "git --work-tree=/some/where/else checkout-index".

 git.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git.c b/git.c
index 25b8274..f8c4545 100644
--- a/git.c
+++ b/git.c
@@ -315,7 +315,8 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "branch", cmd_branch, RUN_SETUP },
 		{ "bundle", cmd_bundle },
 		{ "cat-file", cmd_cat_file, RUN_SETUP },
-		{ "checkout-index", cmd_checkout_index, RUN_SETUP },
+		{ "checkout-index", cmd_checkout_index,
+			RUN_SETUP | NEED_WORK_TREE},
 		{ "check-ref-format", cmd_check_ref_format },
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
-- 
1.5.3.rc4.1.g7805
