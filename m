From: Dmitry Ivankov <divanorama@gmail.com>
Subject: [PATCH 1/3] Fix typo: existant->existent
Date: Thu,  2 Jun 2011 04:27:56 +0600
Message-ID: <1306967278-1971-1-git-send-email-divanorama@gmail.com>
Cc: Dmitry Ivankov <divanorama@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 02 00:28:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRttg-00039t-4b
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758637Ab1FAW2J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:28:09 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:62533 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752233Ab1FAW2H (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:28:07 -0400
Received: by bwz15 with SMTP id 15so448770bwz.19
        for <git@vger.kernel.org>; Wed, 01 Jun 2011 15:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer;
        bh=s7StwATExPaiUF8Ba62nM9+lRvKEfNuJQmqUdKP9rt8=;
        b=UFAJpubf2aLWzrEzC7dXNxcurVKBROku4BGzbuYyTXB4+qnz4piYO0Y9m9/Rc2gEBo
         Ve+3cq23Bir3bYH6F0bRLwXShkbiiWt7NowG45a6eY6ruOL1Zl8jhM3nCdq6YWZhc5gA
         55QY2PpVJ9KUClbpteP1oJXSmUF9CIAO0NqG0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=h79M3HREwTN7OLq5UOOJ8jV9UUqslCbVAfY89UhaTY2kpthHupAd5hUpocpAW5AAVB
         CJYkiouozxHIH2ErhBPpyzKRJjgWLCJC2B3mw866yfXJxmqd1BiraZe8oVrqSasW4nYz
         nw7NSz+j3Eb2Ae32uiY4wWzyainvCq5MrOZRs=
Received: by 10.204.7.4 with SMTP id b4mr33955bkb.39.1306967286398;
        Wed, 01 Jun 2011 15:28:06 -0700 (PDT)
Received: from localhost.localdomain (117360277.convex.ru [79.172.62.237])
        by mx.google.com with ESMTPS id af13sm5071bkc.19.2011.06.01.15.28.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 01 Jun 2011 15:28:05 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174910>

Fix it in error msg "Trying to write ref with nonexistent object".
No tests rely on the wrong spelling.
---
 refs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index e3c0511..b10419a 100644
--- a/refs.c
+++ b/refs.c
@@ -1451,7 +1451,7 @@ int write_ref_sha1(struct ref_lock *lock,
 	}
 	o = parse_object(sha1);
 	if (!o) {
-		error("Trying to write ref %s with nonexistant object %s",
+		error("Trying to write ref %s with nonexistent object %s",
 			lock->ref_name, sha1_to_hex(sha1));
 		unlock_ref(lock);
 		return -1;
-- 
1.7.3.4
