From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 06/17] cmd_diff(): rename local variable "list" -> "entry"
Date: Sun, 19 May 2013 22:27:01 +0200
Message-ID: <1368995232-11042-7-git-send-email-mhagger@alum.mit.edu>
References: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 19 22:28:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeADo-0004mK-51
	for gcvg-git-2@plane.gmane.org; Sun, 19 May 2013 22:28:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab3ESU2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 May 2013 16:28:07 -0400
Received: from ALUM-MAILSEC-SCANNER-2.MIT.EDU ([18.7.68.13]:61200 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754541Ab3ESU2F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 May 2013 16:28:05 -0400
X-AuditID: 1207440d-b7fd06d000000905-97-519935d46b8a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 34.1A.02309.4D539915; Sun, 19 May 2013 16:28:04 -0400 (EDT)
Received: from michael.fritz.box (p57A25040.dip0.t-ipconnect.de [87.162.80.64])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4JKRX5P026019
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 19 May 2013 16:28:03 -0400
X-Mailer: git-send-email 1.8.2.3
In-Reply-To: <1368995232-11042-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqHvFdGagwfT9NhZdV7qZLBp6rzBb
	zLu7i8ni9or5zBY/WnqYHVg9/r7/wORx6eV3No9nvXsYPS5eUvb4vEkugDWK2yYpsaQsODM9
	T98ugTvjQ9dJ5oKfHBXbltU3ME5g72Lk4JAQMJF49Ma/i5ETyBSTuHBvPVsXIxeHkMBlRom+
	K/9YIJzzTBIdkzexg1SxCehKLOppZgKxRQRkJb4f3sgIYjMLTGCUWNpfCGILC3hJnJq8mRVk
	AYuAqsSuj9IgYV4BF4mmdZMZIZYpSFyetYYZxOYUcJXY0r6LFcQWAqr513+bdQIj7wJGhlWM
	cok5pbm6uYmZOcWpybrFyYl5ealFukZ6uZkleqkppZsYIeHEu4Px/zqZQ4wCHIxKPLwa76YH
	CrEmlhVX5h5ilORgUhLlfWcyM1CILyk/pTIjsTgjvqg0J7X4EKMEB7OSCO8eIaAcb0piZVVq
	UT5MSpqDRUmcV22Jup+QQHpiSWp2ampBahFMVoaDQ0mCtwNkqGBRanpqRVpmTglCmomDE0Rw
	gWzgAdpwH6SQt7ggMbc4Mx2i6BSjopQ4bz9IQgAkkVGaBzcAFvmvGMWB/hHmPQJSxQNMGnDd
	r4AGMwENZr02FWRwSSJCSqqB0YOtNvdrzYWrtWtm/Ho5yfz2rcOPW/klFBWU1rgnBTfU6LQ8
	v6s4XXfWhmNP/0qVWG2SF95k++HHiviWpzKHG+0XhBUv5HUWlpnJvmM9M5fh51Wp0odr1+un
	HWyVTqiMmrWtqGj2L4kpPkIH1U22xaTyyPxYYbkud03YJtW+vAuKp6pO/2X5psRS 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224919>

It's not a list, it's an array entry.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 builtin/diff.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 72d99c0..7cac6de 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -338,9 +338,9 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
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
@@ -359,7 +359,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 				die(_("more than two blobs given: '%s'"), name);
 			hashcpy(blob[blobs].sha1, obj->sha1);
 			blob[blobs].name = name;
-			blob[blobs].mode = list->mode;
+			blob[blobs].mode = entry->mode;
 			blobs++;
 			continue;
 
-- 
1.8.2.3
