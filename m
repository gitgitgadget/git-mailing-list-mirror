From: Ori Avtalion <ori@avtalion.name>
Subject: [PATCH] pull: remove extra space from reflog message
Date: Fri, 29 Jul 2011 10:19:26 +0300
Message-ID: <4e3260f8.41d0e30a.741c.51cb@mx.google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 09:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QmhUH-0003VY-ER
	for gcvg-git-2@lo.gmane.org; Fri, 29 Jul 2011 09:28:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab1G2H14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jul 2011 03:27:56 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:60003 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147Ab1G2H1z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2011 03:27:55 -0400
Received: by wyg8 with SMTP id 8so639194wyg.19
        for <git@vger.kernel.org>; Fri, 29 Jul 2011 00:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:sender:from:to:date:subject;
        bh=d91uiTO2hZ6aZnFOCbf3r7qrwsW/rMna0mcptmPkKXo=;
        b=M0dIFzvBN0fIZC83qzitc4q21tVA4+hh3BRWsJpP1D2dsBoR/gqnrZI8wCYjFDQ5ZQ
         O5kMxjDXjP45Hiuc4U+f6bjt1hkmAu18Dwa9WgmXxLpMMpsBR7eiCCOMCI45SjE5iIVT
         2bRLGC757/EJUqnV7rh/JpjXwZgE7oX4uFbRo=
Received: by 10.227.11.137 with SMTP id t9mr1530046wbt.9.1311924474001;
        Fri, 29 Jul 2011 00:27:54 -0700 (PDT)
Received: from localhost6.localdomain6 (bzq-79-178-24-212.red.bezeqint.net [79.178.24.212])
        by mx.google.com with ESMTPS id gb1sm1506217wbb.3.2011.07.29.00.27.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 00:27:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178128>

When executing "git pull" with no arguments, the reflog message was:
  "pull : Fast-forward"

Signed-off-by: Ori Avtalion <ori@avtalion.name>
---

This is a correction of my earlier patch, based on the suggestion
by Andreas Schwab

 git-pull.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-pull.sh b/git-pull.sh
index a10b129..eec3a07 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -10,7 +10,7 @@ SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
 . git-sh-i18n
-set_reflog_action "pull $*"
+set_reflog_action "pull${1+ $*}"
 require_work_tree
 cd_to_toplevel
 
-- 
1.7.4.1
