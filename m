From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH] branch: say "Reset to" in reflog entries for 'git branch -f' operations
Date: Fri,  9 Apr 2010 15:45:12 +0800
Message-ID: <1270799112-4308-1-git-send-email-rctay89@gmail.com>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 09 09:45:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O08uU-0000Su-9W
	for gcvg-git-2@lo.gmane.org; Fri, 09 Apr 2010 09:45:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756355Ab0DIHpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 03:45:32 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:47544 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756321Ab0DIHpb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 03:45:31 -0400
Received: by qw-out-2122.google.com with SMTP id 8so1107821qwh.37
        for <git@vger.kernel.org>; Fri, 09 Apr 2010 00:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :message-id:x-mailer;
        bh=oJ+gJqmA/A7Z9bg6sYSJSxGG83ZPuRkHy4ZrC0mZj/E=;
        b=Tz71EsBgeSiEA0PrOUWRZCbxN3QoD7XGZm1+JmjJ/9ilXi4Njd4r1yTVEh7Da3USJ3
         hIMaHkjtF5Np0bXrClbiLrhkLf3Ntwxp/PfTLrHAhToARIGZoo8XkdkciXvwzQE0gQEO
         uZYG76KYNT7znKHZFS8Lgqvs48O3E1DF+4vvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:message-id:x-mailer;
        b=chN5Ee/cW42BFTy+ASRQQ174CMfqe9GiJGzjcJVGH0BYTvM11FjG12lAQPMhEI/4Qe
         K8QjVqj9QvMRMOQtbZE82rh1IJ2AJkKiZjmNGypxueKQYcscOBcZJGNzWSJTDMiCb470
         oO7x9bJp2GfNFzQVoqs70w6m5Joha8/bww6Zo=
Received: by 10.229.227.5 with SMTP id iy5mr1752925qcb.29.1270799129913;
        Fri, 09 Apr 2010 00:45:29 -0700 (PDT)
Received: from localhost.localdomain (cm46.zeta153.maxonline.com.sg [116.87.153.46])
        by mx.google.com with ESMTPS id v37sm1447322qce.12.2010.04.09.00.45.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Apr 2010 00:45:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.rc0.240.gba75f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144414>

In 5f856dd (fix reflog entries for "git-branch"), it is mentioned that
'git branch -f' is intended to be equivalent to 'git reset'. Since we
usually say "reset to <commit>" in the git-reset Documentation and
elsewhere, it would make sense to say "Reset to" here as well.

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---

  I happened to be perusing my branch's reflog when I spotted this.

 branch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/branch.c b/branch.c
index 9e1f63e..2ab42aa 100644
--- a/branch.c
+++ b/branch.c
@@ -198,7 +198,7 @@ void create_branch(const char *head,
 		log_all_ref_updates = 1;

 	if (forcing)
-		snprintf(msg, sizeof msg, "branch: Reset from %s",
+		snprintf(msg, sizeof msg, "branch: Reset to %s",
 			 start_name);
 	else if (!dont_change_ref)
 		snprintf(msg, sizeof msg, "branch: Created from %s",
--
1.7.1.rc0.240.gba75f
