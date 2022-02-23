Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1661C433F5
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbiBWSbm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 13:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbiBWSbg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 13:31:36 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9514145AE4
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:08 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so4916565wmq.3
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 10:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qw5N4QyXi2eCCr/aaFG4WHyfzLl6kV96xcMMk2SGczk=;
        b=S8xS81lNRu6iVEltyht8g+ix976xDn9SveA+K5Oku86HfVuVQjxF1oa61SeRS6pOYw
         QbwLym7mttKcTpG9PoeL4DJ4F/fdJy6e3R1UgJZ5eaScz6WywlNUDFvEHmsv43PHEKE4
         Q2jK7UL6GOjGkdgGkNf5DPsZxUfHS1/W+hIa9CTnL8GIGEG+HCQgUi9xJcspTtcEJ16C
         hF/F+Frn7LI9epdjAA5mv35CFPEl+PJfRFYb3rUZDGoCNdy8a+VQGsG2GovPaVVjpPPO
         X9E8kQ/LITiaCVKEp8MefHQYOxmM3ogGmYmdoCNoDf0/P3x0oJYdSLO3HwxiXfroW3MH
         nWuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qw5N4QyXi2eCCr/aaFG4WHyfzLl6kV96xcMMk2SGczk=;
        b=YKif5YPhTEUlu518y1Rketvi+HPxGWHvJZw6opHajSpf96xvtKsv9P2ubDS85dPscP
         zqvEdVb0QHJtl2QYhzEw7suI8T3AT2q6ve4QXd0dClf/+olHk10QbXIdLQxlSOPbkOkq
         Uj9swckoMN2eRc7xemu0G8akXDK2xUL8EeFiXdRmCPGl/w9BSOjpan4qmTkkH8J5tBmf
         gVPXK+kVGyixK2nMWg9GUMz229rifgQtBO0+FjnOZs7N1l0fUB+xV+dVCrTH+oi2gQTa
         +gMlZMQhVtGmUQKM5WOmnrSY5Zgw76pvC+Omxk0GEFxr7IbxsVu8XzPGhRLOODDjUFbk
         Whfw==
X-Gm-Message-State: AOAM532ouFqPcj1iLT0Vxa0lm1qla7MdvEGq9Uxk4VaSerubiKhVNOl6
        WNrxwW6k9XhPy6FWS30qn9ddGe5Ogq0=
X-Google-Smtp-Source: ABdhPJzRWYifYgvybmZ8OxPWybMtz3KfRi+bapvxOIPGG89pOT350v0ARSrRMhMSnDVmRflDva8NRg==
X-Received: by 2002:a7b:c016:0:b0:37b:ebf6:3d13 with SMTP id c22-20020a7bc016000000b0037bebf63d13mr8793995wmb.191.1645641066870;
        Wed, 23 Feb 2022 10:31:06 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f63sm256334wma.17.2022.02.23.10.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 10:31:05 -0800 (PST)
Message-Id: <a9bcb6065523e2d2307fdc5b7bc92b04aba012e8.1645641063.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 18:30:40 +0000
Subject: [PATCH 02/25] bundle: alphabetize subcommands better
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, aevar@gmail.com,
        newren@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The usage strings for the 'git bundle' subcommands are not alphabetical.
This also applies to their inspection within cmd_bundle(). Fix this
ordering before we insert a new subcommand.

This change does not reorder the cmd_bundle_*() methods to avoid moving
lines that are more likely wanted in a future 'git blame' call. It is
fine that those longer methods are not ordered alphabetically.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 builtin/bundle.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/builtin/bundle.c b/builtin/bundle.c
index 5a85d7cd0fe..8187b7df739 100644
--- a/builtin/bundle.c
+++ b/builtin/bundle.c
@@ -13,9 +13,9 @@
 
 static const char * const builtin_bundle_usage[] = {
   N_("git bundle create [<options>] <file> <git-rev-list args>"),
-  N_("git bundle verify [<options>] <file>"),
   N_("git bundle list-heads <file> [<refname>...]"),
   N_("git bundle unbundle <file> [<refname>...]"),
+  N_("git bundle verify [<options>] <file>"),
   NULL
 };
 
@@ -24,11 +24,6 @@ static const char * const builtin_bundle_create_usage[] = {
   NULL
 };
 
-static const char * const builtin_bundle_verify_usage[] = {
-  N_("git bundle verify [<options>] <file>"),
-  NULL
-};
-
 static const char * const builtin_bundle_list_heads_usage[] = {
   N_("git bundle list-heads <file> [<refname>...]"),
   NULL
@@ -39,6 +34,11 @@ static const char * const builtin_bundle_unbundle_usage[] = {
   NULL
 };
 
+static const char * const builtin_bundle_verify_usage[] = {
+  N_("git bundle verify [<options>] <file>"),
+  NULL
+};
+
 static int parse_options_cmd_bundle(int argc,
 		const char **argv,
 		const char* prefix,
@@ -209,12 +209,12 @@ int cmd_bundle(int argc, const char **argv, const char *prefix)
 
 	else if (!strcmp(argv[0], "create"))
 		result = cmd_bundle_create(argc, argv, prefix);
-	else if (!strcmp(argv[0], "verify"))
-		result = cmd_bundle_verify(argc, argv, prefix);
 	else if (!strcmp(argv[0], "list-heads"))
 		result = cmd_bundle_list_heads(argc, argv, prefix);
 	else if (!strcmp(argv[0], "unbundle"))
 		result = cmd_bundle_unbundle(argc, argv, prefix);
+	else if (!strcmp(argv[0], "verify"))
+		result = cmd_bundle_verify(argc, argv, prefix);
 	else {
 		error(_("Unknown subcommand: %s"), argv[0]);
 		usage_with_options(builtin_bundle_usage, options);
-- 
gitgitgadget

