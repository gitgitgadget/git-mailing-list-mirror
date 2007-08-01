From: David Kastrup <dak@gnu.org>
Subject: [PATCH] When generating manpages, delete outdated targets first.
Date: Thu, 2 Aug 2007 01:48:44 +0200
Organization: Organization?!?
Message-ID: <S1753674AbXHBABb/20070802000131Z+363@vger.kernel.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 02 02:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGO8H-0005SJ-HH
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 02:01:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753871AbXHBABb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 20:01:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753674AbXHBABb
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 20:01:31 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:43374 "EHLO
	mail-in-02.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753592AbXHBABa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 20:01:30 -0400
Received: from mail-in-09-z2.arcor-online.net (mail-in-09-z2.arcor-online.net [151.189.8.21])
	by mail-in-02.arcor-online.net (Postfix) with ESMTP id 9120E1A73AB
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 02:01:29 +0200 (CEST)
Received: from mail-in-13.arcor-online.net (mail-in-13.arcor-online.net [151.189.21.53])
	by mail-in-09-z2.arcor-online.net (Postfix) with ESMTP id 80AF528EC4D
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 02:01:29 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-017-069.pools.arcor-ip.net [84.61.17.69])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 60820225122
	for <git@vger.kernel.org>; Thu,  2 Aug 2007 02:01:29 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 8E6571C3E076; Thu,  2 Aug 2007 02:00:38 +0200 (CEST)
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
X-Virus-Scanned: ClamAV 0.91.1/3845/Wed Aug  1 08:33:15 2007 on mail-in-13.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54504>

This makes "make doc" work even if you made "sudo make doc" previously
by mistake.  Apparently an oversight: the other targets did this already.

Signed-off-by: David Kastrup <dak@gnu.org>
---
 Documentation/Makefile |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 3bc5357..a186843 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -120,6 +120,7 @@ clean:
 	mv $@+ $@
 
 %.1 %.5 %.7 : %.xml
+	$(RM) $@+ $@
 	xmlto -m callouts.xsl man $<
 
 %.xml : %.txt
-- 
1.5.3.rc2.167.gbef44-dirty
