Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA19AC433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:32:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbiCYTd5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiCYTcf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:32:35 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC72415B050
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:07:11 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id h16so4978465wmd.0
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=aDBD1My7da2KppfsTSqA+LV5wm8c02H13qLg6Uxy6oCLHGAxp7u0bXmMVL+KlDama8
         INhuOaPbbWyHSvt+ytQgX6IZVIony+/9hVzzORNDDyPW0ZowES7/T8YzPzP6c8i8DfPn
         cnh312r3/OmiRvBW2M5AeKr5Dy05LQcYjoKGKk3DY5SxS0V5XaO44SCR06JtCU3fpxxI
         hxaKbfd6MEpXFudZumojW2qOtJl0WEoDHFe6W6f6l/dKGnCJohQ2uQt3TK8FB3ivGGIr
         TDpEH9Oanc5rFXluct8jfyb2ALEkSIDr2i6ixc0R6nVQXrnYRXgIkE0ooukAqyaO2rPb
         erRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oGDRFTIGvSWmNGonDgOtutzgzNzlHM+LdHJYE6AYmv0=;
        b=Jvk1akyqZQQlSYjFzaklnwvPqPKYyLVOZycPZusxkuoLRGKR/JaldyzHmplEp2xzrj
         AULjlOdnn+Vpf7qcPRkb6oqNUm6WWM1NfnyoWDSi40CEXDVh0whlgG8rrp2hBgVGy+mH
         7bgoKqNtWqRoPAPMW1yN3PpSp3CLOAoa99ogtXAE/WPBdrTQvpqpu/MLIKSh1z34HXMD
         4WAn04HEmyK9J7LNmNt2/VrIFJOwuOumIG1c/QivXgoOlO4F4eO7JugkgvcXIb6V3wxc
         Ca8IHp+EJ2wA5zR418bgeNNCS3eZwLAVYMb7e6VPMeks+XSpTvp1nzwjJH9XRidL7Ka+
         OLAw==
X-Gm-Message-State: AOAM532IkLtswxcjh4JHCoSVoGl5vRX5d3pRKxajpQZzHg1jopF20W+J
        g3r64QBt35aTnErdC0nf1oldmvJj7Js=
X-Google-Smtp-Source: ABdhPJxaxpUawYuvHrkkONLz5eM+lnYIgKwWjvjLMBdPCmxnMHLKpK7q31t2m72vbWPZIA1ZdSc4Zg==
X-Received: by 2002:a7b:c922:0:b0:383:e7e2:4a1a with SMTP id h2-20020a7bc922000000b00383e7e24a1amr11362661wml.51.1648231399656;
        Fri, 25 Mar 2022 11:03:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p23-20020a1c5457000000b0038c98c12ea9sm4983399wmi.1.2022.03.25.11.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 11:03:19 -0700 (PDT)
Message-Id: <ea02ba25d8f0e5e76a646d23306eb6a2b312ebe2.1648231393.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
References: <pull.1041.v8.git.1648140586.gitgitgadget@gmail.com>
        <pull.1041.v9.git.1648231393.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Mar 2022 18:02:47 +0000
Subject: [PATCH v9 04/30] fsmonitor: use IPC to query the builtin FSMonitor
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
        Tao Klerks <tao@klerks.biz>, rsbecker@nexbridge.com,
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

