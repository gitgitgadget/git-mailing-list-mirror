Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793115450;
	b=zp8piqWSU0lrbAN3+HyaX09KCbC9lQhwF3OF9DkApi5ak7a3ChaxQyDuzU7apHJ4w6W6
	 UdrL4I96x6Hlwugim5eL1gjwHxGIDyAH6A9sKeZRier7LxDrU893neTNJXNZDCjPZgIxx
	 coNu0FWW9TTn/fC6MBsDFPQ1hax61EKRkcagHW/rbny7ZfbNw1T0J3ua9Xem9DWXN3nXa
	 /kwadsB7NgqWtmtRlhtg+m6oV2Zzo+b/M/wZZH2pll4YvIijxCuZ7llfaZsobhTQlz4s0
	 DNpvv4Lj/U0sezJLQJ7l3rkjn5h0uHBMebgWLOF9iNH4nOIC9Zkf1K0O3z6MqgagCEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793115450;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Kwyton4Mi7qmRDgUOQzVd61Mua6ApAI+S1lDD4jiS1Y=;
	b=nIF7ZEq+Ibr02lHQ7443/LUCcXOfegKNIAAf81T1vheoEKNkitiRlnJue03AVBC4Hu4T
	 r55B8gCBxx1jqVTt3N5OosZRH/EjudQVSYWlCXP9AZkpO09W2tOBYkNUFFePZwMUmYs95
	 0lymvekmSrHM5pE8nK2PlbvaeF3BX+RdVPlwMH7roYbauk+7pMP7kDw2lKwO4rTv6TeLi
	 kP2ivY6HzZ6ItIb7LURZHyvGcJXBobIinF5Tw2S5BGwtL4z+1fOM80hbY2EdTuzBQWQiK
	 ByWBr9OQwG3ySrjWJMEOiiaKtR61H2W0pKooWUVigo9IkddC9OpGFj3d42/nWn5DpIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+4si9SD;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419E1606A33B
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 15:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 419E1606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c+4si9SD
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso17987955e9.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793115448; x=1793720248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Kwyton4Mi7qmRDgUOQzVd61Mua6ApAI+S1lDD4jiS1Y=;
        b=c+4si9SDB12F2pxnGIgbmAvwGk53SoVvGeDHIWD8oKlSfyJc6YkzbIQi2xd2sh2DCV
         KQMeZ6qy9SIt7qL1lV6X1lCf4meuDjxcTUNEzo+L73HX+qvephZCO+hDQ9+I5so7ApNu
         BSAxjDVRR83bxfobfwWEMuYwMxiDbXFs3Q4e/AeH3G2N2Ouc0ZNgDS6ma31Fy7rmNi/l
         OXEr1P6eW1LZ8xy8TgQUdQ3Tb4/mUHeMKPzIIsIqXUzcJHlXDc4p3C5FHMqWwgBFxMNQ
         tFTgpHrG2BWixlNgNjcSAke9vKgTfMxtakTwJWa8xcsl8zirow/05SmO5gbIrdOyHmRB
         EnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793115448; x=1793720248;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Kwyton4Mi7qmRDgUOQzVd61Mua6ApAI+S1lDD4jiS1Y=;
        b=arHRAHOuDcMQ1jBQ8mTfQD27DLZzDbqV36vcwjmBIXew184ViAxNml5eKaOw4I81AR
         EUVXqBsZiChaUcYMWFCRZPlR6RRjJLH6s/f2ul+YZ/p4RBTWOomv5qlbQJne/qS86Lbf
         oB9cf02/SsYH+826YaNkUu6v4Dh95aaDn0oJmaaTK4CM9QYNjZuJpo6fp6a4meLwc3hf
         RcnjcXBbLrj9DbPYzYPRyXKNgRyUKS3hRuhlZUuR2S170Evmz0905i54RUblx72pVwha
         kKCnux960mJUEY3xAm0nOsWFO7PXFmxmoiioxaDY1hslz4xAkIaLPI9lwVPSg7RclQ38
         EMlw==
X-Gm-Message-State: AFq9FYIq/dV+/0uF0LsFVB4Evcg6IpgMpbk5irim5NV1sI0IVnx9wihn
	S8//vY31vT+cD1MaKRDCKWm5j3GDpjarsE+a7s5EH3ni99JTh1ORCRmuf1EqwBhT5UM=
X-Gm-Gg: AYBFou2hRj5hkP2eiyJSw3gnrSs/RL8rsR7zFRg+wtzVtx/k0aSyod6F0yS7Ogiq5WS
	prI0Kjx0reIyWj5d/cd9U92rY5c207sXQfxXQukz/eu+q4Xm5M3tKyQybz4Azy1BohrQ7/hpbH5
	PbIlRnDjiLNxXyY5dCRLPFneovs1LKGoyb9NLSWGW1ozwZYQNQ5AEvAmr4u1nXMgrRmSrF2oWHW
	liw5o26DgNiTGt75JsAQtz/pz6BUoEW432oKf1n7WvNsru/heS1/P27FeN8CNhUyxgcGHcIt+mo
	TlndUiQTXvFiGzFDq9IY/OC0bjg2PdQXDA8uKDIST/kBKpioTYGe/b7gn8bI9qi0VcLYWnAtXK/
	AglKpAb4G1lg2meuqLJl2uGtRfXjcjpbOhbwzRIL/2pK0D+egtJEkhif3wmR2vKjV0tWKwgga7D
	uhyVTI2M+I74VaAa8MGU/nCcAhzfHjkOnV7eLOMb0papyG+gi9PqPKFXzmb6QZIlHnvfkrN6MdW
	oxUVzEQ6eHL/nV7O+iBVUl6PGCtCPdu2HS9lV0AZNODxHbFaKP4O1m1EbLtYwwP0VOX3hvh5ZG1
	KtDKVNlstS0T+9+tJzGPDb4T2HANeGfFi5Nlb5fXVOSsvBQct8fQHm8q/0BIOMv41+ufztrpWNG
	GAiyQO+zpcnJh76in5jg3mvCCTCdCMsfR9W2WYxi6+dDPL0eFFlbxaHjnY7HE8yhInWgjNhhNZf
	G7
X-Received: by 2002:a05:600c:5253:b0:4a2:1a:a120 with SMTP id 5b1f17b1804b1-4a35ac99828mr190472005e9.6.1793115448296;
        Tue, 27 Oct 2026 08:37:28 -0700 (PDT)
Received: from localhost.localdomain ([104.28.251.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5697a7sm268484155e9.7.2026.10.27.08.37.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 27 Oct 2026 08:37:27 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: christian.couder@gmail.com,
	usmanakinyemi202@gmail.com,
	siddharthasthana31@gmail.com,
	kaartic.sivaraam@gmail.com,
	Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [Outreachy PATCH] negotiator/default: stop using the_repository
Date: Tue, 27 Oct 2026 16:34:28 +0100
Message-ID: <20261027153429.14131-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The default negotiator uses the_repository to parse commits,
clear marks, and walk refs. fetch_negotiator_init() already
has the repository but does not pass it down.

Give default_negotiator_init() a repository parameter, store
it on the negotiation state, and use it for those calls.
clear_marks() receives the repository through its callback
data. Drop USE_THE_REPOSITORY_VARIABLE.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 fetch-negotiator.c   |  2 +-
 negotiator/default.c | 26 +++++++++++++++-----------
 negotiator/default.h |  4 +++-
 3 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/fetch-negotiator.c b/fetch-negotiator.c
index be383367f5..1a2cf3f384 100644
--- a/fetch-negotiator.c
+++ b/fetch-negotiator.c
@@ -19,7 +19,7 @@ void fetch_negotiator_init(struct repository *r,
 		return;
 
 	case FETCH_NEGOTIATION_CONSECUTIVE:
-		default_negotiator_init(negotiator);
+		default_negotiator_init(negotiator, r);
 		return;
 	}
 }
diff --git a/negotiator/default.c b/negotiator/default.c
index 19cdf3808c..4684bed796 100644
--- a/negotiator/default.c
+++ b/negotiator/default.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "default.h"
 #include "../commit.h"
@@ -18,6 +16,7 @@
 static int marked;
 
 struct negotiation_state {
+	struct repository *repo;
 	struct prio_queue rev_list;
 	int non_common_revs;
 };
@@ -28,7 +27,7 @@ static void rev_list_push(struct negotiation_state *ns,
 	if (!(commit->object.flags & mark)) {
 		commit->object.flags |= mark;
 
-		if (repo_parse_commit(the_repository, commit))
+		if (repo_parse_commit(ns->repo, commit))
 			return;
 
 		prio_queue_put(&ns->rev_list, commit);
@@ -38,9 +37,10 @@ static void rev_list_push(struct negotiation_state *ns,
 	}
 }
 
-static int clear_marks(const struct reference *ref, void *cb_data UNUSED)
+static int clear_marks(const struct reference *ref, void *cb_data)
 {
-	struct object *o = deref_tag(the_repository, parse_object(the_repository, ref->oid),
+	struct repository *r = cb_data;
+	struct object *o = deref_tag(r, parse_object(r, ref->oid),
 				     ref->name, 0);
 
 	if (o && o->type == OBJ_COMMIT)
@@ -78,7 +78,7 @@ static void mark_common(struct negotiation_state *ns, struct commit *commit,
 			struct commit_list *parents;
 
 			if (!o->parsed && !dont_parse)
-				if (repo_parse_commit(the_repository, commit))
+				if (repo_parse_commit(ns->repo, commit))
 					continue;
 
 			for (parents = commit->parents;
@@ -119,7 +119,7 @@ static const struct object_id *get_rev(struct negotiation_state *ns)
 		commit = prio_queue_get(&ns->rev_list);
 		if (!commit)
 			return NULL;
-		repo_parse_commit(the_repository, commit);
+		repo_parse_commit(ns->repo, commit);
 		parents = commit->parents;
 
 		commit->object.flags |= POPPED;
@@ -179,7 +179,9 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
 
 static void have_sent(struct fetch_negotiator *n, struct commit *c)
 {
-	if (repo_parse_commit(the_repository, c))
+	struct negotiation_state *ns = n->data;
+
+	if (repo_parse_commit(ns->repo, c))
 		return;
 	mark_common(n->data, c, 0, 0);
 }
@@ -190,7 +192,8 @@ static void release(struct fetch_negotiator *n)
 	FREE_AND_NULL(n->data);
 }
 
-void default_negotiator_init(struct fetch_negotiator *negotiator)
+void default_negotiator_init(struct fetch_negotiator *negotiator,
+			     struct repository *r)
 {
 	struct negotiation_state *ns;
 	negotiator->known_common = known_common;
@@ -200,10 +203,11 @@ void default_negotiator_init(struct fetch_negotiator *negotiator)
 	negotiator->have_sent = have_sent;
 	negotiator->release = release;
 	negotiator->data = CALLOC_ARRAY(ns, 1);
+	ns->repo = r;
 	ns->rev_list.compare = compare_commits_by_commit_date;
 
 	if (marked)
-		refs_for_each_ref(get_main_ref_store(the_repository),
-				  clear_marks, NULL);
+		refs_for_each_ref(get_main_ref_store(r),
+				  clear_marks, r);
 	marked = 1;
 }
diff --git a/negotiator/default.h b/negotiator/default.h
index d23a8f2fb8..bd998eb32e 100644
--- a/negotiator/default.h
+++ b/negotiator/default.h
@@ -2,7 +2,9 @@
 #define NEGOTIATOR_DEFAULT_H
 
 struct fetch_negotiator;
+struct repository;
 
-void default_negotiator_init(struct fetch_negotiator *negotiator);
+void default_negotiator_init(struct fetch_negotiator *negotiator,
+			     struct repository *r);
 
 #endif

base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
-- 
2.56.0

