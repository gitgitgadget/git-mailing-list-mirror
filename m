From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 20/28] rebase: cherry-pick: set correct action-name
Date: Fri, 30 Aug 2013 00:56:14 -0500
Message-ID: <1377842182-18724-21-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmc-0007iQ-D2
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755894Ab3H3GBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:01:53 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:47209 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GBv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:01:51 -0400
Received: by mail-ob0-f180.google.com with SMTP id v19so1480868obq.11
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ctlz2pHijvpbF50rUNaaT14+BMXNWI9US0h+7iXgx2M=;
        b=eA3wogbsxQFMAEWeaFuc8xmLBjr+YVlguOD+uwR1KYdIdLQfrQ13/Mx+mNP103GQ2e
         eC26ydr8uzoQcoeVM8qVyuimBy1XOveekePntBnJNUxpzxQVLkcA+XzkV7Wyubz8eA9D
         Fgrwl+qKstGs0lbx1hc2kxeomE5NoadJ2fEIzZfYm3mg1I36iuUb4upWlZcx+94l0KuC
         qEKBXhwFu8YlP55NOh9sQeicvAkye3vtc5bz5PbRDjb1bI8T1+1Ta+uewBjrMWWtHzjS
         /rjlPKszYpuQ46r8WN7rnYQHsQD+++R4Wz5XoqxpTn4LwbSDF9ysI7fC7ELkyMCRQCws
         IgRw==
X-Received: by 10.182.48.130 with SMTP id l2mr5124015obn.44.1377842511376;
        Thu, 29 Aug 2013 23:01:51 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id it7sm35732367obb.11.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:01:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233416>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 241cda7..d36b0dc 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -45,7 +45,7 @@ else
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
-git cherry-pick --no-merges --right-only --topo-order --do-walk $extra "$revisions"
+git cherry-pick --no-merges --right-only --topo-order --do-walk --action-name rebase $extra "$revisions"
 ret=$?
 
 if test 0 != $ret
-- 
1.8.4-fc
