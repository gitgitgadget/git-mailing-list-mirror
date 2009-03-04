From: John Tapsell <johnflux@gmail.com>
Subject: [PATCH] Clarify the "cannot lock existing info/refs" error
Date: Wed,  4 Mar 2009 15:37:06 +0000
Message-ID: <1236181026-15385-1-git-send-email-johnflux@gmail.com>
Cc: John Tapsell <johnflux@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 04 16:38:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LetBL-0008PQ-Fn
	for gcvg-git-2@gmane.org; Wed, 04 Mar 2009 16:38:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755333AbZCDPhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Mar 2009 10:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755091AbZCDPhP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Mar 2009 10:37:15 -0500
Received: from ti-out-0910.google.com ([209.85.142.185]:45106 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753745AbZCDPhM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Mar 2009 10:37:12 -0500
Received: by ti-out-0910.google.com with SMTP id d10so3495183tib.23
        for <git@vger.kernel.org>; Wed, 04 Mar 2009 07:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=9n5v3Pjv9MdYZpqw6BXHiDTcOsOvaDhIDvIVfczdyyo=;
        b=MP9L4DpqVtX+p7/ZxJgoawDE3W+yGDiAcfmlaABQMv84jIz00qrEQzT4MNSO4rynL1
         AL6bAzau0Ty0uKUlqefvGogC4rYDzaTaMZZ6x3KADsY5fHYbNOZwHwcytx3JMMbBC/ax
         0JfKm52ASNGdC8pqCL7rJDYW40q8lcoGXi3g8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=bzmv3HFsGU46hAZJ83qhqPu4nYULMfFOygl8lR2ExMqr7pgBSAOq+zgqPPE0Sr70qM
         uoSC/YbCg6HS2FJCR/G2DThjMEAZsOqFOWarha9lrwA40rTOSyy+/ddunskwPGIWePUH
         0V8waOqIeUTfjGtrQeL8c5s/6XkJ26BV23Bnk=
Received: by 10.110.90.9 with SMTP id n9mr7431tib.25.1236181029338;
        Wed, 04 Mar 2009 07:37:09 -0800 (PST)
Received: from localhost.localdomain (58-190-81-184.eonet.ne.jp [58.190.81.184])
        by mx.google.com with ESMTPS id j5sm983947tid.21.2009.03.04.07.37.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 04 Mar 2009 07:37:08 -0800 (PST)
X-Mailer: git-send-email 1.6.2.rc2.23.g77740
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112223>

---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 30d2d34..6666956 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2293,7 +2293,7 @@ int main(int argc, char **argv)
 		if (info_ref_lock)
 			remote->can_update_info_refs = 1;
 		else {
-			fprintf(stderr, "Error: cannot lock existing info/refs\n");
+			error("cannot lock existing info/refs on remote server\nPerhaps the server is currently busy, or your ~/.netrc file is not configured correctly.");
 			rc = 1;
 			goto cleanup;
 		}
-- 
1.6.2.rc2.23.g77740
