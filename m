From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 3/7] http-push: remove "|| 1" to enable verbose check
Date: Tue,  2 Mar 2010 18:49:27 +0800
Message-ID: <1267526971-5552-4-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg6-0003k4-GP
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab0CBKt5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:49:57 -0500
Received: from mail-yx0-f182.google.com ([209.85.210.182]:40254 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752627Ab0CBKty (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:49:54 -0500
Received: by mail-yx0-f182.google.com with SMTP id 12so38910yxe.33
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=br6rw2IYeErgoB6T3T7JXEHGSIsiM3UDP8rgEkvPqXE=;
        b=QUrl3JAYfqImBvyc3xhsWrlngVlaL9eiAd/bVAodc7ZhvnyhMkbkWLJPDnivOeDsPs
         89mHFc/tK/iq2kgYyAS22yBdg4MnMHYkdBg+q1S2b2Lk/RJauzWppevfXDdEaRrYbkZ6
         jFg2ho0PWyXN+q8nHlo4mIq4qq+KJPtOfXJFg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=SDW6e9vNfFLTnmT9NxGXgkuYIm3n5dlDOb06QmodF5q7zoShRhXgZV2GlPKPBknlXK
         qFl06DbYYj17ejXcGUxmTwmheXSndYQp8qBRkyq51RwVBTFtlHJqZgxWGYJUNHco1D8S
         lvH6AQNtX/Zey0AVHt6PNEkJ6mg6CafuVuJeo=
Received: by 10.91.193.19 with SMTP id v19mr2542260agp.4.1267526992976;
        Tue, 02 Mar 2010 02:49:52 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:49:52 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141386>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-push.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/http-push.c b/http-push.c
index 432b20f..415b1ab 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1965,7 +1965,7 @@ int main(int argc, char **argv)
 		}
 
 		if (!hashcmp(ref->old_sha1, ref->peer_ref->new_sha1)) {
-			if (push_verbosely || 1)
+			if (push_verbosely)
 				fprintf(stderr, "'%s': up-to-date\n", ref->name);
 			if (helper_status)
 				printf("ok %s up to date\n", ref->name);
-- 
1.7.0.26.gbfa16
