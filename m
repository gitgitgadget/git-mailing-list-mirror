Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19C017B505
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683700; cv=none; b=Kq11KWdY6wrd+CNEm/fj7iV6LKhS3b0pZf/1Y6NU2YFGtn5H/DF85kqCii8I/vNtcvazlM6MhJFTdd8Znoa8wrKJn0iKrlsAfu1pV1V84ufVaiHDdtt2vtS5OkIqc9ndI6LfFLsypZXb9dtCN+10Lh313i0tPI8ebAM2311Ty4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683700; c=relaxed/simple;
	bh=zemuHgfyboDsmNFZU4YRfBfq1hQBMj4nq4qPIOSPRqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OyxJdZ1kDyzEMmCSPHMYjg2p9qEkiFF3tJVru8PtD4tn/fCIBl2oX+aEba+JXWdSZU+63GfleJBriZTCsIKTW8fzvS2tkI0EAVOxqtU3kbDb8SAWOBmvazvr6LdQLYCDN2gNtOd4vyhN0+Dy075rRmFX5W6Ic4mESiu0UQ3EWfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hhh1gRg1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pCf8gYvp; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hhh1gRg1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pCf8gYvp"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E729B1140216;
	Mon, 30 Sep 2024 04:08:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 04:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683697; x=1727770097; bh=jQ6xmM4bIR
	2N2mFzsoYHsLo7VOT35aCHxgBGgFaSkhs=; b=hhh1gRg149lnum4vryba9BG3rD
	9+KcstWrpIE5RqQeaYakuDfYekLnzXM9zvIQ1wUZcN05GOmeq5sOxgi5sDuifiAE
	vItKhvCazBDKIE812ea+kLLQ1Jrw6BIkeGmk/xvw1exk1LyBv3BjmfHBcGrQScSF
	mypuZca7ckyz1zy2M493P7hq3qRSbMz01srQgEjxyrB5A3y8MBiuRSvzksWPwxMK
	3oAquU232ZHErG9WNBnhU2Sb25lA+Vr7tEfkFt6mqOerBpxQuyicbxirGvofBJji
	ce2+N5JpcNxBLS861imjIeeZcF7W0U79Usj3/i+2eytCfpsDQmhUUh/Lv4kQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683697; x=1727770097; bh=jQ6xmM4bIR2N2mFzsoYHsLo7VOT3
	5aCHxgBGgFaSkhs=; b=pCf8gYvpMBHT2qgLBqakOe3PSDm4LAeVH1c2rYdLxUn+
	8p31mXlx9Vdvka5hcTwsDPhgQkuVCFsDR86lfR8lTiy2Jzo0lc/MYNl/puNOWogK
	v2emdUfj2JyLeC2Dek/TrqFaZ+RQgm3sA9Dmk/Mohd4957v+GX20Ng01/UMHpC2q
	VIjdEtgc82//5uh2hB+eF1HXjulSSPSl9fewmi53igg0w9ckkNfIfQV3uSgMgQb1
	LrTz+KA29goM0xuUk73/A3jUQaP/yLYe1aPypJmbSxpHZBxFB5rvd6n5GNZ71Mbz
	G3IpLLbBcT7rZQN+y5ibvnhG0TYLOSv1n7chCxO7sA==
X-ME-Sender: <xms:cVz6ZpG6w9RXM5HxniLGyg319yKexjP0MbQSjidfzlu7dNaba_RM3A>
    <xme:cVz6ZuXRlnQe04EoiBgFChVLEETl8ChefdtyiZE0s-0sMGoFEN49BN2Jbcw-VAABK
    __Oxhq8XQMfCLUKfQ>
X-ME-Received: <xmr:cVz6ZrJ0RzHl_azoHLuROVY2IkZLdLh2tXIDNETGYkMMzKCKu2hV64svMIDlyV0Are9abfzrnY48ChmqKjtql1j3mTv3ykFr6lJsHAvSiQs_AsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeeuieeuudfhvefhkeeigfekgfegleejtdffteehheethffhvdel
    udekkeffhfffvdenucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgs
    pghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghthh
    homhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
X-ME-Proxy: <xmx:cVz6ZvEHQGMgA0towdAGazDJUCH6wrp1XTEOICyzR4hWb0qFscrRuA>
    <xmx:cVz6ZvWr1VX6yAaIRU1_BKov64DXMAAOSCsUjIPo7vYCnU50Kh_1dg>
    <xmx:cVz6ZqPxOgEHdaYNQ-y7F-TFmR-qH8igTyUpZtFdARCxxbuMUrvetw>
    <xmx:cVz6Zu3lEgokMy040_fJv93tql50wTCbHp_bkCgzUbkj84trwYinQg>
    <xmx:cVz6ZlxlcMzNFk_d4d-1Ub1NNFYt67iXQj651L1dzIvjmD5QwmIDY1hp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:08:16 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 29de366e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:07:30 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:08:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 02/22] reftable/basics: merge "publicbasics" into "basics"
Message-ID: <4dcdf1d48ecf9a05cfa643d5a6165240898811a7.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

The split between "basics" and "publicbasics" is somewhat arbitrary and
not in line with how we typically structure code in the reftable
library. While we do indeed split up headers into a public and internal
part, we don't do that for the compilation unit itself. Furthermore, the
declarations for "publicbasics.c" are in "reftable-malloc.h", which
isn't in line with our naming schema, either.

Fix these inconsistencies by:

  - Merging "publicbasics.c" into "basics.c".

  - Renaming "reftable-malloc.h" to "reftable-basics.h" as the public
    header.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Makefile                   |  1 -
 reftable/basics.c          | 55 +++++++++++++++++++++++++++++++
 reftable/basics.h          |  3 ++
 reftable/publicbasics.c    | 66 --------------------------------------
 reftable/reftable-basics.h | 18 +++++++++++
 reftable/reftable-malloc.h | 18 -----------
 6 files changed, 76 insertions(+), 85 deletions(-)
 delete mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reftable-basics.h
 delete mode 100644 reftable/reftable-malloc.h

diff --git a/Makefile b/Makefile
index e3abf0ba83..39b10923d4 100644
--- a/Makefile
+++ b/Makefile
@@ -2683,7 +2683,6 @@ REFTABLE_OBJS += reftable/error.o
 REFTABLE_OBJS += reftable/block.o
 REFTABLE_OBJS += reftable/blocksource.o
 REFTABLE_OBJS += reftable/iter.o
-REFTABLE_OBJS += reftable/publicbasics.o
 REFTABLE_OBJS += reftable/merged.o
 REFTABLE_OBJS += reftable/pq.o
 REFTABLE_OBJS += reftable/reader.o
diff --git a/reftable/basics.c b/reftable/basics.c
index 0058619ca6..cf072935c8 100644
--- a/reftable/basics.c
+++ b/reftable/basics.c
@@ -7,6 +7,49 @@ license that can be found in the LICENSE file or at
 */
 
 #include "basics.h"
+#include "reftable-basics.h"
+
+static void *(*reftable_malloc_ptr)(size_t sz);
+static void *(*reftable_realloc_ptr)(void *, size_t);
+static void (*reftable_free_ptr)(void *);
+
+void *reftable_malloc(size_t sz)
+{
+	if (reftable_malloc_ptr)
+		return (*reftable_malloc_ptr)(sz);
+	return malloc(sz);
+}
+
+void *reftable_realloc(void *p, size_t sz)
+{
+	if (reftable_realloc_ptr)
+		return (*reftable_realloc_ptr)(p, sz);
+	return realloc(p, sz);
+}
+
+void reftable_free(void *p)
+{
+	if (reftable_free_ptr)
+		reftable_free_ptr(p);
+	else
+		free(p);
+}
+
+void *reftable_calloc(size_t nelem, size_t elsize)
+{
+	size_t sz = st_mult(nelem, elsize);
+	void *p = reftable_malloc(sz);
+	memset(p, 0, sz);
+	return p;
+}
+
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *))
+{
+	reftable_malloc_ptr = malloc;
+	reftable_realloc_ptr = realloc;
+	reftable_free_ptr = free;
+}
 
 void put_be24(uint8_t *out, uint32_t i)
 {
@@ -121,3 +164,15 @@ int common_prefix_size(struct strbuf *a, struct strbuf *b)
 
 	return p;
 }
+
+int hash_size(uint32_t id)
+{
+	switch (id) {
+	case 0:
+	case GIT_SHA1_FORMAT_ID:
+		return GIT_SHA1_RAWSZ;
+	case GIT_SHA256_FORMAT_ID:
+		return GIT_SHA256_RAWSZ;
+	}
+	abort();
+}
diff --git a/reftable/basics.h b/reftable/basics.h
index c8fec68d4e..4e2e76014a 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -14,6 +14,7 @@ license that can be found in the LICENSE file or at
  */
 
 #include "system.h"
+#include "reftable-basics.h"
 
 /* Bigendian en/decoding of integers */
 
@@ -71,4 +72,6 @@ void *reftable_calloc(size_t nelem, size_t elsize);
 struct strbuf;
 int common_prefix_size(struct strbuf *a, struct strbuf *b);
 
+int hash_size(uint32_t id);
+
 #endif
diff --git a/reftable/publicbasics.c b/reftable/publicbasics.c
deleted file mode 100644
index 44b84a125e..0000000000
--- a/reftable/publicbasics.c
+++ /dev/null
@@ -1,66 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#include "system.h"
-#include "reftable-malloc.h"
-
-#include "basics.h"
-
-static void *(*reftable_malloc_ptr)(size_t sz);
-static void *(*reftable_realloc_ptr)(void *, size_t);
-static void (*reftable_free_ptr)(void *);
-
-void *reftable_malloc(size_t sz)
-{
-	if (reftable_malloc_ptr)
-		return (*reftable_malloc_ptr)(sz);
-	return malloc(sz);
-}
-
-void *reftable_realloc(void *p, size_t sz)
-{
-	if (reftable_realloc_ptr)
-		return (*reftable_realloc_ptr)(p, sz);
-	return realloc(p, sz);
-}
-
-void reftable_free(void *p)
-{
-	if (reftable_free_ptr)
-		reftable_free_ptr(p);
-	else
-		free(p);
-}
-
-void *reftable_calloc(size_t nelem, size_t elsize)
-{
-	size_t sz = st_mult(nelem, elsize);
-	void *p = reftable_malloc(sz);
-	memset(p, 0, sz);
-	return p;
-}
-
-void reftable_set_alloc(void *(*malloc)(size_t),
-			void *(*realloc)(void *, size_t), void (*free)(void *))
-{
-	reftable_malloc_ptr = malloc;
-	reftable_realloc_ptr = realloc;
-	reftable_free_ptr = free;
-}
-
-int hash_size(uint32_t id)
-{
-	switch (id) {
-	case 0:
-	case GIT_SHA1_FORMAT_ID:
-		return GIT_SHA1_RAWSZ;
-	case GIT_SHA256_FORMAT_ID:
-		return GIT_SHA256_RAWSZ;
-	}
-	abort();
-}
diff --git a/reftable/reftable-basics.h b/reftable/reftable-basics.h
new file mode 100644
index 0000000000..6e8e636b71
--- /dev/null
+++ b/reftable/reftable-basics.h
@@ -0,0 +1,18 @@
+/*
+ * Copyright 2020 Google LLC
+ *
+ * Use of this source code is governed by a BSD-style
+ * license that can be found in the LICENSE file or at
+ * https://developers.google.com/open-source/licenses/bsd
+*/
+
+#ifndef REFTABLE_BASICS_H
+#define REFTABLE_BASICS_H
+
+#include <stddef.h>
+
+/* Overrides the functions to use for memory management. */
+void reftable_set_alloc(void *(*malloc)(size_t),
+			void *(*realloc)(void *, size_t), void (*free)(void *));
+
+#endif
diff --git a/reftable/reftable-malloc.h b/reftable/reftable-malloc.h
deleted file mode 100644
index 5f2185f1f3..0000000000
--- a/reftable/reftable-malloc.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/*
-Copyright 2020 Google LLC
-
-Use of this source code is governed by a BSD-style
-license that can be found in the LICENSE file or at
-https://developers.google.com/open-source/licenses/bsd
-*/
-
-#ifndef REFTABLE_H
-#define REFTABLE_H
-
-#include <stddef.h>
-
-/* Overrides the functions to use for memory management. */
-void reftable_set_alloc(void *(*malloc)(size_t),
-			void *(*realloc)(void *, size_t), void (*free)(void *));
-
-#endif
-- 
2.46.2.852.g229c0bf0e5.dirty

