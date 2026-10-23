Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759689;
	b=gkZ+SHWuyq7DtsUC5nOA6+jpeTWWTEH75MvgSZ1QgWgc+gWbRDrOqnLtNBpoSJg1awiX
	 2P48r76ApvWbFO5EyS5WBzjlD0qkV8pUu5TZAdC/nutpAse9hhScfTGvef3BkPayDY4XL
	 4+9Hjh1LlReFEVyeDlUiEAG7Z8UDOsJSbrBqGHT6rbwOkprdpZGU1jEKtYkvfzjPa2MzU
	 i8/Zz0LRkPxIO186QY9xAVl9AAAbKKqiJx4fabyxvy7eFPe3S/FfmhdiOImsy+XOBrhps
	 3BdNdhk7ok4BDQXA/z17k9WGlJHC0mJDpcbLj+wURkyRY2rler0XrfZtu9aYyyZTvnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759689;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=wEVkjv6Qe8akTzYBycOqSOYqNGRimZT5tqkqy4BSD0A=;
	b=DU9GDKiN+shZrM/YDqSjka9LhBZQ0I9kYVEaczju5yOqSCLMzUP/i8uk0PPTAnpJsLe2
	 5hg3d0kqc2sf0mCLwYGtQaLAXCu9CwcjnOBKh2xQi2FyswiKLsY9S8Xeoopdbe5CnzKjl
	 PY0vD1Z8N+Djte4dLcn5GUg+axKbCRlHvcW5pAwbD1Xan66GomjNyvfHPUT5DsI9CKjys
	 S0z/IeVRNJ+sJsJeDaLyuBvbAcgbkJ1JxFyaR9BjneFunft0SDIKyj+1+nSJLAiIHzM9a
	 6YkiIQjeFDMZrUu7E098q5CwfBPlX/20jD6ZasP0gj2y0ecETs3nE/AykSvoluvT7Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FaQ3Us5L;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y5VA+2OG;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834B7606A321
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 834B7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=FaQ3Us5L;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Y5VA+2OG
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id BDA4E1D00120
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:08 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 23 Oct 2026 08:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759688;
	 x=1792846088; bh=wEVkjv6Qe8akTzYBycOqSOYqNGRimZT5tqkqy4BSD0A=; b=
	FaQ3Us5LU/Iqh4OhnD2h9MuHaAWVOwkDx6BhzpTCKrQJF6fqdNMZ6aYGFVugMNMS
	xXbiFMtLUK01XHZqhhmjc2TEbVJRygJBD/64E7MBxNjJNlHbA6cLyuecv3BbjGUZ
	O10OkIzKdre8ccXKa+VgSU0DWNl18/lToHhfMwJDKKH3ycb4M+NKKtAB0+Vllz9B
	O6IgJAkJgyl+ks7kDe4x3x9xIB7hoRiXSU0f/pq5pQ6CreghdhoHDloIDF+OXuN0
	L6hy9PFPV/PL1CFBVGRd7RtoqGxuAz3HgIVo2xNVIG0JELDFnPghw0ruSMCw0RIY
	VnHS55ul1UVN9Q+hTxSvKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759688; x=
	1792846088; bh=wEVkjv6Qe8akTzYBycOqSOYqNGRimZT5tqkqy4BSD0A=; b=Y
	5VA+2OGQL5M8MiQjSgn5d2UJ7vWMyJ9ttVC7O83Bxig4uBprVqotZNEyS/VMtwVY
	46vwN7P+zvHlRi8yqBeliMwUnsM53gI/UgAXDCVQ4ph8v9xNSiqKhDMZg3DEPDgu
	uYawOsKI/grv0oOvsnFW3r/uGZOkj6ExsB9KBY4Z1niOgw1juqXIbcDlVLT50Nzb
	uKgml3FC/Y5iYJKpNTd4unufPbLieMpNJvvTV9FpR92MX08ApIQTPOUHyg3WxLN/
	5/RjhGmVTOaJOlB7nh6Jvhk+CwIaJYqeLGfevmRrVebrbJIJI7Xzp+V9X+gUZnvK
	dp3hJi+tExMU8LoLGu0dg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759688; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HKllN3Qg3x5PAWUmNiCb5dJGKbgV7huar1QQHx6SCmTET+q
	F5KWYhXe3GSpp1jg0lHng/VBnxTuDDTclPHDu16s/d/0lHsep6ZtJxcQMbhMVLYJ
	bDjRYG7EKkJHuAY+iLBUoSHv6KdTCIVX2G3BtvEQJ9CZGAiV+c54Z86sXsiigxQW
	QCi4B1AECiT8mb9Pn5omAm51Xb1B6BBMCWojvvHsTkpVI3uywyO2bIXmiOv987wu
	dvkNZ4A4pQLXj3RBnJ7PWBo/jwPTvEbY8RjVdEV7HZdZ13BvejOaaAd74f1ruk7s
	AxY/+vCT1PlHlCN6up6g+UVjL1mfFt2/fVKnTUw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:gwJsg5w1cJB/GjQMmfMXDk4CZf7rFx1x8wJiGwxd/a8=:qhiV5xmq3r8f1TX5/rfJSiKLdEV/KuGpZp+9lwVW844=;
X-ME-Sender: <xms:iFfbah9lPvkK1DLBUx_pXO9O0aE2cii_3A2ZChsJAm7xLciVvTWbIA>
    <xme:iFfbaruHkiG0xXeEO8nz72ztmOSKlzMm2T7og013Vq1QifjZwn3Vt_Tjwu2kLw3CG
    YlF4le9UlnGMv2Q1-svwjsOV7RXvrRmpTNbC1PE85fy7GmXiOg1kYVp>
X-ME-Received: <xmr:iFfbasrCAnBVhV08xyaePdINKSehAvphJuaBLZEfaTjceZqoIyU2B1OdXv5eaVHeYvXyAA>
X-ME-Proxy-Cause: dmFkZTEzT+pv2S8IJJOlyNgI3HB1jeZQwD15WvbIcUA/LSF85ryD8gUt8eu15gYJeX+FPc
    DJEQiATX83rwVKLmssYXHfbocIInHUYjzLRBUMYJKPuqcr6qXTiIetPMP6xzQiIZCsflfy
    igaBCwS/U8Y0iuqJeFynePchcHcajgFvjq9pgl8edtC3t/QylP6yHGZ+hayv40tYpvsHCr
    k2hi56gUeuoQh+GmOCkE6uLz7fsnanV6VsuSDsx3CGspeaV2VFt7noIF13HAhWAFRa38n+
    j7sH361cJcpu3D3oD/SwtcaXb3gkAZfDr2GY96PY9+14AjvOC01pS4YEa52nEadIOLYPEA
    9jrk8mM2D8qkuV+o+qAXzpwoXu9Yyt66Lp/wFU3Wg+1gmpUgem/GPZcZYg16Zzq8qvQy6b
    /+GIYs9ji2fwMf/tIUi5YrWNuUBozQaJtAHogMbOvQD8u0ZkmocqnC6WEfjKBmdGU5/inJ
    D24v6290s3nJOqq1/d/o+l4v4iGVY8uWRwg9airONabhWA53mYzTByhTqEz4wzrL51PIlx
    VWjNnkTTvQWzLG2jIDCIVO7CkRIb73IZ4P9YafpYukuvxjKFKcQZtf9OTrG/i2awqcLGJn
    6Nq68y/Z8Rw+IYLV2TvXjxRndoyDCP8j+l3lBgzNSlp74x22IVbrgm4Ts9YA
X-ME-Proxy: <xmx:iFfbagm1QBLxCB29HbxqAwX9O3Icpr9Q_blaI_tdhRhAdQae7rhcTQ>
    <xmx:iFfbaoyoRYQ2TKmaFq3kSBmjwe9ZYrAfksbF2GBM_QnA6D24FOwg1Q>
    <xmx:iFfbagl3vk3GinZAkGDvXC2_ODWjpKOtU16uV5IcxPBqy8c_3-nXmA>
    <xmx:iFfbapd3655sWnG2IrleDAjhyw9x2I6vBkAHJjKb_Uta0O8wdEI83Q>
    <xmx:iFfbagtadgOgj3rqRYV8hHiJSu6o2oFhqlaaRfmzyvlOtdxrQ5p4NDV8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:07 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1a8db76 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:48:00 +0200
Subject: [PATCH v2 1/6] odb/source-files: rename alternates-related
 functions
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-1-30559d7ff43b@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

The functions that prepare and add alternates in the "files" backend
were originally part of the object database layer, which explains why
they still have an "odb_" prefix. That prefix does not make much sense
anymore now that those are part of the "files" backend.

Drop the prefix.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 5b4277fbfd..d31da6e5d9 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -348,9 +348,9 @@ static int read_alternates(const char *object_dir, struct strvec *out)
 	return 0;
 }
 
-static void odb_add_alternate_recursively(struct odb_source_files *files,
-					  const char *path,
-					  int depth)
+static void add_alternate_recursively(struct odb_source_files *files,
+				      const char *path,
+				      int depth)
 {
 	struct odb_files_dir *alternate;
 	struct strvec alternates = STRVEC_INIT;
@@ -377,15 +377,15 @@ static void odb_add_alternate_recursively(struct odb_source_files *files,
 		      path);
 	} else {
 		for (size_t i = 0; i < alternates.nr; i++)
-			odb_add_alternate_recursively(files, alternates.v[i], depth + 1);
+			add_alternate_recursively(files, alternates.v[i], depth + 1);
 	}
 
  out:
 	strvec_clear(&alternates);
 }
 
-static void odb_prepare_alternates(struct odb_source_files *files,
-				   const char *alternate_db)
+static void prepare_alternates(struct odb_source_files *files,
+			       const char *alternate_db)
 {
 	struct strvec alternates = STRVEC_INIT;
 
@@ -393,7 +393,7 @@ static void odb_prepare_alternates(struct odb_source_files *files,
 	read_alternates(files->dirs->abspath, &alternates);
 
 	for (size_t i = 0; i < alternates.nr; i++)
-		odb_add_alternate_recursively(files, alternates.v[i], 0);
+		add_alternate_recursively(files, alternates.v[i], 0);
 
 	strvec_clear(&alternates);
 }
@@ -410,7 +410,7 @@ static void odb_source_files_prepare(struct odb_source *source,
 	 * for the lifetime of the process.
 	 */
 	if (flags & ODB_PREPARE_FLUSH_CACHES)
-		odb_prepare_alternates(files, NULL);
+		prepare_alternates(files, NULL);
 
 	for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next) {
 		odb_source_prepare(&dir->loose->base, flags);
@@ -1299,7 +1299,7 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
 	if (!is_absolute_path(object_dir))
 		chdir_notify_register(odb_source_files_reparent, files);
 
-	odb_prepare_alternates(files, alternates);
+	prepare_alternates(files, alternates);
 
 	free(object_dir);
 	free(alternates);

-- 
2.56.0.307.g5fe7bd680c.dirty

