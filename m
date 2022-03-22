Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE4CC433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240394AbiCVSZc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240301AbiCVSZY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:25:24 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E90DE83
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so23631494wru.4
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=HEGgBO7ZpcW2EKj9J0FrwU3eBQ/UCv7k+iKs1sSyiIfbetBeV+wsjKS8XPqoxPw3T7
         pyUUHXimBmaK67pAj0wLO+pMAb2mU/u4VlYA5mLArOMpVWX/LLY8OW0p3whNnpS3bvGH
         nPZOgulBrtjOvfpgk4ci31kJamSCJ4xhgDD9s4d3wGxM8E3YCK6IP4XFAw53eYq9Gw15
         s6O2TfFevcZwJws/sePikuT3zUmtEoqUKHn/dt1Pohakgu+BPO0WNyp/6K0cOvJDACeY
         3I2kDvjbgwdXTwYklalKqZDnIlmc0TlBmU0GZKIrlvg2ohOjcxu7KhcdusC0axOux3XI
         iGwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=m/7nmjzQrPWZOZRTUqvWzqRTYtxoxcBSCt/eY/PHK+w=;
        b=EsSLQFPQiq5WF5WI6SDhZUy/OXSp2qsxOJxzMcNxhpPRdV2wew0pV7Yuwke+1tVU3m
         oew7vjg2F6mWyDuHrw4+HBDbgHtfs+HW9W7gJD6kU5tSCJvowclcJpQTYkqkFfPA51xC
         W0/1Wwf5UXCgxiRKzNSefO3Ky3JCrEQN5OXAGnpFK5y+kvqH+QmwcTY3ZEuFSUZ0TQWz
         zZXI5N2fN/5+9pdWJLQjYuRmSfenSTZ1sAYQuFst1YX0k1QarUg54JkgskCQotyci5x3
         TyT/YInTt96pcs1hiazs4buaJTvkO/PLeqXTnnIOgekcaDeXy9+B0nFGr68jP+/ov0ay
         SINg==
X-Gm-Message-State: AOAM5300YFgMr255ZXf0VMEfYdwKl+PC9nH6SuiwmwNKVn3v8WU+g1aT
        BsNC9vTaDdKeJKkdnLytTmRcsNgtBa0=
X-Google-Smtp-Source: ABdhPJzH5hGpC46pWeycTxEy9fVdruCYHXAvtuIiqlIFSQ0Pa6fRGfTRhsb9esWaiL9CjN45ncl+QA==
X-Received: by 2002:a05:6000:2c9:b0:204:1ce4:7c29 with SMTP id o9-20020a05600002c900b002041ce47c29mr6611388wry.51.1647973432508;
        Tue, 22 Mar 2022 11:23:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e8-20020a056000178800b00203da3bb4d2sm17405632wrg.41.2022.03.22.11.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:23:50 -0700 (PDT)
Message-Id: <01c1a38c46243666c8af0556d5d7588cf4203ada.1647973380.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
References: <pull.1143.v2.git.1646777727.gitgitgadget@gmail.com>
        <pull.1143.v3.git.1647973380.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 18:22:52 +0000
Subject: [PATCH v3 19/27] fsm-listen-darwin: shutdown daemon if worktree root
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
        rsbecker@nexbridge.com, Jeff Hostetler <jeffhost@microsoft.com>,
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

