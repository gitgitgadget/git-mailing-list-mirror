Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BDF61F991
	for <e@80x24.org>; Mon, 31 Jul 2017 20:57:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751707AbdGaU5U (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 16:57:20 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33422 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdGaU5Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 16:57:16 -0400
Received: by mail-pf0-f194.google.com with SMTP id k72so24069667pfj.0
        for <git@vger.kernel.org>; Mon, 31 Jul 2017 13:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3QxqHKvbA9jtJFS3GTg3zDWjTzWsZYn6q0Nz8ZfCJ88=;
        b=HamnRpEeFZxxTq5BlZOjBPATbQ4cSrpTcnwzOuB/qjkjCe6Lbj3ViksIRhG9CgK+4Z
         byTkV6E3dbgyVy88GIu3mhwGIyN9qgDbGOE1GsrN6VjZIYcJcxzVk0xyTEtegN+jM1Q4
         GTvBBrzq6bOfHB38swZxa0rt4XsQFMhAdP6R4e76gw4MDGsxjTMi8WAgCopmLuGbEXL0
         99UFUgnQWdenfpvEofJUs0gYvUTh5kO4WYftLDwGuywf5RHnJB1WoPa8x0rNh1yeKhcY
         21zhLYkT+ZGlk3p87xAhm16kJb6Hf3evRJpWWgA1X+l4SktCdKV2oOYV+AC/fqwfE4CH
         iCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3QxqHKvbA9jtJFS3GTg3zDWjTzWsZYn6q0Nz8ZfCJ88=;
        b=ciwcvhbsz+xKChlTWpgmj7GQpw7FKNRMQTlRjw/Bu6JhzciQuEa9O3yBAcyMhTtbru
         THiVrtH/LAARBj1USDO/ZIqBndZgs7LlRs5RP3ATH8R4EWMUzAQ7WCQVPJBFFZkFlF60
         G0B4oRbiqP5Nvasmj8QS+U/R6h0JTUNttPgZmpqkNB0USz13MJ84fy4/kZiP45QE9mQt
         acvaqXrflLxDw39uYJcl5Ryh92rjoopyojkV08LScCM4xSv9L2SifwgUBDcIpNQfCPbn
         fkPUWbHvGpm+/dHOoUk2XcjFFR5AhtSVdlyF1quEC6AZqvD/luFPeHTN2aAOoyDPg5cD
         M6kQ==
X-Gm-Message-State: AIVw111WwzPDEWqLMjt8zQ1tnU1+cm6dEu2GyOv7wcClmTcmImYTCu62
        O+8eF5EPnd8EbPWKyATPrw==
X-Received: by 10.99.175.1 with SMTP id w1mr16707138pge.390.1501534635746;
        Mon, 31 Jul 2017 13:57:15 -0700 (PDT)
Received: from localhost.localdomain ([2405:205:6182:3b53:5da6:3508:cb8e:5545])
        by smtp.gmail.com with ESMTPSA id 16sm52881007pfq.151.2017.07.31.13.57.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 31 Jul 2017 13:57:15 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, christian.couder@gmail.com,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: [GSoC][PATCH 10/13] submodule foreach: document '$sm_path' instead of '$path'
Date:   Tue,  1 Aug 2017 02:26:18 +0530
Message-Id: <20170731205621.24305-11-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170731205621.24305-1-pc44800@gmail.com>
References: <20170731205621.24305-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As using a variable '$path' may be harmful to users due to
capitalization issues, see 64394e3ae9 (git-submodule.sh: Don't
use $path variable in eval_gettext string, 2012-04-17). Adjust
the documentation to advocate for using $sm_path,  which contains
the same value. We still make the 'path' variable available and
document it as a deprecated synonym of 'sm_path'.

Discussed-with: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
This patch is same as its previous version.
Although here I'll like to add a point that we aim to slowly drop the support
of the variable 'path'.

 Documentation/git-submodule.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index ff612001d..a23baef62 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -183,12 +183,14 @@ information too.
 
 foreach [--recursive] <command>::
 	Evaluates an arbitrary shell command in each checked out submodule.
-	The command has access to the variables $name, $path, $sha1 and
+	The command has access to the variables $name, $sm_path, $sha1 and
 	$toplevel:
 	$name is the name of the relevant submodule section in `.gitmodules`,
-	$path is the name of the submodule directory relative to the
-	superproject, $sha1 is the commit as recorded in the superproject,
-	and $toplevel is the absolute path to the top-level of the superproject.
+	$sm_path is the path of the submodule as recorded in the superproject,
+	$sha1 is the commit as recorded in the superproject, and
+	$toplevel is the absolute path to the top-level of the superproject.
+	Note that to avoid conflicts with '$PATH' on Windows, the '$path'
+	variable is now a deprecated synonym of '$sm_path' variable.
 	Any submodules defined in the superproject but not checked out are
 	ignored by this command. Unless given `--quiet`, foreach prints the name
 	of each submodule before evaluating the command.
-- 
2.13.0

