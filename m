Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5DA7320C11
	for <e@80x24.org>; Sun,  3 Dec 2017 22:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752464AbdLCWSC (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Dec 2017 17:18:02 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:41415 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752144AbdLCWR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Dec 2017 17:17:59 -0500
Received: by mail-it0-f67.google.com with SMTP id x28so8435519ita.0
        for <git@vger.kernel.org>; Sun, 03 Dec 2017 14:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yVXSSlzFOWGK0QUwXuKH3hOStvIPO2QWMUKA4uG83Pw=;
        b=CAjAHCG8+t3nKyXn2CJfYagww5jAN//zEYkMO05I4UaddnDWJ/ForsL+SqXFrbQIuh
         Wr5aq3GP/8RubVFgWs+TbaSmKgx6MdNt3F98nCT22jaj9zQHdvRxdG3uFHLywpyxilEe
         b4Ezo0GTdinG6NQ7ATQ0IVNagFU1XCYKayZWZkglnJxyTsKm3oq/TqXeKJLu2cxXZL/5
         0mFI1tGFXKVcm6PjT140o6tEhJdz2zoxrIJyNMKSjJs+DkgwuS0tVwt2BMZTKAOetT9L
         j+d2OMSU/tiJn3+heVHn7CgMAU/+uQQRHbEJZgdLP+a4zjuBtzGGLZZnATDoP5eVrffi
         KeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yVXSSlzFOWGK0QUwXuKH3hOStvIPO2QWMUKA4uG83Pw=;
        b=EnX98LG/P4+OXi+XsRXFGAv2PGcMp9InkWEOWi4W5VKtUmeqokBcXZBI/wg+wAtrzE
         VcEjZl9McwPz4dNZCMeO4ntFmVIOTrz3FT8zVU97/MwHuebAM5y/oOS5bri84cJrWodt
         29gITD5RCr+ITFq+6njLeWFaGavFTAMd81OvOCKWuWeL6OzePrJkGQdTo0wQB15iE96W
         BGMJT+8TQDmVCcCUqacTzxwy6gAfAw2ThseVFiPKqNit7y6QT9lGlo2IR8OvIDzdKPAs
         2+CrjpUqx6zzvMQzUKJ1MxuPaO/J2U7RGIKkwaXoB4R9l7OgauDO8u1FdxkQwhPe7KEV
         lt4g==
X-Gm-Message-State: AJaThX6Sob0b8vjrbzdVwKsNVfD4eBN/4cNdTsWtit8AyiFAln/d6tTH
        /BwV9pLs7FKGf+W78tFYLFEyFLHK
X-Google-Smtp-Source: AGs4zMau+5ySPgdaK2gTI07novV6Bq95hkqUhooGdRaEqXmnl4sSz4ikszQg9XNW5ILDX80mJa2EQQ==
X-Received: by 10.107.104.18 with SMTP id d18mr19823985ioc.136.1512339478516;
        Sun, 03 Dec 2017 14:17:58 -0800 (PST)
Received: from localhost.localdomain (24-212-246-46.cable.teksavvy.com. [24.212.246.46])
        by smtp.gmail.com with ESMTPSA id c141sm5207054ioe.13.2017.12.03.14.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 14:17:58 -0800 (PST)
From:   Liam Beguin <liambeguin@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com, peff@peff.net,
        Liam Beguin <liambeguin@gmail.com>
Subject: [PATCH v2 1/9] Documentation: move rebase.* configs to new file
Date:   Sun,  3 Dec 2017 17:17:13 -0500
Message-Id: <20171203221721.16462-2-liambeguin@gmail.com>
X-Mailer: git-send-email 2.15.1.280.g10402c1f5b5c
In-Reply-To: <20171203221721.16462-1-liambeguin@gmail.com>
References: <20171127045514.25647-1-liambeguin@gmail.com>
 <20171203221721.16462-1-liambeguin@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move all rebase.* configuration variables to a separate file in order to
remove duplicates, and include it in config.txt and git-rebase.txt.  The
new descriptions are mostly taken from config.txt as they are more
verbose.

Signed-off-by: Liam Beguin <liambeguin@gmail.com>
---
 Documentation/config.txt        | 31 +------------------------------
 Documentation/git-rebase.txt    | 19 +------------------
 Documentation/rebase-config.txt | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+), 48 deletions(-)
 create mode 100644 Documentation/rebase-config.txt

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 531649cb40ea..e424b7de90b5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2691,36 +2691,7 @@ push.recurseSubmodules::
 	is retained. You may override this configuration at time of push by
 	specifying '--recurse-submodules=check|on-demand|no'.
 
-rebase.stat::
-	Whether to show a diffstat of what changed upstream since the last
-	rebase. False by default.
-
-rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
-
-rebase.autoStash::
-	When set to true, automatically create a temporary stash entry
-	before the operation begins, and apply it after the operation
-	ends.  This means that you can run rebase on a dirty worktree.
-	However, use with care: the final stash application after a
-	successful rebase might result in non-trivial conflicts.
-	Defaults to false.
-
-rebase.missingCommitsCheck::
-	If set to "warn", git rebase -i will print a warning if some
-	commits are removed (e.g. a line was deleted), however the
-	rebase will still proceed. If set to "error", it will print
-	the previous warning and stop the rebase, 'git rebase
-	--edit-todo' can then be used to correct the error. If set to
-	"ignore", no checking is done.
-	To drop a commit without warning or error, use the `drop`
-	command in the todo-list.
-	Defaults to "ignore".
-
-rebase.instructionFormat::
-	A format string, as specified in linkgit:git-log[1], to be used for
-	the instruction list during an interactive rebase.  The format will automatically
-	have the long commit hash prepended to the format.
+include::rebase-config.txt[]
 
 receive.advertiseAtomic::
 	By default, git-receive-pack will advertise the atomic push
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3cedfb0fd22b..8a861c1e0d69 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -203,24 +203,7 @@ Alternatively, you can undo the 'git rebase' with
 CONFIGURATION
 -------------
 
-rebase.stat::
-	Whether to show a diffstat of what changed upstream since the last
-	rebase. False by default.
-
-rebase.autoSquash::
-	If set to true enable `--autosquash` option by default.
-
-rebase.autoStash::
-	If set to true enable `--autostash` option by default.
-
-rebase.missingCommitsCheck::
-	If set to "warn", print warnings about removed commits in
-	interactive mode. If set to "error", print the warnings and
-	stop the rebase. If set to "ignore", no checking is
-	done. "ignore" by default.
-
-rebase.instructionFormat::
-	Custom commit list format to use during an `--interactive` rebase.
+include::rebase-config.txt[]
 
 OPTIONS
 -------
diff --git a/Documentation/rebase-config.txt b/Documentation/rebase-config.txt
new file mode 100644
index 000000000000..dba088d7c68f
--- /dev/null
+++ b/Documentation/rebase-config.txt
@@ -0,0 +1,32 @@
+rebase.stat::
+	Whether to show a diffstat of what changed upstream since the last
+	rebase. False by default.
+
+rebase.autoSquash::
+	If set to true enable `--autosquash` option by default.
+
+rebase.autoStash::
+	When set to true, automatically create a temporary stash entry
+	before the operation begins, and apply it after the operation
+	ends.  This means that you can run rebase on a dirty worktree.
+	However, use with care: the final stash application after a
+	successful rebase might result in non-trivial conflicts.
+	This option can be overridden by the `--no-autostash` and
+	`--autostash` options of linkgit:git-rebase[1].
+	Defaults to false.
+
+rebase.missingCommitsCheck::
+	If set to "warn", git rebase -i will print a warning if some
+	commits are removed (e.g. a line was deleted), however the
+	rebase will still proceed. If set to "error", it will print
+	the previous warning and stop the rebase, 'git rebase
+	--edit-todo' can then be used to correct the error. If set to
+	"ignore", no checking is done.
+	To drop a commit without warning or error, use the `drop`
+	command in the todo-list.
+	Defaults to "ignore".
+
+rebase.instructionFormat::
+	A format string, as specified in linkgit:git-log[1], to be used for the
+	instruction list during an interactive rebase.  The format will
+	automatically have the long commit hash prepended to the format.
-- 
2.15.1.280.g10402c1f5b5c

