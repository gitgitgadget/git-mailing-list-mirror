Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 556A61F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754775AbcH0SqD (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:03 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33433 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754720AbcH0SqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:01 -0400
Received: by mail-it0-f68.google.com with SMTP id d65so2941702ith.0
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=N2re3A4DcZIoZ4xMBFNkfsbr0fZMbwQYonFnajq8NAE=;
        b=WvvrC3apaXYIG2p04ybu4WiwZj5expiQIZZZ0SrOobJFhXbathEwE+jyrYISp/pL7o
         uXFL6dQhm2MDret8IwiDLQFdx1dihhh+xKB6mYZhHo373HUI9m1LZIXWGn2mcsIzmM0N
         2t/uXxNFBMnBqbtDwG5RVpfl1+2yQpXrfOpdreQfKoGw8bhvNXMXQihqqx7UA2Q54xkK
         acjIe/KxohCo9tXuLf45goH/QlfcdLJhERIXzU3rpNJqDgDOpx4A/cA4mSmNJs+ONNGp
         TWV737Rrcmv4aoTVzhtSqpFnUQyYzDmqkGgBwf1tvL+zAkcQIeScBI7m6ceYd/2uBwEp
         1ikA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=N2re3A4DcZIoZ4xMBFNkfsbr0fZMbwQYonFnajq8NAE=;
        b=Htz+e50xMXtpxCzvLwbq6k4KOFzFVeamhN2XapibtA6iGU7SvW1c/b9Kz7lmR4vfyD
         p1GXezbyk2iUjTBH9iPwr3EuAJo5f/AxfCxI4eYtdPtLHMFlwb3wx4B2/Kbm3VnFQEi0
         Yx9CHxrRkAz5sg3EXwJzZUwA+UP7OGfomm1FM11hDqrn7Rlat1MADWiXCv++d/X5xiax
         KEKIRHgVx5qAv7ecE2FcwbFNnaJzbsvHLxea8AVs5YwPo0oN0O9stpWH20RaIGEoP+NQ
         rYLRrNMRz2Xl49IOpl7LM+6r3PdmaH84b99oSghY1XqBUmEt0Kb8N/dl+lsqGn6OTgBj
         J9Vg==
X-Gm-Message-State: AE9vXwPKz9Aufy3sXjYrrPK6zLJXj2rGIXOMKFhDII1atHXl29mKkIk2FcixUfTKEmfEQA==
X-Received: by 10.107.135.142 with SMTP id r14mr11769169ioi.133.1472323560585;
        Sat, 27 Aug 2016 11:46:00 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.45.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:00 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Stefan Naewe <stefan.naewe@atlas-elektronik.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v13 02/14] apply: rename and move opt constants to apply.h
Date:   Sat, 27 Aug 2016 20:45:35 +0200
Message-Id: <20160827184547.4365-3-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The constants for the "inaccurate-eof" and the "recount" options will
be used in both "apply.c" and "builtin/apply.c", so they need to go
into "apply.h", and therefore they need a name that is more specific
to the API they belong to.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         |  3 +++
 builtin/apply.c | 11 ++++-------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/apply.h b/apply.h
index 53f09b5..ca1dcee 100644
--- a/apply.h
+++ b/apply.h
@@ -108,4 +108,7 @@ extern int init_apply_state(struct apply_state *state,
 extern void clear_apply_state(struct apply_state *state);
 extern int check_apply_state(struct apply_state *state, int force_apply);
 
+#define APPLY_OPT_INACCURATE_EOF	(1<<0)
+#define APPLY_OPT_RECOUNT		(1<<1)
+
 #endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 429fe44..9c396bb 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4463,9 +4463,6 @@ static int write_out_results(struct apply_state *state, struct patch *list)
 
 static struct lock_file lock_file;
 
-#define INACCURATE_EOF	(1<<0)
-#define RECOUNT		(1<<1)
-
 /*
  * Try to apply a patch.
  *
@@ -4495,8 +4492,8 @@ static int apply_patch(struct apply_state *state,
 		int nr;
 
 		patch = xcalloc(1, sizeof(*patch));
-		patch->inaccurate_eof = !!(options & INACCURATE_EOF);
-		patch->recount =  !!(options & RECOUNT);
+		patch->inaccurate_eof = !!(options & APPLY_OPT_INACCURATE_EOF);
+		patch->recount =  !!(options & APPLY_OPT_RECOUNT);
 		nr = parse_chunk(state, buf.buf + offset, buf.len - offset, patch);
 		if (nr < 0) {
 			free_patch(patch);
@@ -4811,10 +4808,10 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSE(&state.apply_verbosely, N_("be verbose")),
 		OPT_BIT(0, "inaccurate-eof", &options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
-			INACCURATE_EOF),
+			APPLY_OPT_INACCURATE_EOF),
 		OPT_BIT(0, "recount", &options,
 			N_("do not trust the line counts in the hunk headers"),
-			RECOUNT),
+			APPLY_OPT_RECOUNT),
 		{ OPTION_CALLBACK, 0, "directory", &state, N_("root"),
 			N_("prepend <root> to all filenames"),
 			0, apply_option_parse_directory },
-- 
2.9.2.770.g14ff7d2

