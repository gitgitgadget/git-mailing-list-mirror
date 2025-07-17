Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26682046B3
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 04:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752728233; cv=none; b=N53jjLmF6e+y3+emAZ3dVkpQ9B9+Oq8I848NK6xE4F2gZNquK2PHXrcyJFrz++58ZzYN9yKO5id1SyGdieS3GuFlg/nHE8Wgtf3XMvY2frKCU21ZsVYzKmIBZWfqHTK7OBnsm+sUVw3iT67RjPiMRc3U9uuoc9RXQWd9Lx+F0oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752728233; c=relaxed/simple;
	bh=gEYLVVjLlEYVEw6IpIIEwdlG2EnvhD8g8dsSpr1bvYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YZal+Hn5NC4bHn+3D3z/gMhFkHBycUqzM/Eyy2sJnWmJT8odkYTF+W6x0bEWPYJWkkcemqfM+g5g9qOyhECwx1iLup+CNfqaHLxZkAc2iRjVHVg5x8u8ZIfjVH/wZsOM5zZEWY//lAbh3j3gKUY5HxdWypoCCbNhLFEHIr5r52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OXuuJMEO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KWvchwfC; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OXuuJMEO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KWvchwfC"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id EDF1F1D0019E;
	Thu, 17 Jul 2025 00:57:10 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 17 Jul 2025 00:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752728230;
	 x=1752814630; bh=xodGn4/BfvzyL+V0BsI9fSTISjUSQ/Vam/e+iXkE3ZI=; b=
	OXuuJMEOqv6e9k0XHL4Vfio+cCX1TXD4mB7oPajQhBr1eF39+ErV0Jkdve7K9Zbb
	f32uvCRMDQrezBIDe8eql4JBOP6twZ5roGTd0ZI+t9pdrOWC8ECTWcelxjYYOtyK
	wPj1+BiL4+RtcsHUsIwH6yReklkv6vcfHHyjY1CankSBAbOdBzRdBK9ALOSVUf9E
	TmxBQgH2ZwVtuXvxgtfv/EuX3yB6zQ6mczGBg1pqtwhuC4mscet9lrv+z/Qqx29L
	TyHKGQ2d+/Dt2MZQOtYLOmB/O1WhP0urrRYy5Hqve4XJUHCyYGqU8MC2Daj1Sn0K
	7Er2AVyNTkHrMCpuR1LpNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752728230; x=
	1752814630; bh=xodGn4/BfvzyL+V0BsI9fSTISjUSQ/Vam/e+iXkE3ZI=; b=K
	WvchwfCEDRsBem7og0NTEsmLGSpbyzkCb0AUhEByCxOCWCBw+QSsXnuypl3JckNN
	WKpc6I9laFWm7tV4Tz9c+XqxP34C695XEHdfdx8NVKUcObQ+LN7VpkPUpOsEKVit
	e0bTz9ZSzsLjTYS3tQPVY/iTuMDnJRZcl1XHHFbb7cuFYp/OnKi3SoLZWr7Vv1E+
	kOutzsRlJwGqdfb5sAmvRS0cou13sFJec2LpnBAG+Lpv9J81FSpiiBEkW9gDJhqY
	5ORll7Rw5dSKG/uHh1kQoSjggiyqzrnMxHbd7XzdhdCxq9S7xQ5Mu3gWxFAXC8zQ
	nFr1ZoMds1Z4dYRgES57g==
X-ME-Sender: <xms:poJ4aEI9I5mkWYYUCnpy8KpCOh7qE34-sccNxx9u0oaCM2Lm6gKkDA>
    <xme:poJ4aPrz9DTw0hQfbMs9T32EHgSDsv2U8S-PK2NM0rUKCvi0dElT_22aQ89WvIamB
    CzOhN_ug_yjl2Yq6Q>
X-ME-Received: <xmr:poJ4aLKnl9uUHQMerYN0JheO2mgrZ8Cwxm3emXvkrm4RDQfDV5zglYwIhj-z3gMtxcBvnJmd9oTa7spj9QbjPhMmcelsgEhZaZsVG8KmEBqT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleeikecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehkrghrthhhihhkrd
    dukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhm
    pdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:poJ4aMQPaum5FtgfrfJXzPdRuJt7uVcgrY26Vc5XxlC5yqUgWAqlUw>
    <xmx:poJ4aCso_zA7hEEk7SDL4wo4bhxAO2sXjpLWKPXO1eGB31HGXaeIQQ>
    <xmx:poJ4aFYEmMIfKY4vvP77Vbe3p7GQjzKswjxa5G-8xIhsQGCN6T_s-Q>
    <xmx:poJ4aAFeWPkegqWh9DpWBSvBMMjQoK4Dar-G9zWS19TAtbmBtFHBeA>
    <xmx:poJ4aNmLAPeAiBdxNBsyNJJqK4E2Hvr46rMazNnO5ZmQmMnGwt-HxG4k>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 00:57:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 935e4be4 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 17 Jul 2025 04:57:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 06:56:37 +0200
Subject: [PATCH v2 11/16] object-file: inline
 `for_each_loose_file_in_objdir_buf()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-object-file-wo-the-repository-v2-11-36d2cd6c700e@pks.im>
References: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
In-Reply-To: <20250717-pks-object-file-wo-the-repository-v2-0-36d2cd6c700e@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.14.2

The function `for_each_loose_file_in_objdir_buf()` is declared in our
headers, but it is not used anywhere else than in the corresponding code
file itself. Drop the declaration and inline the function into its only
caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c | 31 ++++++++-----------------------
 object-file.h |  5 -----
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/object-file.c b/object-file.c
index fc061c37bb5..5a936f17148 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1388,26 +1388,6 @@ int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 	return r;
 }
 
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-			    each_loose_object_fn obj_cb,
-			    each_loose_cruft_fn cruft_cb,
-			    each_loose_subdir_fn subdir_cb,
-			    void *data)
-{
-	int r = 0;
-	int i;
-
-	for (i = 0; i < 256; i++) {
-		r = for_each_file_in_obj_subdir(i, path, the_repository->hash_algo,
-						obj_cb, cruft_cb,
-						subdir_cb, data);
-		if (r)
-			break;
-	}
-
-	return r;
-}
-
 int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_object_fn obj_cb,
 				  each_loose_cruft_fn cruft_cb,
@@ -1418,10 +1398,15 @@ int for_each_loose_file_in_objdir(const char *path,
 	int r;
 
 	strbuf_addstr(&buf, path);
-	r = for_each_loose_file_in_objdir_buf(&buf, obj_cb, cruft_cb,
-					      subdir_cb, data);
-	strbuf_release(&buf);
+	for (int i = 0; i < 256; i++) {
+		r = for_each_file_in_obj_subdir(i, &buf, the_repository->hash_algo,
+						obj_cb, cruft_cb,
+						subdir_cb, data);
+		if (r)
+			break;
+	}
 
+	strbuf_release(&buf);
 	return r;
 }
 
diff --git a/object-file.h b/object-file.h
index 622e2b2bb7d..eca323f9736 100644
--- a/object-file.h
+++ b/object-file.h
@@ -98,11 +98,6 @@ int for_each_loose_file_in_objdir(const char *path,
 				  each_loose_cruft_fn cruft_cb,
 				  each_loose_subdir_fn subdir_cb,
 				  void *data);
-int for_each_loose_file_in_objdir_buf(struct strbuf *path,
-				      each_loose_object_fn obj_cb,
-				      each_loose_cruft_fn cruft_cb,
-				      each_loose_subdir_fn subdir_cb,
-				      void *data);
 
 /*
  * Iterate over all accessible loose objects without respect to

-- 
2.50.1.465.gcb3da1c9e6.dirty

