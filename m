From: Greg Jacobson <coder5000@gmail.com>
Subject: [PATCH v2] push: Enhance unspecified push default warning
Date: Thu, 3 Oct 2013 16:43:55 -0400
Message-ID: <CAKYC+eJYgjZ1cZ2kA1v+nSN0ADA_ZPFgfYQ6_zR2PuYGBhi+3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Duy Nguyen <pclouds@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 03 22:44:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRpkf-0006SV-3h
	for gcvg-git-2@plane.gmane.org; Thu, 03 Oct 2013 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab3JCUn5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Oct 2013 16:43:57 -0400
Received: from mail-oa0-f68.google.com ([209.85.219.68]:40284 "EHLO
	mail-oa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755093Ab3JCUn4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Oct 2013 16:43:56 -0400
Received: by mail-oa0-f68.google.com with SMTP id l10so696080oag.7
        for <git@vger.kernel.org>; Thu, 03 Oct 2013 13:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=kno5YGjbnxUQ1KrVVs9lM/eIBLkGkWtubk1ZMFp490k=;
        b=RW6sINoC78HFY7manLp2gaI1RWRHbjmQpIhkz722BPrGE7WE4GtctPNvfYZpZuGS/W
         rWFb9vR83qcp11TyE/7dMcdpMg1b/l0MyWE9AWK6/nPFkx1qeMkIC+qZpfyd+wz/I3/r
         rY15lUhoVHvZjZDnuHzN1xj9YigfKSuYkEbJk1rNrZJQIrZxV/naTkMBsCLBZVut1Ow1
         Z39JUuyxf9UlyCGWaiE5UJDQZ8IJzU4qOr5nD/clsS+Db+T+O0we7YrpMKzIlyGu6r/8
         AyO84k/lA9IQWHq+xdKYijtFZe0MBnLSX6QN6/KQ/WRcLsyQCNFl6+jx5CrU+k62Xi67
         tu/w==
X-Received: by 10.60.141.225 with SMTP id rr1mr3871483oeb.55.1380833035921;
 Thu, 03 Oct 2013 13:43:55 -0700 (PDT)
Received: by 10.76.80.134 with HTTP; Thu, 3 Oct 2013 13:43:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235694>

When the unset push.default warning message is displayed
this may be the first time many users encounter push.default.
Modified the warning message to explain in a compact
manner what push.default is and why it is being changed in
Git 2.0.  Also provided additional information to help users
decide if this change will affect their workflow.

Signed-off-by: Greg Jacobson <coder5000@gmail.com>
---
 builtin/push.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 7b1b66c..eb7a721 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -174,6 +174,15 @@ N_("push.default is unset; its implicit value is
changing in\n"
    "\n"
    "  git config --global push.default simple\n"
    "\n"
+   "When push.default is set to matching git will push all local branches\n"
+   "to the remote branches with the same (matching) name.  This will no\n"
+   "longer be the default in Git 2.0 because a branch could be\n"
+   "unintentionally pushed to a remote.\n"
+   "\n"
+   "In Git 2.0 the new push.default of simple will push only the current\n"
+   "branch to the same remote branch used by git pull.   A push will\n"
+   "only succeed if the remote and local branches have the same name.\n"
+   "\n"
    "See 'git help config' and search for 'push.default' for further
information.\n"
    "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
    "'current' instead of 'simple' if you sometimes use older versions
of Git)");
-- 
1.8.4.474.g128a96c.dirty
