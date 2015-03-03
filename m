From: Sudhanshu Shekhar <sudshekhar02@gmail.com>
Subject: [PATCH] reset: allow "-" short hand for previous commit
Date: Wed,  4 Mar 2015 02:21:51 +0530
Message-ID: <1425415911-496-1-git-send-email-sudshekhar02@gmail.com>
Cc: SudShekhar <sudshekhar02@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 03 21:52:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YStnh-00076C-3V
	for gcvg-git-2@plane.gmane.org; Tue, 03 Mar 2015 21:52:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756745AbbCCUwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 15:52:17 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:37300 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756010AbbCCUwQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Mar 2015 15:52:16 -0500
Received: by paceu11 with SMTP id eu11so13194287pac.4
        for <git@vger.kernel.org>; Tue, 03 Mar 2015 12:52:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0HojFvUCCbtbZIwSRbJR/PdujvI9qATSChscb5pGfD0=;
        b=fE+nr/JX1wd6P3LdI3SYnemCNVbO5eVwbNGrKtfH/emnaIqj4El6HdZ7rtLT2YWa19
         I9U66C1+JdyrVe98XVit5NhoK0N+NX1/vdKjdvLscXNnw3zMOvW4hpY+0txYTM4mOWUK
         jtncU5hRqCsCGfs+Q/zu8bwwkTYN982lQa31u1sJfaCQqgRsaGAjHGVtUOYvacpVHI/x
         SyzoC4281prSQxjElkrRGihVT+itytB7KgBgBZQvecUen4gBuuJONgfu0JF4t+Xt6ixs
         vFVYY1y2NVFAO9r3wrCQlrKAjzfs5Bq5BqpNZcLli9lXKJGXeago/l0Cr8GBI13FI6On
         AbWA==
X-Received: by 10.68.224.71 with SMTP id ra7mr1081411pbc.140.1425415936153;
        Tue, 03 Mar 2015 12:52:16 -0800 (PST)
Received: from shekhar-Inspiron-N5110.iiit.ac.in ([14.139.82.6])
        by mx.google.com with ESMTPSA id n8sm1846754pdm.45.2015.03.03.12.52.13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Mar 2015 12:52:15 -0800 (PST)
X-Mailer: git-send-email 2.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264688>

From: SudShekhar <sudshekhar02@gmail.com>

Teach reset the same shorthand as checkout and merge. "-" means the
"previous commit".

Signed-off-by: Sudhanshu Shekhar <sudshekhar02@gmail.com>
---
This is done as a microproject for gsoc purposes. I am looking forward to your feedback/comments. Thanks
builtin/reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/reset.c b/builtin/reset.c
index 4c08ddc..3e0378b 100644
--- a/builtin/reset.c
+++ b/builtin/reset.c
@@ -205,6 +205,8 @@ static void parse_args(struct pathspec *pathspec,
 	 */
 
 	if (argv[0]) {
+		if(!strcmp(argv[0],"-"))
+			argv[0]="@{-1}";
 		if (!strcmp(argv[0], "--")) {
 			argv++; /* reset to HEAD, possibly with paths */
 		} else if (argv[1] && !strcmp(argv[1], "--")) {
-- 
2.3.1
