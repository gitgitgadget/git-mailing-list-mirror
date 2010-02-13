From: Johan Herland <johan@herland.net>
Subject: [PATCHv13 01/30] Minor cosmetic fixes to notes.c
Date: Sat, 13 Feb 2010 22:28:09 +0100
Message-ID: <1266096518-2104-2-git-send-email-johan@herland.net>
References: <1266096518-2104-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, johan@herland.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Feb 13 22:29:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NgPYI-00018f-BR
	for gcvg-git-2@lo.gmane.org; Sat, 13 Feb 2010 22:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758063Ab0BMV25 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Feb 2010 16:28:57 -0500
Received: from smtp.getmail.no ([84.208.15.66]:51139 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757963Ab0BMV2z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Feb 2010 16:28:55 -0500
Received: from smtp.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00EEEUC6VE80@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:28:54 +0100 (MET)
Received: from localhost.localdomain ([84.215.68.234])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KXS00ADYUC2BL00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 13 Feb 2010 22:28:54 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2010.2.13.211545
X-Mailer: git-send-email 1.7.0.rc1.141.gd3fd
In-reply-to: <1266096518-2104-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139832>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/notes.c b/notes.c
index 023adce..47e38a1 100644
--- a/notes.c
+++ b/notes.c
@@ -1,7 +1,6 @@
 #include "cache.h"
 #include "commit.h"
 #include "notes.h"
-#include "refs.h"
 #include "utf8.h"
 #include "strbuf.h"
 #include "tree-walk.h"
@@ -93,7 +92,7 @@ static void **note_tree_search(struct int_node **tree,
 
 	i = GET_NIBBLE(*n, key_sha1);
 	p = (*tree)->a[i];
-	switch(GET_PTR_TYPE(p)) {
+	switch (GET_PTR_TYPE(p)) {
 	case PTR_TYPE_INTERNAL:
 		*tree = CLR_PTR_TYPE(p);
 		(*n)++;
@@ -195,7 +194,7 @@ static void note_tree_insert(struct int_node *tree, unsigned char n,
 
 	assert(GET_PTR_TYPE(entry) == 0); /* no type bits set */
 	l = (struct leaf_node *) CLR_PTR_TYPE(*p);
-	switch(GET_PTR_TYPE(*p)) {
+	switch (GET_PTR_TYPE(*p)) {
 	case PTR_TYPE_NULL:
 		assert(!*p);
 		*p = SET_PTR_TYPE(entry, type);
@@ -257,7 +256,7 @@ static void note_tree_free(struct int_node *tree)
 	unsigned int i;
 	for (i = 0; i < 16; i++) {
 		void *p = tree->a[i];
-		switch(GET_PTR_TYPE(p)) {
+		switch (GET_PTR_TYPE(p)) {
 		case PTR_TYPE_INTERNAL:
 			note_tree_free(CLR_PTR_TYPE(p));
 			/* fall through */
@@ -274,7 +273,7 @@ static void note_tree_free(struct int_node *tree)
  * - hex_len  - Length of above segment. Must be multiple of 2 between 0 and 40
  * - sha1     - Partial SHA1 value is written here
  * - sha1_len - Max #bytes to store in sha1, Must be >= hex_len / 2, and < 20
- * Returns -1 on error (invalid arguments or invalid SHA1 (not in hex format).
+ * Returns -1 on error (invalid arguments or invalid SHA1 (not in hex format)).
  * Otherwise, returns number of bytes written to sha1 (i.e. hex_len / 2).
  * Pads sha1 with NULs up to sha1_len (not included in returned length).
  */
-- 
1.7.0.rc1.141.gd3fd
