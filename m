Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE303C6FA86
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 19:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiISTiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 15:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiISTiG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 15:38:06 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F56192B2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:04 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id c11so701081wrp.11
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=bebhsgLSR/dvglUaatrpWC4eZSs07ICzF3roFpByZIo=;
        b=DnuOE3N2tiLKwAueww4JKphec8OmRb0Y6eOrcn2Sqa15WugebIYpAIJfGO24ETtc4i
         jtOGrgC+/q2IAlzb3YycWSxlGJHs4YZ2fLBusjNDLco5TUnroEv2ZJsnfU1svRIeQ33D
         rU04zoNGNmVefKuUYQpObrUWY4sNzmTEg+R+XtfTiM+mi3a2h5XLjcMGrOahApBaikGv
         HBMWWMXGLb+iv2vXS6MjlbjemD5nMIO9MkgvEj5yUIZ3RkESY9L/+W8RH0Ww+3TV5dWz
         0K3L50njrCdEf3MdtBdhWplO/WTf3f40XSC3WX6nDOBS2v9ND91ZH2tt5dR4kLBheNSp
         eOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=bebhsgLSR/dvglUaatrpWC4eZSs07ICzF3roFpByZIo=;
        b=xwfCuZMKC/g9EWVbRz9Wb6BqxeDHnfTCI3p2bp56+oVeHEtvHOJBB4gHTpz3dr9px4
         FkV7cdaBH4KAkP9aU4lFJ8WktCK/Z1X1S7A2jhlHxqL3MhfbI+3AoATT5Ay6hZyyRGXu
         le3kelV+95FGSS15mBf7N9Jtyd7W690aKS764Dvy2KVAlSXHoj23gHJlIXmqutnkf6k7
         E0DGNsyz1ozhGrh/1zXjvQAMajIgBjGs6q5nNzihyKLQk7lUBgXB6BJ4+ZYLNrlATtYc
         MiqkeJ/g+tvT2CSOndlmEGs8y4RvboYO6hucRCo5S6oOwhL6Z4IZJ1k5IP2OGlCH0KK7
         /nDQ==
X-Gm-Message-State: ACrzQf3HXvDUe3COALZrB/ELmuCNzYXnEVDGn0pCdT9QVylRqzPkUE5/
        oCVARak1oOt6a+BcgKp3laJN3nn0ZX4=
X-Google-Smtp-Source: AMsMyM7C4KUWYgXF3H8Tz97cP5jK3jF4hkbq5jL6eH2Kc02AXAsoM6YUhnbwozoTDOwfIAfiRFb0uQ==
X-Received: by 2002:a5d:47c5:0:b0:22a:6d4c:f21e with SMTP id o5-20020a5d47c5000000b0022a6d4cf21emr11795624wrc.417.1663616283093;
        Mon, 19 Sep 2022 12:38:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id az24-20020adfe198000000b00228d7078c4esm15029886wrb.4.2022.09.19.12.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 12:38:02 -0700 (PDT)
Message-Id: <02afeaa01bef0a033c17a2ab37cc37e5e7818eb9.1663616277.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
References: <pull.1326.v8.git.1663377141.gitgitgadget@gmail.com>
        <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Sep 2022 19:37:56 +0000
Subject: [PATCH v9 5/6] fsmonitor: check for compatability before
 communicating with fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If fsmonitor is not in a compatible state, die with an appropriate error
messge.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor-settings.c | 2 ++
 fsmonitor.c          | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 531a1b6f956..aaa204e0352 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -247,6 +247,8 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 {
 	struct strbuf msg = STRBUF_INIT;
 
+	strbuf_add(&msg, "fsmonitor: ", strlen("fsmonitor: "));
+
 	switch (reason) {
 	case FSMONITOR_REASON_UNTESTED:
 	case FSMONITOR_REASON_OK:
diff --git a/fsmonitor.c b/fsmonitor.c
index 57d6a483bee..43d580132fb 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -305,6 +305,10 @@ void refresh_fsmonitor(struct index_state *istate)
 	int is_trivial = 0;
 	struct repository *r = istate->repo ? istate->repo : the_repository;
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	if (reason > FSMONITOR_REASON_OK)
+		die("%s", fsm_settings__get_incompatible_msg(r, reason));
 
 	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
 	    istate->fsmonitor_has_run_once)
-- 
gitgitgadget

