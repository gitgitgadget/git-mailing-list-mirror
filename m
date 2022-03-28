Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FEDAC433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 14:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243582AbiC1OEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 10:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243575AbiC1OED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 10:04:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57225EDDC
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so20516759wrh.11
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 07:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VvuQDNYHi76po3IhgEBr8bIrGEpBU/9nHBLLa49txsA=;
        b=kBvZ/JSu41wBuLD2iY5skr4iHPZEfJEpWiQP1BsQJk3zGd0O9Tmar3cAorrR8owe52
         kKIPMpAEbuUXV8cLiXzCtuW+TKQ3RKT0S4JtubqzgWWoXaQGP7Hw4M+M5LkVpQi2w7eB
         I1gLTpOxtRmpH9geAvFJHxurudDwH9OIH5W3aYGkrI/fuWHE7egWoZdad4uSunjTVnE+
         Dysx4ydDjbn6VTiuCRUDBwf6Z4rfJ6945zMkWjObI0afku70IDbaaxcG0alC6KPDye2/
         O+9aT+YgVh6xXRCZTvC1ofVh+LaU0oKhArnBgW2ijpEuTadESSeP1TF9BSnFqsBW8ttf
         aLpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VvuQDNYHi76po3IhgEBr8bIrGEpBU/9nHBLLa49txsA=;
        b=AxT/uIU30mZcKUL/nJbEnr0wDwJQOn2B1oY/Xm68Ol6fM9UYYdzRAxvl5nJFoR04NE
         tlcHtPJTgqM2ZTbR/9FRo6W7YXc6Tq5TFzga3Eay/fdRBA3ROI4hJAohCy2iGKRdqH3V
         kdUyjsmElqWBQvduOOy04Fc/Ca/QeBsX9R2qrBBRvJpcOn1WksWGRt3qQnn7oo7aa+zT
         znBCe5NrLvnAlFz6HO/Gi7v1am0ZLCAHUlZSguy94eYsHEhhXYfFcyuAPLgBkoW0TgTD
         9HW5rX/zo7hhjAUOnN+Fkef8jTcrVLZILMJ7UFeFVDyvXQOqYA9CAx/S6iKxHl4KmsTP
         Q38g==
X-Gm-Message-State: AOAM5339D2hhGYsXzLwjDBwAx350Vt3QC7gw2pqHR7mb7+PrbuWOPR9C
        6j0fqZKC4aHd9TdxHJkmn+fAzJNEOXU=
X-Google-Smtp-Source: ABdhPJxYbjInNerWq7O0FUKaCTEzz8pdTEXvalvVT+QzjLAZhx5HI3Kj+8OCbpmo8DaoXCVaTPeH3Q==
X-Received: by 2002:adf:fe4a:0:b0:203:fb08:11d8 with SMTP id m10-20020adffe4a000000b00203fb0811d8mr23693208wrs.356.1648476139644;
        Mon, 28 Mar 2022 07:02:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1-20020a1c6a01000000b0038c9f6a3634sm15614078wmc.7.2022.03.28.07.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 07:02:18 -0700 (PDT)
Message-Id: <f7942344ff897fc064346f283734022fc0ffc540.1648476132.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
References: <pull.1138.v3.git.1646406274.gitgitgadget@gmail.com>
        <pull.1138.v4.git.1648476131.gitgitgadget@gmail.com>
From:   "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Mar 2022 14:02:07 +0000
Subject: [PATCH v4 3/7] builtin/fetch-pack: add --refetch option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Calvin Wan <calvinwan@google.com>,
        Robert Coup <robert@coup.net.nz>,
        Robert Coup <robert@coup.net.nz>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Coup <robert@coup.net.nz>

Add a refetch option to fetch-pack to force a full fetch. Use when
applying a new partial clone filter to refetch all matching objects.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
 Documentation/git-fetch-pack.txt | 4 ++++
 builtin/fetch-pack.c             | 4 ++++
 remote-curl.c                    | 6 ++++++
 3 files changed, 14 insertions(+)

diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index c9758847937..46747d5f429 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -101,6 +101,10 @@ be in a separate packet, and the list must end with a flush packet.
 	current shallow boundary instead of from the tip of each
 	remote branch history.
 
+--refetch::
+	Skips negotiating commits with the server in order to fetch all matching
+	objects. Use to reapply a new partial clone blob/tree filter.
+
 --no-progress::
 	Do not show the progress.
 
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index c2d96f4c89a..1f8aec97d47 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -153,6 +153,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			args.from_promisor = 1;
 			continue;
 		}
+		if (!strcmp("--refetch", arg)) {
+			args.refetch = 1;
+			continue;
+		}
 		if (skip_prefix(arg, ("--" CL_ARG__FILTER "="), &arg)) {
 			parse_list_objects_filter(&args.filter_options, arg);
 			continue;
diff --git a/remote-curl.c b/remote-curl.c
index ff44f41011e..67f178b1120 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -43,6 +43,7 @@ struct options {
 		/* see documentation of corresponding flag in fetch-pack.h */
 		from_promisor : 1,
 
+		refetch : 1,
 		atomic : 1,
 		object_format : 1,
 		force_if_includes : 1;
@@ -198,6 +199,9 @@ static int set_option(const char *name, const char *value)
 	} else if (!strcmp(name, "from-promisor")) {
 		options.from_promisor = 1;
 		return 0;
+	} else if (!strcmp(name, "refetch")) {
+		options.refetch = 1;
+		return 0;
 	} else if (!strcmp(name, "filter")) {
 		options.filter = xstrdup(value);
 		return 0;
@@ -1182,6 +1186,8 @@ static int fetch_git(struct discovery *heads,
 		strvec_push(&args, "--deepen-relative");
 	if (options.from_promisor)
 		strvec_push(&args, "--from-promisor");
+	if (options.refetch)
+		strvec_push(&args, "--refetch");
 	if (options.filter)
 		strvec_pushf(&args, "--filter=%s", options.filter);
 	strvec_push(&args, url.buf);
-- 
gitgitgadget

