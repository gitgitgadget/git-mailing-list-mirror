From: Coder Coder5000 <coder5000@gmail.com>
Subject: [PATCH] push: Enhance unspecified push default warning
Date: Wed, 2 Oct 2013 16:48:55 -0400
Message-ID: <CAKYC+eLGS6ocdE7CTV25E2xMRaHijmQbFBc3tAyx3cNpXfC_sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 02 22:49:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VRTMD-0004au-04
	for gcvg-git-2@plane.gmane.org; Wed, 02 Oct 2013 22:49:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754063Ab3JBUtB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Oct 2013 16:49:01 -0400
Received: from mail-oa0-f67.google.com ([209.85.219.67]:58444 "EHLO
	mail-oa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754027Ab3JBUs4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Oct 2013 16:48:56 -0400
Received: by mail-oa0-f67.google.com with SMTP id i4so324356oah.6
        for <git@vger.kernel.org>; Wed, 02 Oct 2013 13:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=8x26e2LWt0xfhilF/4mb5Wu9tUAkgLqR9bOtysnKyQc=;
        b=mfiD6DGh48pTr+fSRAx6BmHdV0u7RKHQApJLKQycnEyxMFHGXzNa9gjRtq0hel3zAY
         jMbx9lnx9yChxX5DbhJza6jz7Ngpd8CQiNrFfD6TxJ25kLcnIXutkA2kWMkIC+9Vk2bR
         rNhx0UGyOrNQNvtjn0fpD6ZcYCZY/b/nLjtSHoZOvF0riYEnQJGQGz9Ture13Rycgpsd
         uaLu+XiSn2o7HMmOpRn4pJ3AgB3r0KbSm8ZHyOg6XqL6cZ0TvltU1l4GnGY6Z+XncsTL
         DO6W2xcqeudruBVCFcDBlpKYrVzlhlzfDg434UaNNpflNgurRosgDXOhDXSzuiocI/V9
         aPcQ==
X-Received: by 10.60.80.167 with SMTP id s7mr6560951oex.38.1380746936052; Wed,
 02 Oct 2013 13:48:56 -0700 (PDT)
Received: by 10.76.80.134 with HTTP; Wed, 2 Oct 2013 13:48:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235675>

When the unset push.default warning message is displayed
this may be the first time many users encounter push.default.
Modified the warning message to explain in a compact
manner what push.default is and why it is being changed in
Git 2.0.  Also provided additional information to help users
decide if this change will affect their workflow.

Signed-off-by: Greg Jacobson <coder5000@gmail.com>
---
 builtin/push.c | 9 +++++++++
 po/git.pot     | 8 ++++++++
 2 files changed, 17 insertions(+)

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
diff --git a/po/git.pot b/po/git.pot
index c91e197..6025a54 100644
--- a/po/git.pot
+++ b/po/git.pot
@@ -7240,6 +7240,14 @@ msgid ""
 "\n"
 "  git config --global push.default simple\n"
 "\n"
+"When push.default is set to matching git will push all local branches\n"
+"to the remote branches with the same (matching) name.  This will no\n"
+"longer be the default in Git 2.0 because a branch could be\n"
+"unintentionally pushed to a remote.\n"
+"\n"
+"In Git 2.0 the new push.default of simple will push only the current\n"
+"branch to the same remote branch used by git pull.   A push will\n"
+"only succeed if the remote and local branches have the same name.\n"
 "See 'git help config' and search for 'push.default' for further "
 "information.\n"
 "(the 'simple' mode was introduced in Git 1.7.11. Use the similar mode\n"
-- 
1.8.4.474.g128a96c.dirty
