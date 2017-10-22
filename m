Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D75202DD
	for <e@80x24.org>; Sun, 22 Oct 2017 17:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751552AbdJVRDN (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Oct 2017 13:03:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:46173 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751512AbdJVRDL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Oct 2017 13:03:11 -0400
Received: by mail-wr0-f195.google.com with SMTP id l1so15177180wrc.3
        for <git@vger.kernel.org>; Sun, 22 Oct 2017 10:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7tmApb++4IJlP1+ScNxhwf/dnMB7vbxcd4/aS4AZ6Sw=;
        b=qC53qeDQeAU6yorKLdWyJNRLf5w1FnF2jJBerfC15bsX69jMrOUqC9Xp3ta/hxuHRR
         SYsk5pJ3mME/VDGBgIKqXUytAgY4SbZKXU43tN8aQE7Vuo7/BBTbS7wIkanV4y9opmXC
         +7yfG0YMSglgADwpnbQSxcbPxgmrqHHfC9MEwRQ7Oo7IHiHoRwvUuxx7DcDyQKCe5lyT
         Mz7iWZD0GLLKJR9dd2UAMf7he9c605JOUpQ7skjQeN78eBn3lDtk7WHgkZ7IPbAJBnaX
         bD+Yoc4Q3KSvdl00QAbySDEt6sHF4gAxrYgp+PUdcYn5AUzD01Ch3LNhV/CQGdXT6PVK
         IxBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7tmApb++4IJlP1+ScNxhwf/dnMB7vbxcd4/aS4AZ6Sw=;
        b=QOvGob33ukRzJgT7jCao5SfocHDZXgJ3uUQTr7Vn0O2f9sDSyQCqAyq0C65L2Y/jPe
         r8E5miOFSUTAgMP5sUmCcQLMiiAATRQIJJSZ/Wbvb1/RrD1igYEi+8GxXNxNpTkir8CZ
         Hunskz1goTTl2Y10Lr9ylYJknKGDFCm6LzH9O6zkwzQnyVbcIlUO5OiigVYAwMR0zsYF
         4bmUv6UWjMDnK+HBproM3nRuN9c7MO+PbESaJjmqwxq6qISyPNNu9gubBTyDRLr9G2Oi
         Fx9XSCIqsTt9eODOaRq2F9L59hIX0BA0h3niTpyebUHTmhkfE+NIn8aqv7XPczcBn9vw
         KnXQ==
X-Gm-Message-State: AMCzsaWVt4NvJiKp0GR+JgID6F2xSh/sjnN960QGv27UpNsGChbRT03i
        oqcGnZPu3qrv6OxXM6VLWvVYgv1c
X-Google-Smtp-Source: ABhQp+Sxdv8+qWg9cHxfTUpHVBbktY2CyosPzpx5E9kfbZCXyGO5xDvveCznBgNL5gx3+YbOZBKAnQ==
X-Received: by 10.223.186.142 with SMTP id p14mr9826015wrg.169.1508691790190;
        Sun, 22 Oct 2017 10:03:10 -0700 (PDT)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id x15sm2541731wma.32.2017.10.22.10.03.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Oct 2017 10:03:09 -0700 (PDT)
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        "Robert P . J . Day" <rpjday@crashcourse.ca>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 2/3] mark git stash push deprecated in the man page
Date:   Sun, 22 Oct 2017 18:04:08 +0100
Message-Id: <20171022170409.8565-3-t.gummerer@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.2.g8fac3e73c8.dirty
In-Reply-To: <20171022170409.8565-1-t.gummerer@gmail.com>
References: <20171019183304.26748-2-t.gummerer@gmail.com>
 <20171022170409.8565-1-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'git stash push' fixes a historical wart in the interface of 'git stash
save'.  As 'git stash push' has all functionality of 'git stash save',
with a nicer, more consistent user interface deprecate 'git stash
save'.  To do this, remove it from the synopsis of the man page, and
move it to a separate section, stating that it is deprecated.

Helped-by: Robert P. J. Day <rpjday@crashcourse.ca>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 Documentation/git-stash.txt | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index 53b2e60aeb..8be661007d 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -13,8 +13,6 @@ SYNOPSIS
 'git stash' drop [-q|--quiet] [<stash>]
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
-'git stash' save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]
 'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]]
 	     [--] [<pathspec>...]]
@@ -48,7 +46,6 @@ stash index (e.g. the integer `n` is equivalent to `stash@{n}`).
 OPTIONS
 -------
 
-save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 push [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-m|--message <message>] [--] [<pathspec>...]::
 
 	Save your local modifications to a new 'stash entry' and roll them
@@ -87,6 +84,12 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
 
+save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+
+	This option is deprecated in favour of 'git stash push'.  It
+	differs from "stash push" in that it cannot take pathspecs,
+	and any non-option arguments form the message.
+
 list [<options>]::
 
 	List the stash entries that you currently have.  Each 'stash entry' is
-- 
2.15.0.rc0.2.g8fac3e73c8.dirty

