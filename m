Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792756166;
	b=5Bibfon00yp8aa8w9QHHIfZl9W0p1FwGtbFsiyFtVjQ50jUuZX3XQtbjtyp147N9phmC
	 MSRUuz87dpaDG6TCxG7IzSMaP7nLr6YTiBPbKCfGGMLKXuV1Bgu0DShBGgx5psU4EUeiv
	 lAXDdsNZQ8iQ23eIkrgyzMvpFrENlsmd01l7vqQngeDETWdRVAsRQTLFj49hBCyYk9jHq
	 8GM/QxfuEmgampx4nbT/atzUnHxB5z9o57zT3xlmb9G2AIyXw9lfuRs4Gil5vs7rdkYgq
	 0uJbuRoiiJyHl8pKACGt/vlmscT6ihUTgnjMhaVuTtTBCqw5WqRYvUEh6y1RR8VDkQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792756166;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=NSaD/+BDnFY978D0NstVkqxlAAr4ORgJ8s44seGtQMI=;
	b=DhQH1qWO6bfNPCMcmlJkrs+V0YsKiJ4IzYnOFMUDed+yfO/uKRttP6lTt9zvc923RXze
	 IcffgKFB8ZzjUUgccoNOasdsGjII2DwPDuYAmXEN8h48ZTZdUB+YfGevU77WavmRkS7XE
	 OXcLAq25fVa3Pek0XhnKo3UrO11wyDjJ0ltYjrx3jiQ1HQKsT1DfyIiYsTR4/SAQvxW7L
	 IhZeA4uYKz8yJ2Kn0ISixOQ7ooIFQYcxuTCM3Z09dAV7VTUBXAJMv9XgO60TXWC8wx71u
	 CH5nLZv8aqvYWcEdemBAfx03GJie+GpTMq7EDs8/wqprBbutSgFp4GghmFoQ7T4P+bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bK226gOS;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qgST1UsO;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AE7606A31D
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 11:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49AE7606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=bK226gOS;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=qgST1UsO
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8E85E14000F1
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 07:49:24 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Fri, 23 Oct 2026 07:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792756164;
	 x=1792842564; bh=NSaD/+BDnFY978D0NstVkqxlAAr4ORgJ8s44seGtQMI=; b=
	bK226gOSq8tpxh1l6ZJpdQU3+L2/44+YYIfhhN41XPmit4WXOEMIKwwlKlXCBhdR
	AnMgXkNKSHtnIYbQ1HMayWw02m/NldfydXQWs46l5oH2N/maN/mV/zJTj21+Z7cj
	jXIerUabPxehDhnp02TOy7XdoBdETWQPIDDTdDdihFI/Eofge2srO2KMYNdjVBZF
	ueVpU2IzXclpkPpbJ3+P4lIxreOYun7NDOYDVm2+MSCwr9XMMZ905VPWvlkAykEA
	Ti9rTcDoONhy5q5phHkowkG6GmJDxTgM6+hFKuH43FDlx22wSTb8kLhw4rlE2DUd
	lcEQ76eoopC4s2JPwfEm/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792756164; x=
	1792842564; bh=NSaD/+BDnFY978D0NstVkqxlAAr4ORgJ8s44seGtQMI=; b=q
	gST1UsONi07gE7SFwZlTSJ8iYoFJMWYWx/fkiIh3BD+SP+Rezxx5MZz9olNYae2H
	X8RjqYQmngUQSPge0USP2L2gfhwgegn5CBiAa+FBjTrYcTfiqCjfEwQzFbfBV8kl
	bmdfA32sBAf+EaeuDD/XnMQxmrEqWNCk+2HJhXlYmpsDt+uWRj8/3l0BbYsC3cYl
	mMvPs8D/RSP0PkGniCgm8TaSxp1g26XVbT4aJ9FLK9iURrSmnAXezvJoPCVEbWJi
	QaUJpTD4N+jEbrRdJRsIwuedrqlFGM4D19TxJdUQeyNlAD6BqgLEr/TdJcObIWjH
	ocgHFd8fYTrQIwUA6V7tg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792756164; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:j8anxiGhJNHpoyE2+IDOW5389VLVJOt+KckB4jgOexOVZ8E
	JKTaPeEUKzCDH1jx/3mic5Zk7DxE9xZfLpAJCUVDYvJk+zElt0dAHZi+eW+O6KxD
	liZnZK/7JNA8tApFn0JuNEK7yONyZT9pNp0T00fB5f4ZI3QcX/am2zhoUGfSbitM
	loTAkp98AK+OPG3DZW62HZFPxi6Iv6ZdSPagQLjWOhmYZAf1BQpL0ELFD+J8C3ca
	4FjwleRZkBwz7HiwJnhvUI1CDYqCci+DHJYbQ0U8j361kjvgIGG0/DPA1UrI0kSN
	GGEDY1rh5uEiWCAogbepAC/RP0WOrYGrFip0CRQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:HszRNaLA21L0b5IcFtZ79THDQOH8Ci2gwa1HJPvgbww=:lhthKCDj36CIVoXQUmQLth4Fo4eUW3VCYXjoAxBDA/Y=;
X-ME-Sender: <xms:xEnbarooSL7pNK_8dZnL0A3JVgvUgFKWKZpr57UGllvLqtGP9JWMug>
    <xme:xEnbaroSXImQL-_yL940rBU2FbDC7l97o0u78gfKUr2UU0jJBcBQsjRC0HuBpaBrs
    J0au5qhv6nxulNbKMMvr9Es_euKZMCR3TXaRSSZphj3JL56DZTJkCI>
X-ME-Received: <xmr:xEnbal0LyPi99MxUaRffXamKeMTakIuweMrNJK-BNCCoK5SPzHpYYKFDsEpYliQoGTliyw>
X-ME-Proxy-Cause: dmFkZTETiKl8zLrP0TLEWU1svkdLdUEuRYcvYB954Ymnp/43Dja23/M1Al52sMICPKk2YE
    /sZyvwtiljiWi9UTE+Ne8q8rTQDieBPE3rVbbRt0JGe0vebqpgRJmh37k5J0GVJqJUyEiW
    B3/zBuPgUVR4P88CIPiTXPwH7qQ3MVxRBsgZj8ejl2IdQ2nqPuK3eCnHxOe3hggiLOgq3T
    G5yyXo0l6mgvBcdD3SPUmx8CwyW6lVtjhfAh3huMeALopdWPGSaB56bfUKVFup/WJylOC0
    U9Hsnd7aFN9ufDOgyvajszj/DNteaIoB1q0HYk7Z9d6wxUop94oPwEUvBJB7KET8XoShbi
    +592G3CXP4tzECRiz62UDwyi8FXGCAzrLvoC1/QPUdEwxMlHJ2+sKOWnKX+xSPtHG2ThS3
    r0ABcrt243y+X0cLdKGnDXZ3ApEP1LR75I8dzDHKgXY5iqsd3d1ZT+mkGP3D5yFD6UzTk/
    1X97ldHs3k9nLFyQRLN5rZPWFbQgYTYA5dkBPGz2fRgg6fgPBi4PaIoSkztg6ycl/zXznl
    +yFpGum01TAyPfIOHGTMTQZyAGJx1Rg3iPdAUapO4v9VEneVSE1ZAdlcNeIUVDbsqkuZKO
    BSSZCYaELnSBPjPf+CyexbY8dZJJXtkXHil9NTGFR4tb38jTEUR9hpf7GR4Q
X-ME-Proxy: <xmx:xEnbaqCt-O6onfTRxbq0I5OzyvP4BJx_hLe_niUOM7VQtwS8meHQoA>
    <xmx:xEnbatcqJuX9sOMlO54nwXgc2q03CImJcQGEVD2cE2JEXkE72lqpPw>
    <xmx:xEnbavhSiWlbQrGdMZE6hK8gZUbJWIocJCGlrGy6oRp1pN0INVnf8Q>
    <xmx:xEnbalrWN7gqXVPLHhLODb4Qt8jHmHXmr1mdAJwvmjl5c8AqPyGSRg>
    <xmx:xEnbalafsZ5iOH3RNH0YqOCr_GQGU048bXCpATDmEvo820j0Ksc4wVzF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 07:49:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 28e1d58b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 11:49:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 13:49:10 +0200
Subject: [PATCH v3 1/7] loose: drop unused `repo_write_loose_object_map()`
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
Message-Id: <20261023-b4-pks-odb-extension-v3-1-b1bb30a006db@pks.im>
References: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
In-Reply-To: <20261023-b4-pks-odb-extension-v3-0-b1bb30a006db@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15.2

The function `repo_write_loose_object_map()` was introduced in
23b2c7e95b (loose: add a mapping between SHA-1 and SHA-256 for loose
objects, 2023-10-01), but it never had any callers as loose object maps
are instead written incrementally via `repo_add_loose_object_map()`
whenever a new loose object is created.

Besides being dead code, the function also hardcodes the location of the
"loose-object-idx" file as "$GIT_COMMON_DIR/objects", whereas both the
reader and `repo_add_loose_object_map()` derive the location from the
loose source's path. The function would thus disagree with everyone else
where the loose object map is supposed to be located when the object
directory is using a non-default location.

Remove the function.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 loose.c | 46 ----------------------------------------------
 loose.h |  1 -
 2 files changed, 47 deletions(-)

diff --git a/loose.c b/loose.c
index d6a2bb5ba3..7e26a04ec0 100644
--- a/loose.c
+++ b/loose.c
@@ -123,52 +123,6 @@ int repo_read_loose_object_map(struct repository *repo)
 	return 0;
 }
 
-int repo_write_loose_object_map(struct repository *repo)
-{
-	struct odb_source_files *files = odb_source_files_downcast(repo->objects->source);
-	kh_oid_map_t *map = files->dirs->loose->map->to_compat;
-	struct lock_file lock;
-	int fd;
-	khiter_t iter;
-	struct strbuf buf = STRBUF_INIT, path = STRBUF_INIT;
-
-	if (!should_use_loose_object_map(repo))
-		return 0;
-
-	repo_common_path_replace(repo, &path, "objects/loose-object-idx");
-	fd = repo_hold_lock_file_for_update_timeout(repo, &lock, path.buf,
-						    LOCK_DIE_ON_ERROR, -1);
-	iter = kh_begin(map);
-	if (write_in_full(fd, loose_object_header, strlen(loose_object_header)) < 0)
-		goto errout;
-
-	for (; iter != kh_end(map); iter++) {
-		if (kh_exist(map, iter)) {
-			if (oideq(&kh_key(map, iter), repo->hash_algo->empty_tree) ||
-			    oideq(&kh_key(map, iter), repo->hash_algo->empty_blob))
-				continue;
-			strbuf_addf(&buf, "%s %s\n", oid_to_hex(&kh_key(map, iter)), oid_to_hex(kh_value(map, iter)));
-			if (write_in_full(fd, buf.buf, buf.len) < 0)
-				goto errout;
-			strbuf_reset(&buf);
-		}
-	}
-	strbuf_release(&buf);
-	if (commit_lock_file(&lock) < 0) {
-		error_errno(_("could not write loose object index %s"), path.buf);
-		strbuf_release(&path);
-		return -1;
-	}
-	strbuf_release(&path);
-	return 0;
-errout:
-	rollback_lock_file(&lock);
-	strbuf_release(&buf);
-	error_errno(_("failed to write loose object index %s"), path.buf);
-	strbuf_release(&path);
-	return -1;
-}
-
 static int write_one_object(struct odb_source_loose *loose,
 			    const struct object_id *oid,
 			    const struct object_id *compat_oid)
diff --git a/loose.h b/loose.h
index ed663ac550..41c4b46818 100644
--- a/loose.h
+++ b/loose.h
@@ -22,6 +22,5 @@ int repo_add_loose_object_map(struct odb_source_loose *loose,
 			      const struct object_id *oid,
 			      const struct object_id *compat_oid);
 int repo_read_loose_object_map(struct repository *repo);
-int repo_write_loose_object_map(struct repository *repo);
 
 #endif

-- 
2.56.0.307.g5fe7bd680c.dirty

