From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 2/7] sequencer: release a strbuf used in save_head()
Date: Mon, 21 May 2012 16:56:04 +0200
Message-ID: <20120521145610.1911.61154.chriscool@tuxfamily.org>
References: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Nick Bowler <nbowler@elliptictech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 21 17:10:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWUFr-0003PA-8i
	for gcvg-git-2@plane.gmane.org; Mon, 21 May 2012 17:10:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495Ab2EUPK3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 11:10:29 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:39221 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751424Ab2EUPK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 11:10:28 -0400
Received: from [127.0.1.1] (unknown [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id D21D8A626A;
	Mon, 21 May 2012 17:10:21 +0200 (CEST)
X-git-sha1: 499d01da7cdb80b60837559abb4ed0001c9be4d9 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20120521143309.1911.94302.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198109>


Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 sequencer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sequencer.c b/sequencer.c
index 762c527..ad1bbea 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -741,6 +741,7 @@ static void save_head(const char *head)
 		die_errno(_("Could not write to %s"), head_file);
 	if (commit_lock_file(&head_lock) < 0)
 		die(_("Error wrapping up %s."), head_file);
+	strbuf_release(&buf);
 }
 
 static int reset_for_rollback(const unsigned char *sha1)
-- 
1.7.10.2.555.g6528037
