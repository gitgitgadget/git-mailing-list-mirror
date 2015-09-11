From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] pull: don't mark values for option "rebase" for translation
Date: Fri, 11 Sep 2015 17:53:17 +0200
Message-ID: <1441986797-21734-1-git-send-email-ralf.thielow@gmail.com>
Cc: gitster@pobox.com, pyokagan@gmail.com, worldhello.net@gmail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 11 17:53:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaQdh-0001FD-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 17:53:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753148AbbIKPxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 11:53:22 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:37535 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084AbbIKPxV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 11:53:21 -0400
Received: by wicfx3 with SMTP id fx3so63230213wic.0
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 08:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=4N2/v6WB12aRFwYVl1ESPzNKv4E0C78obUuaDmYdHM8=;
        b=bS7SGu1+yP/S61GLUxsGP0k7+vT7tWqNd8vimtk1FowAHNphBpE42dL3erVWMVUB4U
         GYWOm7UuXekNgcy1gV7hCmYqM+rG9KJsMrZw1tcoqnzyhf1KNjmIxVpNcJpeq4shfdSC
         Ga/OvCFlAFsghlXEcaIVXOmRqLXM68lVg9rlAic+dl2zWM0/myKh6k/dN0SOe+oSmot9
         Z0Ab5OQmgC8x+o14yYpxqe4d1EgusmCBgFK7Al50s47Lw3MbafPUNcc79vSsDm4PtQMq
         9/cWhMaOV3TQk1/S0R9bx6pC2Lx2IJluMKvS8R7+PYQvkJOSSD1+6/Ce1evo1NFHYK4h
         8qVg==
X-Received: by 10.180.72.35 with SMTP id a3mr17679029wiv.21.1441986800197;
        Fri, 11 Sep 2015 08:53:20 -0700 (PDT)
Received: from localhost (cable-94-139-9-29.cust.telecolumbus.net. [94.139.9.29])
        by smtp.gmail.com with ESMTPSA id fs9sm1146694wic.24.2015.09.11.08.53.19
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Fri, 11 Sep 2015 08:53:19 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc1.199.g678474c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277675>

"false|true|preserve" are actual values for option "rebase"
of the "git-pull" command and should therefore not be marked
for translation.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 builtin/pull.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pull.c b/builtin/pull.c
index 7e3c11e..a39bb0a 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -112,7 +112,7 @@ static struct option pull_options[] = {
 	/* Options passed to git-merge or git-rebase */
 	OPT_GROUP(N_("Options related to merging")),
 	{ OPTION_CALLBACK, 'r', "rebase", &opt_rebase,
-	  N_("false|true|preserve"),
+	  "false|true|preserve",
 	  N_("incorporate changes by rebasing rather than merging"),
 	  PARSE_OPT_OPTARG, parse_opt_rebase },
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
-- 
2.6.0.rc1.199.g678474c
