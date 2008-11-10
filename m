From: Francis Galiegue <fg@one2team.net>
Subject: [PATCH] very small cleanup: #undef a macro that isn't used anywhere else
Date: Mon, 10 Nov 2008 19:28:27 +0100
Organization: One2team
Message-ID: <200811101928.27207.fg@one2team.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 10 19:30:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KzbWc-0005e2-Pe
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 19:30:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755115AbYKJS25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 13:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755532AbYKJS25
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 13:28:57 -0500
Received: from ns35774.ovh.net ([213.251.185.197]:45113 "EHLO ns35774.ovh.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755080AbYKJS2z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 13:28:55 -0500
Received: from erwin.kitchen.eel (AOrleans-157-1-75-3.w90-20.abo.wanadoo.fr [90.20.62.3])
	(Authenticated sender: fg@one2team.net)
	by ns35774.ovh.net (Postfix) with ESMTP id 362FB92C003
	for <git@vger.kernel.org>; Mon, 10 Nov 2008 19:28:44 +0100 (CET)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100542>


In xdiff-interface.c, the FIRST_FEW_BYTES macro is defined, is never used
anwhere else, so we might as well undefine it after we're done with it.
---
 xdiff-interface.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index e8ef46d..2cf30cd 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -226,6 +226,7 @@ int buffer_is_binary(const char *ptr, unsigned long size)
                size = FIRST_FEW_BYTES;
        return !!memchr(ptr, 0, size);
 }
+#undef FIRST_FEW_BYTES

 struct ff_regs {
        int nr;
--
1.6.0.3


-- 
fge
