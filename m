Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B0C82047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:21:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752012AbdHGSVc (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:21:32 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:33130 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbdHGSVa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:21:30 -0400
Received: by mail-wr0-f195.google.com with SMTP id y43so862783wrd.0
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=R3jcCvoBoo/PkBO91m5EKL9M8O/mkcCaEqowHjPNWrA=;
        b=FPjB42UvyzJUCCPgiGiUzYfQXM/JBxSfLkk4k28pUPu/wCQD1YGewL/Vc7BK8g09uF
         rmrtxAaqYtZSM6kYOcliokgHJxgBKZX8W0weGkMn2hgdelDWC7l3TtCYNWtVmVmzuuMQ
         Vj0JfIakucDjXjSt1QkDY+DOYjIrLob7v7I3Q46ZxKUAdXNhpMvXN/BPCn2mdN3mnOcW
         BtrBC1GvScR6MXLfIq6D/Wr6SqxTyg9fm5/kFzEM8SjQOODg4eIBrhNT4QYS/k5oyZnn
         guXqMWczC1tJLWqtSrcfFKEyBQw7r9EdTRbf7WlwQFzwii2CCKmHk8yKe42h3nzWn5mS
         cWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=R3jcCvoBoo/PkBO91m5EKL9M8O/mkcCaEqowHjPNWrA=;
        b=t5Q10D/m1xOqiOD0CDFkhSQz2k1BlmXO5BWz8xFx9fj+tc1XiLTAK72w9Kg8xbbr6i
         RsyYmgAiRmVrujmIkshelEKGOIJ3NtQD4pHA42Z+wg6lnbVeT/69d+vEpjPSW78imS+g
         g4lEOSg9KUgnL+h34Zhi1KrDetPlvCd3i3D3Rj3wZjOJmyQ88USbh26BIdr4LlbfgNQJ
         2kZL5azVnyL9JrkmvR+PLP7QwTpIb9NomsRNlLCB23nmwsTUsxp6oUChNa6mBS+gns5v
         6uvMdRW+Kd8prYlgSmhj3JgFPqYUcDKU5HMF//c6Iv/5LAfM1K98eYyaRPCW5xRGqbHa
         getw==
X-Gm-Message-State: AHYfb5jTOhXrv9gLILF1YTRjRokN1UAEfJ2BlnQIyFJhoM/1e9ZSAC89
        I029JfnawDPa1Y0b
X-Received: by 10.223.166.109 with SMTP id k100mr1096139wrc.209.1502130088443;
        Mon, 07 Aug 2017 11:21:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:1208:b1ff:fee6:d811])
        by smtp.gmail.com with ESMTPSA id e27sm11519422wra.25.2017.08.07.11.21.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:21:27 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Dave Borowitz <dborowitz@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 6/6] parse_decoration_style: drop unused argument `var`
Date:   Mon,  7 Aug 2017 20:20:50 +0200
Message-Id: <efb46bffdac9dcf1fa91ee5a800ce370ceadfd55.1502128418.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.14.0.5.g0f7b1ed27
In-Reply-To: <cover.1502128418.git.martin.agren@gmail.com>
References: <cover.1502128418.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit left it unused.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 builtin/log.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 9182f0ee3..483d15a94 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -58,7 +58,7 @@ static int auto_decoration_style(void)
 	return (isatty(1) || pager_in_use()) ? DECORATE_SHORT_REFS : 0;
 }
 
-static int parse_decoration_style(const char *var, const char *value)
+static int parse_decoration_style(const char *value)
 {
 	switch (git_parse_maybe_bool(value)) {
 	case 1:
@@ -82,7 +82,7 @@ static int decorate_callback(const struct option *opt, const char *arg, int unse
 	if (unset)
 		decoration_style = 0;
 	else if (arg)
-		decoration_style = parse_decoration_style("command line", arg);
+		decoration_style = parse_decoration_style(arg);
 	else
 		decoration_style = DECORATE_SHORT_REFS;
 
@@ -409,7 +409,7 @@ static int git_log_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "log.date"))
 		return git_config_string(&default_date_mode, var, value);
 	if (!strcmp(var, "log.decorate")) {
-		decoration_style = parse_decoration_style(var, value);
+		decoration_style = parse_decoration_style(value);
 		if (decoration_style < 0)
 			decoration_style = 0; /* maybe warn? */
 		return 0;
-- 
2.14.0.5.g0f7b1ed27

