From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH 6/9] builtin-rm: use warning() instead of fprintf(stderr, "warning: ")
Date: Tue, 24 Mar 2009 02:09:14 +0100
Message-ID: <83e5caf5764a146779d8cefbf874f540a6160eb4.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
 <1fcc4848dd7a24f846bb302bbb555bf1bac795a5.1237856682.git.vmiklos@frugalware.org>
 <9287282d966904f06ae4b3d7cfdf1d79eb645b69.1237856682.git.vmiklos@frugalware.org>
 <a1165f8583c71de7fb053e83ddf1d7acd2e48024.1237856682.git.vmiklos@frugalware.org>
 <d499d514cd704edfc54ad62422e77aca275c9527.1237856682.git.vmiklos@frugalware.org>
 <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
Cc: Jeff King <peff@peff.net>, John Tapsell <johnflux@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 24 02:10:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Llv9f-0006Vh-B0
	for gcvg-git-2@gmane.org; Tue, 24 Mar 2009 02:10:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715AbZCXBIk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 21:08:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754608AbZCXBIh
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 21:08:37 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:57063 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754406AbZCXBI0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2009 21:08:26 -0400
Received: from vmobile.example.net (catv-89-134-199-25.catv.broadband.hu [89.134.199.25])
	by yugo.frugalware.org (Postfix) with ESMTPA id 4DC77294071;
	Tue, 24 Mar 2009 02:08:20 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id EE523186225; Tue, 24 Mar 2009 02:09:18 +0100 (CET)
X-Mailer: git-send-email 1.6.2
In-Reply-To: <6ca31ce7256d8945f520b7d57e2a14b890731abd.1237856682.git.vmiklos@frugalware.org>
In-Reply-To: <cover.1237856682.git.vmiklos@frugalware.org>
References: <cover.1237856682.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114379>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---
 builtin-rm.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/builtin-rm.c b/builtin-rm.c
index c11f455..269d608 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -59,8 +59,7 @@ static int check_local_mod(unsigned char *head, int index_only)
 
 		if (lstat(ce->name, &st) < 0) {
 			if (errno != ENOENT)
-				fprintf(stderr, "warning: '%s': %s",
-					ce->name, strerror(errno));
+				warning("'%s': %s", ce->name, strerror(errno));
 			/* It already vanished from the working tree */
 			continue;
 		}
-- 
1.6.2
