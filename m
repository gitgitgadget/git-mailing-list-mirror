Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7556A1F859
	for <e@80x24.org>; Sun,  4 Sep 2016 20:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754443AbcIDUU6 (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Sep 2016 16:20:58 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36135 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754562AbcIDUSz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Sep 2016 16:18:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id l65so2665504wmf.3
        for <git@vger.kernel.org>; Sun, 04 Sep 2016 13:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BVooDwFEAy5bpxcD28sZ6zRW2pxl3nXDmX+DdaQ8PHA=;
        b=TYSyBl2WRz1vUgXXyuMtOaxj2Ds54QY2Tchg4NtO5jSabdNZpth2XwsaAvC+q3ckPK
         ZAUOyZhDHd7aqNMd1UHDiv12p4cutkn9kFALX+W7zzd+L4RsiBBvxG6jJ18d0aCsYY/v
         fdK3xeNJUek6+ZQVmm9iD945gd9edh4bH0yJJd42u+CVnjFVV/VYsMz7OGr/22JNUp2+
         STNkDr1zHh3mifoABmCpTuLDKlanl4IQVpivlfRSovRtG3d+9t5QJRiXJUR/tfIskUmZ
         lQ7ykZRmL9uC42oADWEiKIkrqtFteCF1NGU/S8GOG9OI/+hoAzn12qN1KSO+aMVv5PX1
         VQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BVooDwFEAy5bpxcD28sZ6zRW2pxl3nXDmX+DdaQ8PHA=;
        b=cNhdzmYUFcbbmDeQ9ZOHBOK1um8wGjQJIfWVFtkLGsgGHW03oC6Raql8zyFgvW9jAV
         NBmuXFle7ghbEU0IxVl36tJv6wssxYOh/df2IcDpeE10BqlsFludwDSFN/yB3R9TNScw
         mgmUXBSq0d3QSX5D8ymAcXwb7WyP/n8HlF0irqga7jJ0kNCoAnHUzf8KvQVXwou6Amse
         GjhVRlpeFl4asp30uC80fwsfKlecXjG8nNdfq+PkX0m3h6t4NmK4HpAwiThu+MsNT74N
         dVU7Lu/tdd3zoL0QG3NdG9oB4Dq4TBbJj8HzmqfExU6GYqzZwYc12aJ3JQrR5BCsg4Ve
         2/ew==
X-Gm-Message-State: AE9vXwMf3NfT2ibezFzpxa7ht/E8pe5l+iV3dQeFPlQcyB817camAvNSJo3oJf7YwPsNDA==
X-Received: by 10.28.184.19 with SMTP id i19mr11803688wmf.43.1473020334441;
        Sun, 04 Sep 2016 13:18:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id n7sm23178805wjf.11.2016.09.04.13.18.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 04 Sep 2016 13:18:53 -0700 (PDT)
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
Subject: [PATCH v14 07/41] builtin/apply: make parse_single_patch() return -1 on error
Date:   Sun,  4 Sep 2016 22:17:59 +0200
Message-Id: <20160904201833.21676-8-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.0.41.g9df52c3
In-Reply-To: <20160904201833.21676-1-chriscool@tuxfamily.org>
References: <20160904201833.21676-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
2.10.0.41.g9df52c3

