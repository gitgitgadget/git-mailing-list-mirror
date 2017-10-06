Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF31920372
	for <e@80x24.org>; Fri,  6 Oct 2017 20:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdJFUMk (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Oct 2017 16:12:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34744 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbdJFUMh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2017 16:12:37 -0400
Received: by mail-wm0-f67.google.com with SMTP id l10so9581768wmg.1
        for <git@vger.kernel.org>; Fri, 06 Oct 2017 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ggCr7WttwIKatuhJF6M8fIYuRsjeMFh6Y/52yS5ul3Y=;
        b=ZN30KR84mZV71/3OH7HcmtXkclUNDwbIKHstfMYaifB6xMpJeSESL7y28jAdq4oW7r
         22RJu/qn3Y8vHOpnLbS/gBO0/83ZrAuKg18+WSEWyhT5sfLdzW9LDlY6fBXUo6MVgjOW
         C8T/QVw83MbF9i1dE8lABTAnaY4ptnp4vFAQYoQgzZdfLAupr+joylnRgLHmEu3s79/5
         EoFNSfEpqqVRd32esEB+va5juIbgA4qHPH7tJkSmAAnHZ76BFkvLeANNRJE0VrSEgmCf
         LVcoX2ZYifkq0lQKOf7JjtCLN+WsZhJVVz80JCl3+vf0zlfbzMdO/XJKQLVr1rRZq8+3
         Y9Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ggCr7WttwIKatuhJF6M8fIYuRsjeMFh6Y/52yS5ul3Y=;
        b=UVTpm2VGIjPsOdr+p5sYfH5racBDu4srsEDrSxPG8a0LbjuonCfUT7pddFH59cmWST
         Pd3D4pc0nUBZlpZn0bc2iEZsnvpmjgNEEBKLCaXxL9jVi8gZcS8NmW+b9QrTfxGD5LGx
         GiMafEYYUS9rqezGYr6Tqke4UsrTi5x36qJQJSsnZ3BcyB4hH3N8RryIseKQFLlPABx0
         iIEWgd8TYEgORvWDYfQRbnUp7KMPPKF+prBrPrWKcavfB2prCG9xHUWAzjQxKn0Jg1dt
         fGHgBM4k6kPv/MG0mRIjCXmhb+KFcqalB66XWVMGPVtKQBmBDDeYw9SOplMOnc6xzPZV
         ERrQ==
X-Gm-Message-State: AMCzsaXD/Ji47ZpR+EIRYnlAhnfZDTcE4HfvPWEAQC8UsHWzrlE7A5/X
        JhzK51Lc03dALSZoj/Mi7WQ+OZPAzlE=
X-Google-Smtp-Source: AOwi7QBGCmPzDvDtyMBZ+V7ivbvlXfySzfCawiPPJ1jSLdjhtXTaDAY1AHlxdn3E+1NqHoHZwz4JRA==
X-Received: by 10.223.184.115 with SMTP id u48mr3060844wrf.91.1507320756450;
        Fri, 06 Oct 2017 13:12:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id h45sm2906522wrf.36.2017.10.06.13.12.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 06 Oct 2017 13:12:35 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>,
        Paul Tan <pyokagan@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 01/12] sha1_file: do not leak `lock_file`
Date:   Fri,  6 Oct 2017 22:12:03 +0200
Message-Id: <f132a127eebb8f1b14b87fc317ca68278fceb2e8.1507320376.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0
In-Reply-To: <cover.1507320376.git.martin.agren@gmail.com>
References: <CAN0heSqr77dptPG2mixnLdNKKcgD36aPnEFtnTB6Oyip6WfQBA@mail.gmail.com> <cover.1507320376.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is no longer any need to allocate and leak a `struct lock_file`.
Initialize it on the stack instead.

Before this patch, we set `lock = NULL` to signal that we have already
rolled back, and that we should not do any more work. We need to take
another approach now that we cannot assign NULL. We could, e.g., use
`is_lock_file_locked()`. But we already have another variable that we
could use instead, `found`. Its scope is only too small.

Bump `found` to the scope of the whole function and rearrange the "roll
back or write?"-checks to a straightforward if-else on `found`. This
also future-proves the code by making it obvious that we intend to take
exactly one of these paths.

Improved-by: Jeff King <peff@peff.net>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 sha1_file.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/sha1_file.c b/sha1_file.c
index 5a2014811..1d1747099 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -456,19 +456,19 @@ struct alternate_object_database *alloc_alt_odb(const char *dir)
 
 void add_to_alternates_file(const char *reference)
 {
-	struct lock_file *lock = xcalloc(1, sizeof(struct lock_file));
+	struct lock_file lock = LOCK_INIT;
 	char *alts = git_pathdup("objects/info/alternates");
 	FILE *in, *out;
+	int found = 0;
 
-	hold_lock_file_for_update(lock, alts, LOCK_DIE_ON_ERROR);
-	out = fdopen_lock_file(lock, "w");
+	hold_lock_file_for_update(&lock, alts, LOCK_DIE_ON_ERROR);
+	out = fdopen_lock_file(&lock, "w");
 	if (!out)
 		die_errno("unable to fdopen alternates lockfile");
 
 	in = fopen(alts, "r");
 	if (in) {
 		struct strbuf line = STRBUF_INIT;
-		int found = 0;
 
 		while (strbuf_getline(&line, in) != EOF) {
 			if (!strcmp(reference, line.buf)) {
@@ -480,18 +480,15 @@ void add_to_alternates_file(const char *reference)
 
 		strbuf_release(&line);
 		fclose(in);
-
-		if (found) {
-			rollback_lock_file(lock);
-			lock = NULL;
-		}
 	}
 	else if (errno != ENOENT)
 		die_errno("unable to read alternates file");
 
-	if (lock) {
+	if (found) {
+		rollback_lock_file(&lock);
+	} else {
 		fprintf_or_die(out, "%s\n", reference);
-		if (commit_lock_file(lock))
+		if (commit_lock_file(&lock))
 			die_errno("unable to move new alternates file into place");
 		if (alt_odb_tail)
 			link_alt_odb_entries(reference, '\n', NULL, 0);
-- 
2.15.0.rc0

