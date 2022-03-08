Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 163BDC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350688AbiCHWRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350692AbiCHWQ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:16:58 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C440E57B34
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:15:50 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so216763wra.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IORzkfN9FX4mvaJUW1/JQvql7wO5s6l+Di6stClhuZA=;
        b=PC84uA7XD8T3CS8QFApb8Mr76iz04a3EdIuVxAEGs2q4R3kCCTw6EquwgTu1sjo5+m
         xmHs5O7M1cTSPBpWDziwqFkm822FfTH9RMy1uuwBURd+oyaw0QzxwGiYhIAoiwchIoy8
         ztRNkH8owf+28KOh7rG/tr3MXobe7RVT5JQ9w9AkzEeBaGxq5DZtia9/w/McL602v3+c
         F8MDBgxPgdiMS/TigUs0OKOqfLrOdmQbCNblwYHPK4pr7HXBadzjFiHzR5LR14l3VzEk
         mqV64YPC62kD+ueQAmjuETfD3BriXdWhnRU84syMFQi7QDR6+N2+fDMcwO6P4ZvIoHoH
         G+3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IORzkfN9FX4mvaJUW1/JQvql7wO5s6l+Di6stClhuZA=;
        b=nt9WMC+g8GoejKp0WmmGpK4QgmbW143AHzyUraB4BIVi3JaUbhmG0uFYGC4NpQ8264
         Ff/9FirLZUKtBLsvJDcomUkv3di8VKTkcfKpELuksOXi9OJquZiKA3rdb3+GJE7/eLOz
         efkhpr//f2L7+plOcIGzryNBlc7GLND/c2vCjWKVjFobO2dl/LFHidsqtqIavPdGgeGZ
         N1uBDfA1BD8gxDgL0W9PFbuB3onxCalGtNMCoIbPPTEBQlXrN5MipOuh+9EFBiKa3UTf
         XopEyqcD9TV1PFvUiuVd8GXBoJqtAhpl2mstfBt3uWnA7/YVcJ5uLvZN7uKYvTvWElwk
         qIDQ==
X-Gm-Message-State: AOAM5326fW3iBiJLExnPQIcwM0KiKQun7S5FizaF83Wki2LO8sY+Cb4s
        g+TVpvtE0Y+xonIOTGzDfsVwrDcS3cE=
X-Google-Smtp-Source: ABdhPJwMFIZLDmE3tbnokNY31W0tZcZLddCzKiT3x828llYKxShGT5daBxOMOkhCSqHwRbvrkBCrUg==
X-Received: by 2002:a05:6000:1a89:b0:203:7089:ea88 with SMTP id f9-20020a0560001a8900b002037089ea88mr3194403wry.651.1646777749125;
        Tue, 08 Mar 2022 14:15:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm53492wmq.46.2022.03.08.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 14:15:48 -0800 (PST)
Message-Id: <796b65913939e4de5ff745981e3d36fe4926ae08.1646777727.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
References: <pull.1143.git.1644940773.gitgitgadget@gmail.com>
        <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 08 Mar 2022 22:15:18 +0000
Subject: [PATCH v2 18/27] fsm-listen-darwin: shutdown daemon if worktree root
 is moved/renamed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Torsten =?unknown-8bit?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Teach the listener thread to shutdown the daemon if the spelling of the
worktree root directory changes.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 compat/fsmonitor/fsm-listen-darwin.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/compat/fsmonitor/fsm-listen-darwin.c b/compat/fsmonitor/fsm-listen-darwin.c
index 7c81bc7e5bf..b6c33f2cf3b 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -178,6 +178,11 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
 	strbuf_release(&msg);
 }
 
+static int ef_is_root_changed(const FSEventStreamEventFlags ef)
+{
+	return (ef & kFSEventStreamEventFlagRootChanged);
+}
+
 static int ef_is_root_delete(const FSEventStreamEventFlags ef)
 {
 	return (ef & kFSEventStreamEventFlagItemIsDir &&
@@ -287,6 +292,26 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
 			continue;
 		}
 
+		if (ef_is_root_changed(event_flags[k])) {
+			/*
+			 * The spelling of the pathname of the root directory
+			 * has changed.  This includes the name of the root
+			 * directory itself or of any parent directory in the
+			 * path.
+			 *
+			 * (There may be other conditions that throw this,
+			 * but I couldn't find any information on it.)
+			 *
+			 * Force a shutdown now and avoid things getting
+			 * out of sync.  The Unix domain socket is inside
+			 * the .git directory and a spelling change will make
+			 * it hard for clients to rendezvous with us.
+			 */
+			trace_printf_key(&trace_fsmonitor,
+					 "event: root changed");
+			goto force_shutdown;
+		}
+
 		if (ef_ignore_xattr(event_flags[k])) {
 			trace_printf_key(&trace_fsmonitor,
 					 "ignore-xattr: '%s', flags=0x%x",
-- 
gitgitgadget

