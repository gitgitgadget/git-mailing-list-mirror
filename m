Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3F9C20193
	for <e@80x24.org>; Sun,  4 Sep 2016 20:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbcIDUTr (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:19:47 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35606 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932341AbcIDUTm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:19:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id c133so10467296wmd.2
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oJuf7S3NyIDey99DII2cz/roxDcAX0JO6VvMh3uPGfo=;
        b=z+z8RdJ6UH0/yO/VxrS9sv6cZuWNDb6AD2l3ijW2uUQN3e8WuCXTd8FDYmRHqYSDu/
         7Pa+hQfHJk3bxre9q65r41p0SgUynesWkc2Y4IKpNw1flu79emqGRwo6+/lMykWOByfA
         yqcFJuTevszqY4HBRuNe+LkS1RimxeOS6z6MPSiiA1TI3g59SnKOZWrw2XEp0XJp7QYt
         LfIVg8EQ63LefSs2LicCnGnWOdxi9LQBJUF4iDSLziPw8xHLh7BwKuqQvlmUalj7tuVQ
         y2e4caPi5AOWGvmhvM+HdWybi7QFmu1Cpg0haKw7TwVsY74/m3V0TQbmlFNkNaXnqM9m
         lK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oJuf7S3NyIDey99DII2cz/roxDcAX0JO6VvMh3uPGfo=;
        b=ATxUk4462BCKj41kv5sBThvZ/rMLGin+lmvGyK5wzVw9S7Sijc8G1oahl30Ph8bkzg
         KTjNetULTETxRT9qjGzKOZ/fzPoEF0cZRKXV6R/97fX+Qic+i7zyIH9z4pxoACwcdMvX
         dv9VBQmoJK5NenZaYH0mFu44qV2cZd07C4N50xI5llotP1OMlyvmw5QcBQBhE8J7I0pn
         Mf0ZGJPsVlBL8JBr3MIaTfOklxyTkWIK7Mvj6JLN41bOcu5bzanQo+7TruEsgGWDUc0K
         ZQXXZ6a4FUhG+pzcs0bJ0X4lW4VF9I3NRohRULXyS/FRLT9WNiIn0SiKwHtiWecZzVht
         ttPA==
X-Gm-Message-State: AE9vXwPVhxCkEqBZ3I8ilHum0JcCUqWzwzCg7CcCZ1Xonmav7PBVhE+rrcYrA88tj7htXA==
X-Received: by 10.28.222.8 with SMTP id v8mr12558398wmg.55.1473020381371;
        Sun, 04 Sep 2016 13:19:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.19.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:19:40 -0700 (PDT)
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
Subject: [PATCH v14 31/41] apply: make some parsing functions static again
Date:   Sun,  4 Sep 2016 22:18:23 +0200
Message-Id: <20160904201833.21676-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
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
index f640224..a4dfc64 100644
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
index 28cbe6c..51b983b 100644
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
2.10.0.41.g9df52c3

