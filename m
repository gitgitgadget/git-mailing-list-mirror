From: Johan Herland <johan@herland.net>
Subject: [PATCH 3/5] Refer to branch.<name>.remote/merge when documenting --track
Date: Fri,  6 Sep 2013 12:40:40 +0200
Message-ID: <1378464042-17476-4-git-send-email-johan@herland.net>
References: <1378464042-17476-1-git-send-email-johan@herland.net>
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Per Cederqvist <cederp@opera.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Sep 06 12:41:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHtTt-00009X-1j
	for gcvg-git-2@plane.gmane.org; Fri, 06 Sep 2013 12:41:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751264Ab3IFKlW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Sep 2013 06:41:22 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:56921 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab3IFKlT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Sep 2013 06:41:19 -0400
Received: by mail-lb0-f173.google.com with SMTP id o14so2673025lbi.4
        for <git@vger.kernel.org>; Fri, 06 Sep 2013 03:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IPYiNqm+AuxU/3N2xUg1V1I3CALffALoT92MzfeB1Dc=;
        b=dk+63l5MOmncWJqH/KwMhLIN93nfMJNeeq9ooinQxVQk/CTyvtmG1Y1zpvV91B6uiU
         VXgLz6RJ2MeduTkDbJMZQStb5fPoeNHyqP1jk6XeKcd69czaDHkv/IZnBc9/KveKC7rn
         HpvAQSE7o6UlapAB4BC+hFQj6IUB9FOwzKNoRu+NrwFMgF6j0FJMmhY/7a3qsKl+FaG5
         IOzGNmkfkOnnF3wHgGE4EiBG2PBkyvEnlWGkcuula3DsS0qNSx6TnnWoSRSaH2qH0zL1
         6Wq91VtTNakxmFOlibSF+hUenMCQRwF1VC3ojfrpIl/wBK17NNbaQuG4za0id8kw+/Js
         6sHw==
X-Received: by 10.112.77.134 with SMTP id s6mr878488lbw.38.1378464078474;
        Fri, 06 Sep 2013 03:41:18 -0700 (PDT)
Received: from localhost.localdomain (c80-216-222-129.bredband.comhem.se. [80.216.222.129])
        by mx.google.com with ESMTPSA id vs11sm1000794lac.3.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 06 Sep 2013 03:41:17 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.GIT
In-Reply-To: <1378464042-17476-1-git-send-email-johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234036>

Make it easier for readers to find the actual config variables that
implement the "upstream" relationship.

Suggested-by: Per Cederqvist <cederp@opera.com>
Signed-off-by: Johan Herland <johan@herland.net>
---

In a private email exchange, Per noted that it was hard for someone reading
the git-branch docs to grasp what really happens when you use --track to
establish an "upstream" relationship. This adds a couple of references to
the config variables involved, and will hopefully make the upstream
relationship a little less "magic".

...Johan

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
