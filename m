Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCD9A1F406
	for <e@80x24.org>; Mon, 14 May 2018 21:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeENV5Z (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 May 2018 17:57:25 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:40959 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752077AbeENV5W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 May 2018 17:57:22 -0400
Received: by mail-yw0-f202.google.com with SMTP id g126-v6so5815273ywb.7
        for <git@vger.kernel.org>; Mon, 14 May 2018 14:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=RSPvXOWg0PxDLY1mfVeigypPhiq/SSPzW36Pi/DAQ/8=;
        b=uZYv8MpgsjWq5b0C80d8SndbrnzttGs6zdxMW1g3tbBTLxhq43AzYH73Hh36T1k3VU
         a5rUdKNW+CRLwag53PIlyhJj2ly/HbZ9JDe/1d2BvSV8SHS3WTOJbsZz+Nykakm6a4MK
         dB0PABzrkefKBCxpP1zTHpMWeAj6rs6EwKxZMm6c8HYs7RTcH+16pDmSWg48pfBDmQhe
         +iNzytY1Gm8nhC/1vAEPlxWpJSkR/mJTDHitOBAhVqslViu6bWa0jXqnfHbMKXLwg1po
         k+p6ss0XY2FkdJh5QPvkI6VxiaQagck3Bw8le7UbF6pf/fUZ4NEmN3/bi5dEo510cezq
         wwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=RSPvXOWg0PxDLY1mfVeigypPhiq/SSPzW36Pi/DAQ/8=;
        b=T0Y914YFK8kF2597Dnm/mOP6uFri6TMjZL4uJqgrgeNuUC3ABvZSkaKg1HXdVyQseQ
         rLG/DPQWiCm/1bc3GYoxiC2fqcImEdgpPx5mPHuVwKFMiZYxITcmlWIW8p7Q+4Khntpq
         oDf8Vj/VnYqz1+61OdOHK4hfpklK2ZMG8qT7K1k0z5yQspWhazIUKx6xsthSUTtsCo+L
         KwELLxYi2QKZLKki1lOaMEUtMXzPOy2ET3KdOuNgAY/3pZUnOLvlfcnVZBsJEfKGxhvR
         evZEHmZ2912lzS6cfrSgV2ilviT+kV2JrWzlIQnJ5OFa2xexZjBo18wzZ4iABflBMmNE
         xRgg==
X-Gm-Message-State: ALKqPweAr2O5ics0ccyACpnqSQYX/fWVB3PVoFA3g7heZHkEXDZOTjgk
        Sxuno9TOScVSkXIA+ZDoCw1p/w5Rx1YD4afNAtI5On+f1IXfOYiY5DBoBAYR6VDhN85WzCW/Ig0
        tCJcvumx5sEeoa6JVw+8yp/my4zRsNn/RAL8nTYKBMRSNcyf/T3MtFdBnAA==
X-Google-Smtp-Source: AB8JxZouf77Xn+EV5Wt1klFId1u80RBvJLKXhyNPlJgUZKK17HW/qzHgpLVo0AjhZ4SkoiUY7O8Fp8npITM=
MIME-Version: 1.0
X-Received: by 2002:a0d:e343:: with SMTP id m64-v6mr3992567ywe.22.1526335042003;
 Mon, 14 May 2018 14:57:22 -0700 (PDT)
Date:   Mon, 14 May 2018 14:56:09 -0700
In-Reply-To: <20180514215626.164960-1-bmwill@google.com>
Message-Id: <20180514215626.164960-19-bmwill@google.com>
References: <20180514215626.164960-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Subject: [PATCH 18/35] refspec: remove the deprecated functions
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org, bmwill@google.com
Cc:     Brandon Williams <bmwill@google.com>
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
index 98c99cd84..7953a70d0 100644
--- a/refspec.c
+++ b/refspec.c
@@ -121,55 +121,6 @@ static int parse_refspec(struct refspec_item *rs, const char *refspec, int fetch
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
index b009440c0..374f8ea63 100644
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

