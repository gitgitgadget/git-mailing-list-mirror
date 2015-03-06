From: Akshay Aurora <akshayaurora@yahoo.com>
Subject: [PATCH][GSoC] revision: forbid --graph and --no-walk usage
Date: Fri,  6 Mar 2015 00:13:30 -0500
Message-ID: <1425618810-21192-1-git-send-email-akshayaurora@yahoo.com>
Cc: Akshay Aurora <akshayaurora@yahoo.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 06 06:13:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTkZx-00006u-ER
	for gcvg-git-2@plane.gmane.org; Fri, 06 Mar 2015 06:13:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752310AbbCFFNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2015 00:13:37 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:46526 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752043AbbCFFNg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2015 00:13:36 -0500
Received: by qgfh3 with SMTP id h3so10337251qgf.13
        for <git@vger.kernel.org>; Thu, 05 Mar 2015 21:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=cyLzBfRgdoM3VutwBb6mcG0SiaRlzsOqDWWB0QxJbAs=;
        b=M5qiPEgthsCSM+mzSGNbowaSN48mQsc7dAJry2dCN5QGeeCN9ibvnw5oWA8QGhvTKY
         4K63RZzCvUA/75uhVDVtVkNRC1zb6HpI/DbxgAciQ2FNivwMOWWAzZFjtZPxWJDlII3N
         CONhpGCP+Jxx+UMSRf8f0V4xzhQU2qcjf63YGAOfzmFWDTGivxfdZ9qkYjvpL4gSZOkR
         QzCJDFY4tbtGHb1uB9Hp2py1RTxzLSY51P2xBj2Gtv5QosXqxO3FXJWy4eGgSLrV8SK3
         XEPbJvyTNS8QDpEgkBCrPilZGZLAI1nT7TRxUf1BdWGIDEyBnqmoaSDkgVTJdpDqytB7
         oZxw==
X-Received: by 10.55.23.83 with SMTP id i80mr20266458qkh.104.1425618816018;
        Thu, 05 Mar 2015 21:13:36 -0800 (PST)
Received: from skyblock.com ([162.243.59.241])
        by mx.google.com with ESMTPSA id d186sm5139132qhc.3.2015.03.05.21.13.34
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 05 Mar 2015 21:13:35 -0800 (PST)
X-Mailer: git-send-email 2.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264890>

Signed-off-by: Akshay Aurora <akshayaurora@yahoo.com>
---
This is my first patch for a GSoC Microproject, would be great to have your feedback.

 revision.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index bd027bc..d578652 100644
--- a/revision.c
+++ b/revision.c
@@ -2248,7 +2248,8 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	 */
 	if (revs->reverse && revs->graph)
 		die("cannot combine --reverse with --graph");
-
+	if (revs->no_walk && revs->graph)
+		die("cannot combine --no-walk with --graph");
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
-- 
2.3.1
