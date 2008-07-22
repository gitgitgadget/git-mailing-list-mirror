From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] builtin-commit: Two trivial style-cleanups
Date: Tue, 22 Jul 2008 21:40:41 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807222139550.8986@racer>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Tue Jul 22 22:41:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOg1-0002UM-NU
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbYGVUkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbYGVUkm
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:40:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:58821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751431AbYGVUkm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:40:42 -0400
Received: (qmail invoked by alias); 22 Jul 2008 20:40:40 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp023) with SMTP; 22 Jul 2008 22:40:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/a5+UxR17am8QoHBboAdZhjBWss7S1/GPH0W4Ngh
	vpK9Bo1cNgZJfE
X-X-Sender: gene099@racer
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89527>


Pierre Habouzit noticed that two variables were not static which should
have been, and that adding "\n\n" is better than adding '\n' twice.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	This was in my queue for half an eternity.

	Oh, and it _is_ meant for inclusion.  On top of master.

 builtin-commit.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 97e64de..7434797 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -68,8 +68,8 @@ static enum {
 static char *cleanup_arg;
 
 static int use_editor = 1, initial_commit, in_merge;
-const char *only_include_assumed;
-struct strbuf message;
+static const char *only_include_assumed;
+static struct strbuf message;
 
 static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 {
@@ -78,8 +78,7 @@ static int opt_parse_m(const struct option *opt, const char *arg, int unset)
 		strbuf_setlen(buf, 0);
 	else {
 		strbuf_addstr(buf, arg);
-		strbuf_addch(buf, '\n');
-		strbuf_addch(buf, '\n');
+		strbuf_addstr(buf, "\n\n");
 	}
 	return 0;
 }
-- 
1.6.0.rc0.22.gf2096d.dirty
