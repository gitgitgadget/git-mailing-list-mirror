Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA5C389DF3
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 08:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780302061; cv=none; b=MdhGi6fb0vuTIObQceSFKM3CDQMyV9dsPxPx9w31KB9hiZHyUNLEApyzNo6APqXlP6iuIwaVWTrwF8pNbLWr6QDboVHoiqVwR7NadmpJuQlZ8fOmTrNeQotjEiSxeun5wf3hT42DGa25kRczJI+QVMlThitv/38jEdU0/zetYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780302061; c=relaxed/simple;
	bh=bEjv4CA3J1B/mMIt+kFR9T8amx88qeLFiWPwyHin66g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fr7kde3EEx6kqgXyG5QMwviMRLyzmmJfIZnZgOqgZvZiR3Zum+nY1U/H5W2u/zZ3lI1CrHmMpKSiryDcO3gWj6NT6EhrlnWRFuNDcAMuVCf9byuSh+IfyQuCMKjOyDm4lHTHiZri/tCY0pyYzh6BMvpTmd2A1UQ/XSRImweo31g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=prvadita; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Eb8uhuSt; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="prvadita";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Eb8uhuSt"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C60841400088;
	Mon,  1 Jun 2026 04:20:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 04:20:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780302059;
	 x=1780388459; bh=YeWzIfr37DXNdSGiNjLBgUFbhj5SMaq0EwQFANS13Rw=; b=
	prvadita2QrY4L2lTIAIFKDfFz7bZ1GcgBbG+cxZLolSlgWtcLSMlp6qNdd6vBoA
	BbLyQqOCf93l+V5A7Vtq64m1kqRkRs5qdPc/YEbZQCSagGuJyWAsMWcYPrutK5hG
	UJux+21bH6HD0i3GBAv8EdCG3L/+Cez/jeAmkWT6sZ0SnaNjZmz+hFket8IUqtS4
	zizKJr3nHF3WuEkCdvZLlwlYeeM1QyxsAq4m/n5xzjaiuVTUsokdWpoTNE/640uS
	+4YIx0KKDwqqOvheCy2HJyVzR7pIS2T2zSvsFJaHDoSOePi3l9Lu75p0cmas4m1V
	B2KmIDemP707Eqd8+8Ryiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780302059; x=
	1780388459; bh=YeWzIfr37DXNdSGiNjLBgUFbhj5SMaq0EwQFANS13Rw=; b=E
	b8uhuStJ0RqL1Liwq04G7NME7t7rGZ1oBy8eQ3w9ZAB9/JLFCJh/VR96rj9EqmPU
	EmsRa88cd+gR/4zs5NoRQewR+zMMnigkOPDV3kXYmfXoUsP0DhZi6P0Vfs6zGELZ
	iGmgkXN+y+e2EsCM4S4JCO9v7hNvwgZdljdb5CcEorFcu5lqVztIiexfIEKE6l2x
	SzKLwaqP65HKscN9iQik3qIYc1kd+JZ4HDMMD4Xd+7jegbMbC5hQO0Jb/v5xOmOg
	sIqd+s/MQySDqnUcYioTintAbP9TSwP6Nrj7dBCQJsCfYx7X1FRvEsTWk7rMytHY
	u1/eISrgSnrgEBkKmUsKA==
X-ME-Sender: <xms:60AdalFd1ONwqTxv7s3fRGXn340kAtvEx7ui-FGdJW4BmdkVqDsP5w>
    <xme:60AdagUhguqkoyXVcJF1OrXydVa8Oe6r5-PSElFEP8VNKU5P2TDuwZnqpO3oNyOAy
    TtQybkthpzUIuDECC35y-J9uASmx5jvzM8PtbQSewhrNYAihEvt>
X-ME-Received: <xmr:60AdakyD971Amz6weFSAxhYuhMnXBm7yWYfxFjZs7umbkjdyttNXy8Z5zM50NzGXjpSxJ3hrDP1VyN8zq7c-1RXnqUR9IHDKvbdLt4XcMAkT>
X-ME-Proxy-Cause: dmFkZTGT2eJkyRD/DPfaj+vauqqSVHB5lHraHkGE+2Y82X2nA9iAD58bIQfhJ7jUNxMezj
    miFjYgaAR42bFjevsgOzM62wxkYvLC4pzqkwRlcUmWm/AMi0zvM6WIF7rGD1zTKQ4B6dkc
    drwsbgMfgzzk01NpRbXp78kRhno139hiGjaykxCjOe40xzAT6EC6kXvTkW4GB+DsY1LrwC
    qyv6ETIR3A88fShWom/rN8FflKYoXznKqyn/j25vf/NK/cjbqYLa9DjbLwMvdvX57WG/95
    5z/l4Moi57Y5pxxtjaswMyxQNzd1YvFvyCUFgZT7yr1UD8daHm+cXejS47FebYzU8zGTN+
    /eP0Kk/YL6xjT6A5bHCBIDCy2o6WlvCjKvA8es2KO5ZfpUK6UxQlu+yWaS5TpKHGhRPcvq
    0nyhoWu4gLohVzBOcmjKi/O22bItYIFGqNanEm5XBCST1EfBtHEXD8Bbw1lAELXFUjZ5OW
    1irurxWhBC1O65jlBpEnHd01zTiagciy8yYnTHKG+P3tVl0g13H0YFZXL7tv/f8eS9Ao4I
    QeHJBoMtQUY4NKDnPfasQuibX7G3opgU8SyFP10GkjpOmsAbmrf1/NA0WjjgxIcB+EdcnM
    EHuTVEfp8AHJZWZzPj0eFLMjcjZI2NCsV2CrSHsvHgmURnGgyAgziZrL+ZEw
X-ME-Proxy: <xmx:60AdamN4Q1yIu5zJJUXriLo1kGvfpRLzUAgvgPOrzXg8jxbFg6IgKA>
    <xmx:60Adat6x7aVKdo3lGrN3Cz4-0XunQ2K0Kh8GNfoKBW_-fVKS7vXkGw>
    <xmx:60AdavMaQk7T9aztWT5x4z6TNTx1miQI9dLduAfziPqbOaBrg-UTwA>
    <xmx:60Adajl-9CP4T2S0qJViO1GZKPAOOt-mC3K8907AlVE3Dw6_wR3vMg>
    <xmx:60Adagdon1kHtkAhxeXR8MqkWYfjo5RrtCu8sKTjSRy8qA8HHIlvdSPf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 04:20:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5849b517 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 1 Jun 2026 08:20:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 10:20:35 +0200
Subject: [PATCH v2 12/18] odb/source-loose: wire up `freshen_object()`
 callback
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-b4-pks-odb-source-loose-v2-12-90ff159430af@pks.im>
References: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
In-Reply-To: <20260601-b4-pks-odb-source-loose-v2-0-90ff159430af@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Move `odb_source_loose_freshen_object()` from "object-file.c" into
"odb/source-loose.c" and wire it up as the `freshen_object()` callback
of the loose source.

As part of the move, `check_and_freshen_source()` is inlined into the
callback function, as it has no other callers anymore.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 object-file.c      | 15 ---------------
 object-file.h      |  3 ---
 odb/source-files.c |  2 +-
 odb/source-loose.c |  9 +++++++++
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/object-file.c b/object-file.c
index c83136cf70..0689a4e67b 100644
--- a/object-file.c
+++ b/object-file.c
@@ -87,15 +87,6 @@ int check_and_freshen_file(const char *fn, int freshen)
 	return 1;
 }
 
-static int check_and_freshen_source(struct odb_source *source,
-				    const struct object_id *oid,
-				    int freshen)
-{
-	static struct strbuf path = STRBUF_INIT;
-	odb_loose_path(source, &path, oid);
-	return check_and_freshen_file(path.buf, freshen);
-}
-
 int format_object_header(char *str, size_t size, enum object_type type,
 			 size_t objsize)
 {
@@ -815,12 +806,6 @@ static int write_loose_object(struct odb_source *source,
 					  FOF_SKIP_COLLISION_CHECK);
 }
 
-int odb_source_loose_freshen_object(struct odb_source *source,
-				    const struct object_id *oid)
-{
-	return !!check_and_freshen_source(source, oid, 1);
-}
-
 int odb_source_loose_write_stream(struct odb_source *source,
 				  struct odb_write_stream *in_stream, size_t len,
 				  struct object_id *oid)
diff --git a/object-file.h b/object-file.h
index 506ca6be40..1d90df9d98 100644
--- a/object-file.h
+++ b/object-file.h
@@ -23,9 +23,6 @@ int index_path(struct index_state *istate, struct object_id *oid, const char *pa
 struct object_info;
 struct odb_source;
 
-int odb_source_loose_freshen_object(struct odb_source *source,
-				    const struct object_id *oid);
-
 int odb_source_loose_write_object(struct odb_source *source,
 				  const void *buf, unsigned long len,
 				  enum object_type type, struct object_id *oid,
diff --git a/odb/source-files.c b/odb/source-files.c
index d5454e170d..ef548e6fe6 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -152,7 +152,7 @@ static int odb_source_files_freshen_object(struct odb_source *source,
 {
 	struct odb_source_files *files = odb_source_files_downcast(source);
 	if (packfile_store_freshen_object(files->packed, oid) ||
-	    odb_source_loose_freshen_object(source, oid))
+	    odb_source_freshen_object(&files->loose->base, oid))
 		return 1;
 	return 0;
 }
diff --git a/odb/source-loose.c b/odb/source-loose.c
index 27be066327..e519365d23 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -580,6 +580,14 @@ static int odb_source_loose_count_objects(struct odb_source *source,
 	return ret;
 }
 
+static int odb_source_loose_freshen_object(struct odb_source *source,
+					   const struct object_id *oid)
+{
+	static struct strbuf path = STRBUF_INIT;
+	odb_loose_path(source, &path, oid);
+	return !!check_and_freshen_file(path.buf, 1);
+}
+
 static void odb_source_loose_clear_cache(struct odb_source_loose *loose)
 {
 	oidtree_clear(loose->cache);
@@ -638,6 +646,7 @@ struct odb_source_loose *odb_source_loose_new(struct odb_source_files *files)
 	loose->base.for_each_object = odb_source_loose_for_each_object;
 	loose->base.find_abbrev_len = odb_source_loose_find_abbrev_len;
 	loose->base.count_objects = odb_source_loose_count_objects;
+	loose->base.freshen_object = odb_source_loose_freshen_object;
 
 	if (!is_absolute_path(loose->base.path))
 		chdir_notify_register(NULL, odb_source_loose_reparent, loose);

-- 
2.54.0.926.g75ba10bac6.dirty

