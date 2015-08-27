From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] reflog: add missing single quote to error message
Date: Wed, 26 Aug 2015 22:26:02 -0600
Message-ID: <1440649562-3421-1-git-send-email-alexhenrie24@gmail.com>
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Aug 27 06:26:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUolV-00022y-FU
	for gcvg-git-2@plane.gmane.org; Thu, 27 Aug 2015 06:26:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752653AbbH0E0M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2015 00:26:12 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34106 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752210AbbH0E0J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2015 00:26:09 -0400
Received: by pabzx8 with SMTP id zx8so11027561pab.1
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 21:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=3g6aAPT1f9Ht63tx07VopwXLlS/9hv4DxnL3wpVjvrA=;
        b=igH/7CWzVFmTCuE88yjvhTag3zpPpM5tnpB3ORqNbADQNaUmiI/r4NCUVpQvLVo7GU
         NiSk1965opV+WblSzDMQ8srgazY2Bku8b2mJFQb5izjzeHW2I3mjw45pjiSyPQbP5Fc4
         MghptnRYL866hCyxCoHQ9BXbjI7dE05rgHc71xbQeHXqeGXFLnYKjm7APfn9KsULI/RW
         8v7J5j/KwW3IdNHs7d8T87ly8GcDzkM0SuN3Dqb1hRzquBBLeZDpUJLBM3SNbk7/aqsm
         606M3CYJ1fseEsdwtzCIih9fEJQJu601CDFz28nsSUD6pELA+9/tBy9OMF09PCdrnXT7
         HvgA==
X-Received: by 10.66.227.98 with SMTP id rz2mr4034218pac.16.1440649569063;
        Wed, 26 Aug 2015 21:26:09 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id j4sm699983pdk.9.2015.08.26.21.26.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Aug 2015 21:26:08 -0700 (PDT)
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276656>

The error message can be seen by running
`git config gc.reflogexpire foo` and then `git reflog expire`.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 builtin/reflog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/reflog.c b/builtin/reflog.c
index 7ed0e85..f96ca2a 100644
--- a/builtin/reflog.c
+++ b/builtin/reflog.c
@@ -429,7 +429,7 @@ static int parse_expire_cfg_value(const char *var, const char *value, unsigned l
 	if (!value)
 		return config_error_nonbool(var);
 	if (parse_expiry_date(value, expire))
-		return error(_("%s' for '%s' is not a valid timestamp"),
+		return error(_("'%s' for '%s' is not a valid timestamp"),
 			     value, var);
 	return 0;
 }
-- 
2.5.0
