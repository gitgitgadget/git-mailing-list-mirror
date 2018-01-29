Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98A7F1F404
	for <e@80x24.org>; Mon, 29 Jan 2018 22:38:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752193AbeA2Wi0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Jan 2018 17:38:26 -0500
Received: from mail-ua0-f202.google.com ([209.85.217.202]:45319 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeA2WiY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jan 2018 17:38:24 -0500
Received: by mail-ua0-f202.google.com with SMTP id o42so6828009uao.12
        for <git@vger.kernel.org>; Mon, 29 Jan 2018 14:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=IU2WEX1rEMJ6/pgWKJzOgB59pIEp/anVvjWJsHR85EE=;
        b=OTWo3kk1r8yeoRzn3NsUOmxRC14+ih2A2MY53ETfzP5rrjg040KARmbR7hyezK4STd
         2S/lYrD9PZ67wTvI87xsIuRb3C0W4aha3kJa/VtmT2V3nYER9bcncLwm94g3vK9XaICX
         PZyqwOEqOGktENQoIAZHQlH+JYopS1HtMw7Be2w1Eqj2894tL2nbd6VmndtNtA/pOmPk
         kzYzP2Wt4z4WJPirSGKVq7DoiWyhHXbqeXYqe0QVITh+vK1B9xQfU4DZSHJjkbYyWzif
         RxfI6J5aaN4uckkI0tUb+bJ9NV/vqXKtnmALXhsjSY38JbzHZZ5qCD5z/i/lxzVAz1VR
         7fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=IU2WEX1rEMJ6/pgWKJzOgB59pIEp/anVvjWJsHR85EE=;
        b=ep5YVZ9+I5lGUtw8UNZczV/E2lWt9pLnYSpgdcAirWXTr4HPxspmX09ASOi5MXu2NZ
         MxorI0ziBfvQyQ6V6Z5XgE7aEdn4L4LnYuwwoo58FxmuyppFYSczCG0VT8RBdxJq/Mnp
         8HV63XC6p3aN22vFKQ7I1w5J5vJuwsMw4ls6K8YlKLgGKP214TpRgOD3CROLciwkAu1s
         Q5uVw9+eiF0pDW8XjEPc4gG3aoFCrQMVVO7GtSv9YEjiTk9uXcZPeoebj0W26WqrXapy
         WYUGq9XhpdYY4NlgfguiYcFFHfkScmzz4ZGcDAu7qEUYeYwFLpyC50sElB8qdoRGFDx0
         Ioww==
X-Gm-Message-State: AKwxytcNjhtAYbzpa8AdpcP5IWKrEaewWSnuO4F+iVhQXI2w8mRvngr2
        d31axjfL1YNAEZdDLbtB3v3fX70F+179//N6+U+2XV1876EH1F4AsFPQN+dne4dqckzd1u3OyfS
        tnP2YRALUH1QUP3YaBo/ooOs+j+281t0XHi+EJHjztF1/OG1PDMP5LXPpDg==
X-Google-Smtp-Source: AH8x225FDnvc781amlsB5001UG0zTG0uaQ7DwbXDh0Fhs5TwD4ARSVIKln1B3aeoji9xHtgLDIbyDv5702s=
MIME-Version: 1.0
X-Received: by 10.176.96.12 with SMTP id j12mr12149128ual.40.1517265503246;
 Mon, 29 Jan 2018 14:38:23 -0800 (PST)
Date:   Mon, 29 Jan 2018 14:37:09 -0800
In-Reply-To: <20180129223728.30569-1-bmwill@google.com>
Message-Id: <20180129223728.30569-19-bmwill@google.com>
References: <20180129223728.30569-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH 18/37] diffcore-delta: rename 'new' variables
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
 diffcore-delta.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/diffcore-delta.c b/diffcore-delta.c
index ebe70fb06..c83d45a04 100644
--- a/diffcore-delta.c
+++ b/diffcore-delta.c
@@ -48,16 +48,16 @@ struct spanhash_top {
 
 static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 {
-	struct spanhash_top *new;
+	struct spanhash_top *new_spanhash;
 	int i;
 	int osz = 1 << orig->alloc_log2;
 	int sz = osz << 1;
 
-	new = xmalloc(st_add(sizeof(*orig),
+	new_spanhash = xmalloc(st_add(sizeof(*orig),
 			     st_mult(sizeof(struct spanhash), sz)));
-	new->alloc_log2 = orig->alloc_log2 + 1;
-	new->free = INITIAL_FREE(new->alloc_log2);
-	memset(new->data, 0, sizeof(struct spanhash) * sz);
+	new_spanhash->alloc_log2 = orig->alloc_log2 + 1;
+	new_spanhash->free = INITIAL_FREE(new_spanhash->alloc_log2);
+	memset(new_spanhash->data, 0, sizeof(struct spanhash) * sz);
 	for (i = 0; i < osz; i++) {
 		struct spanhash *o = &(orig->data[i]);
 		int bucket;
@@ -65,11 +65,11 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 			continue;
 		bucket = o->hashval & (sz - 1);
 		while (1) {
-			struct spanhash *h = &(new->data[bucket++]);
+			struct spanhash *h = &(new_spanhash->data[bucket++]);
 			if (!h->cnt) {
 				h->hashval = o->hashval;
 				h->cnt = o->cnt;
-				new->free--;
+				new_spanhash->free--;
 				break;
 			}
 			if (sz <= bucket)
@@ -77,7 +77,7 @@ static struct spanhash_top *spanhash_rehash(struct spanhash_top *orig)
 		}
 	}
 	free(orig);
-	return new;
+	return new_spanhash;
 }
 
 static struct spanhash_top *add_spanhash(struct spanhash_top *top,
-- 
2.16.0.rc1.238.g530d649a79-goog

