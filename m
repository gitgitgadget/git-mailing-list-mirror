Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E43020193
	for <e@80x24.org>; Mon,  8 Aug 2016 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbcHHVEH (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:04:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35702 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617AbcHHVED (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:03 -0400
Received: by mail-wm0-f67.google.com with SMTP id i5so17865202wmg.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8a6nQiT5uNrWyBdibJej29t/fYNbLOtLOFpllTKoA6M=;
        b=SU2QAfFil3N4nQNkzwkAoAPhJ0yoh7gPZEjCYCJjd8jEyy9KGtJCwKlNUEH2Q/2uuj
         uMtU3FL1TqedL4K7GpywUSdT4tMUvKdYsLmyY1XQDSZnNBn3U9NjlztPHe6KiWsnZ6xN
         qZKnPouhr5+/DO1r8bKKMPUfpq+lel3Rv/L/+QSlcZGqU5Ne/P4i7hVi3P6Z2rFbExh9
         k7nAaYpc0TEePo7DNF4ZGJ12gO/tjreUK6ISzXXhAqkYtXbIoepIMrjjpWg9QSzX+RUJ
         T8HywHv2VZaYZUMT5VOc6oIQpxV7kJXV8geSFWDKIoqfOR3cYYx6+6LmXWAf9KvLy2gA
         Un9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8a6nQiT5uNrWyBdibJej29t/fYNbLOtLOFpllTKoA6M=;
        b=OuPzcQAqZ48Sdhl16OXNPIfRB5MJssmV3znE73wBAyB6qRfvmeKfxANIDrLHoxmBQe
         FYIka3yf7LIiknHJKdQ7+EGlEaLyU/elKI3h1b+ya1UM2asuOYfm9fRuHF84Pl5n6JRm
         7wkEh9Zy94pzpP94UBIE6l9NhhbWKTKFielD8GmzbwMmBtapEIuXkoHQmKfDHg1IaIO5
         puFOGFzBUu2GG08eICn4rIxxzdds1VZu8JBfCRNvYuoLJRs+LbML7KQlCdtiT2nPfRaq
         td76bAB6u7En8ZuWEjZT2rT+eDmtsc+hny3oR1hDb5AVtcNc3gxhJGstzXPC40Z3kjex
         xIQA==
X-Gm-Message-State: AEkoouvDzX6E7pYhUsAN2l0Lkl61cXfT7qJeG8gBWd6Hy+wkjfoGtFZKitgAViljRVirpQ==
X-Received: by 10.28.60.136 with SMTP id j130mr19090762wma.93.1470690241568;
        Mon, 08 Aug 2016 14:04:01 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:00 -0700 (PDT)
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
Subject: [PATCH v10 07/40] builtin/apply: make parse_single_patch() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:04 +0200
Message-Id: <20160808210337.5038-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in builtin/apply.c, parse_single_patch() should return a negative
integer instead of calling die().

Let's do that by using error() and let's adjust the related test
cases accordingly.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c        | 17 +++++++++++++----
 t/t4012-diff-binary.sh |  4 ++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index c07d142..10aaba7 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -1671,6 +1671,10 @@ static int parse_fragment(struct apply_state *state,
  *
  * The (fragment->patch, fragment->size) pair points into the memory given
  * by the caller, not a copy, when we return.
+ *
+ * Returns:
+ *   -1 in case of error,
+ *   the number of bytes in the patch otherwise.
  */
 static int parse_single_patch(struct apply_state *state,
 			      const char *line,
@@ -1688,8 +1692,10 @@ static int parse_single_patch(struct apply_state *state,
 		fragment = xcalloc(1, sizeof(*fragment));
 		fragment->linenr = state->linenr;
 		len = parse_fragment(state, line, size, patch, fragment);
-		if (len <= 0)
-			die(_("corrupt patch at line %d"), state->linenr);
+		if (len <= 0) {
+			free(fragment);
+			return error(_("corrupt patch at line %d"), state->linenr);
+		}
 		fragment->patch = line;
 		fragment->size = len;
 		oldlines += fragment->oldlines;
@@ -1725,9 +1731,9 @@ static int parse_single_patch(struct apply_state *state,
 		patch->is_delete = 0;
 
 	if (0 < patch->is_new && oldlines)
-		die(_("new file %s depends on old contents"), patch->new_name);
+		return error(_("new file %s depends on old contents"), patch->new_name);
 	if (0 < patch->is_delete && newlines)
-		die(_("deleted file %s still has contents"), patch->old_name);
+		return error(_("deleted file %s still has contents"), patch->old_name);
 	if (!patch->is_delete && !newlines && context)
 		fprintf_ln(stderr,
 			   _("** warning: "
@@ -2029,6 +2035,9 @@ static int parse_chunk(struct apply_state *state, char *buffer, unsigned long si
 				       size - offset - hdrsize,
 				       patch);
 
+	if (patchsize < 0)
+		return -128;
+
 	if (!patchsize) {
 		static const char git_binary[] = "GIT binary patch\n";
 		int hd = hdrsize + offset;
diff --git a/t/t4012-diff-binary.sh b/t/t4012-diff-binary.sh
index 643d729..0a8af76 100755
--- a/t/t4012-diff-binary.sh
+++ b/t/t4012-diff-binary.sh
@@ -68,7 +68,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	sed -e "s/-CIT/xCIT/" <output >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
@@ -77,7 +77,7 @@ test_expect_success C_LOCALE_OUTPUT 'apply detecting corrupt patch correctly' '
 	git diff --binary | sed -e "s/-CIT/xCIT/" >broken &&
 	test_must_fail git apply --stat --summary broken 2>detected &&
 	detected=$(cat detected) &&
-	detected=$(expr "$detected" : "fatal.*at line \\([0-9]*\\)\$") &&
+	detected=$(expr "$detected" : "error.*at line \\([0-9]*\\)\$") &&
 	detected=$(sed -ne "${detected}p" broken) &&
 	test "$detected" = xCIT
 '
-- 
2.9.2.614.g4980f51

