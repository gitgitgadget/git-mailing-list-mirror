Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBDBC433F5
	for <git@archiver.kernel.org>; Wed, 29 Dec 2021 18:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbhL2SzZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Dec 2021 13:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbhL2SzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Dec 2021 13:55:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858D0C061401
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:15 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id n10-20020a7bc5ca000000b00345c520d38eso12150830wmk.1
        for <git@vger.kernel.org>; Wed, 29 Dec 2021 10:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qiqOIkyPv8h8Pafi3sxUCLg26n7mS+IxX/AsWfZ1ak0=;
        b=LJkc6Y+wnkD+6V2y4CoMWEVRZeAxVXzLY8OTqxUCgu/x+r+jBmVLAFaHeONSJbQKSp
         JIECyoxrK/FdrOdheKT/hjD89LowY0C+XcY/+EPQzNzWXrmb1Pp5WkEOkoDFICBt968T
         bctwXtV98W2u7OAsyCUAyUh186Z4I+emW8ydA7rjrm3qxqepB85NDJdzpQ4TXbNJQ49X
         IIUcNck1sgo2+yXnELOljrlEZq3oYJ0xmZ9FAtL+791kVoGLBnHD2WOMrECdy/eNqUEB
         kKHu9Oh+kLWDfO3TGE/0OEANYCh6hDR2ffpJzQK4HHwhcbfT2Qjl8LS2IQKyect+jGBO
         foTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qiqOIkyPv8h8Pafi3sxUCLg26n7mS+IxX/AsWfZ1ak0=;
        b=Nwg+S2WQWD64jJ7f+46GCZqOCgXo9sIg0tJ6XaeT5/26h9YVqRxPthjSOtkcGdaDVG
         bt/bmvjZCej4eTpdmCW1qHNpr0zl8MpOz8VY/yua/3rbYVrgRZZDs/juLAyEuDUQTGzw
         Z1ijeq6StP8sSrGwEACu2L4GoGYNxS1VRpgVnp7I/F16Itm/MBPyTGtNi0czd3ZEEUXe
         2F6uhwIJbb/UUfu35Iq9AqXzMJlBJmWe13pItFhhSmj+YgBAbTGdEN4Mn7sCLHFIaZ4U
         XMDtrBqWKMSl6p/CB+SiuHQbrTIJLBMSyC40EycwsZYoyn+LWa+juH6UQ9pWzUQFHUuM
         lZDg==
X-Gm-Message-State: AOAM5336rPeZJexlWIC+UATogE3wIb59OkTHKaOw1cQpdaC1CGkob7aF
        DjrrQbCYaM/WAgZgj61nZ/q/1pJYR2Y=
X-Google-Smtp-Source: ABdhPJw/G/brkjfOrFLsP9C56/VwIKx9EA/NaEpF+l35O/bRVVNttNeTpTlm1gYy1xrc1MF96ZdeFA==
X-Received: by 2002:a7b:cc13:: with SMTP id f19mr22866734wmh.150.1640804113971;
        Wed, 29 Dec 2021 10:55:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bd8sm21270028wmb.44.2021.12.29.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 10:55:13 -0800 (PST)
Message-Id: <4c17e08b9d3a42375c7082d5d2275ea8cc4fab99.1640804108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
        <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 29 Dec 2021 18:55:03 +0000
Subject: [PATCH v3 07/11] i18n: factorize "no directory given for --foo"
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 git.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/git.c b/git.c
index 7edafd8ecff..7e361769ff6 100644
--- a/git.c
+++ b/git.c
@@ -185,7 +185,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--git-dir")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --git-dir\n" ));
+				fprintf(stderr, _("no directory given for %s\n" ), "--git-dir");
 				usage(git_usage_string);
 			}
 			setenv(GIT_DIR_ENVIRONMENT, (*argv)[1], 1);
@@ -213,7 +213,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "--work-tree")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for --work-tree\n" ));
+				fprintf(stderr, _("no directory given for %s\n" ), "--work-tree");
 				usage(git_usage_string);
 			}
 			setenv(GIT_WORK_TREE_ENVIRONMENT, (*argv)[1], 1);
@@ -297,7 +297,7 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 				*envchanged = 1;
 		} else if (!strcmp(cmd, "-C")) {
 			if (*argc < 2) {
-				fprintf(stderr, _("no directory given for -C\n" ));
+				fprintf(stderr, _("no directory given for %s\n" ), "-C");
 				usage(git_usage_string);
 			}
 			if ((*argv)[1][0]) {
-- 
gitgitgadget

