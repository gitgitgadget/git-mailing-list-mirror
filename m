From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT 23/28] The log.decorate setting should not influence guilt rebase.
Date: Fri, 21 Mar 2014 08:32:01 +0100
Message-ID: <1395387126-13681-24-git-send-email-cederp@opera.com>
References: <1395387126-13681-1-git-send-email-cederp@opera.com>
Cc: git@vger.kernel.org, Per Cederqvist <cederp@opera.com>
To: Jeff Sipek <jeffpc@josefsipek.net>
X-From: git-owner@vger.kernel.org Fri Mar 21 08:34:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQtxx-00035m-S0
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 08:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759917AbaCUHdi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 03:33:38 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:52781 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755780AbaCUHdf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 03:33:35 -0400
Received: by mail-la0-f48.google.com with SMTP id gf5so1391296lab.35
        for <git@vger.kernel.org>; Fri, 21 Mar 2014 00:33:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=d6UYuW+8XiRMKURN6fBBnWtLHRPa0uvb+Sb8rBfl12Q=;
        b=l6qBFtC5hcT3kj+bBGbGhlN0HBldYClQ+x3/IRVtCkH6ErxEMMQ3AIavy9+F4Yc6ox
         u61/uPE1752leduFOtPy1U0RnVCJIt7kpw20fFk4bFpjxSS2kYf3gcB4ueLiW2PEAOOq
         yVqM0fG9kNMOT9COt9jNb7jgVcvQT1HRMPHc85jnH4WYtfROEm12oi3yWFgl50ruUeZt
         Gze5rtCWTLx/SqHjoaYz+0pPNxoOtWL+vBapO9I3FTORvkRhN8+ytqd+Pu9gV5pcf6dX
         x7+aABh1bU3zNtoBBRs74EKhbNlpgTwH0jGY0WB3CSkSXjf4gidRy/xLgCw6KlBGhZVO
         AUiA==
X-Gm-Message-State: ALoCoQn1ccaxWhF3JY/eQ5n+z0SPPtzNnLQinRg393n+6jz12haE91DrRBfip/GCiy/nTJQcS9Kd
X-Received: by 10.112.181.232 with SMTP id dz8mr344420lbc.46.1395387214737;
        Fri, 21 Mar 2014 00:33:34 -0700 (PDT)
Received: from dualla.linkoping.osa (ip-200.t2.se.opera.com. [212.247.211.200])
        by mx.google.com with ESMTPSA id j2sm3986624lag.12.2014.03.21.00.33.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 21 Mar 2014 00:33:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1395387126-13681-1-git-send-email-cederp@opera.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244661>

Signed-off-by: Per Cederqvist <cederp@opera.com>
---
 guilt-rebase | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/guilt-rebase b/guilt-rebase
index fd28e48..a1714a0 100755
--- a/guilt-rebase
+++ b/guilt-rebase
@@ -66,7 +66,7 @@ pop_all_patches
 git merge --no-commit $upstream > /dev/null 2> /dev/null
 
 disp ""
-log=`git log -1 --pretty=oneline`
+log=`git log -1 --no-decorate --pretty=oneline`
 disp "HEAD is now at `echo $log | cut -c 1-7`... `echo "$log" | cut -c 41-`"
 
 #
-- 
1.8.3.1
