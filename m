Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C09A1F406
	for <e@80x24.org>; Wed, 16 May 2018 22:59:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752054AbeEPW7Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 18:59:25 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:33091 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751868AbeEPW7Y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 18:59:24 -0400
Received: by mail-it0-f74.google.com with SMTP id i130-v6so2788969iti.0
        for <git@vger.kernel.org>; Wed, 16 May 2018 15:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=8nmOySf6obK4FbXl46z4NzYt3KQK2THVeiMLkdP7GOM=;
        b=U52W7eZjXKBwJqWQKRqKvM8e+jbu4XreimbctmePitZvOkmAQwbqI4rlYsLfuT46mA
         Ayqv2mYGRYhArhEsCdu1ByBS40KrNxwkEC8zR+HovEaI34P/knW8qk/kX5LDAPH6Ihhg
         cp1siIjHB/NEI/KSAAkUyHAAGnvBDYX4QNxbyaxST2kRjWliz9xg//0+s7S1Ho6gwtEn
         wOQd/EgI6dWfnMHACK9YSpF8MllREnhDqorQmNPxXnj7JLZJTaZiTgTNLGSSDoCFXVqc
         XILWGpqwfk9vBexbzVRW0FxiYkXj8+QoE6JF6yna5IWN/+JTMGjoZaN8q95XtBlKMbQt
         dXlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=8nmOySf6obK4FbXl46z4NzYt3KQK2THVeiMLkdP7GOM=;
        b=hJfYTFsfmVNRh/fA7hUfjicfBh9p7Qch6g6u/gjtdQiKeI5YmOPe6bp34i0Mm0ws56
         jg/YUXAp2THwI5caLMxz4YBKKtz953sWXditqZFXwOIwr07QBMk6sQjiu1M5CXJt75qp
         GV1pUhZ8pgj+QORpwpTVPHO+2ZBYi9OBqy4aXr0F9nNCyiIIsTuFOypQHjG3MFQqzwxD
         NLXgz7WuFYIiRMOruza+LRSXABtILZBPmqnfJoQQGy9DpG45JSoo6Zqgby7b1RnLDAxJ
         TtAyFDmjv3E1IVavgr9JYncy41To3s5/+LBgwTznlQjT8a6vkZcLtzeFlNnxR9jXHCmP
         9Jyw==
X-Gm-Message-State: ALKqPwfxbR4ObdfIk4Cwwkn21ybDAhKrbuE45z3ba3bOn66GRk4bQMyp
        w+SIILFij9gDUlYkQUndDpmDVQRpYuqL+Wbjfm0+X0zjeVIDMvC40aZXFtkCgMh8JWw97s/hlYf
        mSrMQShTG1owGCyItWXCWtzMb45cvKzY8kLVbogx8fW699cNBipjhjXZVgw==
X-Google-Smtp-Source: AB8JxZoAT+FITkSDOYVRdS71AEDp2FTvZHzBd4V3CGaNihgoVK1Pt6uvXowmBbyCXLlM+ghphO2okXXOiOg=
MIME-Version: 1.0
X-Received: by 2002:a24:4961:: with SMTP id z94-v6mr197294ita.17.1526511563640;
 Wed, 16 May 2018 15:59:23 -0700 (PDT)
Date:   Wed, 16 May 2018 15:58:06 -0700
In-Reply-To: <20180516225823.235426-1-bmwill@google.com>
Message-Id: <20180516225823.235426-20-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com> <20180516225823.235426-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH v2 19/36] refspec: remove the deprecated functions
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com,
        sbeller@google.com, bmwill@google.com
Cc:     avarab@gmail.com, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that there are no callers of 'parse_push_refspec()',
'parse_fetch_refspec()', and 'free_refspec()', remove these
functions.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 refspec.c | 49 -------------------------------------------------
 refspec.h |  5 -----
 2 files changed, 54 deletions(-)

diff --git a/refspec.c b/refspec.c
index ab37b5ba1..97e76e8b1 100644
--- a/refspec.c
+++ b/refspec.c
@@ -121,55 +121,6 @@ static int parse_refspec(struct refspec_item *item, const char *refspec, int fet
 	return 1;
 }
 
-static struct refspec_item *parse_refspec_internal(int nr_refspec, const char **refspec, int fetch, int verify)
-{
-	int i;
-	struct refspec_item *rs = xcalloc(nr_refspec, sizeof(*rs));
-
-	for (i = 0; i < nr_refspec; i++) {
-		if (!parse_refspec(&rs[i], refspec[i], fetch))
-			goto invalid;
-	}
-
-	return rs;
-
- invalid:
-	if (verify) {
-		/*
-		 * nr_refspec must be greater than zero and i must be valid
-		 * since it is only possible to reach this point from within
-		 * the for loop above.
-		 */
-		free_refspec(i+1, rs);
-		return NULL;
-	}
-	die("Invalid refspec '%s'", refspec[i]);
-}
-
-struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec)
-{
-	return parse_refspec_internal(nr_refspec, refspec, 1, 0);
-}
-
-struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec)
-{
-	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
-}
-
-void free_refspec(int nr_refspec, struct refspec_item *refspec)
-{
-	int i;
-
-	if (!refspec)
-		return;
-
-	for (i = 0; i < nr_refspec; i++) {
-		free(refspec[i].src);
-		free(refspec[i].dst);
-	}
-	free(refspec);
-}
-
 void refspec_item_init(struct refspec_item *item, const char *refspec, int fetch)
 {
 	memset(item, 0, sizeof(*item));
diff --git a/refspec.h b/refspec.h
index 1063c64cc..7e1ff94ac 100644
--- a/refspec.h
+++ b/refspec.h
@@ -14,11 +14,6 @@ struct refspec_item {
 	char *dst;
 };
 
-struct refspec_item *parse_fetch_refspec(int nr_refspec, const char **refspec);
-struct refspec_item *parse_push_refspec(int nr_refspec, const char **refspec);
-
-void free_refspec(int nr_refspec, struct refspec_item *refspec);
-
 #define REFSPEC_FETCH 1
 #define REFSPEC_PUSH 0
 
-- 
2.17.0.441.gb46fe60e1d-goog

