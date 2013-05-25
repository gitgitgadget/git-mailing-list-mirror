From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 06/25] cmd_diff(): rename local variable "list" -> "entry"
Date: Sat, 25 May 2013 11:08:05 +0200
Message-ID: <1369472904-12875-7-git-send-email-mhagger@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johan Herland <johan@herland.net>, Thomas Rast <trast@inf.ethz.ch>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 25 11:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UgATT-00052T-TD
	for gcvg-git-2@plane.gmane.org; Sat, 25 May 2013 11:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633Ab3EYJJJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 May 2013 05:09:09 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:61905 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752762Ab3EYJJD (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 May 2013 05:09:03 -0400
X-AuditID: 12074412-b7f216d0000008d4-2c-51a07fae6b36
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DA.35.02260.EAF70A15; Sat, 25 May 2013 05:09:02 -0400 (EDT)
Received: from michael.fritz.box (p4FDD49F3.dip0.t-ipconnect.de [79.221.73.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4P98gug000489
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 25 May 2013 05:09:00 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsUixO6iqLuufkGgwe5tfBZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYLe5eXsXuwObx9/0HJo9LL7+zedx+PZ/Z41nvHkaPi5eUPT5vkgtg
	i+K2SUosKQvOTM/Tt0vgznhz/RlbwU+Ois+r5rE1ME5g72Lk5JAQMJFourGIDcIWk7hwbz2Q
	zcUhJHCZUWLT5VXMEM4FJok/s2+zgFSxCehKLOppZgKxRQQcJU48uM4KUsQs0Mso8fDRd7CE
	sICvxJRz+8EaWARUJXbM3we2glfAReLH7t9Q6xQkLs9aA7SBg4NTwFXi7QlOkLAQUMnzT+dY
	JzDyLmBkWMUol5hTmqubm5iZU5yarFucnJiXl1qka6aXm1mil5pSuokREmhCOxjXn5Q7xCjA
	wajEwytQPj9QiDWxrLgy9xCjJAeTkigvf+2CQCG+pPyUyozE4oz4otKc1OJDjBIczEoivAwp
	QDnelMTKqtSifJiUNAeLkjjvz8XqfkIC6YklqdmpqQWpRTBZGQ4OJQlejzqgRsGi1PTUirTM
	nBKENBMHJ4jgAtnAA7QhEKSQt7ggMbc4Mx2i6BSjopQ4bwJIQgAkkVGaBzcAlhJeMYoD/SPM
	mwJSxQNMJ3Ddr4AGMwENvpk7H2RwSSJCSqqBMe1xVlJP1PH89j5/33WZNi+KjDV65j/eK1Hd
	99BKfKXUbFf58qQVGmXxOp0Xyt9MaH6Y+7k1Z8sXXje1runv01w7UjSvKDaXt93P/7jhv7DF
	i8vc28OnLvxl8Knn8U7e89tyVb1M7ngsX7jCUPNthJmtRuBhhy5t40mcS84EHp4Y 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225495>

It's not a list, it's an array entry.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 661fdde..84243d9 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -339,9 +339,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	for (i = 0; i < rev.pending.nr; i++) {
-		struct object_array_entry *list = rev.pending.objects+i;
-		struct object *obj = list->item;
-		const char *name = list->name;
+		struct object_array_entry *entry = &rev.pending.objects[i];
+		struct object *obj = entry->item;
+		const char *name = entry->name;
 		int flags = (obj->flags & UNINTERESTING);
 		if (!obj->parsed)
 			obj = parse_object(obj->sha1);
@@ -360,7 +360,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				die(_("more than two blobs given: '%s'"), name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name = name;
-			blob[blobs].mode = list->mode;
+			blob[blobs].mode = entry->mode;
 			blobs++;
 			continue;
 
-- 
1.8.2.3
