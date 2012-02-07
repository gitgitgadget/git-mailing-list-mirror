From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] add -e: ignore dirty submodules
Date: Tue, 7 Feb 2012 05:05:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1202070504340.24259@s15462909.onlinehome-server.info>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Feb 07 05:05:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RucJX-0001sk-9w
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 05:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756185Ab2BGEFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Feb 2012 23:05:50 -0500
Received: from mailout-de.gmx.net ([213.165.64.23]:34974 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756181Ab2BGEFu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Feb 2012 23:05:50 -0500
Received: (qmail invoked by alias); 07 Feb 2012 04:05:48 -0000
Received: from s15462909.onlinehome-server.info (EHLO s15462909.onlinehome-server.info) [87.106.4.80]
  by mail.gmx.net (mp035) with SMTP; 07 Feb 2012 05:05:48 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/clAJRqwrcAHShHDehRm2uWzZd4UBWjA5c1Ai/zV
	eLLxE1CU5plIw8
X-X-Sender: schindelin@s15462909.onlinehome-server.info
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190135>


We cannot add untracked/modified files in submodules anyway.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This patch is actually from Oct 23, 2010.

 builtin/add.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 1c42900..b79336d 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -280,6 +280,7 @@ static int edit_patch(int argc, const char **argv, const char *prefix)
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	DIFF_OPT_SET(&rev.diffopt, IGNORE_DIRTY_SUBMODULES);
 	out = open(file, O_CREAT | O_WRONLY, 0644);
 	if (out < 0)
 		die (_("Could not open '%s' for writing."), file);
-- 
1.7.9.msysgit.0.27.ge92cd
