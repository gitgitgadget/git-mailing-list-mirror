Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A24092018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbcF0SZx (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:25:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36119 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752065AbcF0SZn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:25:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id c82so26941651wme.3
        for <git@vger.kernel.org>; Mon, 27 Jun 2016 11:25:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=O6c6NNH5TmxmUuxMnzPv8ZPbdCKNndmhlc1+i6v8EMw=;
        b=fgH8LMBsVB/v4j2lLsXjDd8cpqbHWBKo6HsIglNQk1PIuK6mhunOcnWGs2QSG77MB1
         1PtoYkLeDxhRnN+82B7ECFMNkV4UN/E+IQyaz1TtRHF96Hn3eNZ16iklfHcJa/fF3trO
         t8bsRGwI4R0Q52sBLf0q2wkDcZRaCx7Ll8yV6tJ5Ifl8jZXK5nLjOueRonNj1DQQQgJJ
         U/AdGDceyRgTNgPHiyXG0pkJZJTvMAABHfodzcxA9zE3Ttt+WdZp1caQ9OvW5dCPTwIA
         m47QQeYGZZ+f4DibERIljZEKz5oCaJ/flbNakOvKFC14C7tycm80fdX64f4auWdiW7UE
         9dcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=O6c6NNH5TmxmUuxMnzPv8ZPbdCKNndmhlc1+i6v8EMw=;
        b=I6A6ZqwB5HddK/OuIbO4XmAdqSW6n683lWHuArA9T1O9LBNNMvnOt73lxaIbQZVTB+
         uUvdNy3bE7T31JqYVpQRNHPHCyj8EEtLYGWU3ouxIX4n4KJf0lX+GCzeOnzEBQBpCzVu
         JA/C5BzW9+OfaQYLtt5kOllwwsqAjCLPVRHMl9cg1RHIHaTuAwMJbbJDt3Sq2Ae7oS6A
         9iggs9wKn9qTE/YNkWemj1dkMQl7n9kC4iDMHJ1zj5tvu+x9xPXvxN2ylCdHDv4CQnKC
         pfl0mw464VuiTPC0IoEVgTmf1ZwZsMu7fXfroPo1SsXAcBA0lGWM6n+ZEIimZWRpgx1V
         U6zw==
X-Gm-Message-State: ALyK8tKddOt6tyNHDJziqQdXteMzGCJEAJYyedKnfsOb5nJRwpxOkb2cboKyt+EQ1gvW0g==
X-Received: by 10.28.140.202 with SMTP id o193mr12772237wmd.55.1467051941857;
        Mon, 27 Jun 2016 11:25:41 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id s67sm1536707wmf.3.2016.06.27.11.25.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Jun 2016 11:25:41 -0700 (PDT)
From:	Christian Couder <christian.couder@gmail.com>
X-Google-Original-From:	Christian Couder <chriscool@tuxfamily.org>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v8 31/41] apply: make some parsing functions static again
Date:	Mon, 27 Jun 2016 20:24:19 +0200
Message-Id: <20160627182429.31550-32-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.172.g48843e9
In-Reply-To: <20160627182429.31550-1-chriscool@tuxfamily.org>
References: <20160627182429.31550-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Some parsing functions that were used in both "apply.c" and
"builtin/apply.c" are now only used in the former, so they
can be made static to "apply.c".

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.c | 6 +++---
 apply.h | 5 -----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/apply.c b/apply.c
index ababc9a..7bf12a7 100644
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
2.9.0.172.gfb57a78

