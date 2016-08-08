Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 337EF2018E
	for <e@80x24.org>; Mon,  8 Aug 2016 21:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752481AbcHHVFX (ORCPT <rfc822;e@80x24.org>);
	Mon, 8 Aug 2016 17:05:23 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33006 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752682AbcHHVEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2016 17:04:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id o80so17871501wme.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 14:04:15 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BBg1qvqyrdGjNMm5NdaC9A8I8i5CzlZctddUEqCj/pk=;
        b=v/UYe42RFRRqjfdbz0+wwiO/KjKTeMavi8NPGhpzQB6SzyBo7peDD433MB+QqOo3py
         LBCjUxbh/QSLlLeX/pfjv36zo9c1cI8+RtH+nVIxXmUTMHVaDRLa18nFyjOnoGooRtJk
         yMHQZ5M3rhONREl2pIT2MkNJZgdKqWyAxbkqTZkKTqYXTRbKNKPEJZHOqtDK5ojvTm2X
         CeXZkHtUo/Yz5PDNGD9gDWwY1cHewwn+R5gPGn/t2sKS7uvasY/P8LI+j7BuTIF5Lz7R
         raCRqEUKzAq7OUCso8D7z4+VdD449KP4NHNaYwpb+Phh7XZ+G2oUz/8lttkzEEKj8+P8
         g1KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BBg1qvqyrdGjNMm5NdaC9A8I8i5CzlZctddUEqCj/pk=;
        b=HNO/wv2yxNf4hje/04FZ6c9CRwRQL9gSY0DgTkuv2Oco4n31RHGuQ6b4yuQ9ByosL8
         EKxuAMnPvPugYDCqkMFP3JdsROj6NLvq12Xu2KiPhbnr3PhLtiml/K/utOKPqKVqxChj
         xwOhp0PtpCgdZndvJK8gfvT1yuBFFGCupjs2NNeuX4Kf8CSYRF24NKERY/5t/o6mYtvg
         /hWRBaRYB/9UChAGiHdB1Y1teqfA/xqe5eUmkLmdo/XyYAZKSROuSOHJ0GGqBGBH+uK/
         CrOyak2UxhuS2feiRLkT0+kGtf36XAa1KpDl6X7fxWu9kt8VcFyCZrZhybjTYUxtIsO8
         WYQg==
X-Gm-Message-State: AEkoouu/W80YNPla5WxTlQceDhdJpnJmbMy4FRWhx3V5h01n2P/GMNO9BIiJ0ZWvx1r4sA==
X-Received: by 10.194.89.73 with SMTP id bm9mr74290664wjb.76.1470690254859;
        Mon, 08 Aug 2016 14:04:14 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id o2sm8539048wjo.3.2016.08.08.14.04.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 14:04:14 -0700 (PDT)
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
Subject: [PATCH v10 17/40] builtin/apply: make gitdiff_*() return -1 on error
Date:	Mon,  8 Aug 2016 23:03:14 +0200
Message-Id: <20160808210337.5038-18-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.2.614.g5428e0c
In-Reply-To: <20160808210337.5038-1-chriscool@tuxfamily.org>
References: <20160808210337.5038-1-chriscool@tuxfamily.org>
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
index eb918e5..6b16173 100644
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
2.9.2.614.g4980f51

