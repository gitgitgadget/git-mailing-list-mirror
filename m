Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB1BC54EE9
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 20:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiITUdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Sep 2022 16:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbiITUdQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2022 16:33:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43B6075CC2
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:15 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id g3so6389983wrq.13
        for <git@vger.kernel.org>; Tue, 20 Sep 2022 13:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=djaJxP7ZOYfRatfIDhQGCKHxJ27VyeU4uwB3LqOGVHQ=;
        b=hEgiYJV+zEoL94R6ub5J8FOeBkU9UEUHJF0/fRnP2ruMAXeMGa3og64iS7u4g+YhJ4
         y0kXYi6MHf7QzhVyDp3Di8fGTw6mDrTnQeoi/7Faalu8XQRTBWYM6pcSziUX2iaJzKAN
         ZyHtJOwgRcGHstnqYuLHxHqi/SE/ixaMZKZrMIX43NBHfIgEgavR9XvIGssSegCJ+vyf
         UTg18YXfU4Jx0+28ULnjCP/spZJS4/yB3K+h1Bv0xkDEhVihSFyMHh0tVmcxjTtScxFR
         3l+STICUZMIh//y4LB6vYwDXXGYHd0cY81iEuNBfXdTYTYMF23jeoyS4Q7EdNLUtp1n0
         OHXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=djaJxP7ZOYfRatfIDhQGCKHxJ27VyeU4uwB3LqOGVHQ=;
        b=cjAw7enJsSBb0S00h/1BdEqYygJvBdVvgrNkz0MEcYrdpOsaim7IlSwHwsArw3L+ZL
         ycjdtN96Q2/ztFBKUAfoR3uN3OkKJ+XQcEffe5pHpc9Jml3h1guFUFYlAt94EhLrRnsu
         kFoY3jwwrzZAE6eBu2kzKGLZVc3cLM1GgqC8JMNlfqu4SY2bZn97UVm8ZMwmwIH71gUx
         JiN95Ba3g1GlM1ViJ1Sv+sN+mbA+k3Q+pN+TPrIdYu9WjVJna7iXtj9OX8cZAMVS7d44
         sneXUQuxVGIWL36WwDv8T53pCFrakZyB72JshjbmFUwCNYOSYYs6I0GpRoLgtfMrmhUa
         bJqg==
X-Gm-Message-State: ACrzQf34X6z/qeFE7nSfDYSlK++nVswKY2a5HB3sPohaBe7QyGE/2GmM
        SM01BL0YeQ9cdkOpjElRsVhJsMRrajQ=
X-Google-Smtp-Source: AMsMyM5n3S6Icx10Re5JIV0UfLpGa2zbA6jYwyWslYVzuRE9j+5qrm43Et+Sp5M8+lMbihFFIk9AwQ==
X-Received: by 2002:adf:dc4c:0:b0:22a:42eb:1e34 with SMTP id m12-20020adfdc4c000000b0022a42eb1e34mr15534067wrj.258.1663705993516;
        Tue, 20 Sep 2022 13:33:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o22-20020a05600c4fd600b003a5ca627333sm932974wmq.8.2022.09.20.13.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 13:33:12 -0700 (PDT)
Message-Id: <8f6c1fbacbfd3df67d1a7591788d98f1af0e26f4.1663705986.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
References: <pull.1326.v9.git.1663616277.gitgitgadget@gmail.com>
        <pull.1326.v10.git.1663705986.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Sep 2022 20:33:05 +0000
Subject: [PATCH v10 5/6] fsmonitor: check for compatability before
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
 compat/fsmonitor/fsm-settings-darwin.c |  2 +-
 fsmonitor-settings.c                   | 10 +++++++---
 fsmonitor-settings.h                   |  2 +-
 fsmonitor.c                            |  4 ++++
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/compat/fsmonitor/fsm-settings-darwin.c b/compat/fsmonitor/fsm-settings-darwin.c
index 40da2d3b533..44233125df8 100644
--- a/compat/fsmonitor/fsm-settings-darwin.c
+++ b/compat/fsmonitor/fsm-settings-darwin.c
@@ -38,7 +38,7 @@ static enum fsmonitor_reason check_uds_volume(struct repository *r)
 	strbuf_release(&path);
 
 	if (fs.is_remote)
-		return FSMONITOR_REASON_REMOTE;
+		return FSMONITOR_REASON_NOSOCKETS;
 
 	if (!strcmp(fs.typename, "msdos")) /* aka FAT32 */
 		return FSMONITOR_REASON_NOSOCKETS;
diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 531a1b6f956..24480b9806d 100644
--- a/fsmonitor-settings.c
+++ b/fsmonitor-settings.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "config.h"
 #include "repository.h"
+#include "fsmonitor-ipc.h"
 #include "fsmonitor-settings.h"
 #include "fsmonitor-path-utils.h"
 
@@ -242,10 +243,11 @@ enum fsmonitor_reason fsm_settings__get_reason(struct repository *r)
 	return r->settings.fsmonitor->reason;
 }
 
-char *fsm_settings__get_incompatible_msg(const struct repository *r,
+char *fsm_settings__get_incompatible_msg(struct repository *r,
 					 enum fsmonitor_reason reason)
 {
 	struct strbuf msg = STRBUF_INIT;
+	const char *socket_dir;
 
 	switch (reason) {
 	case FSMONITOR_REASON_UNTESTED:
@@ -281,9 +283,11 @@ char *fsm_settings__get_incompatible_msg(const struct repository *r,
 		goto done;
 
 	case FSMONITOR_REASON_NOSOCKETS:
+		socket_dir = dirname((char *)fsmonitor_ipc__get_path(r));
 		strbuf_addf(&msg,
-			    _("repository '%s' is incompatible with fsmonitor due to lack of Unix sockets"),
-			    r->worktree);
+			    _("socket directory '%s' is incompatible with fsmonitor due"),
+			    socket_dir);
+		strbuf_add(&msg, _(" to lack of Unix sockets support"), 32);
 		goto done;
 	}
 
diff --git a/fsmonitor-settings.h b/fsmonitor-settings.h
index 0721617b95a..ab02e3995ee 100644
--- a/fsmonitor-settings.h
+++ b/fsmonitor-settings.h
@@ -33,7 +33,7 @@ enum fsmonitor_mode fsm_settings__get_mode(struct repository *r);
 const char *fsm_settings__get_hook_path(struct repository *r);
 
 enum fsmonitor_reason fsm_settings__get_reason(struct repository *r);
-char *fsm_settings__get_incompatible_msg(const struct repository *r,
+char *fsm_settings__get_incompatible_msg(struct repository *r,
 					 enum fsmonitor_reason reason);
 
 struct fsmonitor_settings;
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

