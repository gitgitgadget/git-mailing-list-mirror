From: Elia Pinto <gitter.spiros@gmail.com>
Subject: [PATCH] bisect.c: reduce scope of variable
Date: Wed, 29 Jan 2014 05:25:00 -0800
Message-ID: <1391001900-6686-1-git-send-email-gitter.spiros@gmail.com>
Cc: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 29 14:25:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W8V9P-0003De-Gf
	for gcvg-git-2@plane.gmane.org; Wed, 29 Jan 2014 14:25:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaA2NZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jan 2014 08:25:06 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:57135 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751141AbaA2NZF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jan 2014 08:25:05 -0500
Received: by mail-pa0-f45.google.com with SMTP id lf10so1766611pab.4
        for <git@vger.kernel.org>; Wed, 29 Jan 2014 05:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=iVte+myd86x2pqooB80TDKoI/398WOTd7Y1eJ6dchOU=;
        b=ZcPKcvl+EgeI9OJY1oq3qWbl9h6//aXnDfQaTkNvI+mk4KpT3me4Sieg0lZFYeWUOZ
         r8omzbZDRatqCz3l875u5g7ZDN0Q+0gZewwqkvsE0I+bYAMooNbuFAOQTeCuXr3aiiJF
         0530HcdLay4ZyulkHhtWu256vdiM3LOJ7Zz8WQq3L0xo/5MfZJq+iLqTQM/pbdppRpkT
         TrTPv3M6F++OUxsl9vFi8GSW41WYGx0Dio/+/RfNgCn5KtM1QootOLfsn1pud51vQHvX
         Co4pS/lmAK02ktuLUzfs0h3POr/FXBW+hOakRg85vXE1vDtFSkqhz5adlrPPYKd3dVD/
         5rww==
X-Received: by 10.67.8.102 with SMTP id dj6mr7964008pad.10.1391001904764;
        Wed, 29 Jan 2014 05:25:04 -0800 (PST)
Received: from devzero2000ubu.nephoscale.com (140.195.207.67.nephoscale.net. [67.207.195.140])
        by mx.google.com with ESMTPSA id om6sm7194225pbc.43.2014.01.29.05.25.03
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Jan 2014 05:25:04 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241208>

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 bisect.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index 37200b4..8448d27 100644
--- a/bisect.c
+++ b/bisect.c
@@ -685,7 +685,6 @@ static void mark_expected_rev(char *bisect_rev_hex)
 
 static int bisect_checkout(char *bisect_rev_hex, int no_checkout)
 {
-	int res;
 
 	mark_expected_rev(bisect_rev_hex);
 
@@ -696,6 +695,7 @@ static int bisect_checkout(char *bisect_rev_hex, int no_checkout)
 			die("update-ref --no-deref HEAD failed on %s",
 			    bisect_rev_hex);
 	} else {
+		int res;
 		res = run_command_v_opt(argv_checkout, RUN_GIT_CMD);
 		if (res)
 			exit(res);
-- 
1.7.10.4
