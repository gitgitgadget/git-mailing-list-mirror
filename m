Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE35C433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 21:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349222AbiEZVuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 May 2022 17:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349257AbiEZVte (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 May 2022 17:49:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E75A9EAD12
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id k30so3653534wrd.5
        for <git@vger.kernel.org>; Thu, 26 May 2022 14:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=Pp7wuPhhLoGK0PVhvTHM9oK+BzxxLtiUEurdhYu/c30P/nA3w+Z3a7P0zSsr5a8GEv
         YC5a/PSbwEETfHLFgxHRpPaAJcNg4iaSY82XSC+RjxQoQvi831dlGL5bo27gpsi+PbfL
         XRO+6BMa+IM8EGgQc01IFNtIl+6q5bka/IxrA7h/+6dJ+G2LftCo8gut7ahLtlPuj3Ge
         85yCBCxb9qs08CkDjVXyhhnnMmXtZar7ya2H6+TJ1EuqokxhmaYjVtE+srm+iakIBUK5
         jPe5ZFeNAWzXT9DV8hvzvNoNcaojKbt3/gyYtMA2D90k6UxM2lkC+LrhxCigv6DynDJX
         gscg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=YKm3RFYvg9qB9YMUdHR+czw5cRBe9mM0ndAdrcENqCp3LKY5bYE+3xUAMNjF4dlL4B
         T+xzCfAY96k6QRrRToHzPV57/FAOgNyPjpYRkix9OuHuURnnjdmD3li8MkoGnrMGQ4IA
         zTAoIO8B/N1UGgSezWzOw64+PMbnJ+Tlzf6gZRC4BnQkEXC/Esc4eVo6R49sFOZh6Slw
         STHC7CA//h+ge61vW6vlN7LOjc/jE+YUx31ca/u3aHUMDIPD6lnwF+rDVNX0qRcJcH93
         MCkl/ylSTSEmxx3wOD18IG2f3LA3DKJLVXxtbMaoyr7+N/z5fhzPkgVMJZo+hL/48kMu
         9TSw==
X-Gm-Message-State: AOAM530bUv1SUWbNkzVheMR6alJL3W+oPHDOA75+hiLtbE4SZ3+XRGAz
        RNZJp/jw4nplVZzI1ete+X0kM0otO6E=
X-Google-Smtp-Source: ABdhPJztZjdRgz42+Afp5kcgKb+ntpzaHv7eq24B18FVrmzSv4M5LThiMJ1YGXpiWpUMyAy5Odmi1g==
X-Received: by 2002:a5d:58ca:0:b0:210:272:6fdf with SMTP id o10-20020a5d58ca000000b0021002726fdfmr7263832wrf.382.1653601765158;
        Thu, 26 May 2022 14:49:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h1-20020a1ccc01000000b00397342e3830sm9334245wmb.0.2022.05.26.14.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 14:49:24 -0700 (PDT)
Message-Id: <d8949ab5df6830ca4f5556116157bbc124af9cda.1653601644.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
References: <pull.1143.v8.git.1653490852.gitgitgadget@gmail.com>
        <pull.1143.v9.git.1653601644.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 26 May 2022 21:47:13 +0000
Subject: [PATCH v9 19/30] fsm-listen-darwin: shutdown daemon if worktree root
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
        rsbecker@nexbridge.com, Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
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
index 07113205a61..83d38e8ac6c 100644
--- a/compat/fsmonitor/fsm-listen-darwin.c
+++ b/compat/fsmonitor/fsm-listen-darwin.c
@@ -106,6 +106,11 @@ static void log_flags_set(const char *path, const FSEventStreamEventFlags flag)
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
@@ -215,6 +220,26 @@ static void fsevent_callback(ConstFSEventStreamRef streamRef,
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

