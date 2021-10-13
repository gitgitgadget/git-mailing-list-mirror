Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BB45C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58984610E5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 20:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbhJMUeA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 16:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhJMUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 16:33:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77A8BC061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:52 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e12so12386387wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 13:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=VYs4Xmrl+Ofoo7+qhT0kESE8JUC7abEUY1xcec9ktVxRizdyeqC0ovUiDP0NDt/tho
         lIs62fZ4JFXEvx8/uAIwqI4IMQVYZCZXv8LRuoQWXQQxSS29D2vqZnvlM/+ezvydtL9B
         a8X/kLODcAmOizRMdspdtaV/yOw+JPbhTBmCClKRK5AjoxxIt40scXDimH9DAdNOGfvE
         4S9sF1bGARpu5Jo2c+zVY30/DBBAck79JD4BPmuiigrM1R143azdiQDCV63SS9a939z9
         qYX0r1zUjCn+X+e3Vbfg4/4IFAVzDTc1BDr+xdyOGOcgHkQTveU+K/zw7Ku7veeJw+40
         LUMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OPR/cD4g5iSikjECMnICO/QPaQt/LlN2JVqikY/G/54=;
        b=PRWl0YKowq7V7YJwBdzleZ1b3Uni/SDqw4yrjKuADFptNK1pinidMlAnRQSOvo2RkO
         E3K5oLl2LTiSvsopnYM7wfaM5fM6a+Su9jAnTjVqCddhnhq70ZY0NSWvGHlHa/qjoSos
         9OwS0WnXusU8Z0pGkYpxR7PfdYoVQRrIUiV+Fh60/Fmpn6xYCcPVER148rQGGOSx5s9r
         iIVbWprE5nGcK9m1SBVvsP3vjMTjdUSyOa/YP2ws23hHmpO+V0IVgPUHU/FSRgIAP8yL
         qfOO+a8tY87oL7LG40g36j6o5JD73wIA+g4KqoPZy2afikkHhip5P82ZOhJlPW1snHoK
         kA1A==
X-Gm-Message-State: AOAM533MeXtM6qShGXD4z3AmkxvPf4Bh4NHWyGPXedBDJq33SmI3Tq1p
        SHLRvr93C9TukfkaAxfz24PtVzzEWvA=
X-Google-Smtp-Source: ABdhPJxahKpVDhmIqQN77Hm/U3N1+donqA6OlxzrU7fW7m0wwMDrGk549wvzIOPhYjhVMTsCHrIZgQ==
X-Received: by 2002:a05:6000:18cf:: with SMTP id w15mr1549199wrq.314.1634157111167;
        Wed, 13 Oct 2021 13:31:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f127sm5897268wmf.16.2021.10.13.13.31.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 13:31:50 -0700 (PDT)
Message-Id: <4d8d812be084459b850f11c811bbfc02c4c6f8c4.1634157108.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
References: <pull.1041.v2.git.1633614772.gitgitgadget@gmail.com>
        <pull.1041.v3.git.1634157107.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 13 Oct 2021 20:31:46 +0000
Subject: [PATCH v3 4/5] fsmonitor: use IPC to query the builtin FSMonitor
 daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Use simple IPC to directly communicate with the new builtin file
system monitor daemon when `core.useBuiltinFSMonitor` is set.

The `core.fsmonitor` setting has already been defined as a HOOK
pathname.  Historically, this has been set to a HOOK script that will
talk with Watchman.  For compatibility reasons, we do not want to
overload that definition (and cause problems if users have multiple
versions of Git installed).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fsmonitor.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 63174630c0e..695fb0ce4e7 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -254,8 +254,37 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 
 	if (fsm_mode == FSMONITOR_MODE_IPC) {
-		/* TODO */
-		return;
+		query_success = !fsmonitor_ipc__send_query(
+			istate->fsmonitor_last_update ?
+			istate->fsmonitor_last_update : "builtin:fake",
+			&query_result);
+		if (query_success) {
+			/*
+			 * The response contains a series of nul terminated
+			 * strings.  The first is the new token.
+			 *
+			 * Use `char *buf` as an interlude to trick the CI
+			 * static analysis to let us use `strbuf_addstr()`
+			 * here (and only copy the token) rather than
+			 * `strbuf_addbuf()`.
+			 */
+			buf = query_result.buf;
+			strbuf_addstr(&last_update_token, buf);
+			bol = last_update_token.len + 1;
+		} else {
+			/*
+			 * The builtin daemon is not available on this
+			 * platform -OR- we failed to get a response.
+			 *
+			 * Generate a fake token (rather than a V1
+			 * timestamp) for the index extension.  (If
+			 * they switch back to the hook API, we don't
+			 * want ambiguous state.)
+			 */
+			strbuf_addstr(&last_update_token, "builtin:fake");
+		}
+
+		goto apply_results;
 	}
 
 	assert(fsm_mode == FSMONITOR_MODE_HOOK);
@@ -321,6 +350,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/*
 	 * The response from FSMonitor (excluding the header token) is
 	 * either:
-- 
gitgitgadget

