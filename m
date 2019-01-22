Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E72641F453
	for <e@80x24.org>; Tue, 22 Jan 2019 00:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbfAVA0o (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Jan 2019 19:26:44 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46743 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbfAVA0n (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jan 2019 19:26:43 -0500
Received: by mail-pg1-f195.google.com with SMTP id w7so10157438pgp.13
        for <git@vger.kernel.org>; Mon, 21 Jan 2019 16:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vDuiZrbB0ahKTNzPP967r6ifOxUzBiA8g+PSGUTJRB8=;
        b=NenAJNNxaju+l6vNB/nwnzRRTbepm4xDmQ26pBAkisrOQ4qC+i0VonM8U6WCWcZ/5K
         pvTg87Jf3+5oayaJn4Qj6VYGXG5cKnOxyn7kRR+LdByDTDRaC79nofUap/9egHP/IRy8
         iseiifGUtjiJ9BYlkqZkJZ39i6MtJygRiLSD5q/mTCYl1OLC7Dk3/ecP5UEClA2o9kTi
         OvfnrLJGb8ey2AOfKZ5lqQkMqMMawP+R4YpFD7o0Y0E4RT+W5TpKycTnBf8ni+qHnZbs
         RybFnrHodF4HPr+KI9/qXkynIcBVF+Fj84EqEDIEAaOPz2dTQHhy6FI7lVBTdC6jMTp9
         DQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vDuiZrbB0ahKTNzPP967r6ifOxUzBiA8g+PSGUTJRB8=;
        b=XSoT3Gt7Jhp/zLTq8bX0obQvpZFmr8Gm7vggsKax6Sm6MJk/B+2eHA3AG7PtF8MP9Z
         QB62wbGPZOJl4pilytNjHAR+ZVqQgfTYH+ylT8z+quz6PKtjc7j5Y5QVCiXE9viwsiv7
         Y4DUBIiZj05GZYi887mbebXvPbTz7D6f8lIEcxibGfIHfxSi6fi0K9QO+BuuiH+vseUB
         7T1vz0LcpyzSkz+4Crn+LOoaWV/2nioE/HDNl0hXnOfkCBvLQJ/lOH7t1kzSG2h0p6Iz
         v41LRJubACX6+G6dqclv9qkxmBiqdYlq0G/31JJ1gi43+9pBVD1O4GsyHIBV1hv28iST
         LpEA==
X-Gm-Message-State: AJcUukdsBPqLncH9oGbtrP8FaLfx9v1w79esEwyfAQIuYqNqnjbj3ZsB
        +61lLDgXi0olhzIy12551sD4f+nO
X-Google-Smtp-Source: ALg8bN6ENK3se5hkmE7+7UikmYFZ52iRmyW162XJdUabBtvir5pXZx75iz2ULoBXLkDdJSlXsRN1oA==
X-Received: by 2002:a63:b81a:: with SMTP id p26mr30402608pge.433.1548116802464;
        Mon, 21 Jan 2019 16:26:42 -0800 (PST)
Received: from dektop.dek-tpc.internal ([14.161.14.188])
        by smtp.gmail.com with ESMTPSA id u123sm21306640pfb.1.2019.01.21.16.26.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Jan 2019 16:26:41 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 1/3] Revert "parse-options: allow keep-unknown + stop-at-non-opt combination"
Date:   Tue, 22 Jan 2019 07:26:33 +0700
Message-Id: <20190122002635.9411-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.20.1.560.g70ca8b83ee
In-Reply-To: <20190122002635.9411-1-pclouds@gmail.com>
References: <20190122002635.9411-1-pclouds@gmail.com>
MIME-Version: 1.0
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

