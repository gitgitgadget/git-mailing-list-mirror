From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH] Make check target depend on common-cmds.h
Date: Thu, 04 Jan 2007 19:33:48 +0100
Message-ID: <459D488C.7020907@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 19:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2XnV-0003GS-6X
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 19:58:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbXADS5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 13:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbXADS5I
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 13:57:08 -0500
Received: from static-ip-217-172-187-230.inaddr.intergenia.de ([217.172.187.230]:58745
	"EHLO neapel230.server4you.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932277AbXADS5G (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jan 2007 13:57:06 -0500
Received: from [10.0.1.3] (p508E5B47.dip.t-dialin.net [80.142.91.71])
	by neapel230.server4you.de (Postfix) with ESMTP id 83FA21221E;
	Thu,  4 Jan 2007 19:33:49 +0100 (CET)
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35946>

This fixes sparse complaining about a missing include file
if 'make check' is run on clean sources.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index fa1a022..180e1e0 100644
--- a/Makefile
+++ b/Makefile
@@ -818,7 +818,7 @@ test-sha1$X: test-sha1.o $(GITLIBS)
 check-sha1:: test-sha1$X
 	./test-sha1.sh
 
-check:
+check: common-cmds.h
 	for i in *.c; do sparse $(ALL_CFLAGS) $(SPARSE_FLAGS) $$i || exit; done
 
 
