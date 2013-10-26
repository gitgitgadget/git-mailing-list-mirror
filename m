From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH] sha1_file: move comment about return value where it belongs
Date: Sun, 27 Oct 2013 00:34:30 +0200
Message-ID: <20131026223431.21409.92481.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 27 00:52:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaCiy-0003BJ-OF
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 00:52:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753803Ab3JZWwt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 18:52:49 -0400
Received: from delay-1y.bbox.fr ([194.158.98.16]:63174 "EHLO delay-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753793Ab3JZWws (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 18:52:48 -0400
X-Greylist: delayed 1013 seconds by postgrey-1.27 at vger.kernel.org; Sat, 26 Oct 2013 18:52:48 EDT
Received: from mail-1y.bbox.fr (bt8sssom.cs.dolmen.bouyguestelecom.fr [172.24.208.144])
	by delay-1y.bbox.fr (Postfix) with ESMTP id 91A061981A
	for <git@vger.kernel.org>; Sun, 27 Oct 2013 00:38:55 +0200 (CEST)
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id 81D6A3A;
	Sun, 27 Oct 2013 00:35:52 +0200 (CEST)
X-git-sha1: b78538be571bc10c7ebbec4823f5b36391806423 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236769>

Commit 5b0864070 (sha1_object_info_extended: make type calculation
optional, Jul 12 2013) changed the return value of the
sha1_object_info_extended function to 0/-1 for success/error.

Previously this function returned the object type for success or
-1 for error. But unfortunately the above commit forgot to change
or move the comment above this function that says "returns enum
object_type or negative".

To fix this inconsistency, let's move the comment above the
sha1_object_info function where it is still true.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sha1_file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sha1_file.c b/sha1_file.c
index f80bbe4..7dadd04 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -2514,7 +2514,6 @@ static int sha1_loose_object_info(const unsigned char *sha1,
 	return 0;
 }
 
-/* returns enum object_type or negative */
 int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 {
 	struct cached_object *co;
@@ -2563,6 +2562,7 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
 	return 0;
 }
 
+/* returns enum object_type or negative */
 int sha1_object_info(const unsigned char *sha1, unsigned long *sizep)
 {
 	enum object_type type;
-- 
1.8.4.rc1.28.ge2684af
