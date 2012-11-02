From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/14] remote-testgit: make clear the 'done' feature
Date: Fri,  2 Nov 2012 03:02:14 +0100
Message-ID: <1351821738-17526-11-git-send-email-felipe.contreras@gmail.com>
References: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 02 03:03:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TU6bW-00018E-3l
	for gcvg-git-2@plane.gmane.org; Fri, 02 Nov 2012 03:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992606Ab2KBCDK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2012 22:03:10 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:43159 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992462Ab2KBCDI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2012 22:03:08 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so1234245bkc.19
        for <git@vger.kernel.org>; Thu, 01 Nov 2012 19:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=UTnS98PAE5h3yoCoZKZRUwSHgsEbtPwtzsSxPw8mkVI=;
        b=Vn2YkXw5LZDcgeoDwXa6L5n5UqvsBIgtnO7d8OYISnmxvDa2E9XT4XeWi/Kmzenr+L
         4tFAWa749vXYk/EmNiOJvtTIsmPfBYTl6oBZ20FsP/XvFl8ujZr6P9eNVyWFV+qeMSEr
         GXR2Uf11L5RxVYZCdnlr3gAh1rhdX5Wl/Yv6ZEzo3IDx2aaQzRqBq3HNoUYNTtCXvhng
         kDHtcJdQF9vU9tZ6eadSUDTLcaF11+D2oESkmJoHdM19dttMrHoXnTM+mrygIfVad7Wf
         OHFkWy2gf7162sFaZ8pcBj/0TiP4BgecAcuY5cW/CEJtUWUy1R0Lcrtl0MXciWObNVrq
         XXXg==
Received: by 10.205.135.20 with SMTP id ie20mr26735bkc.16.1351821787948;
        Thu, 01 Nov 2012 19:03:07 -0700 (PDT)
Received: from localhost (ip-109-43-0-51.web.vodafone.de. [109.43.0.51])
        by mx.google.com with ESMTPS id ht18sm5778232bkc.14.2012.11.01.19.03.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 01 Nov 2012 19:03:07 -0700 (PDT)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1351821738-17526-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208905>

People seeking for reference would find it useful.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index 4e8b356..1116587 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -55,8 +55,10 @@ while read line; do
 
         echo "feature import-marks=$gitmarks"
         echo "feature export-marks=$gitmarks"
-        git fast-export --use-done-feature --{import,export}-marks="$testgitmarks" $refs | \
+        echo "feature done"
+        git fast-export --{import,export}-marks="$testgitmarks" $refs | \
             sed -e "s#refs/heads/#${prefix}/heads/#g"
+        echo "done"
         ;;
     export)
         declare -A before after
-- 
1.8.0
