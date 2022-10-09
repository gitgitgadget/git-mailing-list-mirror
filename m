Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63E7C433FE
	for <git@archiver.kernel.org>; Sun,  9 Oct 2022 14:37:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbiJIOh6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 Oct 2022 10:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiJIOhr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2022 10:37:47 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A0E27DC4
        for <git@vger.kernel.org>; Sun,  9 Oct 2022 07:37:46 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n12so13626608wrp.10
        for <git@vger.kernel.org>; Sun, 09 Oct 2022 07:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bGtbzq+IH2Ws4ChKWDCxefvQxY0NorgXVM+ffiB3Qi0=;
        b=NaDrKYXI+dfK9/UpD3fJuxYb+prZXK9pmL3/a+bvCb/PBPwtJGkgYCa+Z4BPmh3rxu
         I4nD5bRL1eulfnlXERfqdnfsFREBXuVfGiCK+J7F7vnvfU+tFH1/cJaULhlO7hQfz867
         KdRuJZ/XuxINqCBtAxedxHImRmuYpUIC7yrV4pNuBB9+Uw9CTIpKJFZKiTChq+YIiuUz
         ghwAAab+qVAV479mKBl/RTW87GsBlpw+GiXasKNi/tHc+IrMINtfY5wEOG1XALe4PX2o
         BdZqePixTW+GKo8Xy23aeZkkb57nRTpuCJ7WOOiL6MZTsSOCqRzwX6VlbWp+5ZYmhBQ/
         bpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bGtbzq+IH2Ws4ChKWDCxefvQxY0NorgXVM+ffiB3Qi0=;
        b=tL0hBmOnxiai9BRsDAbGdJjF5cuY/xomXQMxjh5EAGuBzCL+stqkUpQliSFyc+yGNg
         RpVxDoIINEcQtqAZQBJFkvUX/yYkw1GGdGMPCBNvXQdLzmThg9PDzjqBnaP6/NHbVV1V
         57EzL784U0g8YS38QITX+s6IEe1nLCxttQOAFxn0VllBIGwC1+kp6Kc4icKOt5e/1oeJ
         zVyCO0ajvNEaSUQHenS3nGhLXs17ufJzTPgo6X4vHFzYZAFk1hxI4vNseZoibrcUJHgj
         7rZIyOQGpWAFjIwsfOmPDniTBlXS13LT0wgUDVY2Ca1PfAdN1iZqvzWzcXEx4FOGWSk5
         +J2w==
X-Gm-Message-State: ACrzQf2ryhNHnZS8W1Vfm3C9MZF4MqoOUpFUXFuE5+Rzq5lsclSUUQ7y
        4AkHyCocg+VDVlOwqakJ5MmPWeZzoFo=
X-Google-Smtp-Source: AMsMyM7obxphVuQcLKvjmzF/mXvV6goDjAeKI9rZvj57Pt/29UIlVJcSOiK8rOSC52MHalc1D0FvMg==
X-Received: by 2002:a05:6000:112:b0:22e:58ce:40d4 with SMTP id o18-20020a056000011200b0022e58ce40d4mr9011898wrx.193.1665326264392;
        Sun, 09 Oct 2022 07:37:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bi10-20020a05600c3d8a00b003b47ff307e1sm7709442wmb.31.2022.10.09.07.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 07:37:43 -0700 (PDT)
Message-Id: <fa974bfd5ef8f24d259ec31663ee18b65d96d83c.1665326258.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
References: <pull.1352.git.git.1665326258.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 09 Oct 2022 14:37:31 +0000
Subject: [PATCH 05/12] fsmonitor: check for compatability before communicating
 with fsmonitor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric DeCosta <edecosta@mathworks.com>,
        Eric DeCosta <edecosta@mathworks.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Eric DeCosta <edecosta@mathworks.com>

If fsmonitor is not in a compatible state, warn with an appropriate message.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 fsmonitor-settings.c | 10 +++++++---
 fsmonitor-settings.h |  2 +-
 fsmonitor.c          |  7 +++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/fsmonitor-settings.c b/fsmonitor-settings.c
index 531a1b6f956..ee63a97dc51 100644
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
+			    _("socket directory '%s' is incompatible with fsmonitor due"
+			      " to lack of Unix sockets support"),
+			    socket_dir);
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
index 57d6a483bee..540736b39fd 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -295,6 +295,7 @@ static int fsmonitor_force_update_threshold = 100;
 
 void refresh_fsmonitor(struct index_state *istate)
 {
+	static int warn_once = 0;
 	struct strbuf query_result = STRBUF_INIT;
 	int query_success = 0, hook_version = -1;
 	size_t bol = 0; /* beginning of line */
@@ -305,6 +306,12 @@ void refresh_fsmonitor(struct index_state *istate)
 	int is_trivial = 0;
 	struct repository *r = istate->repo ? istate->repo : the_repository;
 	enum fsmonitor_mode fsm_mode = fsm_settings__get_mode(r);
+	enum fsmonitor_reason reason = fsm_settings__get_reason(r);
+
+	if (!warn_once && reason > FSMONITOR_REASON_OK) {
+		warn_once = 1;
+		warning("%s", fsm_settings__get_incompatible_msg(r, reason));
+	}
 
 	if (fsm_mode <= FSMONITOR_MODE_DISABLED ||
 	    istate->fsmonitor_has_run_once)
-- 
gitgitgadget

