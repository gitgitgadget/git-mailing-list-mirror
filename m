Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F94C433F5
	for <git@archiver.kernel.org>; Tue, 22 Mar 2022 18:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240039AbiCVSCD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Mar 2022 14:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240018AbiCVSBw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Mar 2022 14:01:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F2C65805
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j18so14917788wrd.6
        for <git@vger.kernel.org>; Tue, 22 Mar 2022 11:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=WeznbcD6tryuJLIBd076s3SbMo1LhAWUNvXQ6rkA40D08UtS4JFYvZ7wjlM3+NXKW5
         lmYTc3FBwyRMi6J5geT0YXqn/eLk+BWll5uGzn9p3LBXTAef23fMqAYmDGtgLi5tgKt0
         sH38ENZqMeJWLO/Po0WfKZlX+FaYnGSF8c3MudM/WGRmW/L9EtzXqdTtjHHOQGFdhDZs
         4JITiAertvTL0OytWi79F5L5PHc/i9UgWgfm1MyLGwSRLTAaDZQsSeE4yo1UmOSQbUHM
         cquxINHIO/cFq3SPTh/ok/cb+k6MAVh4qiRcodOU7bZi9+Tsdem3FIS0Xkh9QVeF67x2
         mqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=TT7olviauF/LMYt10KAYW41/9kdJbWbT2mQd2pKY7omzYlp6V3CWtWu0OKw4rP0s/C
         tnl4EEIVsDuBRMKa5Zcz0v5ac+YPDjCwfrDdeVMAZZtTDoIr3VxNcH46qMPFAldEjWEI
         M8dRGTQge7LtFe6DkEwDxTrnxcDqKeSrQtn4dJc+4j4I31sq0C5SZ9dvvsi+f9SSGE8u
         WLX7XHInltIZoSgjBsdGqSqMiTC6bYseD6FeaCX/0FTJO8DneTCC/PqygIrcmTZQG+jL
         UojrHiYYNzhwliMDDuRv+HKfr1I3BpRa3vaKSubsGbSKa31CZSxBNOZzib+WHqq2IgHm
         WNvA==
X-Gm-Message-State: AOAM531hv4BBH/V2VE4SMwMiPN/s9p7PSJLwwXsL3LutHBpp6kLEVPXV
        0B7syVYfbbPDD7TFbE58uw2dXs7Mr2w=
X-Google-Smtp-Source: ABdhPJybSt75AXHIBgbOfSDHqew2y6riVMfMdRGxUnqWBPndRMfJ9qr39Eqa+7vz28fCzWg/EIDWlg==
X-Received: by 2002:a5d:588c:0:b0:205:7f17:3901 with SMTP id n12-20020a5d588c000000b002057f173901mr1841691wrf.359.1647972022771;
        Tue, 22 Mar 2022 11:00:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d1-20020adffbc1000000b00203de0fff63sm16359338wrs.70.2022.03.22.11.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 11:00:22 -0700 (PDT)
Message-Id: <ea02ba25d8f0e5e76a646d23306eb6a2b312ebe2.1647972010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
References: <pull.1041.v6.git.1646160212.gitgitgadget@gmail.com>
        <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Mar 2022 17:59:45 +0000
Subject: [PATCH v7 04/29] fsmonitor: use IPC to query the builtin FSMonitor
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

