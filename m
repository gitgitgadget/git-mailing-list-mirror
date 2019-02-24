Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7FA9202AA
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728350AbfBXKLq (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:46 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:39377 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728325AbfBXKLg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:36 -0500
Received: by mail-ed1-f68.google.com with SMTP id p27so5216148edc.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sfc7J9SZuKFabS/ta2+LHmqfazZiHP/YuVNwzg0MP00=;
        b=AsUx1KXo7BbZ5wUuY8YwQm0KmFb2zI7fI5y8suEUYHoy2PBjThhPD2gAAnFiHeMbqN
         0EUM1hXW45tzsZGOrQ6aTkUtjefSsXZuTLCgZWYBKz+9rVafC6ZL3OK28+nI9r/TgBT6
         sJCi5wVazqns8nwhjZJe7D/XItDyEfAStxRVMn6uyi14R8XBftf47G6onyF8DiGqeHmq
         jlM7aFL20BOLzbkB4alZRV0FA1LuKkfkmcQkw6u3nyd12VcKWk3hlYVvNHZ7qcAawXDm
         FSz6Obmmf+fpuJRIT10sRyi7mpDzkfj7zoB1vIcXjiieGshuIo13zZVzM38tMCLABwPf
         LhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sfc7J9SZuKFabS/ta2+LHmqfazZiHP/YuVNwzg0MP00=;
        b=Y2qyRfI0l5DSbFPFnDHbhI3QsVPtO1eXYEtTp+ECShkIZ9l7oLFmbr+6EjfhSOok/+
         rCZQbo5IRLG+HQ99HwBO2Q2V99v5Qp1S1wNUuqOn8RkZHkoUlUMII/SG6pa+8Ze829ms
         YkG3VUs6qMMHmB23cry83TE06UegQTCgtbOIijh+nAjAQiCAXeKifJ6lgbolazidJLOT
         w/nf4efG0l6+w5YKmBVheAI6gOAHgcBtlIPea88jkr2IbxgLzqnBKwdgNIeZEpV2rFe9
         cXaJupo8DaEfakC5echesMWmFokG5mj4nV7y4EkZN8sZfp7hlPmPqPPmYGXZ1jf8WKcp
         lKLg==
X-Gm-Message-State: AHQUAuZ3vY4tNU4YOYAVb3+zGqm1+CZqOAAY3GeeTUzh5ZBq9sfN01V1
        OLCIMIuU+Ub27qfAR5Qykivapsra
X-Google-Smtp-Source: AHgI3IZNM+sgAkzVSfW1Dms9FNxIzpNNHK6ttQ6GnfA457v9IAv8LrJOwfSOohlem1daxpHpBIT2+w==
X-Received: by 2002:a50:b4db:: with SMTP id x27mr10362802edd.90.1551003094197;
        Sun, 24 Feb 2019 02:11:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z18sm1205419ejp.44.2019.02.24.02.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:33 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:33 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:12 GMT
Message-Id: <e5a8c2fcd4a7e41725df691dae8b9b96dd1e78b2.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 24/26] bisect--helper: remove the dequote in bisect_start()
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

Dequoting the arguments was introduced in 25b48b5c to port the function
`bisect_next()` but after the `bisect_replay()` porting, the dequoting
is carried out itself when it passes the arguments to `bisect_start()`
in a simpler way thus dequoting again isn't required. So remove the
extra "dequoting" code introduced by the commit 25b48b5c.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 4b4401005d..4eb2580ba8 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -558,11 +558,6 @@ static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
 	return 0;
 }
 
-static inline char *dequote_arg(const char *arg)
-{
-	return arg[0] != '\'' ? xstrdup(arg) : sq_dequote(xstrdup(arg));
-}
-
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
@@ -583,22 +578,16 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	 * Check for one bad and then some good revisions
 	 */
 	for (i = 0; i < argc; i++) {
-		char *arg = dequote_arg(argv[i]);
 
-		if (!strcmp(arg, "--")) {
+		if (!strcmp(argv[i], "--")) {
 			has_double_dash = 1;
-			free(arg);
 			break;
 		}
-		free(arg);
 	}
 
 	for (i = 0; i < argc; i++) {
-		char *dequoted = dequote_arg(argv[i]);
-		const char *arg = dequoted;
-
-		if (!strcmp(arg, "--")) {
-			free(dequoted);
+		const char *arg = argv[i];
+		if (!strcmp(argv[i], "--")) {
 			break;
 		} else if (!strcmp(arg, "--no-checkout")) {
 			no_checkout = 1;
@@ -606,7 +595,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			 !strcmp(arg, "--term-old")) {
 			must_write_terms = 1;
 			free((void *) terms->term_good);
-			terms->term_good = dequote_arg(argv[++i]);
+			terms->term_good = xstrdup(argv[++i]);
 		} else if (skip_prefix(arg, "--term-good=", &arg) ||
 			   skip_prefix(arg, "--term-old=", &arg)) {
 			must_write_terms = 1;
@@ -616,7 +605,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			 !strcmp(arg, "--term-new")) {
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
-			terms->term_bad = dequote_arg(argv[++i]);
+			terms->term_bad = xstrdup(argv[++i]);
 		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
 			   skip_prefix(arg, "--term-new=", &arg)) {
 			must_write_terms = 1;
@@ -625,7 +614,6 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		} else if (starts_with(arg, "--") &&
 			   !one_of(arg, "--term-good", "--term-bad", NULL)) {
 			error(_("unrecognized option: '%s'"), arg);
-			free(dequoted);
 			return -1;
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
@@ -633,14 +621,12 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 				error(_("'%s' does not appear to be a valid "
 					"revision"), arg);
 				free(commit_id);
-				free(dequoted);
 				return -1;
 			}
 
 			string_list_append(&revs, oid_to_hex(&oid));
 			free(commit_id);
 		}
-		free(dequoted);
 	}
 	pathspec_pos = i;
 
-- 
gitgitgadget

