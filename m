Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAD1AC25B0E
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 23:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237838AbiHPX61 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 19:58:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbiHPX6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 19:58:16 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0657622B24
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z16so14360887wrh.12
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=YbiPQp6HgVj6OBDH+q6ZBDoA/kArRy37yTtWHkSRKwg=;
        b=QobFL1YQy0b5y2xXFSbiW1MFigQJOlbhQpPD6cywfxtZCmhCxNgC+EIsYq91qJagDQ
         e6g0u1/PYEh9bC861btzBG/4FFirzVbwHLb/SYxtcGrZustigklT3cT7prahPFHa7Ht4
         MkLRdK8fSOszKSYJfCSptNlDcMTXbYrXmc5kMoYh1/2lcygo5yGWcSOkF+u/xWY8OtXx
         w80K86+LCbuE88gmK5w32R42m5sXqleV+RrKDw5ozuLbyjToei3NCt/hkEBGcAhsbMZO
         YThNUsnR0uAFvFlhXllLjyVPERWrapPjbFuJEVUhzDoXoZonIPNYz4fyP8DaC3h4JZEV
         ap6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=YbiPQp6HgVj6OBDH+q6ZBDoA/kArRy37yTtWHkSRKwg=;
        b=0W82EP9ZwVADJUqU6tjiQ/W94hMVqJpHV9OGSNgRntCwFx99sXCiFo7q4hnTCOcg8p
         1+84YG+T1ikmB5+BwrMHgbY7PfloBJIJ+0TB/6SKfOJl24nWBWvHzVLTGZTfJnKrM8Am
         TnmqDkzuatrHiVR8H/E4vPNHqn6b25wO7lecy7/C0m2jZQeN/e6IC/4i6xdwG6eoTQO1
         kzQNAIJLQvITWSXadE7I+WTnjaGt5llCsQIkHnHccm4IDJqG6SI1wfbJB1033LDtZUQn
         keKuuwSplwlAbmdWcFVRn2EXw+roxMoMtN86LdJc9Fh8H9JgCvjEsjPEXBvt/jhQ58oQ
         vC5w==
X-Gm-Message-State: ACgBeo3kMr5rI0JfD/2mSyYOUzQojrdn0m5q5t7a0wTEWY4lcaAPlqLB
        G2YCP/m0mb6RE52lrnj1o23AXrA57mY=
X-Google-Smtp-Source: AA6agR7EpCrtR61EeEXqifBUygrlFm/4aCxtdZxnk1S+zTit7IKTvC/z4WuP36wROypQAwzWECwuJg==
X-Received: by 2002:a05:6000:1681:b0:21f:16a6:626f with SMTP id y1-20020a056000168100b0021f16a6626fmr12790378wrd.717.1660694294417;
        Tue, 16 Aug 2022 16:58:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020a05600c198e00b003a4f08495b7sm264034wmq.34.2022.08.16.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 16:58:13 -0700 (PDT)
Message-Id: <fc4aa1fde31fa0726cde2c1d4e41f3f140fff6f6.1660694290.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
References: <pull.1324.git.1660673269.gitgitgadget@gmail.com>
        <pull.1324.v2.git.1660694290.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Aug 2022 23:58:08 +0000
Subject: [PATCH v2 4/5] scalar unregister: stop FSMonitor daemon
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, mjcheetham@outlook.com,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Especially on Windows, we will need to stop that daemon, just in case
that the directory needs to be removed (the daemon would otherwise hold
a handle to that directory, preventing it from being deleted).

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
 contrib/scalar/scalar.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 28d915ec006..f390f519d26 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -254,6 +254,16 @@ static int start_fsmonitor_daemon(void)
 	return 0;
 }
 
+static int stop_fsmonitor_daemon(void)
+{
+	assert(fsmonitor_ipc__is_supported());
+
+	if (fsmonitor_ipc__get_state() == IPC_STATE__LISTENING)
+		return run_git("fsmonitor--daemon", "stop", NULL);
+
+	return 0;
+}
+
 static int register_dir(void)
 {
 	if (add_or_remove_enlistment(1))
@@ -281,6 +291,9 @@ static int unregister_dir(void)
 	if (add_or_remove_enlistment(0))
 		res = error(_("could not remove enlistment"));
 
+	if (fsmonitor_ipc__is_supported() && stop_fsmonitor_daemon() < 0)
+		res = error(_("could not stop the FSMonitor daemon"));
+
 	return res;
 }
 
-- 
gitgitgadget

