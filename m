Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A65EA1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752179AbeA2WiV (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:21 -0500
Received: from mail-ua0-f201.google.com ([209.85.217.201]:38783 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeA2WiO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:14 -0500
Received: by mail-ua0-f201.google.com with SMTP id w27so7046811uaa.5
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=2uHLOLXQyf3lW9jHbtd1fqI3BlRk5lcAwQVr9dH/BoQ=;
        b=lFc6AG4ITC4GVkoUPYBd23wAyfYYOSx6yXchbtc8KJnD7WB2v/gwYOU8h4Dr8axkP3
         aqG39oZLhxO3GOzwGbSmwvFIg5N7nPQpri0XgwpvXMRDOYpf3v2yfSSRNoilphikXxNx
         /IlroOVW1Zgoybis0KSCXI6ZXqrKiKrWLtX283G5xkoHpwkSd6TX//6NGMTAoDtlfQvM
         U2QXB01MmlmSNCr5HAe5nnTzmrxu1z9b+WznuKeiI2VRx7PivsW2aCxiulDXa32uVCLg
         Ny7NBdHwqVXNe4tVdD5cQD+QIvdI9yM2aj9CVlMjxy4JM2rU7O9ier7Jrzxh1Svz8N2s
         82aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=2uHLOLXQyf3lW9jHbtd1fqI3BlRk5lcAwQVr9dH/BoQ=;
        b=RzDdPGAaAlXDy8Qu1oO6pjtj09sDgQ0H0AUejcLpZkJajXARQJxN55PU6AG8+LRevh
         THmuOqXrKGTUHGglknZFG46aVbGqIsyVtTKEPne+vSi9db+YtC+WQ1Zf3NdxJkjLnDIX
         KWFmlqfVX2dGg/6cEYg7HqcTugiLKUOvfY96rg2IZ80obillP7k5TKSzD5nnUX6oeidZ
         pTp5uXRDhWi3sLBHixFhBBT4hZaH7brOsGdr6EVWgzKrx6Vt5gldX03gApshtI910os9
         Z0aGx7a9KczBCf67ZSLCNY1AZ4WPQc7+/4ZcUwPoLPVLEMP7M9Sdp9Q6LiaHXUNmIBlK
         APqg==
X-Gm-Message-State: AKwxytcMb6gWoqffSU6rkZmNIaN7OlDQMFfZCJg1sYkfZivxy4x/b9++
        0uYZAFzKu120vvPaUHCJtUdCvmGIavamf5vK514vPkr+E/ev1E9clDJoyvyF65bioVpi6xNwA/9
        mTaSj9WVS9rhdV7Z0aQM3juc4hhOcelSDZOwp2mxuqbud6Mz+6JrIWGghPA==
X-Google-Smtp-Source: AH8x2247oaRNbuAaXmrextO+bukA283UpLdMabN0zQP5xKXg2l1lRgD/Ci+VfiL7D9OqTWS4gsO2KlXPvK0=
MIME-Version: 1.0
X-Received: by 10.176.90.151 with SMTP id w23mr3329414uae.2.1517265493865;
 Mon, 29 Jan 2018 14:38:13 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:05 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-15-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 14/37] combine-diff: rename 'new' variables
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, avarab@gmail.com,
        Brandon Williams <bmwill@google.com>
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
2.16.0.rc1.238.g530d649a79-goog

