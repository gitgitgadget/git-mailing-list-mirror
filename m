Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8BDA35C1B4
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771848027; cv=none; b=JxssiRtgovvOURBhcxnIO78+KGr4s8MT9tNGNeW1X4T2yEeNuWu7j00UH615cleRWBsb37g0PsfobbC7kdL67KZrv8swdoPFpvh1XxE+AYOM8R3xY65oTjSeUwpLTYRCzNKKlgnpfsbqYbQlVMT4O9/buVQVBhuK3S93Yertodo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771848027; c=relaxed/simple;
	bh=vYXqCaAD3pcqchd+j5d0SfV/4M101ik6S/OkzjKTjnM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6tFBbFVnK4FXgraS//A1f50YheyjnqT/mq4JXdpwFYxPTEvdUcFhFOKcDZQvypgNP7Mto5j8xxxNUBDF5fGyxC1JhTwiiUbt+iismkSDJyUQnKXHNbMMnv26ZGyiigTn0tgQHjxPniwe1FnJxxqBV8iUgYasI/oO/m8xIFI0d4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=d9r9kGLo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tKtQBC+z; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="d9r9kGLo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tKtQBC+z"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EBCC8140019B;
	Mon, 23 Feb 2026 07:00:25 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 23 Feb 2026 07:00:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771848025;
	 x=1771934425; bh=BVQs4sz7otnmgNcvKEa9dK1LlCP0MPJqviNju6E2ZYo=; b=
	d9r9kGLouPMQz5G4ud5j+vwPdFzhD4VloFrbFSDJ3NOvdr27fVR+Bbg1zOcwpUAx
	oJLNx2nEJ+gdHhUyfHzFHQk7zKlCZnCFRnALCTBlIjQcV40btGY2/ZEih4IMS6rs
	gwtyN0SUQjIvLOPAoshQS+KCNwNobaua3xpavCEzU/kex4ts3RdPxPwqK4yxtbpF
	br9sajqzODARMIvBRYVv2kP4pcWbYif9Nirse1Lq0w+qYjPv7SsMSHSS1HxiLBlu
	1sPwoXS2WqahSqz7PQN6Ws+U2atqN6qcRiEcEYjsEHlTfkCRJFcsrPCmFrHdQ32i
	PLzxWMzKE4cUOcZNoEywWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771848025; x=
	1771934425; bh=BVQs4sz7otnmgNcvKEa9dK1LlCP0MPJqviNju6E2ZYo=; b=t
	KtQBC+zeYzJ2s+2Ps9b8AgtztrFOo/D0ugEOwPnD4E2TGUwa9fjITxoqeqYh2tuV
	AGdDwUT5ep8QHHuvyteZL9AKPl+510aZg8ZRVUZN6KTfkAdgiChN2Sw/3y9L+hFq
	/4zdM74/aZgmtQBLaaM/3eoIA+z7XBVRr6ELXBPYfVXA3JQ8eWdT/NQPYs2S3DuV
	hY/8EgbbD7Jz/+KvRkvyzBaY1WeS3tsV7XqAVHs/vmh17f3+Yecb6Sc8DZcYFkTS
	JPh6F3o7vZYWnKGoyOl3q4ZXXlOJ+3GzHcY7wMapxvdiha1YN5PNZhndyVTZNU3e
	u728YJ/dVCHAxCSRu7C0w==
X-ME-Sender: <xms:WUGcaTXZBR1rAYjZrX3NFOHoWvSKc5eA-jIv7tlso4YmAaDyNPV_-w>
    <xme:WUGcaTARUYHXGdcdQt-CYKoNaq99hhUpLXmjbmQzekiK43Oqzb3U7Y_PuR5wdpZBh
    9GScCo-ykPWux-WH5muQSOMh59m9PU6eHR6MV0IxO08Dw-EyPEcDw>
X-ME-Received: <xmr:WUGcacx5s5FIqX9qEPtkQfNydL6Y4t271AVDJh6HYb0DiqiVAw2hmxZ1M6XUr_LJgZ7N8QibzEefvAC2XFJgWMMLcVjl-JGaH5CaanSgQw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeejudejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehoshifrghlugdrsghuuggu
    vghnhhgrghgvnhesghhmgidruggv
X-ME-Proxy: <xmx:WUGcaYCnsmEUY-RZikS8U3KJqQOTcEcVfZVv7EYDuhzLrnRZOYPq-Q>
    <xmx:WUGcaRbN7--kCk_QRlOepeR9eM1y6dYP3lTdZwTx6diQ2nYwy-f10A>
    <xmx:WUGcaYiXNcpBsoBhO41ZPhNujxWMdJo1NrlGYqhEagX5r4OofpFlaQ>
    <xmx:WUGcab6-KE4agM5zx59nw4PIKZA1_FMxvMRFi4TYYPmA0pIOR9x7dw>
    <xmx:WUGcaUjMYZO_bS-ouX7efxO6I6jQsFJqfOliUVRSsS8HILv4ad22E1rg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Feb 2026 07:00:25 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9025c049 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 23 Feb 2026 12:00:24 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 23 Feb 2026 12:59:50 +0100
Subject: [PATCH v2 16/17] refs: replace `refs_for_each_namespaced_ref()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-pks-refs-for-each-unification-v2-16-515d48c8087b@pks.im>
References: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
In-Reply-To: <20260223-pks-refs-for-each-unification-v2-0-515d48c8087b@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
X-Mailer: b4 0.14.3

Replace calls to `refs_for_each_namespaced_ref()` with the newly
introduced `refs_for_each_ref_ext()` function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 http-backend.c |  8 ++++++--
 refs.c         | 11 -----------
 refs.h         |  8 --------
 upload-pack.c  | 11 +++++++----
 4 files changed, 13 insertions(+), 25 deletions(-)

diff --git a/http-backend.c b/http-backend.c
index 0122146df6..1a171c5c5a 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -565,9 +565,13 @@ static void get_info_refs(struct strbuf *hdr, char *arg UNUSED)
 		run_service(argv, 0);
 
 	} else {
+		struct refs_for_each_ref_options opts = {
+			.namespace = get_git_namespace(),
+		};
+
 		select_getanyfile(hdr);
-		refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-					     NULL, show_text_ref, &buf);
+		refs_for_each_ref_ext(get_main_ref_store(the_repository),
+				      show_text_ref, &buf, &opts);
 		send_strbuf(hdr, "text/plain", &buf);
 	}
 	strbuf_release(&buf);
diff --git a/refs.c b/refs.c
index ca7fc7289b..35a4925ac4 100644
--- a/refs.c
+++ b/refs.c
@@ -1951,17 +1951,6 @@ int refs_for_each_replace_ref(struct ref_store *refs, refs_for_each_cb cb, void
 	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
 }
 
-int refs_for_each_namespaced_ref(struct ref_store *refs,
-				 const char **exclude_patterns,
-				 refs_for_each_cb cb, void *cb_data)
-{
-	struct refs_for_each_ref_options opts = {
-		.exclude_patterns = exclude_patterns,
-		.namespace = get_git_namespace(),
-	};
-	return refs_for_each_ref_ext(refs, cb, cb_data, &opts);
-}
-
 static int qsort_strcmp(const void *va, const void *vb)
 {
 	const char *a = *(const char **)va;
diff --git a/refs.h b/refs.h
index b63775fa35..1b468c4ffb 100644
--- a/refs.h
+++ b/refs.h
@@ -527,14 +527,6 @@ int refs_for_each_ref_in_prefixes(struct ref_store *refs,
 				  const struct refs_for_each_ref_options *opts,
 				  refs_for_each_cb cb, void *cb_data);
 
-/*
- * references matching any pattern in "exclude_patterns" are omitted from the
- * result set on a best-effort basis.
- */
-int refs_for_each_namespaced_ref(struct ref_store *refs,
-				 const char **exclude_patterns,
-				 refs_for_each_cb fn, void *cb_data);
-
 /*
  * Normalizes partial refs to their fully qualified form.
  * Will prepend <prefix> to the <pattern> if it doesn't start with 'refs/'.
diff --git a/upload-pack.c b/upload-pack.c
index 7fe397b0d0..d21f0577f9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -610,7 +610,10 @@ static int allow_hidden_refs(enum allow_uor allow_uor)
 static void for_each_namespaced_ref_1(refs_for_each_cb fn,
 				      struct upload_pack_data *data)
 {
-	const char **excludes = NULL;
+	struct refs_for_each_ref_options opts = {
+		.namespace = get_git_namespace(),
+	};
+
 	/*
 	 * If `data->allow_uor` allows fetching hidden refs, we need to
 	 * mark all references (including hidden ones), to check in
@@ -621,10 +624,10 @@ static void for_each_namespaced_ref_1(refs_for_each_cb fn,
 	 * hidden references.
 	 */
 	if (allow_hidden_refs(data->allow_uor))
-		excludes = hidden_refs_to_excludes(&data->hidden_refs);
+		opts.exclude_patterns = hidden_refs_to_excludes(&data->hidden_refs);
 
-	refs_for_each_namespaced_ref(get_main_ref_store(the_repository),
-				     excludes, fn, data);
+	refs_for_each_ref_ext(get_main_ref_store(the_repository),
+			      fn, data, &opts);
 }
 
 

-- 
2.53.0.536.g309c995771.dirty

