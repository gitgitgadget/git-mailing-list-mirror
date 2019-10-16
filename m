Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30BC91F4C0
	for <e@80x24.org>; Wed, 16 Oct 2019 05:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727923AbfJPFTA (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Oct 2019 01:19:00 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727575AbfJPFTA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Oct 2019 01:19:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id q5so13907490pfg.13
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 22:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40B3gZrqY+7KU7YjSmgsedW6mYXe5cG+COQRaRZd6e8=;
        b=UHJlPmfD0P0eXDoRCMJIzajysS9vDdoo2Vmf6xFMV+Vu+6WxuRiDH4c15HcKHXCMMa
         DVBW3uilR4HH0k/vmlS9SBT5DbapxWEYN4ll6HXq0CjohV6+oQHJYJ3MLIWX/AvsGuBr
         OWHJje1o4n1mxItO+Exun2HWhzZ6+kCwQupSe6AK4ZrIIXRNS8qiArJrw782kqJQixEx
         RWQgentCyOJLR2PT0QXp87Y6mlD5fIXWejiOlO0VRSepGLdUZ0Lj/v08vM/VvGZLOZHv
         pngEKgYEVf2lcHk48EfTwarinofgwW0SiUv2WfMssoIs0WUZWfcBdOrSAKcl3FilfFCb
         2Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40B3gZrqY+7KU7YjSmgsedW6mYXe5cG+COQRaRZd6e8=;
        b=EJe8mBSfpqwY+gcF2P37cLJ4XWUUNPe6P3uhaYarE10FabCeGmmKJ9dSsZHhY33LDk
         IMHaC5lJ82D3Y+s++R9to6OApR6KO7Gf2mmP0dvtFmNDoxZSSo8eeVM/iHspKWpWGupE
         U7y4Rc9LeYGtYlvtuTC8bRj3671lxl3AWoOrV2aCTA0y3F5Elet3Mtu6RZowyVAR5acY
         ZGDuceNvnc3Y8PRE2XoG19hybyLkmMZR79xEErsnoIydrcLJImkMR+2Wl3dJ/xJmtruu
         Pf+b4ULAbweP+HOCQyTjZiYpCB1X10FbUujQgxGBxZIux6CwePeltXMgl9vPdjthtJjW
         t3LQ==
X-Gm-Message-State: APjAAAWZj1a6IA87pN8BlNMKsjWESlQAQZ81y5r7iZStJqzVo1VZr64c
        vVs6ioBdZPsBMyOJATdUCo4JvKv/
X-Google-Smtp-Source: APXvYqzf8PxpyMs3a1RD+U+gMtJ64qxTVe9vZtpiwTl6BdAMZwHDMDCDXfq+eIUW4bCOP83qqYsi1Q==
X-Received: by 2002:a63:1e59:: with SMTP id p25mr41937780pgm.361.1571203138806;
        Tue, 15 Oct 2019 22:18:58 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:2b61:f51c:7233:c8a4:1e74])
        by smtp.gmail.com with ESMTPSA id f6sm24759105pfq.169.2019.10.15.22.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Oct 2019 22:18:58 -0700 (PDT)
From:   Doan Tran Cong Danh <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     Doan Tran Cong Danh <congdanhqx@gmail.com>
Subject: [PATCH 2/2] notes: fix minimum number of parameters to "copy" subcommand
Date:   Wed, 16 Oct 2019 12:18:41 +0700
Message-Id: <20191016051841.19896-2-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016051841.19896-1-congdanhqx@gmail.com>
References: <20191015163631.21808-1-congdanhqx@gmail.com>
 <20191016051841.19896-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The builtin/notes.c::copy() function is prepared to handle either
one or two arguments given from the command line;
in case of one argument is given, to-obj defaults to HEAD.

When bbb1b8a3 ("notes: check number of parameters to "git notes copy"",
2010-06-28) tried to make sure "git notes copy" (with *no* other
argument) does not dereference NULL by making sure we did not get
too few parameters, it incorrectly insisted that we need two arguments,
instead of either one or two.
This disabled the defaulting to-obj to HEAD.
Correct it.

Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
---
 Documentation/git-notes.txt |  6 +++---
 builtin/notes.c             |  2 +-
 t/t3301-notes.sh            | 40 +++++++++++++++++++++++++++++++++++--
 3 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index f56a5a9197..ced2e8280e 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git notes' [list [<object>]]
 'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' copy [-f] ( --stdin | <from-object> <to-object> )
+'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
 'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [--allow-empty] [<object>]
 'git notes' show [<object>]
@@ -68,8 +68,8 @@ add::
 	subcommand).
 
 copy::
-	Copy the notes for the first object onto the second object.
-	Abort if the second object already has notes, or if the first
+	Copy the notes for the first object onto the second object (defaults to
+	HEAD). Abort if the second object already has notes, or if the first
 	object has none (use -f to overwrite existing notes to the
 	second object). This subcommand is equivalent to:
 	`git notes add [-f] -C $(git notes list <from-object>) <to-object>`
diff --git a/builtin/notes.c b/builtin/notes.c
index 02e97f55c5..95456f3165 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -513,7 +513,7 @@ static int copy(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	if (argc < 2) {
+	if (argc < 1) {
 		error(_("too few parameters"));
 		usage_with_options(git_notes_copy_usage, options);
 	}
diff --git a/t/t3301-notes.sh b/t/t3301-notes.sh
index d7767e4438..d66a5f6faa 100755
--- a/t/t3301-notes.sh
+++ b/t/t3301-notes.sh
@@ -864,6 +864,24 @@ test_expect_success 'append to note from other note with "git notes append -c"'
 '
 
 test_expect_success 'copy note with "git notes copy"' '
+	commit=$(git rev-parse 4th) &&
+	cat >expect <<-EOF &&
+		commit $commit
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:16:13 2005 -0700
+
+		${indent}4th
+
+		Notes:
+		${indent}This is a blob object
+	EOF
+	git notes copy 8th 4th &&
+	git log 3rd..4th >actual &&
+	test_cmp expect actual &&
+	test "$(git note list 4th)" = "$(git note list 8th)"
+'
+
+test_expect_success 'copy note with "git notes copy" with default' '
 	test_commit 11th &&
 	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
@@ -878,7 +896,7 @@ test_expect_success 'copy note with "git notes copy"' '
 		${indent}
 		${indent}yet another note
 	EOF
-	git notes copy HEAD^ HEAD &&
+	git notes copy HEAD^ &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD^)"
@@ -892,6 +910,24 @@ test_expect_success 'prevent overwrite with "git notes copy"' '
 '
 
 test_expect_success 'allow overwrite with "git notes copy -f"' '
+	commit=$(git rev-parse HEAD) &&
+	cat >expect <<-EOF &&
+		commit $commit
+		Author: A U Thor <author@example.com>
+		Date:   Thu Apr 7 15:23:13 2005 -0700
+
+		${indent}11th
+
+		Notes:
+		${indent}This is a blob object
+	EOF
+	git notes copy -f HEAD~3 HEAD &&
+	git log -1 >actual &&
+	test_cmp expect actual &&
+	test "$(git notes list HEAD)" = "$(git notes list HEAD~3)"
+'
+
+test_expect_success 'allow overwrite with "git notes copy -f" with default' '
 	commit=$(git rev-parse HEAD) &&
 	cat >expect <<-EOF &&
 		commit $commit
@@ -905,7 +941,7 @@ test_expect_success 'allow overwrite with "git notes copy -f"' '
 		${indent}
 		${indent}yet another note
 	EOF
-	git notes copy -f HEAD~2 HEAD &&
+	git notes copy -f HEAD~2 &&
 	git log -1 >actual &&
 	test_cmp expect actual &&
 	test "$(git notes list HEAD)" = "$(git notes list HEAD~2)"
-- 
2.23.0

