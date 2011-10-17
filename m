From: mhagger@alum.mit.edu
Subject: [PATCH v4 4/7] clear_ref_cache(): rename parameter
Date: Mon, 17 Oct 2011 04:38:08 +0200
Message-ID: <1318819091-7066-5-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:39:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6W-00026B-9S
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754389Ab1JQCiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:54 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45413 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754289Ab1JQCir (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:47 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3W013403;
	Mon, 17 Oct 2011 04:38:33 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183756>

From: Michael Haggerty <mhagger@alum.mit.edu>

...for consistency with the rest of this module.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index ddd799e..623d673 100644
--- a/refs.c
+++ b/refs.c
@@ -158,13 +158,13 @@ static void free_ref_array(struct ref_array *array)
 	array->refs = NULL;
 }
 
-static void clear_ref_cache(struct ref_cache *ca)
+static void clear_ref_cache(struct ref_cache *refs)
 {
-	if (ca->did_loose)
-		free_ref_array(&ca->loose);
-	if (ca->did_packed)
-		free_ref_array(&ca->packed);
-	ca->did_loose = ca->did_packed = 0;
+	if (refs->did_loose)
+		free_ref_array(&refs->loose);
+	if (refs->did_packed)
+		free_ref_array(&refs->packed);
+	refs->did_loose = refs->did_packed = 0;
 }
 
 static struct ref_cache *create_ref_cache(const char *submodule)
-- 
1.7.7.rc2
