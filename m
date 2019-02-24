Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB7D520248
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbfBXKLV (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:21 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39362 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbfBXKLU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:20 -0500
Received: by mail-ed1-f67.google.com with SMTP id p27so5215879edc.6
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QMmOFIwudwN2B1TBXm250Vc2BquDiZ9nel/R5Wcp+k0=;
        b=W3VySRbnupd0nmp7mykFSpQPEOeYazynXGmlKjXWz+0ULQBYdAeQb9RRH/2RDuvonN
         3s3jm3/jrekDkrb40KPCgdwV9KIcJxum0mEVF/w8KKyW8r0qKtaDQBc8Xi/p+jsLKyim
         h5kcNxGtFPVZk2945m7/JVw5staNEsJnBYCAzHesP3sZmlEjJUOEmGJdM9EG1Oc+E2BV
         kiBgkY25hl1siwUanZjRIONF9i0E8atc4t9TG+hnb5mMDzhvgYNz7NEUKXimSbnPCEK1
         Hv1bmJpR4Mq3EiwWVQBcCXx3ayl+CY4/c8FEyf98TFB9QOFhpoaKUp+IW4UHWy7sRBtq
         111Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QMmOFIwudwN2B1TBXm250Vc2BquDiZ9nel/R5Wcp+k0=;
        b=RYNIsWLHQKdKeE7dC/EDCxkMjXMr4MOhOhVqY1/VMm42nTUpMOIJ5xoSdfrtF74//Y
         /pDjU/frXqNBT9gTtoRE9D1ggbcpIFSrPK89MdDBaaLLQ8d13QF4fX8NYKyZhIcTp5OH
         RMf+Dph4io/KF5aHiuvi3/ZUWeWXYp9mEPtOzPeYEShz3qyP5elRDhufg0cn1+m8wx2s
         6OKQZaMqIbo0sT8Ml1nibtvuz2RTCSoP4faVfQ7I1TgzENymPvGwTBqAHJvkVrqR+BN+
         /qrH3WZBe675U4dngXD1ELkKwFPKAzE2gdI9c6GP73cKqSGiMBl65K/qFL0UxZI4SzRH
         3zDA==
X-Gm-Message-State: AHQUAuYgeZbYFjXbGw1yv3sFhN2QtkW3hX/UDe1qkvNXx3ha7a6i72EI
        A4QCb+cOA9Gui70eIvWa552YV5Ix
X-Google-Smtp-Source: AHgI3IaUpcqDXk1upnKr/FiLtGSF1RQBRDvAuS5xENG30KylssXnf8pFjYOkP9wtYApQXRFBNVJSDA==
X-Received: by 2002:a50:b639:: with SMTP id b54mr10061663ede.229.1551003078086;
        Sun, 24 Feb 2019 02:11:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p93sm1777015edp.7.2019.02.24.02.11.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:17 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:17 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:51 GMT
Message-Id: <cadc46442d5c960caa58227092289fa2f44fb96f.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Tanushree Tumane via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/26] bisect--helper: `decide_next()` helper function.
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Tanushree Tumane <tanushreetumane@gmail.com>

introduce `decide_next()` helper function from `bisect_next_check()`
for better and clear understanding.

convert `*...warning` char pointers to `...warning[]`char arrays, as
char [] only creates char array while char * creates both char array
and a pointer to that char array.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 builtin/bisect--helper.c | 66 +++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 5093e55273..f441ea85ff 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -282,35 +282,23 @@ static int mark_good(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
-static const char *need_bad_and_good_revision_warning =
+static const char need_bad_and_good_revision_warning[] =
 	N_("You need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static const char *need_bisect_start_warning =
+static const char need_bisect_start_warning[] =
 	N_("You need to start by \"git bisect start\".\n"
 	   "You then need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static int bisect_next_check(const struct bisect_terms *terms,
-			     const char *current_term)
+static int decide_next(const struct bisect_terms *terms,
+		       const char *current_term, int missing_good,
+		       int missing_bad)
 {
-	int missing_good = 1, missing_bad = 1, res = 0;
-	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
-	const char *good_glob = xstrfmt("%s-*", terms->term_good);
-
-	if (ref_exists(bad_ref))
-		missing_bad = 0;
-
-	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
-			     (void *) &missing_good);
-
 	if (!missing_good && !missing_bad)
-		goto finish;
-
-	if (!current_term) {
-		res = -1;
-		goto finish;
-	}
+		return 0;
+	if (!current_term)
+		return -1;
 
 	if (missing_good && !missing_bad &&
 	    !strcmp(current_term, terms->term_good)) {
@@ -321,7 +309,7 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		warning(_("bisecting only with a %s commit"), terms->term_bad);
 		if (!isatty(0))
-			goto finish;
+			return 0;
 		/*
 		 * TRANSLATORS: Make sure to include [Y] and [n] in your
 		 * translation. The program will only accept English input
@@ -329,21 +317,35 @@ static int bisect_next_check(const struct bisect_terms *terms,
 		 */
 		yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
 		if (starts_with(yesno, "N") || starts_with(yesno, "n"))
-			res = -1;
-		goto finish;
-	}
-	if (!is_empty_or_missing_file(git_path_bisect_start())) {
-		res = error(_(need_bad_and_good_revision_warning),
-			       vocab_bad, vocab_good, vocab_bad, vocab_good);
-	} else {
-		res = error(_(need_bisect_start_warning),
-			       vocab_good, vocab_bad, vocab_good, vocab_bad);
+			return -1;
+		return 0;
 	}
 
-finish:
+	if (!is_empty_or_missing_file(git_path_bisect_start()))
+		return error(_(need_bad_and_good_revision_warning),
+			     vocab_bad, vocab_good, vocab_bad, vocab_good);
+	else
+		return error(_(need_bisect_start_warning),
+			     vocab_good, vocab_bad, vocab_good, vocab_bad);
+}
+
+static int bisect_next_check(const struct bisect_terms *terms,
+			     const char *current_term)
+{
+	int missing_good = 1, missing_bad = 1;
+	const char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
+	const char *good_glob = xstrfmt("%s-*", terms->term_good);
+
+	if (ref_exists(bad_ref))
+		missing_bad = 0;
+
+	for_each_glob_ref_in(mark_good, good_glob, "refs/bisect/",
+			     (void *) &missing_good);
+
 	free((void *) good_glob);
 	free((void *) bad_ref);
-	return res;
+
+	return decide_next(terms, current_term, missing_good, missing_bad);
 }
 
 static int get_terms(struct bisect_terms *terms)
-- 
gitgitgadget

