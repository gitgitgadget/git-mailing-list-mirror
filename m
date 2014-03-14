From: Nemina Amarasinghe <neminaa@gmail.com>
Subject: [PATCH] simplifying branch.c:install_branch_config() if()
Date: Fri, 14 Mar 2014 07:15:58 +0530
Message-ID: <1394761558-4888-1-git-send-email-neminaa@gmail.com>
Cc: Nemina Amarasinghe <neminaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 14 02:46:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOHCZ-0005ic-Pb
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 02:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754381AbaCNBqT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2014 21:46:19 -0400
Received: from mail-pb0-f41.google.com ([209.85.160.41]:63601 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752735AbaCNBqT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2014 21:46:19 -0400
Received: by mail-pb0-f41.google.com with SMTP id jt11so1924547pbb.0
        for <git@vger.kernel.org>; Thu, 13 Mar 2014 18:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=sbEJSLDx2PeJH+Ahut3WV4GrPIKZy71hrDlXsoGd2B4=;
        b=ewckMUhhH2E9emjd/oF4SDSjnChWPW+sDaRVMABCjDMeSv4uEVhJeVmOGJo1bkAWza
         0pbM/g6xGoFFPno8Hoj5hiaHc04LgKMBjgnDkHgjhSi0HAoPcT0k7XwAdc3UdSqdpBun
         wnvxngvCvosVqlq52zM95Hf5u3syhZBYyari7dRkZ5xSKCh4ZBIc4FY4G6z169bQzi+1
         ycY8mGrmHcsJ9sXwvfhmMzXkfwlW337VRxe1gSW4HsmjeNkSbmU4VbbOOJeaIKF3DsMB
         ZZgnPFPs0+9uVGmoOIutkYxuCCPpLUvHAMihX3SF7W4gcGO3mEdKP/0R1siwhOpAWpBI
         ezOw==
X-Received: by 10.66.164.229 with SMTP id yt5mr6048142pab.67.1394761578679;
        Thu, 13 Mar 2014 18:46:18 -0700 (PDT)
Received: from localhost.localdomain ([61.245.163.57])
        by mx.google.com with ESMTPSA id rk15sm17439724pab.37.2014.03.13.18.46.13
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 13 Mar 2014 18:46:16 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.152.g6ab4ae2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244067>

Signed-off-by: Nemina Amarasinghe <neminaa@gmail.com>
---
 branch.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/branch.c b/branch.c
index 723a36b..fd93603 100644
--- a/branch.c
+++ b/branch.c
@@ -87,16 +87,11 @@ void install_branch_config(int flag, const char *local, const char *origin, cons
 				  _("Branch %s set up to track local branch %s by rebasing.") :
 				  _("Branch %s set up to track local branch %s."),
 				  local, shortname);
-		else if (!remote_is_branch && origin)
+		else if (!remote_is_branch)
 			printf_ln(rebasing ?
 				  _("Branch %s set up to track remote ref %s by rebasing.") :
 				  _("Branch %s set up to track remote ref %s."),
 				  local, remote);
-		else if (!remote_is_branch && !origin)
-			printf_ln(rebasing ?
-				  _("Branch %s set up to track local ref %s by rebasing.") :
-				  _("Branch %s set up to track local ref %s."),
-				  local, remote);
 		else
 			die("BUG: impossible combination of %d and %p",
 			    remote_is_branch, origin);
-- 
1.9.0.152.g6ab4ae2
