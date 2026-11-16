Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816103;
	b=I/QmKHtYHP/mtPwQyZNihpvUudcCNTMteWTjAFqOx7W/Edt6jJS00QYGOsnRebfwfgae
	 zGuU58Q79iS6lXsjOwxznRGrslyBtLKtnIsS8dKS4EpDvJ1v5oiLDIObKOCQFoQiYBmRj
	 WpUm+bJo/OVFgFQHDEv7QtYzK7QLE8DmQZcX+Ip+KNtlOgrhDc9NgWMBE+spSzRifixnc
	 i5sFeQ2eor4JMcvDg9VLIYPLxpUF/KAvQTe3n1ehSi9U3//6aqzjMuolDvoG84MeABTh9
	 LeYww6wO+1/lyGoEjTmSRv9f2GSZqrpEewtkBf1jE3KuuieCob+VwVB+7aRM5h5p60w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816103;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=XXzKYrpXBCNFCnyLqYmrvw7JB9KVy2xFMLw7+PGxCEQ=;
	b=e4NmAw63XVgcSkPMelgjSpbWkrqz/LYkKOwrPNScNGi/l8ZCDVmwyOyFkObpgvsb+y/3
	 tomgJMOHxnVz9At9KMspIjMPXoWKYLBKqCffp//wuLzLpqnMZqLh1+lL9NFmPCFB4D2+p
	 Gzx+YjNDNpaFbWOac0FHx1YYlR6D7663fBLrEiWcl1teSfTfHGJPxCVIRRjzhANYCAaE6
	 J9gX1lG3RC4/Tr22xMR4XPP+UwDjDdYpJOF3qNiMwSMCyVUc5BDCZBwQSlJs1DhbcUgfm
	 8Z8qrP4ZbykB/yof4Hw+Fb9P+MWENirw8IJ9970dyARvI6iP5C98X4yqGLVU+E/VJqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ONpdAupG;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TwesrERw;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D3F606A337
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 08:01:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40D3F606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=ONpdAupG;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=TwesrERw
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C5EA87A0170
	for <git@vger.kernel.org>; Mon, 16 Nov 2026 03:01:42 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 16 Nov 2026 03:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794816102;
	 x=1794902502; bh=XXzKYrpXBCNFCnyLqYmrvw7JB9KVy2xFMLw7+PGxCEQ=; b=
	ONpdAupGLZkAQsNWCa+MkOEAh5AwOMaZsgEnUQ8v4po9IKVsR4UbYqNahx+KPRoK
	cHnwmJvXtSgpShvPgl0Ak9qlt3kRSHcUYDOKULaRnfVCIWnqdSJcJjxaCSOovhmf
	FFAru3pd5juTueZMsavnWxc53FxgkAoH/CtwcvTabWqPa7JJeQfND2Mm0kI6dFBO
	R5oWMVK5GGX4fCZdngxTrys+eorzoCKhGo3qA9FseFobcNYYdoBbU1xVEHPGCkwm
	UQyHYIvY56Nmf7nZ0P9Hb0h3BWbauR9JhvrhMiphWpnM8L/VhqfuOHD/EXGvJ7oG
	uFELij7gZbvwgiPoXPynJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794816102; x=
	1794902502; bh=XXzKYrpXBCNFCnyLqYmrvw7JB9KVy2xFMLw7+PGxCEQ=; b=T
	wesrERwOI903gkinfkwPR6fbT2uEws/5s7QB81vf4tcpzdedfW3buM+de6donT9G
	JCelaCgxwAbKsEzH/W1WKsYxnw6APCAlLKEE/nU6Gcd9tKQ/K5FX22ML0jcI5dFE
	VV2KOg+BfSQfLzT+KJjujj7C73dsyRH5ieC1C0C8O6RvFnSwGvN6DVwGB1LLEmxy
	3FsV+PEbK4lpFjXEUC6RFQtyjECTASewDSwV/rvyW6UGxF6tb+Hnq5WGxLCQs9Kw
	tVxsE6A8ogdcyl/Ht0mL/wW3RdBOFPZ7otPA7Dj6513+Uz64gmev/Tn/IDr/wMTk
	erqrag+xnDxuc1XqK2JrQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794816102; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:iOidi642upyglVi/z5aN0KNy2Vr23IvkdMKMXi+2JmQwTxi
	83ffMWwMmSdhHVUCOTUfnqh9KO3p9tXm3a6vsYyO5+1vhABgivSoOOx/PP9inrSS
	mi7Kb0h+0ffk6wRKcyE+wlhArHCpd24AO3g9H0BSN4JTXOg4E/V9P0wCYmK8ZYkL
	BqBPG6f11VWyBDlMX20ppQhKBuLTnS/VIHSbbiIeI2Ctv95oRcOK593pwhqLoPDi
	zX/XhBzDwwA5DSOvA2V185ZnzO9RkflVNNKISWzI2oiOA1k6ZKCKGRh/IhSixHxr
	XwN6uyHO3zQhTVnMVNfeF7Qvf2TrxHSRB/YWaHw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:VN0cmB+GoX4D9N4ygGzqPVFBX2WWzgUzemWjkqQf79k=:29lqWWTKLYRyH1+phLz/2loszA7XGE/HWs74dllESIg=;
X-ME-Sender: <xms:Zrj6an1dRKvveyHqHPMTKiQUtXorPfdkMLqvKAsJldkTG1Btp9EsSg>
    <xme:Zrj6asG76cWl_v3T80tsidnfdZR_k9j4ywQtrYP8cp3F_c1PzDUXejj7CBF59ksUD
    Kp07pgfFpd73_WVjK2PAYbdYKpBGw9o8cyyVUMgx9xAP96aT2Cf_mY>
X-ME-Received: <xmr:Zrj6alhNaesVLGY4TTO81NK4zrQBW-clbjUzlzTJRTVxsOqpsTvV4MN7YFvNLJeZt5WSO64>
X-ME-Proxy-Cause: dmFkZTFeV2TARsV2pw2wFbtyRUeI+jv0KgMuM97dvfnBjOGCAi6eQeSr/G+HIOsX1Dc3BV
    QzbolohuxA2/aQw3jKIhT8rlyXM7ckj0UCTaW84zfw0roJAAriX+XROvkwnrAux7MDrk2I
    CjlxALDGeAuCDzXqP8+thN9XowiDQRV9T5V9Yi39o4k70mRYUQ4Tmkb21KHlsYZCitlC4W
    sY5xxL/NqvJH+HHw6yQ0gLbbiR9asIB+GonydFPs/v/FwRM8Y2dGNB5QwR7daU5NiLyr2d
    ikR1l3goAZMjO9SsX14fR/jJ4fTihR3mDf7EfzHOhwx+ZmMKQo3ME+KDDymO4qnZRXWSie
    zOyCA4LLhtznVoP98JrfEKXW1m5ZK+09Hoc7YBQrybtrptPkRuSDrjTD4PNEL+uJvEd/bZ
    i+Ph5F63tyZMEmFLTVYdNoUnHWhdIg8MZVDyeimOTHryqg1U6BiTxzd93e1ma8ctcKHcZG
    JDondqKJzYCsTT2/lmCkrkm4l/bZTr2i9qmsUBe3JQLTbSFVCnRQnpYOmn4o+Fbm45y05F
    V5kBeZcWpKnnEQI2rgZq++wVYi04PafgQTcALwEZpBLVcnUQHgUFaaWklhF9yXLusaAthM
    i2T5Xi4RYmGxL730AwsRXyW6dG/PtxEyjfvjw8QewYzhm+yQTET27dKLCxpw
X-ME-Proxy: <xmx:Zrj6an9HTZywyoRZQi1AXbSIRSaR2y1dhxLx6FPdFaaHFnjZY5pulg>
    <xmx:Zrj6asoI_u9ih0FMqaWeudWTsMld8ASh3_SS_4MoE1YmHqwEM665RQ>
    <xmx:Zrj6am8l306IM-Yb7R3CpChEwwfX5I8SqLwLTueyKyoLNG4PCAemeA>
    <xmx:Zrj6agVdjbDZHHAicfDgjrDqdWfJlnb1wmpax2rSBzK7Dvn5V8QvUw>
    <xmx:Zrj6apGmNFwjxR3jDNL3I_uvw8q15Ccl2_XEZoKDiyS0aM3jMs0jKLYg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Nov 2026 03:01:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0989381a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Nov 2026 08:01:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 16 Nov 2026 09:01:34 +0100
Subject: [PATCH v2 1/2] builtin/repo: only parse objects as needed
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261116-pks-repo-count-objects-speedup-v2-1-9c8be218eaff@pks.im>
References: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
In-Reply-To: <20261116-pks-repo-count-objects-speedup-v2-0-9c8be218eaff@pks.im>
To: git@vger.kernel.org
Cc: Kristofer Karlsson <krka@spotify.com>
X-Mailer: b4 0.15.2

To count objects we walk the repository's object graph. We then read the
individual objects that we encounter so that we can learn about their
metrics like their size.

As part of this, we also unconditionally read the object's content and
parse it. But this is quite unnecessary, as we only really need parsed
commits and trees because we need their number of parents and tree
entries, respectively. So the time we spend reading and parsing blobs
and tags is ultimately pointless.

Improve the status quo so that we only parse as needed. This allows us
to do another small optimization: as we reach commits via the rev walk
we know that they have already been parsed anyway. Consequently, we
don't even need to read their data at all, and we can instead just look
up the already-parsed commit.

This speeds up `git repo structure` a bit. The following benchmark was
executed in "git.git":

  Benchmark 1: ./git repo structure (commit = HEAD~) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time   10.891 s   ±   0.113 s     10.779 s   …  11.181 s
    Memory         3.5 GiB ±     0.0 GiB      3.5 GiB …     3.5 GiB

  Benchmark 2: ./git repo structure (commit = HEAD) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    9.577 s   ±   0.064 s      9.485 s   …   9.673 s            -12.1%
    Memory         3.4 GiB ±     0.0 GiB      3.4 GiB …     3.4 GiB           -4.1%

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repo.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 0399c558719..45ac005c2f7 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -847,13 +847,14 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		size_t inflated_st = 0;
 		struct commit *commit;
 		struct object *obj;
-		void *content;
+		void *content = NULL;
 		off_t disk;
-		int eaten;
+		int eaten = 0;
 
 		oi.sizep = &inflated_st;
 		oi.disk_sizep = &disk;
-		oi.contentp = &content;
+		if (type == OBJ_TREE)
+			oi.contentp = &content;
 
 		if (odb_read_object_info_extended(data->odb, &oids->oid[i], &oi,
 						  OBJECT_INFO_SKIP_FETCH_OBJECT |
@@ -861,9 +862,6 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 			continue;
 		inflated = cast_size_t_to_ulong(inflated_st);
 
-		obj = parse_object_buffer(the_repository, &oids->oid[i], type,
-					  inflated, content, &eaten);
-
 		switch (type) {
 		case OBJ_TAG:
 			stats->type_counts.tags++;
@@ -873,7 +871,15 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 				      inflated);
 			break;
 		case OBJ_COMMIT:
-			commit = object_as_type(obj, OBJ_COMMIT, 0);
+			/*
+			 * Commits should already have been parsed by the
+			 * revision walk, so in theory we do not need to read
+			 * their contents again.
+			 */
+			commit = lookup_commit(data->odb->repo, &oids->oid[i]);
+			if (!commit || repo_parse_commit(data->odb->repo, commit))
+				continue;
+
 			stats->type_counts.commits++;
 			stats->inflated_sizes.commits += inflated;
 			stats->disk_sizes.commits += disk;
@@ -883,6 +889,9 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 				      commit_list_count(commit->parents));
 			break;
 		case OBJ_TREE:
+			obj = parse_object_buffer(the_repository, &oids->oid[i], type,
+						  inflated, content, &eaten);
+
 			stats->type_counts.trees++;
 			stats->inflated_sizes.trees += inflated;
 			stats->disk_sizes.trees += disk;

-- 
2.56.1.763.g16177fe143.dirty

