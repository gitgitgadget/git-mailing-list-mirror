Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D72ECC636CC
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 03:25:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjBNDZw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Feb 2023 22:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBNDZu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2023 22:25:50 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D054415569
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 19:25:45 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id o1so5304355ioo.10
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 19:25:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dP6KFKtsI3CbgogXV9zFzLPAs8Ewq9flUvB8djo4Z0I=;
        b=HRBZlJCo12EaPvGU3KCqjL5eCjvm2V0duS2cqZPksfZNOHDo7daqhlEMuYZ6EMVpJn
         ItYLY1LLQvH3oHBGV+Kk5wt98S0ZPPc3gkhTdgyul2lS2GwzoxV83Z7B8mtycm2gsJHU
         MZXPNVeVAFA9bgqOZO0WRfus6YJgCjdDt1ga6wviZHrJcGqiZxU8gUrqfxB1/mwAMPOS
         PUVoj3RuaOrLFmq9TIjfkDUCsDSw3q2jQIMLfwOUOxe/wHad3vWU5PfJzBM82sADg4Br
         lMmVVmyIFkMH5VznYynEjHzymu76Oz6mPLEAxEklL7NGt/AQ4umKKw3D284j7iQZ+5gy
         NrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dP6KFKtsI3CbgogXV9zFzLPAs8Ewq9flUvB8djo4Z0I=;
        b=XcXMiBftFx0ol6tXmhUGeBm3+il9tZdkgZARDvjAQsxYPpluEFYXziCVjhP0GQGQM9
         fvVI1n9dRjkHEiUpyEhzhDb+ElYINs3ZjBUxgX7pv7Hq+z487vnHfFVTJuxlAHvXhMK9
         vVbNMboanikch7RC5pgHNV2URDpvsbOvNrE12w/eIsgE2a8A4KKhSfhPPgUsB39MqvOo
         vzI80hQJJ8uCUnTOZCqI90e/q4qhNYX3CYbSpVxksEOssgKdHHUOHDPLXQnI7wfY7JGx
         gTkHhmt2hV9pMiMPa5Vs1qYKJN4+Jd5HvJ7miITPZAMdo/uugUTTAKD03e0lraqOv1qW
         U1SQ==
X-Gm-Message-State: AO0yUKUTJNVKXHImKhnVmuTI968dmsySDoS1eihepzb81NvQZaQxEbb8
        xKSYkBDMO830qg5749RODgkdafiYl4087Q==
X-Google-Smtp-Source: AK7set/jf5+rJKniTg/SSd3NmycCaj4rPzRUm7m63eEEO6Gvz6GCDLv360qQ3wW1G70yCd+Y2IHDZg==
X-Received: by 2002:a05:6602:200d:b0:722:19dc:deaa with SMTP id y13-20020a056602200d00b0072219dcdeaamr563870iod.10.1676345144761;
        Mon, 13 Feb 2023 19:25:44 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id s19-20020a6b7413000000b0073f8a470bacsm1222396iog.16.2023.02.13.19.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 19:25:44 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [GSoC][PATCH] builtin/clean.c: fix error message usage typo
Date:   Mon, 13 Feb 2023 22:25:34 -0500
Message-Id: <20230214032534.507628-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As Documentation/CodingGuidelines says, we shouldn't capitalize the first
word in error message. Change the capital letter to lowercase letter.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 builtin/clean.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index b2701a2815..e6ce776001 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -30,14 +30,14 @@ static const char *const builtin_clean_usage[] = {
 	NULL
 };
 
-static const char *msg_remove = N_("Removing %s\n");
-static const char *msg_would_remove = N_("Would remove %s\n");
-static const char *msg_skip_git_dir = N_("Skipping repository %s\n");
-static const char *msg_would_skip_git_dir = N_("Would skip repository %s\n");
+static const char *msg_remove = N_("removing %s\n");
+static const char *msg_would_remove = N_("would remove %s\n");
+static const char *msg_skip_git_dir = N_("skipping repository %s\n");
+static const char *msg_would_skip_git_dir = N_("would skip repository %s\n");
 static const char *msg_warn_remove_failed = N_("failed to remove %s");
 static const char *msg_warn_lstat_failed = N_("could not lstat %s\n");
-static const char *msg_skip_cwd = N_("Refusing to remove current working directory\n");
-static const char *msg_would_skip_cwd = N_("Would refuse to remove current working directory\n");
+static const char *msg_skip_cwd = N_("refusing to remove current working directory\n");
+static const char *msg_would_skip_cwd = N_("would refuse to remove current working directory\n");
 
 enum color_clean {
 	CLEAN_COLOR_RESET = 0,
-- 
2.39.0

