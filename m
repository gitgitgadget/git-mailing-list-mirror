From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 6/6] builtin-commit: Add newline when showing which commit
 was created
Date: Sun, 11 Nov 2007 17:36:52 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711111736440.4362@racer.site>
References: <Pine.LNX.4.64.0711111730580.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, krh@redhat.com, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Nov 11 18:37:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrGkO-0006Hw-O0
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 18:37:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756173AbXKKRhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 12:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756147AbXKKRhH
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 12:37:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:46085 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756119AbXKKRhE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 12:37:04 -0500
Received: (qmail invoked by alias); 11 Nov 2007 17:37:02 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp033) with SMTP; 11 Nov 2007 18:37:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18wkJtkNVcwuJ0+NwPnD2DyAXPrSjUw6Lb4qct9TM
	d/83VEdgNdy9gz
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0711111730580.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64484>


The function log_tree_commit() does not break the line, so we have to
do it ourselves.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin-commit.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 069d180..3739bfc 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -493,6 +493,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	printf("Created %scommit ", initial_commit ? "initial " : "");
 
 	log_tree_commit(&rev, commit);
+	printf("\n");
 }
 
 int git_commit_config(const char *k, const char *v)
-- 
1.5.3.5.1693.g26ed
