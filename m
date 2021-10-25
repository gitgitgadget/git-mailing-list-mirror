Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F85C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:32:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A6196105A
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 22:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbhJYWfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 18:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233844AbhJYWfB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 18:35:01 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0393C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:32:38 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id w15so11855414wra.3
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 15:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4pgW0/ZeEqgr+GE4/H4IdYpfMgJSNKXJzo9KEei/dyM=;
        b=jxQPgx7tAjuguB/gCfTOqEBjD9qdYoMp7BL2x43o1Hpx8G8eaMFzYO4RDI9o24Okau
         LJUUKMnCXj6EaMvIpzDSSzp0ISuWjzMu92Qk98rzqbxFP786ywEF69ZZEI2tCpoUxBqu
         qHNcTTN2p7BlrLcKnNSdH5XCq87mjBUJa5hJnjYSJJCL6mt+9Yu/p7BOXxZz1cUy8MIA
         M0IbMurp+CPPLYGWyrE/MX/6P8EI9JYFsdK0KI+jGOidyN52ph/8eZGRsx7Aaq0bURBl
         ga647MfTZxT9BU25HZrzW3Xj1qccPEhFuWSdyfZ0W9cQCdIhCjNwCBhIaMSncznijD1y
         xmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4pgW0/ZeEqgr+GE4/H4IdYpfMgJSNKXJzo9KEei/dyM=;
        b=ji77thx3TYCLL9DYNkT2t1VJnF62L7muBTgnn8is+syv5ahaLnGkk+LW4WFgs8Q7rv
         MkBCMklF7u6phe34oXsOfBH/9lL7Rgs8Vu73ymzO7Njs5+j8kFZaCb72HgLfMmaI7LRj
         qpMxlBU85bvEl+trJDstVQpsgQUJzv4pxXhQybogiCHVMX38cu4KJJDRy3qtUohG4nvS
         FugTUCDAy3tp87ykUh5NMb6CCz/2vxBV29dhtbV/RKHPkbXQE428k/b8CrAhHa9qmdN7
         eWwuIryqYcSPa47/D6bwwj23c0SDyoIbIknYEuk/QuB3112poU6NeSZQvmv1uUuIhx+a
         skhw==
X-Gm-Message-State: AOAM533DJUCrk8uBtV0D3QTfN6fRtNoBhCDGiBapZOcA1K8hODBxblX3
        mvupYbH9iMnOd98wk+9D3jzjw4lm1XE=
X-Google-Smtp-Source: ABdhPJzqGlAkrBai0bcL5mZcJAwl+V4raL/BqXOY4bisLhq5exAqkMrI2+5IehFP4wfhNdyuUS2aLA==
X-Received: by 2002:adf:e38a:: with SMTP id e10mr26399036wrm.162.1635201157594;
        Mon, 25 Oct 2021 15:32:37 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i24sm17587598wml.26.2021.10.25.15.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 15:32:37 -0700 (PDT)
Message-Id: <733fae23d1cef11410befdf514a2360a420a4c62.1635201156.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
References: <pull.1116.git.git.1635201156.gitgitgadget@gmail.com>
From:   "Robert Estelle via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 25 Oct 2021 22:32:35 +0000
Subject: [PATCH 1/2] color: add missing GIT_COLOR_* white/black constants
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Robert Estelle <robert.estelle@gmail.com>,
        Robert Estelle <robertestelle@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Robert Estelle <robertestelle@gmail.com>

The colors black and white where conspicuously missing from the color
constants. Although they are not currently used in the codebase, having
them included makes it easier to visually verify the ANSI codes, and to
distinguish them explicitly from "GIT_COLOR_DEFAULT" in a subsequent
change.

Signed-off-by: Robert Estelle <robertestelle@gmail.com>
---
 color.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/color.h b/color.h
index 98894d6a175..c20d324e7ca 100644
--- a/color.h
+++ b/color.h
@@ -24,30 +24,38 @@ struct strbuf;
 #define GIT_COLOR_NORMAL	""
 #define GIT_COLOR_RESET		"\033[m"
 #define GIT_COLOR_BOLD		"\033[1m"
+#define GIT_COLOR_BLACK		"\033[30m"
 #define GIT_COLOR_RED		"\033[31m"
 #define GIT_COLOR_GREEN		"\033[32m"
 #define GIT_COLOR_YELLOW	"\033[33m"
 #define GIT_COLOR_BLUE		"\033[34m"
 #define GIT_COLOR_MAGENTA	"\033[35m"
 #define GIT_COLOR_CYAN		"\033[36m"
+#define GIT_COLOR_WHITE		"\033[37m"
+#define GIT_COLOR_BOLD_BLACK	"\033[1;30m"
 #define GIT_COLOR_BOLD_RED	"\033[1;31m"
 #define GIT_COLOR_BOLD_GREEN	"\033[1;32m"
 #define GIT_COLOR_BOLD_YELLOW	"\033[1;33m"
 #define GIT_COLOR_BOLD_BLUE	"\033[1;34m"
 #define GIT_COLOR_BOLD_MAGENTA	"\033[1;35m"
 #define GIT_COLOR_BOLD_CYAN	"\033[1;36m"
+#define GIT_COLOR_BOLD_WHITE	"\033[1;37m"
+#define GIT_COLOR_FAINT_BLACK	"\033[2;30m"
 #define GIT_COLOR_FAINT_RED	"\033[2;31m"
 #define GIT_COLOR_FAINT_GREEN	"\033[2;32m"
 #define GIT_COLOR_FAINT_YELLOW	"\033[2;33m"
 #define GIT_COLOR_FAINT_BLUE	"\033[2;34m"
 #define GIT_COLOR_FAINT_MAGENTA	"\033[2;35m"
 #define GIT_COLOR_FAINT_CYAN	"\033[2;36m"
+#define GIT_COLOR_FAINT_WHITE	"\033[2;37m"
+#define GIT_COLOR_BG_BLACK	"\033[40m"
 #define GIT_COLOR_BG_RED	"\033[41m"
 #define GIT_COLOR_BG_GREEN	"\033[42m"
 #define GIT_COLOR_BG_YELLOW	"\033[43m"
 #define GIT_COLOR_BG_BLUE	"\033[44m"
 #define GIT_COLOR_BG_MAGENTA	"\033[45m"
 #define GIT_COLOR_BG_CYAN	"\033[46m"
+#define GIT_COLOR_BG_WHITE	"\033[47m"
 #define GIT_COLOR_FAINT		"\033[2m"
 #define GIT_COLOR_FAINT_ITALIC	"\033[2;3m"
 #define GIT_COLOR_REVERSE	"\033[7m"
-- 
gitgitgadget

