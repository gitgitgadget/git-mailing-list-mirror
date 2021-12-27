Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9241BC43217
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 23:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233970AbhL0XYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 18:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbhL0XYF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 18:24:05 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F436C06175A
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:05 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r17so34931667wrc.3
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=qiqOIkyPv8h8Pafi3sxUCLg26n7mS+IxX/AsWfZ1ak0=;
        b=O3WaYIAaPZSpoMSUMPjVBFZeBcVBmssFd8yBhiHdxevxYFj5yW/JmBLWUgYtldYX1B
         JaNpEsEUx+z3CiXeTZojbrAPRPgLfq07piMFMCxVcE0oT8URp9aSyF9OmZzLWdWapUa6
         Ofy+YnRpwpBlPyVmKL8ShZpnDyDsY8WCclFn2VjS/MDt5c2oFslZjVCtpYc6Haz6Sn3m
         wB05nJI7KCLy0vqVOxP/EiPO9dI31qy66zn4vZ0zRRuit3cmc+fy3wR0LrFfy5EtUVQf
         c8Xj66tsy8OVSurAYVte2fGYcXAHChfBg2ErV1jPXEsQZT92VRVrJM8oOvQKNdmmE8wx
         iaIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=qiqOIkyPv8h8Pafi3sxUCLg26n7mS+IxX/AsWfZ1ak0=;
        b=TtrTmNR1Nei5/L63EoiVw794BxIHqGr5jdeFM5yhC8cH7jYu3Nm5a9jR4wzO2Uhz7a
         mPBim7SKQtot8hUjC2aC2Way7fxtNQBpINWzjI6868L3C0nzwxzKta8yNSpppZ5s8M5F
         cCG1ccDdG2uV09PVPPOzqyVP1sED4ZxH+fEfNnTl4MucEKG9sDglPslan7INwURgCNPS
         Y534lfptQpIbhRA4/aTDR+y0+nZ1m4lC5N4h4CY7r7VVAydLYKJZgQoVyrv3+mePbszb
         2rPcrDb7IHhhsHTbJGarA8LUYRQie51mseNuzeoIQTXQRjvNrzDEtLObt+yJQwnr8XRi
         vq6A==
X-Gm-Message-State: AOAM531ekfRzuRFW/Dqsva3hXJeeNYV4wJecV9hGPxXNtWqHBXsHglc3
        Bqu3G0NA11ttmiS5mMFssvndfRKU9s4=
X-Google-Smtp-Source: ABdhPJw5XPIPh994xkDQ7vQNXJv8uAILZxL4crclQSQSCanUoVGe3M5pSTbAem8N1DUIsyfZiaXAyg==
X-Received: by 2002:a05:6000:188f:: with SMTP id a15mr14326951wri.153.1640647443708;
        Mon, 27 Dec 2021 15:24:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 1sm8311350wrb.13.2021.12.27.15.24.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 15:24:03 -0800 (PST)
Message-Id: <2b7d558f8f99f61302b8d0b27fb33656090a6715.1640647438.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
        <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 27 Dec 2021 23:23:53 +0000
Subject: [PATCH v2 07/11] i18n: factorize "no directory given for --foo"
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

