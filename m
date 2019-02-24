Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D83B8202AA
	for <e@80x24.org>; Sun, 24 Feb 2019 10:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728273AbfBXKLX (ORCPT <rfc822;e@80x24.org>);
        Sun, 24 Feb 2019 05:11:23 -0500
Received: from mail-ed1-f45.google.com ([209.85.208.45]:41734 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728251AbfBXKLW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Feb 2019 05:11:22 -0500
Received: by mail-ed1-f45.google.com with SMTP id x7so5198735eds.8
        for <git@vger.kernel.org>; Sun, 24 Feb 2019 02:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jwJwlovIi86pVFsbXvj+6QMHOlznabX3ihIVBcOzS2E=;
        b=dWQCvK4hLK3sle8PB+TfdlR/kMAsKLXdHyCtK0eiEDbe63F8SynnXRSWIxmLV8IupW
         gfCIIaKVWPqJbo5mc4FCtNvfkGQxMF8Dlt790AfH4t+NQ8t/OV30DwbUg3ggAPbcLvGK
         /cbSdtAcKsp63HTwop7t6H2/11pERwtBnIW6NKoidmg/QW6C8+uXaLkig7hSy1iKliHh
         b33JE4jM/0AghSKX1/jETxIOvaWUjxgg9MFnnlmPPDdaPJX99KgJG0VGTLgT+QvREUNG
         1nYt86YCz9gYDZpOd4FbWGyRrk38pm1VWvRH/dnHp3UsDDelJVlJfWg6g3j7yzTH2Vgc
         2v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jwJwlovIi86pVFsbXvj+6QMHOlznabX3ihIVBcOzS2E=;
        b=Gicd0GjRDutK0QcnY7pFADW1ClmlgPwH8iH5TCbwdDj9uom/gRzneeC9KTmaqcaViJ
         EJ8jdRFlKLpxQJWNl9lSh9EByiliNJqdBj4LWIeeS8g4iCgGouxg2PH9NBUYiILmnTYo
         6ri8soXCfKMeZ99dIR2l8XeL4I0w+UHHdnPy0HX4t1PhRpj6nxeZAfefDiMZIC8a0RKa
         lyyoT/NwcTsNui4UZUsafaqGGn/BLp+FVrjMpv7s9fXuSwjzTs6mXcYD63+Zvg0nQRs6
         R8rMgj9tjRU6jfqQ28Fdwrso1Aodp2A4908SoW7lzGHslCZBdZkuEXCO7WQw9zmPyv6e
         Aswg==
X-Gm-Message-State: AHQUAuYPKNhHmEipNkfdOjeFSaBhh1+On5AsXlEqAtvo87D/2NXF1/uQ
        RcIeFFGfqjjABY2fj3W/7NYTNHbE
X-Google-Smtp-Source: AHgI3Ia0iFu6pp8Vp3atVmQfSwDYebhDRjMZ5Xw0L3RxV+gARqRI8A9MxlYaz1VpvZUpckaEOFKcIQ==
X-Received: by 2002:a17:906:35d8:: with SMTP id p24mr9318084ejb.112.1551003080574;
        Sun, 24 Feb 2019 02:11:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l24sm1184624eja.57.2019.02.24.02.11.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Feb 2019 02:11:20 -0800 (PST)
Date:   Sun, 24 Feb 2019 02:11:20 -0800 (PST)
X-Google-Original-Date: Sun, 24 Feb 2019 10:10:54 GMT
Message-Id: <1a955345100ed3e953bc7b9f0c6ce66f6b2b4e2a.1551003074.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.117.git.gitgitgadget@gmail.com>
References: <pull.117.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 06/26] bisect.c: libify `check_merge_bases` and its
 dependents.
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

Since we want to get rid of git-bisect.sh it would be necessary to
convert those exit() calls to return statements so that errors can be
reported.

Emulate try catch in C by converting `exit(<positive-value>)` to
`return <negetive-value>`. Follow POSIX conventions to return
<negative-value> to indicate error.

Turn `exit()` to `return` calls in `check_merge_bases()`.

In `check_merge_bases()` there is an early success special case,
so we have introduced special error code `-11` which indicates early
success. This `-11` is converted back to `0` in `check_good_are_ancestors_of_bad()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
---
 bisect.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index 1f2f3201a3..1134854fe2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -801,13 +801,16 @@ static void handle_skipped_merge_base(const struct object_id *mb)
  * "check_merge_bases" checks that merge bases are not "bad" (or "new").
  *
  * - If one is "bad" (or "new"), it means the user assumed something wrong
- * and we must exit with a non 0 error code.
+ * and we must return error with a non 0 error code.
  * - If one is "good" (or "old"), that's good, we have nothing to do.
  * - If one is "skipped", we can't know but we should warn.
  * - If we don't know, we should check it out and ask the user to test.
+ * - If a merge base must be tested, on success return -11 a special condition
+ * for early success, this will be converted back to 0 in cmd_bisect__helper.
  */
-static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
+static int check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 {
+	int res = 0;
 	struct commit_list *result;
 
 	result = get_merge_bases_many(rev[0], rev_nr - 1, rev + 1);
@@ -822,11 +825,16 @@ static void check_merge_bases(int rev_nr, struct commit **rev, int no_checkout)
 			handle_skipped_merge_base(mb);
 		} else {
 			printf(_("Bisecting: a merge base must be tested\n"));
-			exit(-bisect_checkout(mb, no_checkout));
+			res = bisect_checkout(mb, no_checkout);
+			if (!res)
+				/* indicate early success */
+				res = -11;
+			break;
 		}
 	}
 
 	free_commit_list(result);
+	return res;
 }
 
 static int check_ancestors(int rev_nr, struct commit **rev, const char *prefix)
@@ -857,7 +865,7 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 {
 	char *filename = git_pathdup("BISECT_ANCESTORS_OK");
 	struct stat st;
-	int fd, rev_nr;
+	int fd, rev_nr, res = 0;
 	struct commit **rev;
 
 	if (!current_bad_oid)
@@ -874,8 +882,10 @@ static void check_good_are_ancestors_of_bad(const char *prefix, int no_checkout)
 	/* Check if all good revs are ancestor of the bad rev. */
 	rev = get_bad_and_good_commits(&rev_nr);
 	if (check_ancestors(rev_nr, rev, prefix))
-		check_merge_bases(rev_nr, rev, no_checkout);
+		res = check_merge_bases(rev_nr, rev, no_checkout);
 	free(rev);
+	if(res)
+		exit(res == -11 ? 0 : -res);
 
 	/* Create file BISECT_ANCESTORS_OK. */
 	fd = open(filename, O_CREAT | O_TRUNC | O_WRONLY, 0600);
-- 
gitgitgadget

