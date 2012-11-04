From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 14/16] remote-hg: add extra author test
Date: Sun,  4 Nov 2012 03:13:36 +0100
Message-ID: <1351995218-19889-15-git-send-email-felipe.contreras@gmail.com>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 03:15:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TUpjq-0002tS-GQ
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 03:15:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821Ab2KDCOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2012 22:14:45 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:62548 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab2KDCOn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2012 22:14:43 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1657497bkc.19
        for <git@vger.kernel.org>; Sat, 03 Nov 2012 19:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=r94+BiKY6KYPWv5xc4W9OZa/Y0ZmbtVtiwA2IiOwA8g=;
        b=0tcD/fsKIMYnzlK/1kPWcLUjj9d8GVlE/ENUYBjjyMAovUVItxJafitrd4fUIkaOXi
         TwkK8dFshJR+rn9GuPZv0AzqXIEhx/B8VxouViVZUu5zwq7Vi6/eJGDjaCFgJYnFNORm
         ynignqNBXDAc2XoG3MRbSl0boDJkUoTEevv1+OPO1R+AIyqTS1diwrRT5k4OFzhFtnkF
         9dLOQ5D/wLGMK3w1NS5s3k8vOwZPGcMqyCdiOAq4ZvRS734dfIkAwsn6MmsOC0IfZms0
         +6HgtQsLz+DMmitGlOJov1RcjyXY0MT/u1Ym3mpXnriyiB/KllgDLKTg21xkdo82Hsxe
         zjpg==
Received: by 10.204.146.10 with SMTP id f10mr1378301bkv.98.1351995283044;
        Sat, 03 Nov 2012 19:14:43 -0700 (PDT)
Received: from localhost (ip-109-43-0-39.web.vodafone.de. [109.43.0.39])
        by mx.google.com with ESMTPS id x13sm7967709bkv.16.2012.11.03.19.14.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 03 Nov 2012 19:14:42 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209002>

For hg.hg.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/test-hg-hg-git.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/test-hg-hg-git.sh b/contrib/remote-helpers/test-hg-hg-git.sh
index e07bba5..3e76d9f 100755
--- a/contrib/remote-helpers/test-hg-hg-git.sh
+++ b/contrib/remote-helpers/test-hg-hg-git.sh
@@ -370,7 +370,11 @@ test_expect_success 'hg author' '
 
 		echo theta > theta &&
 		hg add theta &&
-		hg commit -u "test >test@example.com>" -m "add theta"
+		hg commit -u "test >test@example.com>" -m "add theta" &&
+
+		echo iota > iota &&
+		hg add iota &&
+		hg commit -u "test <test <at> example <dot> com>" -m "add iota"
 		) &&
 
 		hg_push_$x hgrepo-$x gitrepo-$x &&
-- 
1.8.0
