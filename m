Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792561163;
	b=Y6gPBPTA278bPKy/s0asXbIKAA3bMe8dBZFYdw4G6y0T9a5c5jbHDoUvW/9xtjLsT4PP
	 fV9qT/jaaTSxIJkrIVKuciTd/DLdtBwHmsYwbXXLqWhiG1D0SA4JsGbTqGJRhDcbIai8X
	 /Zz1ydgye1JqrmMRsTXYQOeXbnFQBddL7mi0iq8LKX0WYXG1gswjNSo/2MfwKUG+2B/Iy
	 fXQStX2W+c3E0xtbvgvQB1m/UwBZYzPIus7zpnREksbVt5RUx8vM58QQeBI3dNP/4h9W2
	 zqj1qPXIMao/ecnVeYMfxuYZMsI/5usK7508stk6hEYhQEa1EVLVyEI8XQvDT26mcSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792561163;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=NSaD/+BDnFY978D0NstVkqxlAAr4ORgJ8s44seGtQMI=;
	b=bDCLP5CuuxzRSiTYntlwg12fAanhnnv/YpY4r1B85d9HIVbdycMY09/5Zw8/J6cDHr55
	 ZMLnKKD8N92i5JNJYvHmMK5goW0rr1b7SvBuF+9RMrCPhN54CoMYYL1ZdotcMQL3vurdi
	 qgGW2ETtKNb16vOcTZcw8GodhEELdeYU07oGmdc4slIsLMjUlRUI1qoBAx7VRrQlWF3ww
	 uNEZmIcx7n6Fctxc/IQ8tpFM1LMOAWxTBvauvUuILaM5GSpJW6Ua2zDfxlBGgAR/GbgF5
	 +be6g8vNr+L4H8HL18y8zwi0UPwib5p8zMUPSjryLCg0NHX/cR2Ixu1eYtRXvTpYJ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=m7RjXxue;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="gXd1ZUF/";
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73276606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 05:39:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73276606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=m7RjXxue;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=gXd1ZUF/
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8B1427A00BC
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 01:39:22 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 21 Oct 2026 01:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792561162;
	 x=1792647562; bh=NSaD/+BDnFY978D0NstVkqxlAAr4ORgJ8s44seGtQMI=; b=
	m7RjXxue1X1JxZoTGhmIzpK/Bv5Qh6Eo/mb2YyYHUCex9C7eupSftiySbyx8j392
	GiVXlNWjJSSzjv3oAYTf/vsp+OXo42UL22oG9pgSRQr0gNwoBQQgVyT3632sX77/
	uw7tMbrOAku3wshiS42Njo2CHIaP0uPZ77Q6t1wk9KsijTK9S2+bCNSLyF8XRdaE
	kZe2rG6s0dTHbAwH3CEnS2GBl0IRO5glNcje+/uYFGCrKETzAsQsSjSqWmCdavTW
	/Wk84hIISphV425N6ie0SxQoacdjvsPujSo7n1fgcGwJdiLO+hQMQHTR9xdmFWmg
	t8Hih0gmOoT0s/73myN3Yg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792561162; x=
	1792647562; bh=NSaD/+BDnFY978D0NstVkqxlAAr4ORgJ8s44seGtQMI=; b=g
	Xd1ZUF/FYzyif/IRN1T+ViYzD1IGJhtWVc24OhIsAIqGJUSNAdW0G1BJqMS29082
	v8eW86ExsAsGq2V76fC6cn4za/E5OJ7OL9zVrgIs/up/as2MLvX1lCibqlw6StuH
	3AbDzGhXBaI8uUxmMRa+2WR3q87ZwmbX/Qfh1JHLBaOlRI37Ir/FSkAaAAHiOF5d
	e7xjuZxQxscBTLc42yxhBJE1JzD116QbwZUYyRq4x3BM7nugfzgY1+442DRTdu6J
	aIvRyq4DaptVOcTtgzuKISo0PaIVk1eFp02wECKhGp6mlGZvNZCok3zfdyfl/sSz
	FgDwW9sxx6gmQqN4ib5Xw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792561162; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:XCMV4F8GVwhzibCxHXsbjPhBQ6t1w8o9iEQcvAiPNu4yPDd
	37FzZG1WJu3Bj9O9hBhe8g5MBfIuV9VfOeCIXVQimNww8c9i4UytuTM0kkPNST7k
	t6TftjkN6bdoZlK5NhzHJlwj0Y5JnjMD4svwBmg2Cj+MVj1Jk/5Dn5g6zZjuXp4J
	LJxUWOArHHwi6sV3oJuVqXA2MpuLiFUptgZ1nSc7/V0fcGXIjUmdCSBJBth6cCLD
	TShp7GPS+lyiuIBOwzmG6BWq/9TMYKkLRarZdQiKjIiExkwce/kzeNP+yI3UVwsh
	+yK4KwmfkYLixGa9c8z4MVlElRxUeZL7oBrQVEw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AKL06/M/QZZyg8S6IRMlifHIk1Mxk4hRfMTCZGvU8+w=:lhthKCDj36CIVoXQUmQLth4Fo4eUW3VCYXjoAxBDA/Y=;
X-ME-Sender: <xms:ClDYankLAzAOqVRYX1tswmmRxu5Ek_31hltEYjHzx9GoDAeVygOLGg>
    <xme:ClDYag04uodnDN9OKpnDu3dXggPyqbjbt3ufrbmlWEIqKyJzOMteRisvR_EJkBNXD
    8SM-YepKGiu09suG5GRyHDfrwwqXBs0ApGV20UuuMKEYFrhLpFGJMY>
X-ME-Received: <xmr:ClDYarSB6j6yC3FUyHUU7Py4m4zSXLzZlhKYSYRaoY763zWU1o5hyA>
X-ME-Proxy-Cause: dmFkZTFjdiHAftcLcxym7iyS6GGrr/hwgFjz6lyXgvbwNBTSpUGjBHjsxHa7aWLwD6r8/y
    i2fuv7S9i1ADuywbn12Qket1cjLDXkJ8huziohbALlYFFv5IeSPdo64QwnwB3rK4fKY8wr
    6vG2mCCE9emAm7rwWxvUG3vs+lrefardrkhp+6NcddLYfYabalVLmpcdWs+HVZZxn+9RGQ
    GoZCIDcFFBIkpfsCmvOapl7dvlB/aeoZBxOJxhKRitBNLvf253VGsHLOlhed8EgJLNxlKS
    L5ApeOskZ0InMS3wHs4ISt+Rs2ia27LW4DilV75gqOCUTkCtNCrOfSgpi23lq1zKjF5Sar
    iJ1wE6p1So/GEQMERzd5oTHRAy5tjd9yYxlYlGZg4cCL6IhYLvsVZZm5p31CyP/rpve68s
    Z747Cbyk3oeNF/nOOAi31Hw8XmmB3qIGiYqusg/5DqE0mM17kcUvQQsqZ55/0Vnj/hY6Ad
    xN9rTzvXo6dAC3a9OjKt7cWYImIBp8+JfhaARTbttjvTvedpKo7CqY4+CJnwsYew5SKGVq
    6M1AEVNwHsTiR5x0MIVMt+U0ZhR6hL/fHr7cbK4DssBAZwLOUVx0O2T6apWt/tY5rU3nlH
    uzwJR06ieYBbTHFkKT/Mnm1telqwl9p597YmMt+5sFl6i0ttDJSb7iJIHetA
X-ME-Proxy: <xmx:ClDYaqs6K0xnZnNakasTRw0QvhuHNgpmI5Wrbd4jTEz9wBDVVKIAzQ>
    <xmx:ClDYaoYaiI79C54bgr0REgoCuAEnj2jwS-_shqwPf7taFdB-KOWtPw>
    <xmx:ClDYanua5zwJ-i7ZiCWjVUSDngYgddKt-yf997HG7TtL2yz_KpQGng>
    <xmx:ClDYaiH7X_I1OKKtdeTm9up69pQcpPGX6zMsSuZf6bGDvp0vJqrI_A>
    <xmx:ClDYagVWhB9oFVf-0PSurgPPQSdPy5EROFKUoARTZNWlwDGP0O0js_1v>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 01:39:21 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ae2f13fd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Oct 2026 05:39:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 21 Oct 2026 07:39:14 +0200
Subject: [PATCH v2 1/7] loose: drop unused `repo_write_loose_object_map()`
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
Message-Id: <20261021-b4-pks-odb-extension-v2-1-8cf11b65eda8@pks.im>
References: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
In-Reply-To: <20261021-b4-pks-odb-extension-v2-0-8cf11b65eda8@pks.im>
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

