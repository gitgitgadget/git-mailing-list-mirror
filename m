From: Johan Herland <johan@herland.net>
Subject: [PATCHv6 01/23] notes.c: Hexify SHA1 in die() message from init_notes()
Date: Tue, 09 Nov 2010 22:49:37 +0100
Message-ID: <1289339399-4733-2-git-send-email-johan@herland.net>
References: <1289339399-4733-1-git-send-email-johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: johan@herland.net, jrnieder@gmail.com, bebarino@gmail.com,
	avarab@gmail.com, gitster@pobox.com, srabbelier@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 09 22:50:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFw5G-0000PX-TC
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 22:50:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755415Ab0KIVuP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 16:50:15 -0500
Received: from smtp.getmail.no ([84.208.15.66]:61168 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754947Ab0KIVuM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Nov 2010 16:50:12 -0500
Received: from get-mta-scan01.get.basefarm.net ([10.5.16.4])
 by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN005W10NMCV30@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:10 +0100 (MET)
Received: from get-mta-scan01.get.basefarm.net
 (localhost.localdomain [127.0.0.1])	by localhost (Email Security Appliance)
 with SMTP id 5479B1799CD1_CD9C212B	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:10 +0000 (GMT)
Received: from smtp.getmail.no (unknown [10.5.16.4])
	by get-mta-scan01.get.basefarm.net (Sophos Email Appliance)
 with ESMTP id 3F9C21799CCE_CD9C212F	for <git@vger.kernel.org>; Tue,
 09 Nov 2010 21:50:10 +0000 (GMT)
Received: from alpha.herland ([84.215.68.234]) by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0LBN00HVN0NLS730@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Tue, 09 Nov 2010 22:50:10 +0100 (MET)
X-Mailer: git-send-email 1.7.3.2.173.gab1c9.dirty
In-reply-to: <1289339399-4733-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161078>

Signed-off-by: Johan Herland <johan@herland.net>
---
 notes.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/notes.c b/notes.c
index 1978244..bb03eb0 100644
--- a/notes.c
+++ b/notes.c
@@ -940,7 +940,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 		return;
 	if (get_tree_entry(object_sha1, "", sha1, &mode))
 		die("Failed to read notes tree referenced by %s (%s)",
-		    notes_ref, object_sha1);
+		    notes_ref, sha1_to_hex(object_sha1));
 
 	hashclr(root_tree.key_sha1);
 	hashcpy(root_tree.val_sha1, sha1);
-- 
1.7.3.2.173.gab1c9.dirty
