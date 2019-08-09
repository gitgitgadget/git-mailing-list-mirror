Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F229A1F731
	for <e@80x24.org>; Fri,  9 Aug 2019 15:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407250AbfHIPA5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Aug 2019 11:00:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407234AbfHIPA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Aug 2019 11:00:56 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so6048206wml.0
        for <git@vger.kernel.org>; Fri, 09 Aug 2019 08:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qactH6NGLKS36jenwYSX3VNJA3yZ7TcKZEALDn+R0jQ=;
        b=HweQfJN6GxfwPqWD2hZ1e7jLno/8DG2cmU68LIejJff12UiDpQgouGGH6c2xgdsRET
         zq4QcvtnF/CnibJnGc4veOFG0ewwn1gju5ta5Wp0a/s6mZRa5YNQwTH/EK9bFzzsrado
         BrLOy/hc5xBPC5nagW66vObOTcsHfxOc4ArS33qvAGfRFtghc091kLxhKlz4hoUPlvJ9
         uxLkMaYd5hsJ5r6gLIF2fRriTD9hrbGA/bs+4gxl+iw3rg7fbyA+maABie+BLx8hvu9x
         WzMn8p2q6E1izAFA41CHu9yRYI2ImBbGmqGnk343iVJ4ZPZ/ROksLF+a8FGBVW3NvXz9
         3HpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qactH6NGLKS36jenwYSX3VNJA3yZ7TcKZEALDn+R0jQ=;
        b=WV8vSuYFiXznl2qO/+IVMmWtbeU9+bp8nxFWuSGuGi94O+TIxq+sIfMQl2iX6+Dt8+
         XfIPcdaiwlKh1ZyeE2a1nrPFumotF5mE0wliSwtyeA3+PdPEc6HxJBbtJM5HaCWrMlK2
         wnwhIh7AJ2Il+QKNmSOuxeixw4H1qidW0ebfhoUkQ0AgKLQlYtoqDYZoVC7fhE7Y7iA6
         vjseTWEINQBeyvPAflJutROx54+GdYPrrMMPbvb1Fbh3vK8CBFNfhZErKpv+ohZpOwgv
         sJMksM1AWyPnhJEy5g6Ai6Ns6mYtJqSbQjLtvkYftSU1LegaX0NXiF5ZrZ23MpDbWffv
         s5Kw==
X-Gm-Message-State: APjAAAVuTHrpOttfa7UH8Mi5mtQt+PueGrceri37YbZCgBvFNwlkpreL
        NgjDfA8TdCF83C8lzClN3ghW5tjf
X-Google-Smtp-Source: APXvYqy03fukdQ8LKyBSbvu/LYvxBvhzkffkPYX0d35SgePAWHU4WeKeJau+MSooKXcWZxKNQuF67A==
X-Received: by 2002:a7b:c651:: with SMTP id q17mr10656889wmk.136.1565362854264;
        Fri, 09 Aug 2019 08:00:54 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h2sm4046821wmb.28.2019.08.09.08.00.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Aug 2019 08:00:53 -0700 (PDT)
Date:   Fri, 09 Aug 2019 08:00:53 -0700 (PDT)
X-Google-Original-Date: Fri, 09 Aug 2019 15:00:46 GMT
Message-Id: <db3509971281bbaadf2003c3b3fa3058ca5f9ab0.1565362851.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.298.v3.git.gitgitgadget@gmail.com>
References: <pull.298.v2.git.gitgitgadget@gmail.com>
        <pull.298.v3.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 2/7] trace2: trim whitespace in region messages in perf
 target format
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Avoid unecessary trailing whitespace in "region_enter" and "region_leave"
messages in perf target format.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 trace2/tr2_tgt_perf.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index 4a9d99218b..fb845cb627 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -452,8 +452,11 @@ static void fn_region_enter_printf_va_fl(const char *file, int line,
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	if (label)
-		strbuf_addf(&buf_payload, "label:%s ", label);
-	maybe_append_string_va(&buf_payload, fmt, ap);
+		strbuf_addf(&buf_payload, "label:%s", label);
+	if (fmt && *fmt) {
+		strbuf_addch(&buf_payload, ' ');
+		maybe_append_string_va(&buf_payload, fmt, ap);
+	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
 			 NULL, category, &buf_payload);
@@ -469,8 +472,11 @@ static void fn_region_leave_printf_va_fl(
 	struct strbuf buf_payload = STRBUF_INIT;
 
 	if (label)
-		strbuf_addf(&buf_payload, "label:%s ", label);
-	maybe_append_string_va(&buf_payload, fmt, ap);
+		strbuf_addf(&buf_payload, "label:%s", label);
+	if (fmt && *fmt) {
+		strbuf_addch(&buf_payload, ' ' );
+		maybe_append_string_va(&buf_payload, fmt, ap);
+	}
 
 	perf_io_write_fl(file, line, event_name, repo, &us_elapsed_absolute,
 			 &us_elapsed_region, category, &buf_payload);
-- 
gitgitgadget

