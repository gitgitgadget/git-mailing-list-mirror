Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02181F955
	for <e@80x24.org>; Sat, 30 Jul 2016 17:27:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbcG3R1k (ORCPT <rfc822;e@80x24.org>);
	Sat, 30 Jul 2016 13:27:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36772 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752840AbcG3R0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jul 2016 13:26:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id x83so20018371wma.3
        for <git@vger.kernel.org>; Sat, 30 Jul 2016 10:25:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hxyuM1HyMmB44yq+zwAb8qAeUIvxQLT/yyFYEfTAkM=;
        b=jFsVtT/xAWLae51vLEtzgGgu7+CRnCYueL2kEIZJSBTpYpPiMWTopkO2yLFbICgnUq
         se8Lk95WDuwifbeAAYolYMMkP78B58J1dxeIW39xg3Ccwtb96MNNMcBg0P4sTPTJDKDi
         jEj/GDNtjlWAshrTLE3LeTMcUJMFOC6nCzYGTs7bhdY9ukkrl0glVGbpK12ZpML1JKDv
         TufVmc0QtKoUbl+hkTfDNk2F4hvDwDnTC/4nCXqoSojaPfY4sVhSGAuy1CWqiSICmR+c
         /iK3nPtQguFLl55MjOuaJiGYjGk7ZqrmQ544P2SJK30EmFe4I21Rt3IOcKR0GODdtWp0
         m3Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hxyuM1HyMmB44yq+zwAb8qAeUIvxQLT/yyFYEfTAkM=;
        b=gvpdVLeDANM1rpmeaT7N/iK12edC/EJO1tckVB0hx5HdqCcIl+IRNh8VAvXH+aT2ju
         npXxIAMIN3Gdi21eKY5w5lboKqVYqlPerp4SKCido+BdZm1wG48Tv6hyUffSjBzd//TK
         YFmHo/zZw+5/SnlJIquA2tiKUz8vIDsBLhvsTfzufOrjRHul8lywt5bacQ5KPLcxdquX
         Lj/S8LOCrr+C0XXDuZfBDX9fZbfIfMaw+ESvmatRutRFwWKrLH0Khz+MyRuKXDjSEAUv
         7FZymIgCAGuxz7b2p3IN2nC/ZgIJQYhZ8qofetrszeXDBG9bQ2h0UqhlWGpbH5t3mMZu
         sX9w==
X-Gm-Message-State: AEkoouswYXQ8RhloXqz0/C9xWFhSnXYDf1oARiGL+yRfsqeNlFvabuQw2kqz15R8+JCFVQ==
X-Received: by 10.28.131.199 with SMTP id f190mr6533631wmd.30.1469899554286;
        Sat, 30 Jul 2016 10:25:54 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id d62sm8641970wmd.7.2016.07.30.10.25.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 Jul 2016 10:25:53 -0700 (PDT)
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
Subject: [PATCH v9 17/41] builtin/apply: make gitdiff_*() return -1 on error
Date:	Sat, 30 Jul 2016 19:24:45 +0200
Message-Id: <20160730172509.22939-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.558.gf53e569
In-Reply-To: <20160730172509.22939-1-chriscool@tuxfamily.org>
References: <20160730172509.22939-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

To libify `git apply` functionality we have to signal errors to the
caller instead of die()ing.

To do that in a compatible manner with the rest of the error handling
in "builtin/apply.c", gitdiff_*() functions should return -1 instead
of calling die().

A previous patch made it possible for gitdiff_*() functions to
return -1 in case of error. Let's take advantage of that to
make gitdiff_verify_name() return -1 on error, and to have
gitdiff_oldname() and gitdiff_newname() directly return
what gitdiff_verify_name() returns.

Helped-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/apply.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 877610c..6a0818b 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -827,54 +827,56 @@ static int gitdiff_hdrend(struct apply_state *state,
 #define DIFF_OLD_NAME 0
 #define DIFF_NEW_NAME 1
 
-static void gitdiff_verify_name(struct apply_state *state,
-				const char *line,
-				int isnull,
-				char **name,
-				int side)
+static int gitdiff_verify_name(struct apply_state *state,
+			       const char *line,
+			       int isnull,
+			       char **name,
+			       int side)
 {
 	if (!*name && !isnull) {
 		*name = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		return;
+		return 0;
 	}
 
 	if (*name) {
 		int len = strlen(*name);
 		char *another;
 		if (isnull)
-			die(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
-			    *name, state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null, got %s on line %d"),
+				     *name, state->linenr);
 		another = find_name(state, line, NULL, state->p_value, TERM_TAB);
-		if (!another || memcmp(another, *name, len + 1))
-			die((side == DIFF_NEW_NAME) ?
+		if (!another || memcmp(another, *name, len + 1)) {
+			free(another);
+			return error((side == DIFF_NEW_NAME) ?
 			    _("git apply: bad git-diff - inconsistent new filename on line %d") :
 			    _("git apply: bad git-diff - inconsistent old filename on line %d"), state->linenr);
+		}
 		free(another);
 	} else {
 		/* expect "/dev/null" */
 		if (memcmp("/dev/null", line, 9) || line[9] != '\n')
-			die(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
+			return error(_("git apply: bad git-diff - expected /dev/null on line %d"), state->linenr);
 	}
+
+	return 0;
 }
 
 static int gitdiff_oldname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_new, &patch->old_name,
-			    DIFF_OLD_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_new, &patch->old_name,
+				   DIFF_OLD_NAME);
 }
 
 static int gitdiff_newname(struct apply_state *state,
 			   const char *line,
 			   struct patch *patch)
 {
-	gitdiff_verify_name(state, line,
-			    patch->is_delete, &patch->new_name,
-			    DIFF_NEW_NAME);
-	return 0;
+	return gitdiff_verify_name(state, line,
+				   patch->is_delete, &patch->new_name,
+				   DIFF_NEW_NAME);
 }
 
 static int gitdiff_oldmode(struct apply_state *state,
-- 
2.9.2.558.gf53e569

