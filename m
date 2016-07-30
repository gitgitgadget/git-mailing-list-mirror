Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7250A1F71B
	for <e@80x24.org>; Sat, 30 Jul 2016 17:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753745AbcG3RiC (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:38:02 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34493 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753723AbcG3RiA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:38:00 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20082599wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:37:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OlgWdmJ+64T3EEIQiNQXLYNJB843HVro7mZhqLgiAQ0=;
        b=o+UUVO44qbS9ACwr9q1GhGDYOcDh9mKj8IdO2Gio9W1jSBoUAO9/1vccu7QEiPL9vs
         oqofqYvyeu7ZY2nQihJ4rLyGUSCZH8BreeC0hgr1QShcwScZIpo7hg1+olFStNLjtX0U
         z+/ZWOypuaOcvrsY13lm4LN026WNO2AB0KoBQ20ecJQU2NlCNqscbnoOICIIwdMzlUgF
         oejpihJDAJCeRyQPmW6bPKXFzi/7Um+gGqfDisRIQr6oIfEHdyWKR1nCJwAVdpw9EpeC
         OrwDA1YtnQfh+7XQbCt5HMozA3m5QZ5C1HPN1cJc0IEaricIx+vpMqwvpQzBDB5ecVA2
         PrIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OlgWdmJ+64T3EEIQiNQXLYNJB843HVro7mZhqLgiAQ0=;
        b=KeeMysAvRxjB6h9J28dbqO7JC4ABAP0HSOSguai+uz2J/2wl9Xpw+UXvNLXYj1CCi0
         R82XNn1OOkK77gn6OZMSJ7MIw7xkxAemiwoOs8Vg34EH9QJU02xJTblqEYdqG4cjRAeA
         nIGsbLjGzLEmS164YIpXEWhvYqS0iXHHq4wR/CkIRkt3GniDNgi8Vt5zfK1qn2PZm5I0
         xHtNwailCWcJycl40T9OZa3kVHfYYuTaKnGzdRJoq/rUhi6UMazLPGtM5TqN4ofOrlyI
         knYQZT2euLjQd9Eye7gHXvuFtyrgOgFI3lzC7aa7KgVA7hh5Rj+LXd7UdO2iFHHffM0U
         g7mQ==
X-Gm-Message-State: AEkoouuWKKslfMPWBqEoQnJkPx0fYJc6vbEGZ25L46rVKRtHNl4SSTvMeVHGypEflKc5oA==
X-Received: by 10.28.0.70 with SMTP id 67mr51418707wma.88.1469899545255;
        Sat, 30 Jul 2016 10:25:45 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:44 -0700 (PDT)
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
Subject: [PATCH v9 12/41] builtin/apply: make check_apply_state() return -1 instead of die()ing
Date:	Sat, 30 Jul 2016 19:24:40 +0200
Message-Id: <20160730172509.22939-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", check_apply_state() should return -1 instead of
calling die().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 7e5869d..0dbc561 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -4551,17 +4551,17 @@ static int option_parse_directory(const struct option *opt,
 	return 0;
 }
 
-static void check_apply_state(struct apply_state *state, int force_apply)
+static int check_apply_state(struct apply_state *state, int force_apply)
 {
 	int is_not_gitdir = !startup_info->have_repository;
 
 	if (state->apply_with_reject && state->threeway)
-		die("--reject and --3way cannot be used together.");
+		return error("--reject and --3way cannot be used together.");
 	if (state->cached && state->threeway)
-		die("--cached and --3way cannot be used together.");
+		return error("--cached and --3way cannot be used together.");
 	if (state->threeway) {
 		if (is_not_gitdir)
-			die(_("--3way outside a repository"));
+			return error(_("--3way outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->apply_with_reject)
@@ -4569,16 +4569,18 @@ static void check_apply_state(struct apply_state *state, int force_apply)
 	if (!force_apply && (state->diffstat || state->numstat || state->summary || state->check || state->fake_ancestor))
 		state->apply = 0;
 	if (state->check_index && is_not_gitdir)
-		die(_("--index outside a repository"));
+		return error(_("--index outside a repository"));
 	if (state->cached) {
 		if (is_not_gitdir)
-			die(_("--cached outside a repository"));
+			return error(_("--cached outside a repository"));
 		state->check_index = 1;
 	}
 	if (state->check_index)
 		state->unsafe_paths = 0;
 	if (!state->lock_file)
-		die("BUG: state->lock_file should not be NULL");
+		return error("BUG: state->lock_file should not be NULL");
+
+	return 0;
 }
 
 static int apply_all_patches(struct apply_state *state,
@@ -4747,7 +4749,8 @@ int cmd_apply(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, state.prefix, builtin_apply_options,
 			apply_usage, 0);
 
-	check_apply_state(&state, force_apply);
+	if (check_apply_state(&state, force_apply))
+		exit(128);
 
 	ret = apply_all_patches(&state, argc, argv, options);
 
-- 
2.9.2.558.gf53e569

