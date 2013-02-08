From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] user-manual: Rewrite git-gc section for automatic packing
Date: Fri, 08 Feb 2013 11:43:02 -0500
Message-ID: <7ac63ea832711ad4bee636163e277a408cbddda4.1360341577.git.wking@tremily.us>
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 08 17:44:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3r3R-0002IA-9F
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 17:44:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946620Ab3BHQni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 11:43:38 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:55207 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946552Ab3BHQnh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 11:43:37 -0500
Received: from odin.tremily.us ([unknown] [72.68.84.219])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MHW00FRAUFVQ700@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Fri, 08 Feb 2013 10:43:13 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 7D74F877A79; Fri,
 08 Feb 2013 11:43:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1360341786; bh=3f5YIKdyow8/rACXb+t/H2klx1M/Y7zNR0pX+NBC+Oc=;
	h=From:To:Cc:Subject:Date;
	b=tFZVsxU34i6koIZkNsYm8JQq1nRXVwV162e3YoKipkssUjoT5U7XqxCNwosO9T0dV
 xX6QK64k8m+uJnb6qe6byLvJIbLx0GnFP8xUfnBWcuvD3LMJrL3Iyx6l7ObRjk9Ttn
 vRSEI4zvzSZaFnThsmVOojIrDpzZnW9WrsTWcg9c=
X-Mailer: git-send-email 1.7.12.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215779>

From: "W. Trevor King" <wking@tremily.us>

This should have happened back in 2007, when `git gc` learned about
auto:

  commit e9831e83e063844b90cf9e525d0003715dd8b395
  Author: Junio C Hamano <gitster@pobox.com>
  Date:   Mon Sep 17 00:39:52 2007 -0700

    git-gc --auto: add documentation.

Signed-off-by: W. Trevor King <wking@tremily.us>
---
I'd also be happy just dropping the whole git-gc section ;).

 Documentation/user-manual.txt | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 5077e7c..d14e3c7 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1562,17 +1562,13 @@ Ensuring good performance
 -------------------------
 
 On large repositories, Git depends on compression to keep the history
-information from taking up too much space on disk or in memory.
+information from taking up too much space on disk or in memory.  Some
+git commands may automatically run linkgit:git-gc[1], so you don't
+have to worry about running it manually.  However, compressing large
+repositories may take some time, so you might want to disable
+automatic comression and run it explicitly when you are not doing
+other work.
 
-This compression is not performed automatically.  Therefore you
-should occasionally run linkgit:git-gc[1]:
-
--------------------------------------------------
-$ git gc
--------------------------------------------------
-
-to recompress the archive.  This can be very time-consuming, so
-you may prefer to run `git gc` when you are not doing other work.
 
 
 [[ensuring-reliability]]
-- 
1.8.1.336.g94702dd
