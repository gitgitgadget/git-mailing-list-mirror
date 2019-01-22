Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 143771F453
	for <e@80x24.org>; Tue, 22 Jan 2019 21:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfAVVWV (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 16:22:21 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:34970 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbfAVVWT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 16:22:19 -0500
Received: by mail-ed1-f66.google.com with SMTP id x30so19940edx.2
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 13:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=ItU/6BQFY+gBt0KcJWlG3Hljr1XeFfRNad6e4+ENr/qLQYkgyzs2KYbCwBMlqsi1TO
         htAgb9gImECsgUS4rcB4ttMwpbtbq0s1UR6TEry0tiRWZvZu4IRNM5rHGgPtxi8tIXNU
         BqQaYqextsTtOanGmENpyLz86P/9RUg5EwRTrNX1xok5GApVl5JCKMbnn3avs6QYgVsg
         lCfN0D/O4sgXRFrUYJGpEo8iojN3GyjO/nn5aV+Ih8euBr6BBB1GXX1Ydh7jhN97jm57
         jm88tDMyH63ASi++72ckD/TTdi8NnaT4AiG1vQe5OFfoYwaGzfMd7ppQEXS+ato3Sw+F
         NALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lEO2zm4D+RRdgd0jZP3xHjEnfHFoC5J4c6eHcxbWOoE=;
        b=F2fjuSJvldvRvNXKKFOsf9uMpZCbQGKoBTAoNhlASGRdvlQGn8oJwg59KgZWrSrsbV
         BHwrVon9HgTrESrOxUdu7aIySuq3m7AbEPZNObOgF4t1fPSTmbyODIWauW7Un7zzClXQ
         xGMgnuNLeQfXokWve7ghTjl6Vj41MsUJx3S3vKbP3R5EGWiVc68ZrqWInxBgVcETfCuO
         gBpKJbBUCflWMKzBq74zsX62Ewpq9QxNctHTVQM9nRffJIO3NCT1bQbK2KrzCRLQmBYd
         OSvkD42tlMk6663NAsMZT10fu1OR/FapMHyiqHIzM1hATgHrzXn8GlwVLmmuHYnGVZct
         C/BQ==
X-Gm-Message-State: AJcUukfS1hqLySBrWPn48Xih+Z3ddH3yH4TBdKQZYXHNm45EJYQp0v+0
        dfVHsJp6HSgPdIRwB/Anj5xKY69+
X-Google-Smtp-Source: ALg8bN6YQQTpA8CDxTLZvYEO1B47hAhOFvv8E21Ct2Aek7JQCiCUntl9ROvJ4eouRgfkHlRFA7pWCw==
X-Received: by 2002:a17:906:9259:: with SMTP id c25mr110533ejx.31.1548192138051;
        Tue, 22 Jan 2019 13:22:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x38sm10195817edx.24.2019.01.22.13.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 13:22:17 -0800 (PST)
Date:   Tue, 22 Jan 2019 13:22:17 -0800 (PST)
X-Google-Original-Date: Tue, 22 Jan 2019 21:22:03 GMT
Message-Id: <a20cf139eed7d19f0faa82981d77467c9e34d239.1548192131.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.108.git.gitgitgadget@gmail.com>
References: <pull.108.git.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/14] trace2:data: add trace2 sub-process classification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add trace2 classification for long-running processes
started in sub-process.c

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 sub-process.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sub-process.c b/sub-process.c
index 8d2a1707cf..3f4af93555 100644
--- a/sub-process.c
+++ b/sub-process.c
@@ -88,6 +88,7 @@ int subprocess_start(struct hashmap *hashmap, struct subprocess_entry *entry, co
 	process->out = -1;
 	process->clean_on_exit = 1;
 	process->clean_on_exit_handler = subprocess_exit_handler;
+	process->trace2_child_class = "subprocess";
 
 	err = start_command(process);
 	if (err) {
-- 
gitgitgadget

