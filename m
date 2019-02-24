Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 302E620248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728317AbfBXKLb (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45094 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728269AbfBXKL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:27 -0500
Received: by mail-ed1-f65.google.com with SMTP id d9so5178131edh.12
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YvJYn5Toj5r0hLzPiPZsVOwhHSlqWsZ5C63ybPPSWoo=;
        b=VShtqZU6W6fS8h2MMYeeeqbuKjjgZPQLSXDLHGY6uQNglYhmRo7nqDltPXZVad+QW0
         TzxjeQDJB8z8lywdJB4kazOs1oPV/obyKhg3kP87AfkQI726mhDn1bbnNVe1qZ3LMlu0
         Xn1yKHqVdpUNuuf6MgoAAEFESvXTvvv34OZc+xUGF5OPvIYDHdyTaeqYYmH4uoRZktER
         Ukq+Anct7/1nS+qBgHLb42vV92PX+9JCqAaOXhJsTSgHByIELW/1xeLqI/RXU2CqTib/
         /8xIVF4eaUqM0Rm2AVi401o4yzEieZMV5TW60Strnv4rCO1Qrfqoa7NEVgar336bbbjo
         iU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YvJYn5Toj5r0hLzPiPZsVOwhHSlqWsZ5C63ybPPSWoo=;
        b=ktDw/S6cDiX/hhBhrT/f10NqpMNY9xDsZsiaN0O60+qiU/OtGvYjKgtlJyM4bSHNzU
         3vMMSTInyOtln2+XseNK0xUrOqQyYvPoVxqelFqN/B/xZCrRfdwH3MWnARkeBfh4QT05
         Q9FMt1w/vLI1HmvwD9rxqE+8ZMNB4EjosSqgfh2lSmJF/Iodm9WfKpDEwHzP5zCYqNlk
         mZVqHwKBdp4qNuafhsZHpO5+eqyN2SDLc6GUxE8OhpycPnVwXsynfkuRBvu7Cv0o8vNr
         qhRTBex0/uWy46nvw6t/i9E3E+kgG/uX2gk/3ce0If1RZiCnEHfNaQRqCdyCnqbVGVid
         GLDw==
X-Gm-Message-State: AHQUAuZisBjNE14J1qbnO6xbR/MIy4XxYmYIVPwe0uOxHmautYEw0aMc
        J6fMqzZrbJGuo5t1BxUddVHcl/s6
X-Google-Smtp-Source: AHgI3IYzQoRI7G8l7BLtiy3MCzcS3p15FxyI1CZ65gryNghpnEq8UkQpO7HngVakIV+qdYX/+nY2WA==
X-Received: by 2002:a17:906:1d0d:: with SMTP id n13mr9285134ejh.23.1551003085163;
        Sun, 24 Feb 2019 02:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x21sm1178295ejf.65.2019.02.24.02.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:24 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:24 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:11:00 GMT
Message-Id: <7a37c5ca752e1c5ac4dd56232ce94fd41fb49406.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 12/26] bisect--helper: dequote arguments in `bisect-start`
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

As more and more calls are happening to the subcommands in `git
bisect--helper`, more specifically when `bisect_start $rev` is converted to
`git bisect--helper --bisect-start $rev` it is necessary to dequote the
arguments because of shell to C conversion.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d538cb04fb..b9f2138811 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -557,6 +557,11 @@ static int bisect_auto_next(struct bisect_terms *terms, const char *prefix)
 	return 0;
 }
 
+static inline char *dequote_arg(const char *arg)
+{
+	return arg[0] != '\'' ? xstrdup(arg) : sq_dequote(xstrdup(arg));
+}
+
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			const char **argv, int argc)
 {
@@ -577,15 +582,22 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	 * Check for one bad and then some good revisions
 	 */
 	for (i = 0; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
+		char *arg = dequote_arg(argv[i]);
+
+		if (!strcmp(arg, "--")) {
 			has_double_dash = 1;
+			free(arg);
 			break;
 		}
+		free(arg);
 	}
 
 	for (i = 0; i < argc; i++) {
-		const char *arg = argv[i];
-		if (!strcmp(argv[i], "--")) {
+		char *dequoted = dequote_arg(argv[i]);
+		const char *arg = dequoted;
+
+		if (!strcmp(arg, "--")) {
+			free(dequoted);
 			break;
 		} else if (!strcmp(arg, "--no-checkout")) {
 			no_checkout = 1;
@@ -593,7 +605,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			 !strcmp(arg, "--term-old")) {
 			must_write_terms = 1;
 			free((void *) terms->term_good);
-			terms->term_good = xstrdup(argv[++i]);
+			terms->term_good = dequote_arg(argv[++i]);
 		} else if (skip_prefix(arg, "--term-good=", &arg) ||
 			   skip_prefix(arg, "--term-old=", &arg)) {
 			must_write_terms = 1;
@@ -603,24 +615,31 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			 !strcmp(arg, "--term-new")) {
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
-			terms->term_bad = xstrdup(argv[++i]);
+			terms->term_bad = dequote_arg(argv[++i]);
 		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
 			   skip_prefix(arg, "--term-new=", &arg)) {
 			must_write_terms = 1;
 			free((void *) terms->term_bad);
 			terms->term_bad = xstrdup(arg);
 		} else if (starts_with(arg, "--") &&
-			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
-			return error(_("unrecognized option: '%s'"), arg);
+			   !one_of(arg, "--term-good", "--term-bad", NULL)) {
+			error(_("unrecognized option: '%s'"), arg);
+			free(dequoted);
+			return -1;
 		} else {
 			char *commit_id = xstrfmt("%s^{commit}", arg);
-			if (get_oid(commit_id, &oid) && has_double_dash)
-				die(_("'%s' does not appear to be a valid "
-				      "revision"), arg);
+			if (get_oid(commit_id, &oid) && has_double_dash) {
+				error(_("'%s' does not appear to be a valid "
+					"revision"), arg);
+				free(commit_id);
+				free(dequoted);
+				return -1;
+			}
 
 			string_list_append(&revs, oid_to_hex(&oid));
 			free(commit_id);
 		}
+		free(dequoted);
 	}
 	pathspec_pos = i;
 
-- 
gitgitgadget

