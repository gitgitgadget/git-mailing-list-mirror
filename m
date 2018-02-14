Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13DAD1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 19:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162605AbeBNTCr (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 14:02:47 -0500
Received: from mail-oi0-f74.google.com ([209.85.218.74]:40705 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1162526AbeBNTBU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 14:01:20 -0500
Received: by mail-oi0-f74.google.com with SMTP id 15so11246964oip.7
        for <git@vger.kernel.org>; Wed, 14 Feb 2018 11:01:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/NWq4gL9Vx08o5ik9pCtyMblglQIfFrHHfeFxw9UXRc=;
        b=kHoXzoX99/1z9h43x0h0zld58S9zt0afF9TTu8Y0SNPLa9Eh1kxfRWF5JwQRyzF89l
         sM54LefF1lIT+icdFFo2wfQUrEG5wLe6PbnUiHWuzeYFkPA7bvoKm2rWjag8b7Wzoo2e
         D0aGcmO2+titNJSRK+K4MLNTWUbUWFG1L3OeBahiKsrzLUqReefynNL4gDRt37qYSOsP
         sA2bOP9F2zzTRKzwfaNM2FFlVzVLFlNgwh31ysNxi9StA60YvOSwRqx2Hx9JIF7zBiN4
         i+R6Bde091TPpMYFDf0ThidK21jydiSt5l5puojVWmxhq5mdyAcVEmoV5JpGCFEP6Y3H
         Bufg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/NWq4gL9Vx08o5ik9pCtyMblglQIfFrHHfeFxw9UXRc=;
        b=CqaItkEfQh9iETDOnr/H7+a64tG7NNFAT4HG7sT8FdHdD/YNXeZftgJghiQksfY5fT
         NBfA2VUZm0mtnepx5Mk+NqY9NtU8vpbV1Wbo8nhMYIerV7ObPQp7k9F6cF+bihVk/CNp
         ioyLG/LJa6tPUdjylhGXRDUxG00sI1rRQ9NYrofcnZWM3/q2dr6PNLtbs6gL01E9vgWU
         6mGylYk0P2tdDfCKS+JmYOPMW2qzZhky6HOSvcKrpqsLDF00LtEpr59rHGMOEVueWI7J
         BvfNfSVKSeKiP/yh/zJzK94wJUYTtrWhFpURI4kQpvwELXAwmhlZO89B5FgZ0IfFOr5K
         nt/w==
X-Gm-Message-State: APf1xPCPzLp1kYtfXwl2mRWoNFl5hAGbEkRZhV6JLO/qFupdOfVCLEoT
        WKIwbfpQd360dvL0rfQHZGsC2SLWShakl1Tzt+RpAqFUfHGWvdz282/UkIo9r/uTTYVpHTmgPyG
        1ucOc1KbNoF/xt455E+aEvqU1NKQO9woLN0SiFMXJJYJyjomudnDUWWMg9A==
X-Google-Smtp-Source: AH8x227xrt3nRk/RYmA6ZdSYQxXOU14TuRuY8OG1kpgqoiZYWpJVhkpItOuluJpjWW+79JLP8Whg5Hb3kFI=
MIME-Version: 1.0
X-Received: by 10.157.44.174 with SMTP id p43mr29112otb.30.1518634880132; Wed,
 14 Feb 2018 11:01:20 -0800 (PST)
Date:   Wed, 14 Feb 2018 10:59:36 -0800
In-Reply-To: <20180214185959.221906-1-bmwill@google.com>
Message-Id: <20180214185959.221906-15-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com> <20180214185959.221906-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.109.g93438bbb9.dirty
Subject: [PATCH v2 14/37] combine-diff: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, sbeller@google.com, avarab@gmail.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rename C++ keyword in order to bring the codebase closer to being able
to be compiled with a C++ compiler.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 combine-diff.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index bc08c4c5b..14db48966 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -162,7 +162,7 @@ enum coalesce_direction { MATCH, BASE, NEW };
 
 /* Coalesce new lines into base by finding LCS */
 static struct lline *coalesce_lines(struct lline *base, int *lenbase,
-				    struct lline *new, int lennew,
+				    struct lline *newline, int lennew,
 				    unsigned long parent, long flags)
 {
 	int **lcs;
@@ -170,12 +170,12 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 	struct lline *baseend, *newend = NULL;
 	int i, j, origbaselen = *lenbase;
 
-	if (new == NULL)
+	if (newline == NULL)
 		return base;
 
 	if (base == NULL) {
 		*lenbase = lennew;
-		return new;
+		return newline;
 	}
 
 	/*
@@ -200,7 +200,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 		directions[0][j] = NEW;
 
 	for (i = 1, baseend = base; i < origbaselen + 1; i++) {
-		for (j = 1, newend = new; j < lennew + 1; j++) {
+		for (j = 1, newend = newline; j < lennew + 1; j++) {
 			if (match_string_spaces(baseend->line, baseend->len,
 						newend->line, newend->len, flags)) {
 				lcs[i][j] = lcs[i - 1][j - 1] + 1;
@@ -241,7 +241,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 			if (lline->prev)
 				lline->prev->next = lline->next;
 			else
-				new = lline->next;
+				newline = lline->next;
 			if (lline->next)
 				lline->next->prev = lline->prev;
 
@@ -270,7 +270,7 @@ static struct lline *coalesce_lines(struct lline *base, int *lenbase,
 		}
 	}
 
-	newend = new;
+	newend = newline;
 	while (newend) {
 		struct lline *lline = newend;
 		newend = newend->next;
-- 
2.16.1.291.g4437f3f132-goog

