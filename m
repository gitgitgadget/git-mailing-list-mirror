From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Fix update-po target to call msgmerge with right parameters
Date: Sun, 22 Jul 2007 12:19:30 +0200
Message-ID: <20070722101930.GC3408@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 12:19:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICYXS-0007re-VK
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 12:19:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751127AbXGVKTe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 06:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbXGVKTe
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 06:19:34 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:59569 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750714AbXGVKTd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 06:19:33 -0400
Received: from tigra.home (Fab51.f.strato-dslnet.de [195.4.171.81])
	by post.webmailer.de (fruni mo4) (RZmta 9.1)
	with ESMTP id h047c0j6M3nrzL ; Sun, 22 Jul 2007 12:19:31 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 262BD277BD;
	Sun, 22 Jul 2007 12:19:31 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id E3D0FBDD0; Sun, 22 Jul 2007 12:19:30 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzwpJtIOQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53244>

Add accidentally forgotten semicolon at the end of msgmerge command line
---
 Makefile |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 52975a7..2c9b3ad 100644
--- a/Makefile
+++ b/Makefile
@@ -113,7 +113,7 @@ ALL_MSGFILES = $(subst .po,.msg,$(ALL_POFILES))
 $(PO_TEMPLATE): $(SCRIPT_SH) $(ALL_LIBFILES)
 	$(XGETTEXT) -kmc -LTcl -o $@ $(SCRIPT_SH) $(ALL_LIBFILES)
 update-po:: $(PO_TEMPLATE)
-	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) )
+	$(foreach p, $(ALL_POFILES), echo Updating $p ; msgmerge -U $p $(PO_TEMPLATE) ; )
 $(ALL_MSGFILES): %.msg : %.po
 	@echo Generating catalog $@
 	msgfmt --statistics --tcl $< -l $(basename $(notdir $<)) -d $(dir $@)
-- 
1.5.3.rc2.37.g67fa
