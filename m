Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72BACC433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 16:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351846AbiCXQvj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 12:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351830AbiCXQv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 12:51:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBA3996AD
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:55 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u16so7490271wru.4
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 09:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=G0TC5+LYaF831v/Mbtmtr7gl3WWUXBZkWlRur/UQRQg0w4YFcTDaFu3Mw/93lJxQim
         4+2f4ZW1Xqr9BMki8qMJmVc+YPN86zfJVoWnfYZ2F3kTBkORQoLFicceOhhHI6Sk5KxR
         wdgOOmw72mL+2xEJwh4EhjyINmcDlHWkPDBD4nDyu2DPmuJC/AWFLay+cEwUhP7tSTP7
         5N/ddP19ffI/RGbMHHgAC32JKBoKTuF4C7aEx/NuzcXbDvk5mKpOLW74BYJKGtV4g/ub
         6XHrwS9AQgpA294qorRuxA12lwQXVKiacFPUpIkX6Hdf/RLimiVvPXKrvL3J2G7Xqg6F
         ShbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=r1TWkvKqGQiflCMy553oOBEFKD08uWbrQy+NK556jBEdXVCVomzrb/e236TUBpyc3z
         1t1kfTbqnDkeFasji50kzdUrpQAmaNASTmTmQpw/HwIwKij99EIF94UQelHCuf/Xzzmi
         Xw36fnh3yA4+4sO22WYUkA2rMnI42dOu6msSlCbIupd5u9CJo6U+x9EjzZilUO3kxvvb
         RSUuy3ml+hOWRoIb71xvY6dAOIkXZHqFS0Zk5lUVvt1HggFoTQv8D8zXoxbIdxa2Jbut
         EFa7HngNGvic9xvll00nG65BiaRVPWNiwfXSN2IosfifgohL0e/7fDM8x2WhOy4B6GXv
         7lXw==
X-Gm-Message-State: AOAM531ZNXWgzV9uqMiTf83XZviNVYX+wuV7HlwkGOjPjeP9LnsKzvdu
        YE9g5y0D1yLzxAwt8Sfv9dLPp7eQmG8=
X-Google-Smtp-Source: ABdhPJxL2A3AD29WiogsK95v/8HC0/I/PDH5zTDimZoMM5F/8X4dNoeUNbU/vG7a+FywTmdor1mDKw==
X-Received: by 2002:a5d:6505:0:b0:205:9a98:e184 with SMTP id x5-20020a5d6505000000b002059a98e184mr2321012wru.317.1648140593909;
        Thu, 24 Mar 2022 09:49:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i5-20020adfaac5000000b00203fd04bf86sm3020436wrc.66.2022.03.24.09.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 09:49:52 -0700 (PDT)
Message-Id: <ea02ba25d8f0e5e76a646d23306eb6a2b312ebe2.1648140586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
References: <pull.1041.v7.git.1647972010.gitgitgadget@gmail.com>
        <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 24 Mar 2022 16:49:20 +0000
Subject: [PATCH v8 04/30] fsmonitor: use IPC to query the builtin FSMonitor
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

