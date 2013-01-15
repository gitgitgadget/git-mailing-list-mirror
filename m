From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 04/14] imap-send.c: remove struct store_conf
Date: Tue, 15 Jan 2013 09:06:22 +0100
Message-ID: <1358237193-8887-5-git-send-email-mhagger@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 09:07:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tv1YV-0002VJ-EN
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 09:07:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756068Ab3AOIHL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 03:07:11 -0500
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:52503 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755754Ab3AOIHJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 03:07:09 -0500
X-AuditID: 1207440c-b7f196d0000008bc-75-50f50e2c456d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id B8.FC.02236.C2E05F05; Tue, 15 Jan 2013 03:07:08 -0500 (EST)
Received: from michael.berlin.jpk.com (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0F86n5Q029668
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 15 Jan 2013 03:07:07 -0500
X-Mailer: git-send-email 1.8.0.3
In-Reply-To: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEIsWRmVeSWpSXmKPExsUixO6iqKvD9zXAoOmNskXXlW4mi4beK8wW
	t1fMZ3Zg9vj7/gOTx8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGdsebyBteAJe8Xk6RoNjN1s
	XYycHBICJhIPj/1ihrDFJC7cWw8U5+IQErjMKHF0bgMjhHOGSWLO7SWMIFVsAroSi3qamUBs
	EQE1iYlth1hAbGYBB4nNnxvBaoQF7CVWt50F28AioCrR1DUVLM4r4Czx/foUFohtChKvd15i
	BbE5BVwkrv48BnaFEFDNlw2nGScw8i5gZFjFKJeYU5qrm5uYmVOcmqxbnJyYl5dapGuol5tZ
	opeaUrqJERIqPDsYv62TOcQowMGoxMN7S/dLgBBrYllxZe4hRkkOJiVR3g6urwFCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHh93gGV86YkVlalFuXDpKQ5WJTEeVWXqPsJCaQnlqRmp6YWpBbB
	ZGU4OJQkeGN4gYYKFqWmp1akZeaUIKSZODhBBBfIBh6gDa+4gQp5iwsSc4sz0yGKTjEqSonz
	moFMEABJZJTmwQ2ARfUrRnGgf4R5g0CqeIAJAa77FdBgJqDBm/Z+BhlckoiQkmpgnCbMvFhy
	f9ZtlopbaYoP0/3eXd38fK5YgfHCWKMLqwVvzfjA1ebwSTgke4aykvakqXX/zFZft09edpJ3
	6rfZS7sOTIq/Uf+7NOOKsJ2Zv8rL/JDvE4Sf58+5mH5s12tBWf/9p2oME6vnVTyN8ZH851K1
	YjXTxqundi1uW7zj6LcP5iWi/fmTbJVYijMSDbWYi4oTAbOQA8nFAgAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213606>

It was never used.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 imap-send.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index dbe0546..b8a7ff9 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -33,15 +33,6 @@ typedef void *SSL;
 #include <openssl/hmac.h>
 #endif
 
-struct store_conf {
-	char *name;
-	const char *path; /* should this be here? its interpretation is driver-specific */
-	char *map_inbox;
-	char *trash;
-	unsigned max_size; /* off_t is overkill */
-	unsigned trash_remote_new:1, trash_only_new:1;
-};
-
 /* For message->status */
 #define M_RECENT       (1<<0) /* unsyncable flag; maildir_* depend on this being 1<<0 */
 #define M_DEAD         (1<<1) /* expunged */
@@ -55,8 +46,6 @@ struct message {
 };
 
 struct store {
-	struct store_conf *conf; /* foreign */
-
 	/* currently open mailbox */
 	const char *name; /* foreign! maybe preset? */
 	char *path; /* own */
-- 
1.8.0.3
