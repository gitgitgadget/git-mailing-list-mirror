From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Remove unused sha1 parameter from pprint_tag function.
Date: Wed, 16 Sep 2009 20:12:36 -0400
Message-ID: <1253146356-17867-1-git-send-email-tfransosi@gmail.com>
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 17 02:13:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mo4cy-0003ER-L7
	for gcvg-git-2@lo.gmane.org; Thu, 17 Sep 2009 02:13:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbZIQAN2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2009 20:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZIQAN1
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Sep 2009 20:13:27 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:51802 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751193AbZIQAN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2009 20:13:26 -0400
Received: by qw-out-2122.google.com with SMTP id 9so1809106qwb.37
        for <git@vger.kernel.org>; Wed, 16 Sep 2009 17:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=Pmatnkda6ShMH7e2Efl5zTyxB7DXQTwOIIqE6BCEtS8=;
        b=S5K3Ai4NYwCyLOqjnuSENeaRuIqXLCdRrU/olghzj7KFtvQnsS4m4VBWIE5YPZTQ00
         ifm6ZTrj0/OHh9EHIIRyVYsQA1kaF9XLR6Wlnzecne4LVCpO8gzmUzH2KVXopjoxeBwE
         Aq3DXf0U6gkBklCmmaiNvxCa3rU2KB13tKEDY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=onev6TKxGiJfzezB1HLdH1/oiB7P1FHdBeC9Ipov1XE3XfiWDugzaq+iwhMzCiB0JQ
         AU5Ee/cs6De3PjjBEH99BT0cVUar/Px6/l14jFidYk8qsa1lZu2s+UWwwlxLYUloS+07
         EUozkIRmRxmnCtqatX7pFcAPtcxbOULSyTct0=
Received: by 10.224.87.75 with SMTP id v11mr7876001qal.236.1253146410213;
        Wed, 16 Sep 2009 17:13:30 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 7sm311656qwf.57.2009.09.16.17.13.29
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 16 Sep 2009 17:13:29 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128699>

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 builtin-cat-file.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 5906842..626c6a7 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -13,7 +13,7 @@
 #define BATCH 1
 #define BATCH_CHECK 2
 
-static void pprint_tag(const unsigned char *sha1, const char *buf, unsigned long size)
+static void pprint_tag(const char *buf, unsigned long size)
 {
 	/* the parser in tag.c is useless here. */
 	const char *endp = buf + size;
@@ -126,7 +126,7 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
 		if (!buf)
 			die("Cannot read object %s", obj_name);
 		if (type == OBJ_TAG) {
-			pprint_tag(sha1, buf, size);
+			pprint_tag(buf, size);
 			return 0;
 		}
 
-- 
1.6.5.rc0.dirty
