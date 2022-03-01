Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96C8CC433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235014AbiCASoU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiCASoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:18 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176BB286D5
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:37 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id bk29so4649386wrb.4
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=DGrIqUPt3UKqGz+RDcfyfrM2OXbigV5jWZ0e260JNq726J8NMzj8swYrmz/kr0HXjG
         mus6uzU9GCe1FdQ94RK/rVnj5rO1qouNyII5S2RCt6U4akgwlbEXQ18V+w43WT/ElnKE
         RR7M+rW0zBkZzp7WwiJOuGWq0WClgK7Lu4MetVORg6eOj92vGAJ0oB3qhkfp4rBVRDW8
         7hDSDC7jGWl8Rpd3vlLdePYv+e6a4u6aSiWkasn2vMhcvZMzDE6gFdAwIc7JV9S832Zw
         BXh+PO14Ji9DMsmJN9ylQmLh5jv8RPQxBHMTIuZr0Ijp6jg8D/3c2m1Ddb3mHm5HNihN
         TCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GykMGxH+vcSxKSOuzIgVgE2plWrsxxaHhbdq7JLSrgU=;
        b=kcMY2y91VyIK+XvS3aRXgiHGGQpP9h5KnnHeOLfdoQWucOgevg4XpYRbTIZ3xyNv/s
         rBrYVpvGDTtpnMhY5+llRqBMClUX2ZLH/gztudi11B1noIo0yqJfLDJh3DRbx9Hn+Oit
         hnwroHQz2h5JtIxnP8sUxci3kszJOcEZEbOyMK+05pXOEAc2OmFW4+IHPuO61hwrsNE+
         lTO40O4G55lrsHrh7GAV4JrKLJZQAqxympJksHRyjm42DvJNQi49K7chLDa5sTKpb7FJ
         wbfBEQUlZGMF6VCbcPOtMusKxSq+yw3f1PYA9YWeTjecBpDdg8AmPJsgMRk08tpCcBnZ
         1gWw==
X-Gm-Message-State: AOAM532+KjCV9y3U7SAvfSxmGopT9neUKXzH0XFVaCaqCFFMl0k91kbf
        6AR0pCMvCl+6cf+/pPFpEmN2X98J9j4=
X-Google-Smtp-Source: ABdhPJwCUrIf1k++hwg/xFNL50BbduFOx4111AX+12AZOUi8eSnOL4eqOE2I7bOl6KrrNOdQVzv8iA==
X-Received: by 2002:adf:d1e9:0:b0:1ea:7d0f:69c7 with SMTP id g9-20020adfd1e9000000b001ea7d0f69c7mr21208548wrd.373.1646160215272;
        Tue, 01 Mar 2022 10:43:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i20-20020a05600c355400b0038164ef5418sm3596937wmq.32.2022.03.01.10.43.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:34 -0800 (PST)
Message-Id: <10a34082fcc7ddf693b4a50fb2ce05905ee2986f.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:03 +0000
Subject: [PATCH v6 01/30] fsmonitor: enhance existing comments, clarify
 trivial response handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff Hostetler <git@jeffhostetler.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tao Klerks <tao@klerks.biz>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsmonitor.c | 64 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index ab9bfc60b34..448d0ee33f5 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -168,29 +168,15 @@ static int query_fsmonitor(int version, const char *last_update, struct strbuf *
 
 	if (result)
 		trace2_data_intmax("fsm_hook", NULL, "query/failed", result);
-	else {
+	else
 		trace2_data_intmax("fsm_hook", NULL, "query/response-length",
 				   query_result->len);
 
-		if (fsmonitor_is_trivial_response(query_result))
-			trace2_data_intmax("fsm_hook", NULL,
-					   "query/trivial-response", 1);
-	}
-
 	trace2_region_leave("fsm_hook", "query", NULL);
 
 	return result;
 }
 
-int fsmonitor_is_trivial_response(const struct strbuf *query_result)
-{
-	static char trivial_response[3] = { '\0', '/', '\0' };
-
-	return query_result->len >= 3 &&
-		!memcmp(trivial_response,
-			&query_result->buf[query_result->len - 3], 3);
-}
-
 static void fsmonitor_refresh_callback(struct index_state *istate, char *name)
 {
 	int i, len = strlen(name);
@@ -238,6 +224,7 @@ void refresh_fsmonitor(struct index_state *istate)
 	struct strbuf last_update_token = STRBUF_INIT;
 	char *buf;
 	unsigned int i;
+	int is_trivial = 0;
 
 	if (!core_fsmonitor || istate->fsmonitor_has_run_once)
 		return;
@@ -283,6 +270,7 @@ void refresh_fsmonitor(struct index_state *istate)
 					query_success = 0;
 				} else {
 					bol = last_update_token.len + 1;
+					is_trivial = query_result.buf[bol] == '/';
 				}
 			} else if (hook_version < 0) {
 				hook_version = HOOK_INTERFACE_VERSION1;
@@ -294,16 +282,38 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (hook_version == HOOK_INTERFACE_VERSION1) {
 			query_success = !query_fsmonitor(HOOK_INTERFACE_VERSION1,
 				istate->fsmonitor_last_update, &query_result);
+			if (query_success)
+				is_trivial = query_result.buf[0] == '/';
 		}
 
+		if (is_trivial)
+			trace2_data_intmax("fsm_hook", NULL,
+					   "query/trivial-response", 1);
+
 		trace_performance_since(last_update, "fsmonitor process '%s'", core_fsmonitor);
 		trace_printf_key(&trace_fsmonitor, "fsmonitor process '%s' returned %s",
 			core_fsmonitor, query_success ? "success" : "failure");
 	}
 
-	/* a fsmonitor process can return '/' to indicate all entries are invalid */
-	if (query_success && query_result.buf[bol] != '/') {
-		/* Mark all entries returned by the monitor as dirty */
+	/*
+	 * The response from FSMonitor (excluding the header token) is
+	 * either:
+	 *
+	 * [a] a (possibly empty) list of NUL delimited relative
+	 *     pathnames of changed paths.  This list can contain
+	 *     files and directories.  Directories have a trailing
+	 *     slash.
+	 *
+	 * [b] a single '/' to indicate the provider had no
+	 *     information and that we should consider everything
+	 *     invalid.  We call this a trivial response.
+	 */
+	if (query_success && !is_trivial) {
+		/*
+		 * Mark all pathnames returned by the monitor as dirty.
+		 *
+		 * This updates both the cache-entries and the untracked-cache.
+		 */
 		buf = query_result.buf;
 		for (i = bol; i < query_result.len; i++) {
 			if (buf[i] != '\0')
@@ -318,11 +328,16 @@ void refresh_fsmonitor(struct index_state *istate)
 		if (istate->untracked)
 			istate->untracked->use_fsmonitor = 1;
 	} else {
-
-		/* We only want to run the post index changed hook if we've actually changed entries, so keep track
-		 * if we actually changed entries or not */
+		/*
+		 * We failed to get a response or received a trivial response,
+		 * so invalidate everything.
+		 *
+		 * We only want to run the post index changed hook if
+		 * we've actually changed entries, so keep track if we
+		 * actually changed entries or not.
+		 */
 		int is_cache_changed = 0;
-		/* Mark all entries invalid */
+
 		for (i = 0; i < istate->cache_nr; i++) {
 			if (istate->cache[i]->ce_flags & CE_FSMONITOR_VALID) {
 				is_cache_changed = 1;
@@ -330,7 +345,10 @@ void refresh_fsmonitor(struct index_state *istate)
 			}
 		}
 
-		/* If we're going to check every file, ensure we save the results */
+		/*
+		 * If we're going to check every file, ensure we save
+		 * the results.
+		 */
 		if (is_cache_changed)
 			istate->cache_changed |= FSMONITOR_CHANGED;
 
-- 
gitgitgadget

