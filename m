From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] format-patch: trivial cleanup
Date: Sun,  7 Apr 2013 01:18:59 -0600
Message-ID: <1365319139-12362-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 07 09:20:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOjtT-0002gd-HE
	for gcvg-git-2@plane.gmane.org; Sun, 07 Apr 2013 09:20:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759177Ab3DGHT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 03:19:58 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:58504 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757892Ab3DGHT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 03:19:57 -0400
Received: by mail-oa0-f41.google.com with SMTP id f4so5311852oah.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2013 00:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=E6WrsMqOGcd0h4wlu9CaQIQzdvRHK6ffdf4BHj/vQPg=;
        b=bLQ8vaCdDlnZ32GoymAqpr4uF30VQsp3cynk19Rc4rxF2MC9VQWbTFknOAjl75wm0C
         GIcKyrEbCSsweKYBxznwJBH41IrIhpFkRnC3brWBf9mS/P0uEEigLspu4YBem3C2ZdL9
         FJwjmNdW5yDiFAxqRR4lIMGQFoMer1jgVvof5w75hjEQbnuThrYc6wXLCHRNpY+6uyz2
         8KruHhWnrvx5s/fMr7HVwa2Nhq0xzfyyh0+pp1luMRWoECa9AWDjO/L5899lQXSW09rk
         XEejJtK7Yd3RFJbyupnX1VyWkHwZqCEKxrh+87Mee0vEGL4z4oGZpxh1HTIwHocfM75V
         Z8Tw==
X-Received: by 10.60.38.198 with SMTP id i6mr5532315oek.13.1365319197289;
        Sun, 07 Apr 2013 00:19:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a10sm19925689oez.1.2013.04.07.00.19.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 07 Apr 2013 00:19:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220287>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

Actually, now that we are on it. After applying my latest patch series, this makes sense.

 builtin/log.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index fab7998..7cf9277 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1058,12 +1058,10 @@ static char *find_branch_name(struct rev_info *rev)
 		else
 			return NULL;
 	}
-	if (0 <= positive) {
-		ref = rev->cmdline.rev[positive].name;
-		tip_sha1 = rev->cmdline.rev[positive].item->sha1;
-	} else {
+	if (positive < 0)
 		return NULL;
-	}
+	ref = rev->cmdline.rev[positive].name;
+	tip_sha1 = rev->cmdline.rev[positive].item->sha1;
 	if (dwim_ref(ref, strlen(ref), branch_sha1, &full_ref) &&
 	    !prefixcmp(full_ref, "refs/heads/") &&
 	    !hashcmp(tip_sha1, branch_sha1))
-- 
1.8.2
