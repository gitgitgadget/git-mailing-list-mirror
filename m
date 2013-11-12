From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v7 01/11] transport-helper: fix extra lines
Date: Tue, 12 Nov 2013 14:56:54 -0600
Message-ID: <1384289830-5471-2-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:04:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL8Q-0007dt-3e
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209Ab3KLVEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:15 -0500
Received: from mail-oa0-f54.google.com ([209.85.219.54]:43010 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932193Ab3KLVEG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:06 -0500
Received: by mail-oa0-f54.google.com with SMTP id o6so4180106oag.27
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pb461rKuy/YoiOVvF0VIzbqdDdtrl4GRew9MJWMfJLc=;
        b=j7ExEuK7txL5OPfS82kezm/TdaRNpCW2jrzXUgQm51BsHNucG1Q049blu1LbZTqYCf
         S+RAoW/PXPh4zi/5K1tBgbsBbMN8PmzbXzVnsh35GNjOT4CHIKpN0+QKeejftGJLwfzV
         aGpqTdaJjEAfTHzEZsE+yKRSKSduO77gSw7Zvw37uubHybeCSn/lUSs9vevF7LROC5Oo
         cyw67kw1O83lD2h0ebF912acMIwJE/Zw/g9sP0eT/f1jqTjakziRVy9kQ1Ae3zUtR8Bf
         O29YTTcHBcsUNdsosYrYmHfJSZsqQzwRanUwDLoz3m0R/s3Sc3e/MTSv5oingWzDp8uh
         KKcw==
X-Received: by 10.182.81.99 with SMTP id z3mr8651765obx.64.1384290245411;
        Tue, 12 Nov 2013 13:04:05 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id xr8sm35387149obc.12.2013.11.12.13.04.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:04 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237739>

Commit 9c51558 (transport-helper: trivial code shuffle) moved these
lines above, but 99d9ec0 (Merge branch 'fc/transport-helper-no-refspec')
had a wrong merge conflict and readded them.

Reported-by: Richard Hansen <rhansen@bbn.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 673b7c2..b66c7fd 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -875,9 +875,6 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion)
-			die("remote-helpers do not support ref deletion");
-
 		if (ref->peer_ref) {
 			if (strcmp(ref->peer_ref->name, ref->name))
 				die("remote-helpers do not support old:new syntax");
-- 
1.8.4.2+fc1
