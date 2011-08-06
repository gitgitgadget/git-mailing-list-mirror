From: Jon Seymour <jon.seymour@gmail.com>
Subject: [PATCH 15/40] whitespace: remediate t5400-send-pack.sh
Date: Sat,  6 Aug 2011 18:44:29 +1000
Message-ID: <1312620294-18616-15-git-send-email-jon.seymour@gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
 <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Cc: Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 06 10:45:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpcVx-000510-S1
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 10:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754611Ab1HFIpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Aug 2011 04:45:43 -0400
Received: from mail-iy0-f170.google.com ([209.85.210.170]:39722 "EHLO
	mail-iy0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754092Ab1HFIpk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2011 04:45:40 -0400
Received: by mail-iy0-f170.google.com with SMTP id 16so5182410iye.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 01:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=4BE4K4lNgAoleMLE3UZFD2hXVifMU8Rb2NMIpFJGDtA=;
        b=YxPMonodAp7MJgI053NhcmjnjRAn5cfSBQxPHlzhbDCNP+Ex0uSGfLuWfwmsLrnBns
         fcIGBK89ntWcyds+9G8cR8LYpO4WW9EKBteGS9AwYsSAvPOqaCRNbDB1WiJUVGKa7JQX
         pEmPMBOiJfhjDUbUGE1R5cBahC7ZoW3f1R0hM=
Received: by 10.231.55.143 with SMTP id u15mr919321ibg.58.1312620340223;
        Sat, 06 Aug 2011 01:45:40 -0700 (PDT)
Received: from localhost.localdomain (124-169-144-208.dyn.iinet.net.au [124.169.144.208])
        by mx.google.com with ESMTPS id a10sm2667049iba.7.2011.08.06.01.45.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 06 Aug 2011 01:45:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.362.gf0e6
In-Reply-To: <1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178841>

This file was edited by applying:

	 expand -i | unexpand --first-only | sed "s/ *$//"

to the file.

No change to test outputs or status code was observed.

Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
---
 t/t5400-send-pack.sh |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t5400-send-pack.sh b/t/t5400-send-pack.sh
index 0eace37..8e214b0 100755
--- a/t/t5400-send-pack.sh
+++ b/t/t5400-send-pack.sh
@@ -77,7 +77,7 @@ test_expect_success 'refuse pushing rewound head without --force' '
 '
 
 test_expect_success \
-        'push can be used to delete a ref' '
+	'push can be used to delete a ref' '
 	( cd victim && git branch extra master ) &&
 	git send-pack ./victim :extra master &&
 	( cd victim &&
@@ -187,7 +187,7 @@ test_expect_success 'pushing explicit refspecs respects forcing' '
 	(
 	    cd child &&
 	    git send-pack ../parent \
-	        +refs/heads/master:refs/heads/master
+		+refs/heads/master:refs/heads/master
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	child_head=$(cd child && git rev-parse --verify master) &&
@@ -200,14 +200,14 @@ test_expect_success 'pushing wildcard refspecs respects forcing' '
 	(
 	    cd child &&
 	    test_must_fail git send-pack ../parent \
-	        "refs/heads/*:refs/heads/*"
+		"refs/heads/*:refs/heads/*"
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	test "$parent_orig" = "$parent_head" &&
 	(
 	    cd child &&
 	    git send-pack ../parent \
-	        "+refs/heads/*:refs/heads/*"
+		"+refs/heads/*:refs/heads/*"
 	) &&
 	parent_head=$(cd parent && git rev-parse --verify master) &&
 	child_head=$(cd child && git rev-parse --verify master) &&
-- 
1.7.6.362.gf0e6
