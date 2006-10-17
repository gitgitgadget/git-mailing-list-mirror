From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] add proper dependancies on the xdiff source
Date: Tue, 17 Oct 2006 19:08:08 +0100
Message-ID: <2ffb978570666d608b8a58c39e30b9d1@pinky>
References: <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Oct 17 20:09:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZtMt-0008Vh-TU
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 20:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbWJQSIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 14:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWJQSIo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 14:08:44 -0400
Received: from 85-210-250-36.dsl.pipex.com ([85.210.250.36]:59363 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751001AbWJQSIn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 14:08:43 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GZtMG-0006pP-S8; Tue, 17 Oct 2006 19:08:08 +0100
To: git@vger.kernel.org
Content-Disposition: inline
InReply-To: <Pine.LNX.4.64.0610171005370.3962@g5.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29097>

We are not rebuilding the xdiff library when its header files change.
Add dependancies for those to the main Makefile.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/Makefile b/Makefile
index 932bcb9..3e54f75 100644
--- a/Makefile
+++ b/Makefile
@@ -768,6 +768,8 @@ git-http-push$X: revision.o http.o http-
 	rm -f $@ && $(AR) rcs $@ $(LIB_OBJS)
 
 XDIFF_OBJS=xdiff/xdiffi.o xdiff/xprepare.o xdiff/xutils.o xdiff/xemit.o
+$(XDIFF_OBJS): xdiff/xinclude.h xdiff/xmacros.h xdiff/xdiff.h xdiff/xtypes.h \
+	xdiff/xutils.h xdiff/xprepare.h xdiff/xdiffi.h xdiff/xemit.h
 
 $(XDIFF_LIB): $(XDIFF_OBJS)
 	rm -f $@ && $(AR) rcs $@ $(XDIFF_OBJS)
