Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A866B1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 20:41:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeH1A3g (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 20:29:36 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43124 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726994AbeH1A3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 20:29:36 -0400
Received: by mail-pg1-f196.google.com with SMTP id v66-v6so109358pgb.10
        for <git@vger.kernel.org>; Mon, 27 Aug 2018 13:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=zhzyC86jamcIAKUp1vhGlOa+f9+2z11kBeOkNS8kz2Q=;
        b=CiXWxJEl5ylf5nYZGiQ3rdJdEyaXHc0AMarhOBR//dZcpVOb25FlPJvUHNgPzRzJS/
         qALh9fTBfoCEkGmzw0DainJi/rXQWG4QYMXWmtNzyoSzKXway00uo5DagsLBWU9Mu7Y2
         VEmNQgHjOHMdV9T56P+nZJtfjx4aeJ3SqObr/fLgxyIb1w5mtXhb1FYazqpzOrz4bBcX
         5yd6FHoAz+LBrQQgRr8yv8qAkjw6AdWr/G1hgzpxIDZOzX7JXJ+G4hzh9esm+acuLzMO
         KIDj7QT0i1mfx+1xMzNxMBUIrRZ8G1v3K1n15/2jql6dgIIg2LZhvasrue0hVdQTP57l
         LzvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=zhzyC86jamcIAKUp1vhGlOa+f9+2z11kBeOkNS8kz2Q=;
        b=aUSNC2Q/Wtjqvw0fH582FMNN9Qff1XO3KhG4xZ/m7TNVXy+7v77yfW0ZuSk9iyvpY+
         kE7x310Qe+pcsGB22zhGiuQ2gdB4Q6ggHm08XYJI12PXEbeEdfyvOBIkQDc3cLvHa0QR
         Banl9SJd81K5NXD543wdTY7QjHb8XOL6kR7VsOaQ5CZS/rf71wNBi7EB1FqOE5HvsB2h
         NwmPdfeAy71W1PCmXAxiaTIN2JXxAg2hJNZpxAQitNkYoX554dt3xiRFQCyZlA57Z2Xz
         P6z6n/kHvyW796OdMAs3P3QjXnRqh47BTtV3uZv6aLc3LGh9nO8RygFkAkgShHdJsfB8
         Gb9w==
X-Gm-Message-State: APzg51CBqNHqWn+KeRyGKV0sq2yJCh1R1Z9Q2FRgqML6cCyKH1nk0SlW
        lbH76ifjuyB5q86mBlfROQu2SbsE
X-Google-Smtp-Source: ANB0VdapBLADYnUAPNP69Wr/nADqyQ4poyGDqh5ys/mMotYTg/azDQ4dU9Q04cxPdjKoQF48UEQwpg==
X-Received: by 2002:a62:c288:: with SMTP id w8-v6mr15909352pfk.92.1535402483804;
        Mon, 27 Aug 2018 13:41:23 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id l84-v6sm352842pfg.3.2018.08.27.13.41.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 13:41:23 -0700 (PDT)
Date:   Mon, 27 Aug 2018 13:41:23 -0700 (PDT)
X-Google-Original-Date: Mon, 27 Aug 2018 20:41:14 GMT
Message-Id: <5e55669f4d035eee7f839a7b6559907f97e6b7c6.1535402479.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.25.git.gitgitgadget@gmail.com>
References: <pull.25.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 1/6] prio-queue: add 'peek' operation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When consuming a priority queue, it can be convenient to inspect
the next object that will be dequeued without actually dequeueing
it. Our existing library did not have such a 'peek' operation, so
add it as prio_queue_peek().

Add a reference-level comparison in t/helper/test-prio-queue.c
so this method is exercised by t0009-prio-queue.sh.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 prio-queue.c               |  9 +++++++++
 prio-queue.h               |  6 ++++++
 t/helper/test-prio-queue.c | 10 +++++++---
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index a078451872..d3f488cb05 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -85,3 +85,12 @@ void *prio_queue_get(struct prio_queue *queue)
 	}
 	return result;
 }
+
+void *prio_queue_peek(struct prio_queue *queue)
+{
+	if (!queue->nr)
+		return NULL;
+	if (!queue->compare)
+		return queue->array[queue->nr - 1].data;
+	return queue->array[0].data;
+}
diff --git a/prio-queue.h b/prio-queue.h
index d030ec9dd6..682e51867a 100644
--- a/prio-queue.h
+++ b/prio-queue.h
@@ -46,6 +46,12 @@ extern void prio_queue_put(struct prio_queue *, void *thing);
  */
 extern void *prio_queue_get(struct prio_queue *);
 
+/*
+ * Gain access to the "thing" that would be returned by
+ * prio_queue_get, but do not remove it from the queue.
+ */
+extern void *prio_queue_peek(struct prio_queue *);
+
 extern void clear_prio_queue(struct prio_queue *);
 
 /* Reverse the LIFO elements */
diff --git a/t/helper/test-prio-queue.c b/t/helper/test-prio-queue.c
index 9807b649b1..e817bbf464 100644
--- a/t/helper/test-prio-queue.c
+++ b/t/helper/test-prio-queue.c
@@ -22,9 +22,13 @@ int cmd__prio_queue(int argc, const char **argv)
 	struct prio_queue pq = { intcmp };
 
 	while (*++argv) {
-		if (!strcmp(*argv, "get"))
-			show(prio_queue_get(&pq));
-		else if (!strcmp(*argv, "dump")) {
+		if (!strcmp(*argv, "get")) {
+			void *peek = prio_queue_peek(&pq);
+			void *get = prio_queue_get(&pq);
+			if (peek != get)
+				BUG("peek and get results do not match");
+			show(get);
+		} else if (!strcmp(*argv, "dump")) {
 			int *v;
 			while ((v = prio_queue_get(&pq)))
 			       show(v);
-- 
gitgitgadget

