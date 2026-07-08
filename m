Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FED3B8D4A
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783532993; cv=none; b=ApnwzvzXtN0DvHz/qyzS4EzVQieRLASATEPv/2GDhLSDIcwfzssStyLVd98iSAm0ZKN9vzByHbP7M19v3LcL+7U0Cmf7aRM7PSfIUxQ7kGGhe3cmyKnLZCMe6+nnwD4mzIadX50/x/2aKQ1Z/cd2sWdnCMRG59RhZ0jIZIHTD28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783532993; c=relaxed/simple;
	bh=m3gp88U5GQ3cbfQ/aMsCGGDvBJJvAGFElxX0yYlV5fQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=D2n10X0gZpyjhvkQUVyxb0+UMzDAX//KHipG2Flqd84RnEHuCCQPnsvqz10U0Hrjd88D97ccae9wjXynu7/peLbnE7cafMkSaHmPI2rcD3+LS3Syuu/lHu7aCg7BhH/OX5qw7TGfksvuqxjsMAVLidnxHkEP4iZqwfb6gam3GQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eR34ay0N; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eR34ay0N"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c01089e8aso5654651cf.2
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783532991; x=1784137791; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jqj0hdie9pU20nCAuSn6rqeGzreS1cvyzpSS2FaZc08=;
        b=eR34ay0NXQ50TlHBcyixbfb9rKZcODk0N8Udpt6EGYXJO6GTSOzax0DaKJr3w5gEat
         Vg++1YbU7ei8OpoARc/NOBee5w4t8zrgRQMfRkjMb9oAR8yAVzDB3G33xgyK1oAdkd1H
         ehM3G8f2yUNwcVUTtnXocXENhfQOKLlkLQvn2vIuXxdHs4dtLwMF2c9S6LJ4g+8hn8Fi
         MGgdUpfEFqOFEPXSORLmQfyXGgZ9KvJVMyS9YcqatCnO6OOj+/R5Z6UJuYTycAef4tFq
         MzeAzFRoG0VKtPcYq1agbzvS3l66FLgeyhHAyleEAxc4XnFuZM8+a+cINdVv1EH3IdM5
         TVJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783532991; x=1784137791;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jqj0hdie9pU20nCAuSn6rqeGzreS1cvyzpSS2FaZc08=;
        b=JVLLNc2yzTEwHydS/rK/IJNAQ7nW1vnNYu1+CVGl0D/cf1MKsapJIYw0DSiFsylkzh
         GR50WqsRTXZhAYUeUr1pQ/9r9nbpSaokZL3MpnQVWbnmH/KxSj3d20by+Kz8gv4Sn7lM
         XoVj19kmgnAAxb4ODey37t2uwK49n8dycK7FfP14oHWwlDceL0Q5UikFnSXwAUk5BOIM
         3TX1T5RRSQSI23flXkBpLb3cl5BArRTS18lUrY7HXl+PO2i570Sm+DKmeDVCmfACJOBi
         MralV2IbsL7GNHhGNQbvrqZBOlWbN/onzjhu81c5emtur5qXjaiTO0X91uiRTXVtofLy
         z6AQ==
X-Gm-Message-State: AOJu0YyIddsJ2nqMxI1mB3lKXNExBdUFrHM+XuwT2c39oAWG2Hc7Kt3Y
	kwuUvohLfchX2bDIFrUstRZ6l1/UQHulUHVUhL5TjwApR/qLC2YNKD7/oG94FA==
X-Gm-Gg: AfdE7cmzJbaF861ShQ0kfVJfgbqB93pVSYuQOrC8DK2vmQERajYxCY2MFRBTOHAfE7J
	F10FLttM8YS1Qkz5bYwXfWWeWakIrZDIJK1FOz8bDp4Fjx8bRWpmn6dOQxLNnq0KRIir8Le88HM
	XwSc6CRWFVnLZw3AmAmKbVufAPP5XVpRZJJmtwkjxgRp8YVBuxgdXmVY7U8ra9RZx/acjLRB/ze
	kgy5eKfw5qlOl4jBswHX93slHHD7s3jNBf1bf/7HqcPFjnSQt8mwkmwxhv3V7iEEVVv/Coujk0h
	Kd51GkjON4OukxF/7RKg1f1P5POYdGaW8Ou/4iglAspPEukvhbdFz3peOVc85GLsYiQ1t/+ReZE
	uUsKuBxzW6+6I6UpvQdu2hoM46JpX49eBzeUZsxCULZpf3xE8qS02au4qGrEYGj0D1RkZDlCWu7
	t79uXOgjv/4+IT
X-Received: by 2002:a05:622a:102:b0:51c:1b78:b044 with SMTP id d75a77b69052e-51c8b41e37cmr41796111cf.61.1783532991402;
        Wed, 08 Jul 2026 10:49:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.55.47.18])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51c41b281c9sm142983861cf.9.2026.07.08.10.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 10:49:50 -0700 (PDT)
Message-Id: <ec6a448563ad57a40dd7d964ea4b2f9bb3dafb7c.1783532989.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
References: <pull.2132.v2.git.1780301856444.gitgitgadget@gmail.com>
	<pull.2132.v3.git.1783532989.gitgitgadget@gmail.com>
From: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jul 2026 17:49:47 +0000
Subject: [PATCH v3 1/2] prio-queue: extract sift_up() from prio_queue_put()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>,
    Kristofer Karlsson <krka@spotify.com>

From: Kristofer Karlsson <krka@spotify.com>

Factor out the bubble-up loop from prio_queue_put() into a
standalone sift_up() function.  This is a pure refactor with
no behavior change, preparing for reuse in a subsequent commit.

Suggested-by: Rene Scharfe <l.s.r@web.de>
Signed-off-by: Kristofer Karlsson <krka@spotify.com>
---
 prio-queue.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/prio-queue.c b/prio-queue.c
index 199775d5af..926fc04e85 100644
--- a/prio-queue.c
+++ b/prio-queue.c
@@ -37,6 +37,17 @@ void clear_prio_queue(struct prio_queue *queue)
 	queue->get_pending = 0;
 }
 
+static void sift_up(struct prio_queue *queue, size_t ix)
+{
+	while (ix) {
+		size_t parent = (ix - 1) / 2;
+		if (compare(queue, parent, ix) <= 0)
+			break;
+		swap(queue, parent, ix);
+		ix = parent;
+	}
+}
+
 static void sift_down_root(struct prio_queue *queue)
 {
 	size_t ix, child;
@@ -66,8 +77,6 @@ static inline void flush_get(struct prio_queue *queue)
 
 void prio_queue_put(struct prio_queue *queue, void *thing)
 {
-	size_t ix, parent;
-
 	if (queue->get_pending) {
 		queue->get_pending = 0;
 		queue->array[0].ctr = queue->insertion_ctr++;
@@ -85,13 +94,7 @@ void prio_queue_put(struct prio_queue *queue, void *thing)
 		return; /* LIFO */
 
 	/* Bubble up the new one */
-	for (ix = queue->nr_ - 1; ix; ix = parent) {
-		parent = (ix - 1) / 2;
-		if (compare(queue, parent, ix) <= 0)
-			break;
-
-		swap(queue, parent, ix);
-	}
+	sift_up(queue, queue->nr_ - 1);
 }
 
 void *prio_queue_get(struct prio_queue *queue)
-- 
gitgitgadget

