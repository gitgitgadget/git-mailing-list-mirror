Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A523A986
	for <git@vger.kernel.org>; Wed,  2 Apr 2025 11:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743592436; cv=none; b=YgT7wXygcF9bxh5s2iVEKlQHbU7pTv5sa1c1sKu23RixuKkgE6lqLun59Esf08aJfd4Gu8FH6s380Ob5mceTUkkPzuiM+07PSxQFMwIbjxOdf6SewKzWSRNyNeDPqz5hNNr6G6By5+v8PtJSpClVTnCum3j67dmcCNbdRcBzJO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743592436; c=relaxed/simple;
	bh=1AS0FqDgJ+cYFLj1oyGcN62UE6oZUhiuCKnwxrjLH6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oGSHuFtNFacxLgqsOQT+92VXWrvAPCXYxxYI5+Saj67EPRIKOkUf/GsFcyJb8EEJiL53nZLH1GVzYrD2QJzUNiN03Wo7vgU98T7FZ47tnslGqiRwA5iV0ZH8gKH0k5Xy6rYxgX0V2ZVMfFllfWXrSZ5p4uSdVItQnKdxhiFTUwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pIXMOWRV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QwwZEQ0F; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pIXMOWRV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QwwZEQ0F"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C9F792540233;
	Wed,  2 Apr 2025 07:13:53 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Wed, 02 Apr 2025 07:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743592433;
	 x=1743678833; bh=en1/fnjEDFXY83sKWg+q99E6BogXAT16Z56tqfnO/rE=; b=
	pIXMOWRVxlzxRasZsR/Js7nQqa9vhrSi+2rC/iUEtPPuOn1w7FFkW/xm2YWDqirK
	0YvH9Lb7UNqBOCx3Rqjp/ducsIkL1WdgI8db3lQ3Vf7HR5xOc5z0eWLv8LnxZjgY
	oGePWxxMIPWHQCF89TUylSlcP+WGsMgn98qFhW86RMjPdOH7yzprWb6eRDejcAC9
	LQEYCTO6QDhOEuVf+bHx4PXudBlBWZMFrU32M1PYtjIO3EyRAi8LB/6DzuAUUeL5
	k7k3Hyod6IQvlLquZSdnQrtT0l0PEACuk1B0ExwoJa06ncdlEfxoDuGgi3JkQvYt
	WoHMF4bPaHepZYpBb+lksw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743592433; x=
	1743678833; bh=en1/fnjEDFXY83sKWg+q99E6BogXAT16Z56tqfnO/rE=; b=Q
	wwZEQ0FsGkw6eu4SI6xOAvXOcWh4KnP11m8S20CaLmxDMFmV7NAtYYz05T7sUjQp
	7MFd2ROQFEhSN+H6DUjIwu43xg00R7EcDqtpr0DuFT9beqhGtwd9vTuourv9BPOo
	BihB+up+DR/8qHbdEkAxbRBYc7VTRPEahklUbIlZiK0GhQAR4evOXeV40SLw7Axr
	EHDP7CtwX2Z0mBYibPAr5Dm6UCyRNN8RgJ/ZXTgb5LqmI8VnXOggwHYw2i28NT1i
	dghFiPWfRPsW2bAwlWTJMQCd4vjpY1+mt322HFk7l/64JO0wlYryoZBQjaUnlRFX
	e0pTRqMtJx/kqw+Gpo9WA==
X-ME-Sender: <xms:8RvtZx5qAMf6jiKPJSwzVsWugq72l9nkhXnmSQzKfffZnWUc7E3rDw>
    <xme:8RvtZ-4-IjrdNqVxas8Ra0ldlD4fqtuLNNx2YUU9SkonqRx5FhY6gZfiuQUKxTloy
    hvd4scUhzSTaYgdtw>
X-ME-Received: <xmr:8RvtZ4f35uNZ7apoeVc0QOEf5OuGcrw8OKg7CrSMX-09VlWyEY7U5hEuDM_FmrnHXzPdh9RXEwXACZrWpHYzdouP4KCdI5MQCz0BQxbr-6-51A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehheefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohho
    nhesihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtoh
    hmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:8RvtZ6IaEhMURuS4p8IJd0fqZgMDHtXMn-_Q4dm09eRqKlKRw4rfsw>
    <xmx:8RvtZ1KnPqgEyPICyNcQk3xblDGeJBvcWSxrf_-PAI6L3FiP6MO91w>
    <xmx:8RvtZzyGf8kRiHNUMgzMdHDsN8FxlIXwyDxfVizMUB6kpooZRsGgeA>
    <xmx:8RvtZxKh05cZ0hzJps5QYTxsMO3DV4A8mtFELyM4EHO1zYfQdUhpKg>
    <xmx:8RvtZ5Y6gB8SJV99xzUKesn3cBCFOD-jVR0_WDfz7n8quBIKo71-yTir>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:13:52 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8611b9ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Apr 2025 11:13:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 02 Apr 2025 13:13:45 +0200
Subject: [PATCH v3 10/11] builtin/cat-file: deduplicate logic to iterate
 over all objects
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250402-pks-cat-file-object-type-filter-v3-10-4da6bb21871c@pks.im>
References: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
In-Reply-To: <20250402-pks-cat-file-object-type-filter-v3-0-4da6bb21871c@pks.im>
To: git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Pull out a common function that allows us to iterate over all objects in
a repository. Right now the logic is trivial and would only require two
function calls, making this refactoring a bit pointless. But in the next
commit we will iterate on this logic to make use of bitmaps, so this is
about to become a bit more complex.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/cat-file.c | 85 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 37 deletions(-)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 0f17175a549..b0c758eca02 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -642,25 +642,18 @@ static int batch_object_cb(const struct object_id *oid, void *vdata)
 	return 0;
 }
 
-static int collect_loose_object(const struct object_id *oid,
-				const char *path UNUSED,
-				void *data)
-{
-	oid_array_append(data, oid);
-	return 0;
-}
-
-static int collect_packed_object(const struct object_id *oid,
-				 struct packed_git *pack UNUSED,
-				 uint32_t pos UNUSED,
-				 void *data)
+static int collect_object(const struct object_id *oid,
+			  struct packed_git *pack UNUSED,
+			  off_t offset UNUSED,
+			  void *data)
 {
 	oid_array_append(data, oid);
 	return 0;
 }
 
 static int batch_unordered_object(const struct object_id *oid,
-				  struct packed_git *pack, off_t offset,
+				  struct packed_git *pack,
+				  off_t offset,
 				  void *vdata)
 {
 	struct object_cb_data *data = vdata;
@@ -674,23 +667,6 @@ static int batch_unordered_object(const struct object_id *oid,
 	return 0;
 }
 
-static int batch_unordered_loose(const struct object_id *oid,
-				 const char *path UNUSED,
-				 void *data)
-{
-	return batch_unordered_object(oid, NULL, 0, data);
-}
-
-static int batch_unordered_packed(const struct object_id *oid,
-				  struct packed_git *pack,
-				  uint32_t pos,
-				  void *data)
-{
-	return batch_unordered_object(oid, pack,
-				      nth_packed_object_offset(pack, pos),
-				      data);
-}
-
 typedef void (*parse_cmd_fn_t)(struct batch_options *, const char *,
 			       struct strbuf *, struct expand_data *);
 
@@ -823,6 +799,45 @@ static void batch_objects_command(struct batch_options *opt,
 
 #define DEFAULT_FORMAT "%(objectname) %(objecttype) %(objectsize)"
 
+typedef int (*for_each_object_fn)(const struct object_id *oid, struct packed_git *pack,
+				  off_t offset, void *data);
+
+struct for_each_object_payload {
+	for_each_object_fn callback;
+	void *payload;
+};
+
+static int batch_one_object_loose(const struct object_id *oid,
+				  const char *path UNUSED,
+				  void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, NULL, 0, payload->payload);
+}
+
+static int batch_one_object_packed(const struct object_id *oid,
+				   struct packed_git *pack,
+				   uint32_t pos,
+				   void *_payload)
+{
+	struct for_each_object_payload *payload = _payload;
+	return payload->callback(oid, pack, nth_packed_object_offset(pack, pos),
+				 payload->payload);
+}
+
+static void batch_each_object(for_each_object_fn callback,
+			      unsigned flags,
+			      void *_payload)
+{
+	struct for_each_object_payload payload = {
+		.callback = callback,
+		.payload = _payload,
+	};
+	for_each_loose_object(batch_one_object_loose, &payload, 0);
+	for_each_packed_object(the_repository, batch_one_object_packed,
+			       &payload, flags);
+}
+
 static int batch_objects(struct batch_options *opt)
 {
 	struct strbuf input = STRBUF_INIT;
@@ -877,18 +892,14 @@ static int batch_objects(struct batch_options *opt)
 
 			cb.seen = &seen;
 
-			for_each_loose_object(batch_unordered_loose, &cb, 0);
-			for_each_packed_object(the_repository, batch_unordered_packed,
-					       &cb, FOR_EACH_OBJECT_PACK_ORDER);
+			batch_each_object(batch_unordered_object,
+					  FOR_EACH_OBJECT_PACK_ORDER, &cb);
 
 			oidset_clear(&seen);
 		} else {
 			struct oid_array sa = OID_ARRAY_INIT;
 
-			for_each_loose_object(collect_loose_object, &sa, 0);
-			for_each_packed_object(the_repository, collect_packed_object,
-					       &sa, 0);
-
+			batch_each_object(collect_object, 0, &sa);
 			oid_array_for_each_unique(&sa, batch_object_cb, &cb);
 
 			oid_array_clear(&sa);

-- 
2.49.0.604.gff1f9ca942.dirty

