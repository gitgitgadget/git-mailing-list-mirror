Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE891F4C0
	for <e@80x24.org>; Thu, 17 Oct 2019 20:17:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437218AbfJQURd (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 Oct 2019 16:17:33 -0400
Received: from mail-vk1-f201.google.com ([209.85.221.201]:38142 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbfJQURd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Oct 2019 16:17:33 -0400
Received: by mail-vk1-f201.google.com with SMTP id k132so1412042vka.5
        for <git@vger.kernel.org>; Thu, 17 Oct 2019 13:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SkWoFSW9/ZnGBNqh9eBUlPVU68AMoA32DFzs1tDlqsg=;
        b=nO05626in75120Wd8npkKPuwJzxImKKqqAbbVwFtPzmY70Yjp3sDjDGPpLqk0qxEvK
         aJGrGPXmR05Ei8UGks+9NMdrDhoGlGmUB7rC+5yeTE+T2Zu+/BgOt4C/c21WzJtIt0bE
         umJiX1vVQmZxwyDB0+VzLfEFSTjUZEQjS1vJM2jIrWxZvJM2I5X2pd+7+LwKZPn45vuF
         lAxylsBjUO8kIlUkN63LYNFW1tKh977nLt7S/bbETpejg2QBXAdoQ9robrUT9wCit1ow
         I1aDnI8PHeVK22LZiy3yFhh7PyLx7ph6ztg4p4AXd/l/45ZGUYOwmYGk02MYT9m7o6U/
         I6jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SkWoFSW9/ZnGBNqh9eBUlPVU68AMoA32DFzs1tDlqsg=;
        b=QDDPGDNp5v84k957DvtAN885WbAj7UjWDHCrVInOrxVTSxuRs6RQNH6NtEDHxfSrkV
         O3lo/vjUcFtHGwi526Q9ydgaMjsVDYVSi8jJfgiy7zAu3KLqXCTbh4x4CAzTLXLBSXO2
         Db8ZVoNAoWBk/7YRyBb77Gct2Iyz6Xu4xmBSucmp+Twi/6i7RczeTOwb6+yztApsVfM1
         OM0zjC0SFTNLBIj8/Zd2m2BhJ69aw1dUb/PYbF8a5CZxpbtVgLFMewlxLcZHTOGnfN7W
         9exKsMueiH0K6y4UJnFN9+IF6x+AECnOttr7VWjmZ57Q6Ik/oGXiVQBEBG0JRCnssOjI
         9tAA==
X-Gm-Message-State: APjAAAV7Y42K4tpkvYd5kyu5NI7OF4tDHSGGV1acAisEDLPz6iQuA+Ys
        85IgXUmrBhBDcpM71Wj0xi80vwo+rXURPovynTslytUO6R8TnTGyLZggeXL4CJ6HA70SC87Lwwg
        ByXJWnIK20MiDdQPaaT0sqws+PPALYBkrD/Z1gT9tGPRt8ky8h0rgDQOa6gDFd9CB69k0pAespe
        dD
X-Google-Smtp-Source: APXvYqyKLGcLNwLaAB8ka+0W4Mx06xipzUfUwuEOKIC9MOlMOXQH2kDn6CR/C+eq+C42mE6Oeo/9sDqCR6Ffijm/2M33
X-Received: by 2002:ab0:55c8:: with SMTP id w8mr3288316uaa.66.1571343451775;
 Thu, 17 Oct 2019 13:17:31 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:17:13 -0700
In-Reply-To: <cover.1571343096.git.jonathantanmy@google.com>
Message-Id: <3359b66b841e7eabdc45d3d937e97208b22e2901.1571343096.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1570663470.git.jonathantanmy@google.com> <cover.1571343096.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.23.0.866.gb869b98d4c-goog
Subject: [PATCH v2 4/7] index-pack: remove redundant child field
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        peff@peff.net
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is refactoring 1 of 2 to simplify struct base_data.

In index-pack, each thread maintains a doubly-linked list of the delta
chain that it is currently processing (the "base" and "child" pointers
in struct base_data). When a thread exceeds the delta base cache limit
and needs to reclaim memory, it uses the "child" pointers to traverse
the lineage, reclaiming the memory of the eldest delta bases first.

A subsequent patch will perform memory reclaiming in a different way and
will thus no longer need the "child" pointer. Because the "child"
pointer is redundant even now, remove it so that the aforementioned
subsequent patch will be clearer. In the meantime, reclaim memory in the
reverse order of the "base" pointers.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c | 41 ++++++++++++++++++++++-------------------
 1 file changed, 22 insertions(+), 19 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 296804230c..220e1e3693 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -34,7 +34,6 @@ struct object_stat {
 
 struct base_data {
 	struct base_data *base;
-	struct base_data *child;
 	struct object_entry *obj;
 	void *data;
 	unsigned long size;
@@ -44,7 +43,6 @@ struct base_data {
 
 struct thread_local {
 	pthread_t thread;
-	struct base_data *base_cache;
 	size_t base_cache_used;
 	int pack_fd;
 };
@@ -380,27 +378,37 @@ static void free_base_data(struct base_data *c)
 	}
 }
 
-static void prune_base_data(struct base_data *retain)
+static void prune_base_data(struct base_data *youngest_child)
 {
 	struct base_data *b;
 	struct thread_local *data = get_thread_data();
-	for (b = data->base_cache;
-	     data->base_cache_used > delta_base_cache_limit && b;
-	     b = b->child) {
-		if (b->data && b != retain)
-			free_base_data(b);
+	struct base_data **ancestry = NULL;
+	size_t nr = 0, alloc = 0;
+	ssize_t i;
+
+	if (data->base_cache_used <= delta_base_cache_limit)
+		return;
+
+	/*
+	 * Free all ancestors of youngest_child until we have enough space,
+	 * starting with the oldest. (We cannot free youngest_child itself.)
+	 */
+	for (b = youngest_child->base; b != NULL; b = b->base) {
+		ALLOC_GROW(ancestry, nr + 1, alloc);
+		ancestry[nr++] = b;
 	}
+	for (i = nr - 1;
+	     i >= 0 && data->base_cache_used > delta_base_cache_limit;
+	     i--) {
+		if (ancestry[i]->data)
+			free_base_data(ancestry[i]);
+	}
+	free(ancestry);
 }
 
 static void link_base_data(struct base_data *base, struct base_data *c)
 {
-	if (base)
-		base->child = c;
-	else
-		get_thread_data()->base_cache = c;
-
 	c->base = base;
-	c->child = NULL;
 	if (c->data)
 		get_thread_data()->base_cache_used += c->size;
 	prune_base_data(c);
@@ -408,11 +416,6 @@ static void link_base_data(struct base_data *base, struct base_data *c)
 
 static void unlink_base_data(struct base_data *c)
 {
-	struct base_data *base = c->base;
-	if (base)
-		base->child = NULL;
-	else
-		get_thread_data()->base_cache = NULL;
 	free_base_data(c);
 }
 
-- 
2.23.0.866.gb869b98d4c-goog

