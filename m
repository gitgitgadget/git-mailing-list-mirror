Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570405;
	b=wZYPGXmnn0PvOGcVQ+E31/Fqc7BAfwO0MVKLEP5v4XkInN6X5j/zhn7EkNqqNtf0GBeA
	 i+HW3Sp+HejZtbndxKGS5JPOwf6Ss1VwDcxI3GKAqoy7xdX+cBLuO/3C8Ggbq2OzuhqTK
	 DirOD0vSJ8pzyR2zH/EwD14+narhqXNoHfHimdW0dOPT49j5vTr46IWIPgHxiKu/o9QrY
	 ENIGulJd2eCL0fVIGXpypzFxnci+CUhnhQEu+XMtsbTKle27mcNv4v0pus61ASTvzIjDt
	 5m0EWhEtCj00Gf3peWAchEoLGYKE4DDINWujGTPkVdDy9xI0LL4sYHlkpK2wbbkgyoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570405;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=a2QutNsfvUbJDiOjOpNxfoZYgtz3+hNLVyELl1X4oCQ=;
	b=Ed3LIw6/1wwLnwfCWiHGgsw+q9aQX7OPpGGyJRQaCoM76tEu4Ktr8yQKnPduqz0E9+i/
	 MiWPqeuISupaA/9Was9p8XLM+eCfXAJZrMVRZRGaMZW4SEeTgX/1XMBBSv/GzkbwQJpBe
	 rRmC2zd7NPFhSUFdd4mWtyZ6x7cwW13oaLZmzFQLkHbGFSCO/8riwuFu7tuT2l8w9kiIj
	 559wUqdSWAT9beiCGhr+N7LnfpTyZbhlEN79sBlW1WtArzjlU+tztcg21mNPziT8EOYjA
	 1msOvO4Y3TGwME3+y9xQv/YJXbWEvQrxkISdmqmzTsBkiiIMI8jhrCR/hkUx+XHZfaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HZ8g1j32;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wBELXt8y;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B2A606A33B
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:46:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72B2A606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=HZ8g1j32;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=wBELXt8y
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D0DD41D0008F
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:46:44 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 13 Nov 2026 06:46:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794570404;
	 x=1794656804; bh=a2QutNsfvUbJDiOjOpNxfoZYgtz3+hNLVyELl1X4oCQ=; b=
	HZ8g1j32If8syG5r9L7o3NXNyKbYYBktEC8i1CIb3d5HUIcmG6FNj+dR7Q9QDZvR
	TEochCZom1XnaoQSRsH0YczT2pJWfPr1wsGE15jBT56zNQO1d2VMXVexJJkcUz4P
	IVeL1RYEOpvIJEMZAgwIHizAvPbzvA2MVXFcYaYOUXunjxFLH8gz5h/ZfgA4BrYu
	rmC0Cir74mUvsjbw9X94nsYOY56FvLIgmVyxVFXJsER89I1EOiyrbqTJ34p0z9Sf
	YNyFRCeASS/XCF4I1fhbs6PmZOPF2h0t1sUUIIj8E3ujPo7Nu4ZQPeJW4IfshWrz
	UiP0Eycilh68WEcgITANPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794570404; x=
	1794656804; bh=a2QutNsfvUbJDiOjOpNxfoZYgtz3+hNLVyELl1X4oCQ=; b=w
	BELXt8yrmbWwzuhLghIipjh9cVvbp1CAl0r4tbHYeJjxkWJmuaowF3vW8etO8uqV
	ZQVLiNh+xUIg5InSYCVaVSW4H9GQpbtypCCQ4kwEb5bts3Q9dCA9Wtd1xW1TGV4k
	rl0LE+Du0pATO11Cohg7f3j+4NsxB65GXmoorZ7k2biHJaE1sGew1GLkO3H1tD9Y
	ucYZSqaPb6ZT0c18R8V/+06gbXyAx6JitO3HHEJKoFR8k5WwGozbmXvlItZikjoY
	cwCf6s42hRH9Rizi1/U8Qa5/y52bS+YvudPvOW6QO8rXAm0hK5gzRVcC4OttkoeM
	axc2WWqpRaKR/KR4X0KBA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794570404; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fDboKQ78bTVkEn5CzvibL8lW4nRmR2sHGWuo21lWTlplLN0
	q1frWAqYilBYNab4MqqtcaUAyzDiaPA51JgLoGRI98A74O0YZIN6CUgBHyzDcPmR
	wgbk84AF9sG25ut4L/naCfSlqFt2XBBf8au9UMCHxcnKWnnb+Bu3lrsetRGn864Z
	ZPdcSVuMnYWJV8EDbvz/mXS8rDXAcGC3yI6fMuLW+keohXmXrKXMq6EnAct2TTfN
	tXDlILig3qldp/IVXa6bYJjWuU1T9Ovg8MDI2kWI7xGD25BVJ9faCFFVGbm3zal0
	MLWTqffxWlBLn+NlTAf67LAv4wBgp8K5cUGHKzA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:AoFICo7DLBiTERA7GEd6+kYP6s8j3tovOu54rFSy0KA=:uhNaO2KGhExLB7yq88PRXgvpfWwNhwbDOVYvzXzpm9k=;
X-ME-Sender: <xms:pPj2ajc7YfDwlnKL66FL7uYdu_PX2LtcA30N01UM96DS3Dp0jSl7Qg>
    <xme:pPj2agK17aOARCcvpvqryVOLKmsB35n9FGhC763xqeIfH5rvBjXRqrEhfijzzPAS7
    cvM4Zsk-e-ND_DApKxRZKEPoVeAMSfuEgw6-WzYcVHSAASaFFCp0w>
X-ME-Received: <xmr:pPj2aiJJ0HLwc0kdNJgsFcvc9b4-CgyKtRYVqLZtBrmcuIgA21TyMA>
X-ME-Proxy-Cause: dmFkZTGmxDoWqEMuc57Due7UI063KNsVC/6gq6Zxi7CJJS66EK1Q2YGgMpmzbcUcbOnR9D
    sGaSePoyoVvf0+yrEK5x9MSAkjYOsAL/uqSqETSm4OSKAbNHtjBVwOkwpvkvk5VuwfN6M6
    UHcV1eJ6QAmlRs9qFh2WzgkmZFfs/u7b+dZ9S3/TZxJf9VVJOAuV+89kCWduMOHUb1GTQy
    z0l3doot34i8E1R7jHHBcfOPT4LAiaHvIk54p5ohk+0Sxws7Vy64eaLW4HT7m3nHlW2lL6
    DaxcWK/cQqa9IwAXtFx+3W7Xe436zoWGpQsiqR++sNj+y0IyLZZ3m6FtKq/uSSKTZ7zGkw
    s6X7kIPe7AYd3LjSXMP4SOB1pefrvMPDxw01AGbZcymoPerlGMkZVpauORnTIhrVJ0kpq0
    aDvzH5g0mZIyi8ZP/x0RDw5LIkVrLXn8AWm2nuRGc1VCgUk1R6zaU+Bmdi+Cbeybgr+csq
    fA70fx8YK9VLHp4wThbI55C1xmH5vbbqtpZwqDIvPPtm6shfRsWtoJtqmYpre6lcF+YK0r
    ceiVUnkUO/P4Lu3LLJHlGgTlRydwUnwzmMn9sk6mOVLeSgpBSDU5VeztJ3NMd1FB8aapo8
    UeyzICbF1a+VVBxDHuXs6grBnQEDX+OK/40nujhpMLMMLbXhvEo1GQAyWqvA
X-ME-Proxy: <xmx:pPj2aqEwMVTrz40bsn-wed9NuruRMkNLfPxJYGj25m7khe9yH8HBzQ>
    <xmx:pPj2avlPMx7zLJIg8Vu8eRYoFZXB3ujPhwll_dciVGw5aXyhnA1Rdg>
    <xmx:pPj2avKv6V40HbqofYAL9i7x0OGp3toMiiSDARXm7faxF222WZmsxQ>
    <xmx:pPj2aoZfqntpxVz9hjv4RbaWEC2wc8Y0QI23DeWlzGVfXzTZ4D60hQ>
    <xmx:pPj2alPqxo1bnILHNRuQtmEnqVDAOA-Hu4G8LaXun08Vmm4ZbiCPLEuF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Nov 2026 06:46:44 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0823cd0f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Nov 2026 11:46:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Nov 2026 12:46:18 +0100
Subject: [PATCH 2/2] builtin/repo: don't fully parse trees
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
Message-Id: <20261113-pks-repo-count-objects-speedup-v1-2-7ba4f29e74fb@pks.im>
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
In-Reply-To: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

When the rev walk hits a tree object we read its content and then parse
it via `parse_object_buffer()`. This requires us to perform some extra
bookkeeping that is ultimately unnecessary as we keep those trees in
memory.

The only thing that we need the tree object's content for is so that we
can count its entries. But that can easily be done without having a
parsed tree object, all we need is its content.

Refactor the code accordingly, which gives us another significant
speedup when executing `git repo structure` in "git.git":

  Benchmark 1: ./git repo structure (commit = HEAD~) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    9.635 s   ±   0.072 s      9.534 s   …   9.799 s
    Memory         3.4 GiB ±     0.0 GiB      3.4 GiB …     3.4 GiB

  Benchmark 2: ./git repo structure (commit = HEAD) (10 runs)
                  mean     ±       σ          min     …     max
    Wall Time    7.676 s   ±   0.106 s      7.568 s   …   7.823 s            -20.3%
    Memory         0.7 GiB ±     0.0 GiB      0.7 GiB …     0.7 GiB          -80.4%  (5.1x less)

But besides the speedup, the bigger win here is that we no longer keep
these parsed trees in memory at all, which translates in a significant
reduction in peak memory usage.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repo.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/builtin/repo.c b/builtin/repo.c
index 98be90891ce..64fb5e788d1 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -820,14 +820,14 @@ static void check_largest(struct object_data *data, struct object_id *oid,
 	}
 }
 
-static size_t count_tree_entries(struct object *obj)
+static size_t count_tree_entries(const struct object_id *oid,
+				 void *buffer, unsigned long size)
 {
-	struct tree *t = object_as_type(obj, OBJ_TREE, 0);
 	struct name_entry entry;
 	struct tree_desc desc;
 	size_t count = 0;
 
-	init_tree_desc(&desc, &t->object.oid, t->buffer, t->size);
+	init_tree_desc(&desc, oid, buffer, size);
 	while (tree_entry(&desc, &entry))
 		count++;
 
@@ -846,10 +846,8 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		unsigned long inflated;
 		size_t inflated_st = 0;
 		struct commit *commit;
-		struct object *obj;
 		void *content = NULL;
 		off_t disk;
-		int eaten = 0;
 
 		oi.sizep = &inflated_st;
 		oi.disk_sizep = &disk;
@@ -889,16 +887,16 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 				      commit_list_count(commit->parents));
 			break;
 		case OBJ_TREE:
-			obj = parse_object_buffer(the_repository, &oids->oid[i], type,
-						  inflated, content, &eaten);
-
 			stats->type_counts.trees++;
 			stats->inflated_sizes.trees += inflated;
 			stats->disk_sizes.trees += disk;
 			check_largest(&stats->largest.tree_size, &oids->oid[i],
 				      inflated);
 			check_largest(&stats->largest.tree_entries, &oids->oid[i],
-				      count_tree_entries(obj));
+				      count_tree_entries(&oids->oid[i], content,
+							 inflated));
+
+			free(content);
 			break;
 		case OBJ_BLOB:
 			stats->type_counts.blobs++;
@@ -910,9 +908,6 @@ static int count_objects(const char *path UNUSED, struct oid_array *oids,
 		default:
 			BUG("invalid object type");
 		}
-
-		if (!eaten)
-			free(content);
 	}
 
 	object_count = get_total_object_values(&stats->type_counts);

-- 
2.56.0.611.g1030f0b940.dirty

