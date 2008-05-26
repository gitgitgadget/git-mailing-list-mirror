From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Makefile: wt-status.h is also a lib header
Date: Mon, 26 May 2008 22:21:10 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805262220160.30431@racer>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer> <483ADA17.3080401@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon May 26 23:22:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0k8m-0003oX-Sg
	for gcvg-git-2@gmane.org; Mon, 26 May 2008 23:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbYEZVVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 17:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753846AbYEZVVH
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 17:21:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:33723 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753742AbYEZVVF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 17:21:05 -0400
Received: (qmail invoked by alias); 26 May 2008 21:21:03 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp023) with SMTP; 26 May 2008 23:21:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DbTAK6u/DDSRt4W1ATpwnsYxeAVgqVc0qA/FzNB
	T4CtuBZ0+AXz2f
X-X-Sender: gene099@racer
In-Reply-To: <483ADA17.3080401@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82955>


When a struct in wt-status.h changes, many files need to be rebuilt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Hannes noticed that this patch was not yet accepted (or not
	even submitted, I do not remember).

 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index dbfa2b6..aced19b 100644
--- a/Makefile
+++ b/Makefile
@@ -376,6 +376,7 @@ LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += utf8.h
 LIB_H += levenshtein.h
+LIB_H += wt-status.h
 
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
@@ -1129,7 +1130,6 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
-builtin-revert.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
-- 
1.5.6.rc0.175.gdd78
