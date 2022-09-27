Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B45C6FA82
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 20:57:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbiI0U54 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 16:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbiI0U5n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 16:57:43 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5396E1B85E3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id z6so16835365wrq.1
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 13:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=dGPBcKUgeUZ0B0/7zoDbOtB89jBJhmHgJI4xQ6b+zEk=;
        b=eTiR4D03dv342Lbt/xBJCYOpDiTbPdGXglUYjvNKxJyejR5FL7rnUeTsLGZb+Eysyn
         kxnySZNdTz+29o7QXiy1HnRM9Pu/GdF74tJKWrAJS6NOhx3a3/8nsCt9WSy3EQ+/6kfC
         C4igv6J3k0hEUSZQS/ACWGoI04RF9nkXNbIf88KvhiT6+XdSrC5kjzQF6mlGwEf8hkzG
         ZcMX2xovYHNMlundwl2fcIGM8cAe9zX6AVdN0pJ339xA14l7PZ5Qv6rACbjLiv7dp5SC
         g1Ok4kAF/eqCVNEcqdtMcZ+Ynu3Uf6BXD4qEinNbSHSO9PKaWzZOio308yCbcphlpb2W
         m+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dGPBcKUgeUZ0B0/7zoDbOtB89jBJhmHgJI4xQ6b+zEk=;
        b=xIpUgAA7j2e/3pE7RYzGZb2PIq30JMi4zCESXMS13sffF24LaPEDlFnEIiKryAOmW2
         hazvK5CRu+0LFS6hlpEzOONwDwEIqX8obGYOrifosNzIlOqeR4/VTsyfMCkGWi+CQLGW
         BP1+HAZq2/rgDCUwAC5dWDfLf0f+gsGjoeoK5NAGYlnLUzH9kceopEA2JMZ90BobqJQI
         08FpM1kC/+4F39QHnm5O+KWN3LoKQuWF5Ge589xcmFCyEoYSYa0RQV2DqOGa7U7bzccc
         q09n8IVqPtbVpqp67t8BP5fJkDgsPKT5AhmSrKzC8yVy2ms8QI7s2S704mEJGuAcHYsO
         m6hw==
X-Gm-Message-State: ACrzQf0sLjclfemzNtt01JoCIyZTe543J3eC4j02kNfCK/FTtDdewS9s
        px8iJ7IauWq+1Zxwo48PfbN5kBzFiCc=
X-Google-Smtp-Source: AMsMyM6CBgJ36yHADVeemzg5HQCcCxcbx1UwOFhAKWjZhdWExO7VgRw3/yB4rbkdj7TC+x95FFtLrg==
X-Received: by 2002:adf:d1e3:0:b0:22a:b9e2:8841 with SMTP id g3-20020adfd1e3000000b0022ab9e28841mr17939806wrd.184.1664312260698;
        Tue, 27 Sep 2022 13:57:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n43-20020a05600c502b00b003b486027c8asm15239129wmr.20.2022.09.27.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 13:57:40 -0700 (PDT)
Message-Id: <b1ea378dff7848a4e654e1e10f8a1f9681d42dec.1664312254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
References: <pull.1326.v12.git.1664048782.gitgitgadget@gmail.com>
        <pull.1326.v13.git.1664312253.gitgitgadget@gmail.com>
From:   "Eric DeCosta via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 20:57:32 +0000
Subject: [PATCH v13 5/6] fsmonitor: check for compatability before
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

If fsmonitor is not in a compatible state, warn with an appropriate message.

Signed-off-by: Eric DeCosta <edecosta@mathworks.com>
---
 compat/fsmonitor/fsm-settings-darwin.c |  2 +-
 fsmonitor-settings.c                   | 10 +++++++---
 fsmonitor-settings.h                   |  2 +-
 fsmonitor.c                            |  7 +++++++
 4 files changed, 16 insertions(+), 5 deletions(-)

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

