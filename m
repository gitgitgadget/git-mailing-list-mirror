From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [GIT-GUI PATCH 2/3] po2msg: ignore untranslated messages
Date: Tue, 30 Oct 2007 11:24:53 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0710301124450.4362@racer.site>
References: <Pine.LNX.4.64.0710301122300.4362@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: stimming@tuhh.de, spearce@spearce.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 30 12:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ImpEE-0008KW-Pm
	for gcvg-git-2@gmane.org; Tue, 30 Oct 2007 12:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXJ3LZf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 07:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752475AbXJ3LZe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 07:25:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:41435 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751099AbXJ3LZe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 07:25:34 -0400
Received: (qmail invoked by alias); 30 Oct 2007 11:25:32 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 30 Oct 2007 12:25:32 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/QrIhPexXQwBLmkQZU+cZjC8AFlMFyZOU2fMnv1M
	hgZmonapyOsXA7
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0710301122300.4362@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Do not generate translations when the translated message is empty.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 po/po2msg.sh |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/po/po2msg.sh b/po/po2msg.sh
index 48a2669..91d420b 100644
--- a/po/po2msg.sh
+++ b/po/po2msg.sh
@@ -62,6 +62,9 @@ proc flush_msg {} {
 	if {$msgid == ""} {
 		set prefix "set ::msgcat::header"
 	} else {
+		if {$msgstr == ""} {
+			return
+		}
 		set prefix "::msgcat::mcset $lang \"[u2a $msgid]\""
 	}
 
-- 
1.5.3.4.1423.g7c7a7
