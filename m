Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5D2C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbiCASoZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:44:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232623AbiCASoV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:44:21 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D132A24B
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:43:39 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p4so8029940wmg.1
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 10:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=IM62jR5/2Mez2apwBKHg3oiA2LB3K3S3UCqUM5mbyWcZJEa8l7J85mHuR1ZWnSe2MW
         Q4ErZYfBwyEO5opfX6pETeehh/xYlB990DSb+EkZKCHaVFMNtdiU+2YolXEH9BV2IkjX
         WoArwW+uZ0IwTQf8382Cg9CroyDsH0jos8vKX8wfwTo6TU4ixA05HUo1T4zboCN8bGKv
         806bfYv0f/fXdHQGBFSvku3NAvTOyVsLBy4g5yvFq30dlypW32nvuTOF7v46FTwKBfFY
         ib9hb4GJNtoXV6HhFYPULx1LUvm4Lcn4bkL03CpgN1pB6oR5jibyUBBrm5BtxCBPHUvS
         ZIyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=PUfrfk3LSQ1UDAE+u/7DtvrurFnuTW+q1gJyHN+ZN9UeyQ5HcxNvI9Rk6Uh8rPKKAY
         n2Q8RQIuLR1XyROqOZ6Kew8BWMUsKflOOiR3rFQgzt+ph0ebIPp/yd0hmc6o9aLFfhGo
         ZmfNUx5Uh9ZIhfHIcgjZ4n8RwkHJVqtv+OVSw5kJFhKPT/vCC5oFei2bkaNq0Ci/CEYX
         MjYhpfCqbKnw1VVFR6jdZyeLWEy4pKLCGIFgf8A63FlNNlYOYvmVaLZ+oQB531Su5YIr
         ezwTzsacCqFQZIw+fOJh0JgJMy0ZTwJ6ZxZKA/5Xz3RbX1hna2MdXo9MTXcN87hgI/aV
         TRgg==
X-Gm-Message-State: AOAM533WLbXiB5kqHN//u/rx9KXaea9T3xkXTiksugj3rKXsn7fNciOi
        vTDgKKCohUlSw98CMQpDsN86/itAX+4=
X-Google-Smtp-Source: ABdhPJxvQt9qSI8uIzf0bcpnXUobV2XMoAzRUaOBXwidMTfxKQc3IwxsWVjK2dQh+CBmmrT7wTReCg==
X-Received: by 2002:a05:600c:297:b0:381:41d3:e22f with SMTP id 23-20020a05600c029700b0038141d3e22fmr15262237wmk.108.1646160218179;
        Tue, 01 Mar 2022 10:43:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10-20020adf808a000000b001edd413a952sm14582731wrl.95.2022.03.01.10.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 10:43:37 -0800 (PST)
Message-Id: <55974867da5f791fe736221ffa1ae4cf3e204c17.1646160212.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
References: <pull.1041.v5.git.1644612979.gitgitgadget@gmail.com>
        <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Mar 2022 18:43:06 +0000
Subject: [PATCH v6 04/30] fsmonitor: use IPC to query the builtin FSMonitor
 daemon
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

Use simple IPC to directly communicate with the new builtin file
system monitor daemon when `core.fsmonitor` is set to true.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 fsmonitor.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/fsmonitor.c b/fsmonitor.c
index 0e961b74d82..a38b5710eb3 100644
--- a/fsmonitor.c
+++ b/fsmonitor.c
@@ -241,8 +241,41 @@ void refresh_fsmonitor(struct index_state *istate)
 	trace_printf_key(&trace_fsmonitor, "refresh fsmonitor");
 
 	if (fsm_mode == FSMONITOR_MODE_IPC) {
-		/* TODO */
-		return;
+		query_success = !fsmonitor_ipc__send_query(
+			istate->fsmonitor_last_update ?
+			istate->fsmonitor_last_update : "builtin:fake",
+			&query_result);
+		if (query_success) {
+			/*
+			 * The response contains a series of nul terminated
+			 * strings.  The first is the new token.
+			 *
+			 * Use `char *buf` as an interlude to trick the CI
+			 * static analysis to let us use `strbuf_addstr()`
+			 * here (and only copy the token) rather than
+			 * `strbuf_addbuf()`.
+			 */
+			buf = query_result.buf;
+			strbuf_addstr(&last_update_token, buf);
+			bol = last_update_token.len + 1;
+			is_trivial = query_result.buf[bol] == '/';
+			if (is_trivial)
+				trace2_data_intmax("fsm_client", NULL,
+						   "query/trivial-response", 1);
+		} else {
+			/*
+			 * The builtin daemon is not available on this
+			 * platform -OR- we failed to get a response.
+			 *
+			 * Generate a fake token (rather than a V1
+			 * timestamp) for the index extension.  (If
+			 * they switch back to the hook API, we don't
+			 * want ambiguous state.)
+			 */
+			strbuf_addstr(&last_update_token, "builtin:fake");
+		}
+
+		goto apply_results;
 	}
 
 	assert(fsm_mode == FSMONITOR_MODE_HOOK);
@@ -315,6 +348,7 @@ void refresh_fsmonitor(struct index_state *istate)
 				 query_success ? "success" : "failure");
 	}
 
+apply_results:
 	/*
 	 * The response from FSMonitor (excluding the header token) is
 	 * either:
-- 
gitgitgadget

