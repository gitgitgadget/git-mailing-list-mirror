From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix passing of TCLTK_PATH to git-gui
Date: Thu, 5 Apr 2007 21:31:53 +0200
Message-ID: <20070405193153.GA15907@steel.home>
References: <81b0412b0704050049u746842ebn270998c5732927d3@mail.gmail.com> <7v8xd7tdl0.fsf@assigned-by-dhcp.cox.net> <81b0412b0704050610m19a72984u34888af00d70eeab@mail.gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Eygene Ryabinkin <rea-git@codelabs.ru>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 21:32:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZXge-0001HD-It
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 21:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767248AbXDETb5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 15:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767232AbXDETb5
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 15:31:57 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:30127 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767248AbXDETb4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 15:31:56 -0400
Received: from tigra.home (Fc944.f.strato-dslnet.de [195.4.201.68])
	by post.webmailer.de (fruni mo11) (RZmta 5.5)
	with ESMTP id 804df0j35GhLri ; Thu, 5 Apr 2007 21:31:54 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 4186C277B6;
	Thu,  5 Apr 2007 21:31:54 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id C8F6DD150; Thu,  5 Apr 2007 21:31:53 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <81b0412b0704050610m19a72984u34888af00d70eeab@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaFzAPqgw==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43849>

GNU make does not include environment variables by default
in its namespace. Just pass them in make command line.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index ad321b3..507ad91 100644
--- a/Makefile
+++ b/Makefile
@@ -703,7 +703,7 @@ endif
 
 all::
 ifndef NO_TCLTK
-	$(QUIET_SUBDIR0)git-gui TCLTK_PATH='$(TCLTK_PATH_SQ)' $(QUIET_SUBDIR1) all
+	$(QUIET_SUBDIR0)git-gui $(QUIET_SUBDIR1) TCLTK_PATH='$(TCLTK_PATH_SQ)' all
 endif
 	$(QUIET_SUBDIR0)perl $(QUIET_SUBDIR1) PERL_PATH='$(PERL_PATH_SQ)' prefix='$(prefix_SQ)' all
 	$(QUIET_SUBDIR0)templates $(QUIET_SUBDIR1)
-- 
1.5.1.rc3.48.g803f1
