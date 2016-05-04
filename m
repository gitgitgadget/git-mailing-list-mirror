From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [PATCH 1/2] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
Date: Wed,  4 May 2016 10:37:51 +0530
Message-ID: <1462338472-3581-2-git-send-email-pranit.bauva@gmail.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
 <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
Cc: Pranit Bauva <pranit.bauva@gmail.com>, chriscool@tuxfamily.org,
	christain.couder@gmail.com, Johannes.Schindelin@gmx.de,
	larsxschneider@gmail.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 07:08:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axp3J-0004y1-CF
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 07:08:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbcEDFIp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 01:08:45 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:36157 "EHLO
	mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751152AbcEDFIo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 01:08:44 -0400
Received: by mail-pf0-f175.google.com with SMTP id c189so21219268pfb.3
        for <git@vger.kernel.org>; Tue, 03 May 2016 22:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=NXYUaRoTUX0wV3LQNvcAdnXDHjTo6Kn0Z5SziJblcC0=;
        b=IvTaPVzNZl8j+lkwydWdsQ8eugC72X06qmJsza0PBa7meBcuh3Ys95EVdhmjUfuohz
         GlLMeqfndie3Xmyzi6iYYUygnMcUR437GXgg2fX8WrzrsH0CQCPzf63yk0f7RrA95pUK
         3IDCcqtRIY+rnQL6fclkf50fHOwUJgG/n05TVZ92Wer1OgnI1sJ1xz6JE2kQp3DL5eKz
         JoAo6tmKruBzpae1yRI8a4G/q9rtslt8kt2LDeFRoza4n2VE9uohac5Vw5Pd01zPXGsL
         fVPMBC7fuSBWINAqP61ZB++XF5GFLsVXMRqfAB1LNJrYnoRkVw7e2IaK8ZF/RRt21Gka
         U34A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=NXYUaRoTUX0wV3LQNvcAdnXDHjTo6Kn0Z5SziJblcC0=;
        b=eVtvZy8tJ32WngNng8QaIwOs2Tpj4ZS1QeSTsAgzg5edr0Sa4bvjxXre3ITYPT1jrt
         oRUtYC/jqJPV4Ke2hvKGArxCZncFV7b3smVwih6jNv8mUiQoGKodf+fBRvdA0S0Wov+O
         SbCGs5+2vQN0+xypnaXfdEK/tCMgY8KCI80Cl0/YoX/l3m8eZvhp9XmwVFGEHaPPl7Cv
         GT77WBXyb3ROD4CP00Fw04LJmzICBwhuK0hwZ1bJftzoGHbnTUng6FgZcPQbhDYr82ya
         IMxwqOBt8AuGzQl0zZ+42xaQl2Za8qqOKt8PD1vgXZp1cxXdRa/laL6Ozmo2hZKoMcHY
         XxIw==
X-Gm-Message-State: AOPr4FUFv4VSaVeKTAsV9HBUOmLyzbh2cINMTgaInprwi9gUayUL3KLZPS8mO6QEzAViFg==
X-Received: by 10.98.5.196 with SMTP id 187mr9405947pff.103.1462338523282;
        Tue, 03 May 2016 22:08:43 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.50])
        by smtp.gmail.com with ESMTPSA id p189sm2171709pfb.51.2016.05.03.22.08.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 May 2016 22:08:42 -0700 (PDT)
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1462338472-3581-1-git-send-email-pranit.bauva@gmail.com>
In-Reply-To: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
References: <01020153a254974b-68f7d16a-66d7-4dc1-805d-2185ff1b3ebf-000000@eu-west-1.amazonses.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293487>

`--next-all` is meant to be used as a sub command to support multiple
"operation mode" though the current implementation does not contain any
other sub command along side with `--next-all` but further commits will
include some more subcommands.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christain Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..5f6ef8c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -8,13 +8,17 @@ static const char * const git_bisect_helper_usage[] = {
 	NULL
 };
 
+enum sub_commands {
+	NEXT_ALL = 1
+};
+
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	int sub_command = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &sub_command,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +27,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!sub_command)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (sub_command) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die(_("bug: unknown subcommand '%d'"), sub_command);
+	}
+	return 0;
 }
-- 
2.8.1
