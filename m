From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Makefile: wt-status.h is also a lib header
Date: Tue, 27 May 2008 00:03:29 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0805270001050.30431@racer>
References: <483AC2CE.7090801@gmail.com> <alpine.DEB.1.00.0805261521130.30431@racer> <483ADA17.3080401@viscovery.net> <alpine.DEB.1.00.0805262220160.30431@racer> <7vlk1w4tp9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 27 01:04:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K0ljj-0005gk-CE
	for gcvg-git-2@gmane.org; Tue, 27 May 2008 01:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbYEZXDY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2008 19:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753308AbYEZXDY
	(ORCPT <rfc822;git-outgoing>); Mon, 26 May 2008 19:03:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:38725 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751529AbYEZXDX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2008 19:03:23 -0400
Received: (qmail invoked by alias); 26 May 2008 23:03:21 -0000
Received: from R105f.r.pppool.de (EHLO racer.local) [89.54.16.95]
  by mail.gmx.net (mp004) with SMTP; 27 May 2008 01:03:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CFHtVrHuC1AtaYifR2YzTsByE4kGKglL6u2h/3h
	ZzwLuIhRn/emA/
X-X-Sender: gene099@racer
In-Reply-To: <7vlk1w4tp9.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82969>

Hi,

On Mon, 26 May 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > When a struct in wt-status.h changes, many files need to be rebuilt.
> 
> What project, that has levenshtein.h, is this patch is for ;-)?

Heh.  Missed that one.  There was a discussion some time ago that the 
rename detection should prefer names with a smaller Levenshtein distance, 
so I implemented that (back when I still had some time).

This one is on top of the current 'next':

-- snipsnap --
[PATCH v2] Makefile: wt-status.h is also a lib header

When a struct in wt-status.h changes, many files need to be rebuilt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ef5ce5e..ab358b2 100644
--- a/Makefile
+++ b/Makefile
@@ -375,6 +375,7 @@ LIB_H += tree.h
 LIB_H += tree-walk.h
 LIB_H += unpack-trees.h
 LIB_H += utf8.h
+LIB_H += wt-status.h
 
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
@@ -1127,7 +1128,6 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
-builtin-revert.o wt-status.o: wt-status.h
 
 $(LIB_FILE): $(LIB_OBJS)
 	$(QUIET_AR)$(RM) $@ && $(AR) rcs $@ $(LIB_OBJS)
-- 
1.5.6.rc0.175.gdd78
