Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14566C433F5
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353467AbiBKU40 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:56:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbiBKU4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:56:25 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37B3CBA4
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:23 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id s10so3656846wrb.1
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:56:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RRpz92VGuvw0YR2fhpzZ+/QaEGfxZA1ikNoqwNpxXPw=;
        b=HaByYoJL9fTSzHxbHXyTXPmRw5r6/qrOMTcl6zyZsDvroAoI3ErLurvjSQMJ0y7Mn9
         D4cpCjKZeZ58Or+tT30/PHSSmILh/DCGmFiJY28RWj3mNSpuGX4C8cHZ+KMAvO2NaxkK
         9VJJ5thlafDuD/l94nahvEBnVHPf+05Z8+8BqaT1psAZ+2X0AyfoM9AP5kkbePMWt/cc
         YEk8MloEwF0dfcokqho3C0hMav31jsGA/2Azxkfq939oPWY5ifpzCe48Jkdxph+sKBvB
         OdkxXlLt1ioJQOCbscd4vbQTujUT7JfR4LLIBnU78Btlb2Z/pMM3RF3nxrLVDW7a99gO
         105Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RRpz92VGuvw0YR2fhpzZ+/QaEGfxZA1ikNoqwNpxXPw=;
        b=uO3tksNq5fw56Uj8Gcnf854PrkISC1fE50AVF26QyZqAfqeNZOU+anEEPmLtEea6F9
         gML1uhTM0An7ZuOuwsMrY0YRoq5jrPymBjxJ17FwUzZS3YNsLY2oNeE9vYEtTe3wKtuL
         opdh1TYmaHvcGeXDSzADW2juDto7UHY7NYK1X79M9VierH6rEWNbSSbB+pyPos3wx9wR
         7ITEYoG8TBPTG/tTqHdOHopC39iV3YnJmdyJjBUgfbXy5Yf0jEOYYTpC6+J5dkeDJLqI
         NaOS3pvPFGYnfh0z5Gq53628Yy8zPhtOEk6D9MInnZGHTDkXFkNuX4JOlPta9cuVNnti
         J7WA==
X-Gm-Message-State: AOAM5315M5bG6mEEKkK3LGbAe/WKfNTunLOIA87Dmnv1djHWgft/I39T
        2W9CnsTylSQSgD4TLmrKbhW8UKBQ64Y=
X-Google-Smtp-Source: ABdhPJz7mTeB+1orxzjmBk38iaqYFLSTN19KJ+SA3XP97et5lJQVWmChUaxRfwkIAG6DXVFih/aUMA==
X-Received: by 2002:a5d:5541:: with SMTP id g1mr2620224wrw.515.1644612981628;
        Fri, 11 Feb 2022 12:56:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k34sm4048356wms.35.2022.02.11.12.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 12:56:21 -0800 (PST)
Message-Id: <a5ecabb4d02eb0eb7167f2b4e6be2d4f89d2bba5.1644612979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
References: <pull.1041.v4.git.1634826309.gitgitgadget@gmail.com>
        <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 11 Feb 2022 20:55:50 +0000
Subject: [PATCH v5 01/30] fsmonitor: enhance existing comments, clarify
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
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
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

