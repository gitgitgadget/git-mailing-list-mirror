From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/2] sequencer: release a strbuf used in save_head()
Date: Fri, 04 May 2012 21:40:34 +0200
Message-ID: <20120504194035.25080.21240.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 04 21:46:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQOSX-0005E7-9Y
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 21:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759494Ab2EDTq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 May 2012 15:46:29 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55200 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754506Ab2EDTq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 May 2012 15:46:28 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 3C92FA61F5;
	Fri,  4 May 2012 21:46:22 +0200 (CEST)
X-git-sha1: 3c6a84115cb7f217a7b6c921f6d039a014ea8518 
X-Mailer: git-mail-commits v0.5.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197061>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index aa4c1a4..af8e7db 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -733,6 +733,7 @@ static void save_head(const char *head)
 		die_errno(_("Could not write to %s"), head_file);
 	if (commit_lock_file(&head_lock) < 0)
 		die(_("Error wrapping up %s."), head_file);
+	strbuf_release(&buf);
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
-- 
1.7.10.579.g68891.dirty
