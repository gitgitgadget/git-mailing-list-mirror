Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAF161F955
	for <e@80x24.org>; Sat, 30 Jul 2016 17:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753410AbcG3RZo (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:25:44 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34112 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbcG3RZf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:25:35 -0400
Received: by mail-wm0-f65.google.com with SMTP id q128so20051359wma.1
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:34 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tQ5A4dhKW2rh3eWndMVCBNPNyYJyLnZlfwSfUwRiLVo=;
        b=NZ0CC98e/sOaKOHEett1DgZCa/pdeKAbcMBjwA6qUA2mH/ZncFmkNNERJ9d5tFnzSm
         W314RCuM6EK71M665v9EeeurhP35ePZB+m2fAvbUlksB0oshBRHQNTVXTKJsMAfKvbgc
         d7F+bSXNh/CBGrXjhA/rafn1UtwCXRfeUDOXqxlpcYtro1/Djtzg0jwMUqYNDji4MIyS
         2qQFYew13dU9u3DF3ROs+2oyhG4bKnyuU9RaA/6HFRv8fc7/s4sF9oD7E5XxYcA3x1pg
         ptBG33YAopxgGGV4UAjnlQYVmfF6P8m9oTkEbR4uYeFFIO6m9guiILU0HR7h4MyPJGWy
         wmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tQ5A4dhKW2rh3eWndMVCBNPNyYJyLnZlfwSfUwRiLVo=;
        b=ZStL7dvgCj/nq3MKALM74/14hKTq1iQ1N+qECkkatB0DE8gtD3Wh5YiDMgX4UCWWC9
         SNAcPC4DaCaCizyclOwdE5vkQseu6mtLxWjLu8Fc/WRagjjupsMxakJSGYRGmLvOP0DL
         b14Gb2ioSHcWPJqRrGZqXxKR80Fgav5dE2C0fquIDwywq+QSCYyMBcRhS7FqMU66um2S
         +PLHyvm3hUuONVpPVQedtIjVfC/8CA2mSGue2wtDAPbZZ03vqZdWfOJNgLFKL8IuupSj
         7JLpfepWxADg9EiacE6kGaWOKyiuYvjqVHL6n+2WVBf+X2E3us9co0g8CsPOSW8Or8Js
         QpRA==
X-Gm-Message-State: AEkoousxKS9K7wHXzPDCvWHPhpnzUVcpszHgetu8o7BEb6JyNV3N9Th5IGuPOC/O363Gdw==
X-Received: by 10.194.114.103 with SMTP id jf7mr47637427wjb.172.1469899533591;
        Sat, 30 Jul 2016 10:25:33 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:32 -0700 (PDT)
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
Subject: [PATCH v9 07/41] builtin/apply: make parse_single_patch() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:35 +0200
Message-Id: <20160730172509.22939-8-chriscool@tuxfamily.org>
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
index 5c73a37..9939a83 100644
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
2.9.2.558.gf53e569

