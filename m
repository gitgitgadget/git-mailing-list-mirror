Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69F031F770
	for <e@80x24.org>; Wed,  2 Jan 2019 15:38:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729405AbfABPif (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Jan 2019 10:38:35 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39011 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729102AbfABPif (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Jan 2019 10:38:35 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so26504165edt.6
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 07:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:mime-version
         :content-transfer-encoding:fcc:content-transfer-encoding:to:cc;
        bh=9rft/zwtPTp5vIgPZDGvf3PabsaUBsqrvDpFgsAzHaA=;
        b=NrUitZbOmVqKylSoAXZ7ePemjZ270Ql32082/d8Fe8AFbygX5LtaT5h0WABoP+ae4i
         NOL/HZjFMiWgb0CaO/TSBHrm6PeTzKlrNhTvBpjwxJpujAbJfNwyxTwq0+IAgh8+HsAe
         z84z5D7elqUR2oyk6aJ2TQHPtOy+IFppNvzNnpN28trMhQ6CQDUw/E5flCmu8iMOjKr3
         2zb6la9zanMVL3+aFkYVzMa12HxawGBYJKFYWT49m5tWO0DrkxfhZLSAgBL1IBhCurAe
         yAyQ/PJadrxqWWhERtWy207cn7Reg+iUOe+SZ/2EKqqj9Qdqy390ya08vzE7z2uIvdvc
         YWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:mime-version:content-transfer-encoding:fcc
         :content-transfer-encoding:to:cc;
        bh=9rft/zwtPTp5vIgPZDGvf3PabsaUBsqrvDpFgsAzHaA=;
        b=Pnb2v5X+NfhPJQZFFOaiLh7BDn7sKR6BsOqiIXw260ggpf6vy/pXWlFT0ei3khsABp
         3sPbaRfPLbTG7DuWGpg0tV8X8G8s7ChLOCDp2GW/Y16oB5LyMX3xxzMhDCa2v/Uk7E7+
         EMOeIeFcLY4xQbKdkMstKBAZywLX217FcIyDgHrA+IuE5sdP2XlPeXAIqaODtrSxdVHa
         07ypLUC7LDLBHLp43WHgtOt/4I9LiqSrymTkD/ObuwPhv8BTp/n1s532Ss+Qx1OOu8TS
         B7MyFdzf3jY61meL2Nfb+HAwRWg03WLFpo6qS4Of4wid1GondnmrBvWb/UOusdJFWC5n
         +CuA==
X-Gm-Message-State: AA+aEWa1dLQZQmaWtPrlO361zEYdozhmBF3C+kvcgbKd0apeT0CD17Ta
        pn1L3stzZsPo7cHkuvpFyQKFwHkI
X-Google-Smtp-Source: AFSGD/XSm+6CP635IDOMA+1NabgmCxadc8abBywEqrRNwMp98SNrFDY3Fj0Hb+N8WWurvk/ua8mYfw==
X-Received: by 2002:a05:6402:511:: with SMTP id m17mr40214385edv.33.1546443513217;
        Wed, 02 Jan 2019 07:38:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h8sm19241669edb.95.2019.01.02.07.38.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Jan 2019 07:38:32 -0800 (PST)
Date:   Wed, 02 Jan 2019 07:38:32 -0800 (PST)
X-Google-Original-Date: Wed, 02 Jan 2019 15:38:24 GMT
Message-Id: <5f24e7cef26b4b1b6c87be03e5485b182040ece1.1546443509.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.101.v17.git.gitgitgadget@gmail.com>
References: <0102015f5e5ee171-f30f4868-886f-47a1-a4e4-b4936afc545d-000000@eu-west-1.amazonses.com>
        <pull.101.v17.git.gitgitgadget@gmail.com>
From:   "Pranit Bauva via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v17 3/7] wrapper: move is_empty_file() and rename it as
 is_empty_or_missing_file()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Pranit Bauva <pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Pranit Bauva <pranit.bauva@gmail.com>

is_empty_file() can help to refactor a lot of code. This will be very
helpful in porting "git bisect" to C.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/am.c | 20 ++------------------
 cache.h      |  3 +++
 wrapper.c    | 13 +++++++++++++
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 8f27f3375b..310eefe9e8 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -34,22 +34,6 @@
 #include "packfile.h"
 #include "repository.h"
 
-/**
- * Returns 1 if the file is empty or does not exist, 0 otherwise.
- */
-static int is_empty_file(const char *filename)
-{
-	struct stat st;
-
-	if (stat(filename, &st) < 0) {
-		if (errno == ENOENT)
-			return 1;
-		die_errno(_("could not stat %s"), filename);
-	}
-
-	return !st.st_size;
-}
-
 /**
  * Returns the length of the first line of msg.
  */
@@ -1220,7 +1204,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_file(am_path(state, "patch"))) {
+	if (is_empty_or_missing_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty."));
 		die_user_resolve(state);
 	}
@@ -1803,7 +1787,7 @@ static void am_run(struct am_state *state, int resume)
 		resume = 0;
 	}
 
-	if (!is_empty_file(am_path(state, "rewritten"))) {
+	if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
 		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
diff --git a/cache.h b/cache.h
index ca36b44ee0..9ff7e56b74 100644
--- a/cache.h
+++ b/cache.h
@@ -1788,4 +1788,7 @@ void safe_create_dir(const char *dir, int share);
  */
 extern int print_sha1_ellipsis(void);
 
+/* Return 1 if the file is empty or does not exists, 0 otherwise. */
+extern int is_empty_or_missing_file(const char *filename);
+
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index e4fa9d84cd..ea3cf64d4c 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -690,3 +690,16 @@ int xgethostname(char *buf, size_t len)
 		buf[len - 1] = 0;
 	return ret;
 }
+
+int is_empty_or_missing_file(const char *filename)
+{
+	struct stat st;
+
+	if (stat(filename, &st) < 0) {
+		if (errno == ENOENT)
+			return 1;
+		die_errno(_("could not stat %s"), filename);
+	}
+
+	return !st.st_size;
+}
-- 
gitgitgadget

