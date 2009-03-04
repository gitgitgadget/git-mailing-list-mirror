From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Make the 'lock file' exists error more informative
Date: Wed,  4 Mar 2009 15:00:44 +0000
Message-ID: <1236178844-7958-1-git-send-email-johnflux@gmail.com>
Cc: John Tapsell <johnflux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 16:02:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lesc1-0001Mw-BN
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 16:02:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334AbZCDPAu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 10:00:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753330AbZCDPAu
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:00:50 -0500
Received: from ti-out-0910.google.com ([209.85.142.187]:52976 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091AbZCDPAu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 10:00:50 -0500
Received: by ti-out-0910.google.com with SMTP id d10so3487102tib.23
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 07:00:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9wCwE29p9IC7jtOhpi6ChT+ObLLLq44SajSR3xMir+Y=;
        b=U0pP8hBLiiV9qq9/OLPcaXC2zR5QcUQv2lKb7fG7hRLr48YTlLAn1OYTx8GgLuMWMI
         wCqldGbiM6rRhY4oQexDqL325E+/tLrwXPu/+2q9RMjpQVF0lQ2drCJEuJs7Nd9QzTn5
         7JzDCHUS6VeRSBkJD1n/ncZJ9/4mk8ksn5PMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=BXgIeiftgMvwmt/kElyqaGHvcJUBBrKl9/LGqqqFypskkzAmIkiYjP/fGGbtFc2qJ3
         dCTawFs4KuY5fZXcOHQaVuU41TBN/s7Jmqxt1WIlrM3P9NOL22P7oVX1PyhNi7lTwO2o
         aGu44b9GJrJ0nooCfjp9Zwbm9HUpLevWIsU8A=
Received: by 10.110.2.2 with SMTP id 2mr12351333tib.2.1236178847177;
        Wed, 04 Mar 2009 07:00:47 -0800 (PST)
Received: from localhost.localdomain (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id w5sm213204tib.5.2009.03.04.07.00.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 07:00:46 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc1.3.g7d31b.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112218>

It looks like someone did 90% of the work, then forgot to actually use
the function
---
 lockfile.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 1db1a2f..6772f38 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -184,7 +184,7 @@ int hold_lock_file_for_append(struct lock_file *lk, const char *path, int flags)
 	fd = lock_file(lk, path, flags);
 	if (fd < 0) {
 		if (flags & LOCK_DIE_ON_ERROR)
-			die("unable to create '%s.lock': %s", path, strerror(errno));
+			unable_to_lock_index_die(path, strerror(errno));
 		return fd;
 	}
 
-- 
1.6.2.rc1.3.g7d31b.dirty
