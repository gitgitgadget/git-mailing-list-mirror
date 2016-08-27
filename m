Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091091F6C1
	for <e@80x24.org>; Sat, 27 Aug 2016 18:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754835AbcH0SqG (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Aug 2016 14:46:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:33911 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754788AbcH0SqE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2016 14:46:04 -0400
Received: by mail-it0-f68.google.com with SMTP id e63so2929964ith.1
        for <git@vger.kernel.org>; Sat, 27 Aug 2016 11:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GhrJcSpHz8FVMqhHzNbyv6igRZe7kpARr4DVzee4whU=;
        b=aE8EC26FaGKSQy190cqvIxBAknJdUPR1NXwb5RMa39ZZ/Z0hbdpeZuwWApyf+CsFzo
         nVdTLGUcxQjpOgXZuV1iCKEAaI85gXJ9spwb2HJzJKww0Iln7pph3SCBUuE6dqpa3OhQ
         c08lO8S/iSYssMNloPT0s438WbWzwYuDmG7X4CtuxEHmxH5PphGwkOe15qpNO7i+oE4q
         jXNvy76JjMnxFUrqxX0Pqfn1DrD8cvCkso+IBu/SkRVlRv5bbcEj1hMiaDfWvEHNSrm7
         q0kvg815sbGc3i2ahiovQ8P1xvYRt5qOZZXoEw7GDMMtQ2pBsvXUnmmuDA2oX8f5Yw1Z
         mOlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GhrJcSpHz8FVMqhHzNbyv6igRZe7kpARr4DVzee4whU=;
        b=ZfHYk5XdpoFTYuL0kfH7D0DV0uZiflYQDh1hN7MJd7Xp39MmLdiBTzNFQichK5ON2w
         J30wV+Ki9Y/zTxiIQxq9YzBDjDBqySpP50cTYe4c6BhpyeeU71uQcaorTMdH52lfEZD/
         fA63j0wClZIdlT3kRoTbudSy6DbSvHJmSmDWrp2CU0tBROLSQkr+CiceQ6aicuWLO2iv
         /Et646gHhTSSY2K2pZD+GYylJGY/k33AJFoVjPx4xyDNcXkdZSY3lh3pvPJvY1tqTO9e
         bmH/4UgpjgzfldEmH8sFyR84nwnPBQKosuTHgOHMmAJV8UShvornH/zgum5zbNLZenBA
         dcbQ==
X-Gm-Message-State: AE9vXwNZ/Wyi8QO4NmNxlQ/b5jW2+5P1MYdHIrKdrk+BcGQC+C9fhl08duv5YLhlyj/v3g==
X-Received: by 10.36.55.146 with SMTP id r140mr5767828itr.73.1472323563591;
        Sat, 27 Aug 2016 11:46:03 -0700 (PDT)
Received: from christian-Latitude-E6330.starbucks.net (TOROON12-3096782379.sdsl.bell.ca. [184.149.38.43])
        by smtp.gmail.com with ESMTPSA id r123sm2350901ith.1.2016.08.27.11.46.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Aug 2016 11:46:03 -0700 (PDT)
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
Subject: [PATCH v13 04/14] apply: make some parsing functions static again
Date:   Sat, 27 Aug 2016 20:45:37 +0200
Message-Id: <20160827184547.4365-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.770.g14ff7d2
In-Reply-To: <20160827184547.4365-1-chriscool@tuxfamily.org>
References: <20160827184547.4365-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some parsing functions that were used in both "apply.c" and
"builtin/apply.c" are now only used in the former, so they
can be made static to "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index 7b96130..c0cb3f5 100644
--- a/apply.c
+++ b/apply.c
@@ -27,7 +27,7 @@ static void git_apply_config(void)
 	git_config(git_default_config, NULL);
 }
 
-int parse_whitespace_option(struct apply_state *state, const char *option)
+static int parse_whitespace_option(struct apply_state *state, const char *option)
 {
 	if (!option) {
 		state->ws_error_action = warn_on_ws_error;
@@ -57,8 +57,8 @@ int parse_whitespace_option(struct apply_state *state, const char *option)
 	return error(_("unrecognized whitespace option '%s'"), option);
 }
 
-int parse_ignorewhitespace_option(struct apply_state *state,
-				  const char *option)
+static int parse_ignorewhitespace_option(struct apply_state *state,
+						 const char *option)
 {
 	if (!option || !strcmp(option, "no") ||
 	    !strcmp(option, "false") || !strcmp(option, "never") ||
diff --git a/apply.h b/apply.h
index 5ec022c..df44b51 100644
--- a/apply.h
+++ b/apply.h
@@ -97,11 +97,6 @@ struct apply_state {
 	int applied_after_fixing_ws;
 };
 
-extern int parse_whitespace_option(struct apply_state *state,
-				   const char *option);
-extern int parse_ignorewhitespace_option(struct apply_state *state,
-					 const char *option);
-
 extern int apply_option_parse_exclude(const struct option *opt,
 				      const char *arg, int unset);
 extern int apply_option_parse_include(const struct option *opt,
-- 
2.9.2.770.g14ff7d2

