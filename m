Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C8F1F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:30:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfAVAan (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:30:43 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46022 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVAam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:30:42 -0500
Received: by mail-pl1-f195.google.com with SMTP id a14so10527849plm.12
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RMS3lhtscUxyTYRIhGe99HhCTSViI9EUxOWeMtT+tQ=;
        b=c/zlcJSW27dlXTXxppBm4e4jbcUai6BE8bj9rREPYvQ8UzCCNr+ZYTlY0yqRVWOUR3
         XNNvDjGb5DB9ScrEQoUJ0+xS7ps8MchzN7JSVPUydpboFYu06bIFTWp5tcMmrbZ6X5yL
         buMzTNNkJntUocanWCI8gbHcJnh43N0q9/YF9Ou2/sNi1ypq+UZXjhSiF1ey0BFJ/Jlr
         KyLZ5n48lsy/uLSYnraOZ5h/4FBnjHAVxxpjOyuMpD8bhGPVHy7A2glDZ8Z/fmzHBMum
         uFddxnTZJfrktfVfWI162ih3YVJZqHRpf2S6tQZYOPWDXGA7igF/nNeMz+FtekUoItXL
         ngrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RMS3lhtscUxyTYRIhGe99HhCTSViI9EUxOWeMtT+tQ=;
        b=TE8HDbIl8aUcPpwUln24DJP/vndbHdGcvCqxzdxQqtXbfNBESsvyredakWC+MlO6/+
         LEK5JomDs6/JdWygJInxzo+9SNqJuV08jtzk6W9Rn/wchf2+2WlJwREIq/LxituSAJTy
         3XvDsQRTBAD3bRA70QojZa45ixR/Z8DNbPIuC1gqFzEfujRIsLZH5Cb4JR3CExC3wS92
         7IFrS5f/vhRzRwQkNm+H6wsXCiFn8fjGLQMCahYC4sLDgGiqzqtSRF3kwUTY1PFAoL+D
         00bHS4GFvaoR/dQfigu1qauNprUgvqhrX0rcYg2kLc+M30gr/Q/sj5xwk5jn/6CwVovp
         c4Og==
X-Gm-Message-State: AJcUukdj5HSf65/CY8IaPc2DPacvM0p1XUAifx302k0wRngM1fLi52qg
        t7OuXViSK0AI6EvhcSC6DKXJxS4F
X-Google-Smtp-Source: ALg8bN41UkYOz/KCOh/0w76F1WOGaOaUrqDGe+KWHqlEJgS9t+QN/5uHXimlGkbIYsHzhJmh9y8CuA==
X-Received: by 2002:a17:902:4324:: with SMTP id i33mr31565164pld.227.1548117041852;
        Mon, 21 Jan 2019 16:30:41 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id p77sm26157897pfi.85.2019.01.21.16.30.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:30:41 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/3] Revert "parse-options: allow keep-unknown + stop-at-non-opt combination"
Date:   Tue, 22 Jan 2019 07:30:18 +0700
Message-Id: <20190122003020.9672-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122003020.9672-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
 <20190122003020.9672-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit a85e5a01080e35da0f94bf98f5f334c64e214ce3, which is a
revert of 0d260f9a09 (parseopt: prevent KEEP_UNKNOWN and
STOP_AT_NON_OPTION from being used together - 2009-03-09).

As described in 0d260f9a09, this option combination is tricky to get
right and should be prevented unless you know what you're doing. In the
one-shot mode, the diff and revision parsers are very well aware of
remaining arguments being potentially unknown options or revisions and
should handle the combination safely.

Reinstate the check added by 0d260f9a09. Modify it a bit to let one-shot
mode through.

Noticed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 parse-options.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/parse-options.c b/parse-options.c
index a0ff8ea225..cec74522e5 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -466,6 +466,10 @@ void parse_options_start(struct parse_opt_ctx_t *ctx,
 	ctx->prefix = prefix;
 	ctx->cpidx = ((flags & PARSE_OPT_KEEP_ARGV0) != 0);
 	ctx->flags = flags;
+	if ((flags & PARSE_OPT_KEEP_UNKNOWN) &&
+	    (flags & PARSE_OPT_STOP_AT_NON_OPTION) &&
+	    !(flags & PARSE_OPT_ONE_SHOT))
+		BUG("STOP_AT_NON_OPTION and KEEP_UNKNOWN don't go together");
 	if ((flags & PARSE_OPT_ONE_SHOT) &&
 	    (flags & PARSE_OPT_KEEP_ARGV0))
 		BUG("Can't keep argv0 if you don't have it");
-- 
2.20.1.560.g70ca8b83ee

