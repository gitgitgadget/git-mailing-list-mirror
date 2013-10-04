From: Greg Jacobson <coder5000@gmail.com>
Subject: [PATCH v3] push: Enhance unspecified push default warning
Date: Fri, 4 Oct 2013 10:20:07 -0400
Message-ID: <CAKYC+eKCsRbF=6HtcY8ZtaafTDpbMFJ1tyWbaZDKrmbzdnOoUw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>,
	Duy Nguyen <pclouds@gmail.com>, philipoakley@iee.org
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Oct 04 16:20:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VS6Es-0004mu-Qi
	for gcvg-git-2@plane.gmane.org; Fri, 04 Oct 2013 16:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754883Ab3JDOUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Oct 2013 10:20:11 -0400
Received: from mail-oa0-f48.google.com ([209.85.219.48]:52910 "EHLO
	mail-oa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754395Ab3JDOUI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Oct 2013 10:20:08 -0400
Received: by mail-oa0-f48.google.com with SMTP id m6so3945523oag.7
        for <git@vger.kernel.org>; Fri, 04 Oct 2013 07:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=koIkcD6c0I1OCWGqbmO+3+BGIB7DBT/QQmNpz4F7L3I=;
        b=G5xH9Fmze/V28zOSTrvXwZlTi6UQfAW6bVmrIg4+UyiOX3e/D6ml6lN6sxHsAc+iVo
         HkPPVjZ3HjdiU1WsJe0kSfMq+lChqErn3rSW9i1vqPu02r0HyXT/MB6d6duqTnLY19B2
         GrW34cLYv4lwkSnyGjKScPK24vkIlI0CViFBIhm4nHcGsMjEqsimmkz8EuODZXiPSjiJ
         JX5yVwrjWsIPEkEOJXtxLwh4Dr9bYtcYsuV+6zTn1r06vtacYxQ4HuvrgxBWrUKiH+4d
         iriUx90J3KSb8wnVVzpvLZ+eZLnPNBXPxyU3d2/9u49VlaOF0q3hZJ/mpMTCM7Vk6Dqb
         E5Ig==
X-Received: by 10.60.78.227 with SMTP id e3mr21991550oex.5.1380896407998; Fri,
 04 Oct 2013 07:20:07 -0700 (PDT)
Received: by 10.76.80.134 with HTTP; Fri, 4 Oct 2013 07:20:07 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235713>

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
index 7b1b66c..5393e28 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -174,6 +174,15 @@ N_("push.default is unset; its implicit value is
changing in\n"
    "\n"
    "  git config --global push.default simple\n"
    "\n"
+   "When push.default is set to 'matching', git will push all local branches\n"
+   "to the remote branches with the same (matching) name.  This will no\n"
+   "longer be the default in Git 2.0 because a branch could be\n"
+   "unintentionally pushed to a remote.\n"
+   "\n"
+   "In Git 2.0 the new push.default of 'simple' will push only the current\n"
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
