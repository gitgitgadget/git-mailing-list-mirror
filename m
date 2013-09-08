From: Johan Herland <johan@herland.net>
Subject: [PATCHv2 3/5] Refer to branch.<name>.remote/merge when documenting --track
Date: Sun,  8 Sep 2013 22:58:13 +0200
Message-ID: <1378673895-23127-4-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
 <1378673895-23127-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Sep 08 22:58:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VIm4D-0003Eo-Pi
	for gcvg-git-2@plane.gmane.org; Sun, 08 Sep 2013 22:58:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751290Ab3IHU6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Sep 2013 16:58:31 -0400
Received: from mail-la0-f48.google.com ([209.85.215.48]:53795 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751270Ab3IHU6a (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Sep 2013 16:58:30 -0400
Received: by mail-la0-f48.google.com with SMTP id er20so4285301lab.35
        for <git@vger.kernel.org>; Sun, 08 Sep 2013 13:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6DTmG30EmsUm/DmOTS+PQlfE0BoBrB82Jsm94nGzOMc=;
        b=fduekhczA5FrGroaLkV/5YGiKxMJ9fCAwCOmSBG1ZORUuVoJtRhAoG0IU24K6147ZH
         D4lEsyBERvFx7dq3beLAwmkzqfU+tsKFrI6oDDkPe2NlRIwVNNXN8G/mAJkBz46UXHbD
         A8pH4IbDKG/IYUX18De3xFeJrr7SPUvR+ohgpxv6DyODeszdAeprnXG3/kNAyLGoQQ5M
         TSrL5rRc/7jjfeEKsO7hjqlPJkdent6W6pL+Tvw1PYaRF/LM4vT+UWC91/5/hnCeHMuf
         X+b4zpZR4T9UkqWpylJeESPamwQSj2MS0/Nl45OYPW5H4/VPq/cxY2VcQyAEvBO9ubz1
         RPfw==
X-Received: by 10.152.5.162 with SMTP id t2mr13148751lat.1.1378673909119;
        Sun, 08 Sep 2013 13:58:29 -0700 (PDT)
Received: from beta.herland (cm-84.208.177.71.getinternet.no. [84.208.177.71])
        by mx.google.com with ESMTPSA id vo1sm4292384lbb.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 08 Sep 2013 13:58:28 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378673895-23127-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234270>

Make it easier for readers to find the actual config variables that
implement the "upstream" relationship.

Suggested-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-branch.txt | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index b7cb625..311b336 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -48,7 +48,8 @@ working tree to it; use "git checkout <newbranch>" to switch to the
 new branch.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
-branch so that 'git pull' will appropriately merge from
+branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
+configuration entries) so that 'git pull' will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
 `branch.autosetupmerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
@@ -156,7 +157,8 @@ This option is only applicable in non-verbose mode.
 
 -t::
 --track::
-	When creating a new branch, set up configuration to mark the
+	When creating a new branch, set up `branch.<name>.remote` and
+	`branch.<name>.merge` configuration entries to mark the
 	start-point branch as "upstream" from the new branch. This
 	configuration will tell git to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
-- 
1.8.3.GIT
