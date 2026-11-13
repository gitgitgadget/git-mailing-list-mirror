Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570404;
	b=M70z4OMg/rQjg7FgS6yMiBA5lYPf7pAgSkF2hXkXwG/qSdZAnCnfLhcvoBVAx44gNbYt
	 zxeyoWuZWn+R8wJLCe1r3XpM4p9xYUKfxO13I3+v6Vczlxij05lg5ACvDIlh8UFRfC1ag
	 f/lau/LG74ExQ1qjAUebfjagcqHWjgdM21rjbPpnUgCU6DzpmRjkFYj6YcTJNS7CbMB8c
	 WApr/0uHykfCJoplJ3iktUBrK+6ipa+Ma3zFFRkouS2aeNHrurNmhGba0gPBgB0Cm4DTm
	 kKu9sT1KRf7MZPljQFurhliFxLBr3X5A+Pxoy1atY8etYHNpZ2MqfwkGKhVKDQ0fxow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570404;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=/YKZEkboeFNmWEdcMYFqIbLKPhr9u9jd5IdDI7XeUlo=;
	b=uowrrxJsu6iDwgVz2+TkTZ358ZnhWANlBVoIk3AOuBEetmWvr0LGbNC/TBCpcZvRgIS7
	 9cnDxWkNjpJB58OC2VxNIXOBIiwBcSn/GuKJdYNdrngSCz74GgFEYvqEVs+gYsLLxua6k
	 vCQYnXt4/B8zj3V+R34TPMz9qVG4wrNibLEnson42Yhl58rjwynV+maiHX/TCQo5q2xOt
	 kWmJiBiZd4MAjUwmkRfSKNHu8Cz9v++7LaATgirAlhRksNpUbkXYY38MK5qQZ5mvIN83D
	 N9TM7apxM6qMS5Jtzr7eRaNM5Zl7McKaZT4JHuh1NIxWR2bTrWuo2XdFQPYlErac2lg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=VIqMv4gP;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rPqK8x1H;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB52E606A32E
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 11:46:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB52E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=VIqMv4gP;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rPqK8x1H
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id E29C91D00468
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 06:46:42 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 13 Nov 2026 06:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794570402;
	 x=1794656802; bh=/YKZEkboeFNmWEdcMYFqIbLKPhr9u9jd5IdDI7XeUlo=; b=
	VIqMv4gPpCN+dYl+GVw1Oej0bZXJZ2bHJB4lBA8wgYSuWAy3R33OMOPbQcSZpdLv
	tPosPhlWD9vJzukn4vusLYEklApNsfHfNzOOeVG1KQd9zu9j1olSyaLUDPzQj1M9
	/RKoNyZiafaPqU7DgBLBvN67IRsgzE5GXiq9s4HjVciwAFFNJH6rsC/QoT2S5FNV
	P8Uw4JB4djfKfU/2AikfBiljsxPh18TL9dyzn42gmwJFONWq0A7wxVCqIrZwqZWO
	OQE/Oq1Jy2mC9uYRlrGTBZ9S+EtRFhaqcj5iHiQOo/LehAdBWn0o4y/RjbpZbymk
	fAG82HldaPFOu4l28LUFnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794570402; x=
	1794656802; bh=/YKZEkboeFNmWEdcMYFqIbLKPhr9u9jd5IdDI7XeUlo=; b=r
	PqK8x1HVYZAMOI6d7Vnk/CzckApgc4+zTYQtZHsNqaZdf4K04pcY+mLhY7WivXxg
	qM7HYMb5Dtwmgv/ceYr+pV2C7gstsPsfh/t8rxBLH3kEkhxPxFYowfczrUqchQPD
	M54zEAv9jni4gIHzXVkJJzTMttOiMjNctp+Oh1MPhral02tUqe1Y2n+/7vpDlaJj
	Z2eyWGusrkQ/zwY37+4zIHBTHB5WiSQ9Sq99/2Qh6IW3m8KEOrdcbJvk8iSPckwU
	ii2Dpr5zxfFc8XjK4FRfsZTrqN3g7wCusHLOVPkyTxCIwhnqTSfd7prNWIQz1+QP
	PKf1I+2kx60gECaxcO+Bw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794570402; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:knoaaBFQ4M7CT3OWtffVq/pBLZ/B0Nl+0ETMPPWcQ1H0o9T
	rrREmcjucs//G+nfhx2E7yphF8djE/hcMQG94tjnmdURsxs5ZWv7UCDzWpIZwCSf
	TFxkw78XgKW+98UeGJzZ3XIihCle4CrqTzIsRPxfVUtIaoipjyK+VCnOJcJxfQdv
	3SBLASeoWzTsBIrHXHMQZYqPq6FcVJ1HYMA5eWWK2/6uaOEGbX/nu5b3dVbmRWzi
	FERKjbsUfWM7ss3uY+bfZ/xCSyepqAlVVXH9e3DEO6ggSC1qHEt6Mtmv2ZbiOezp
	sMe4t/u1F8LM3CcQT0osRR/WjVzdJjRqYv/x5Kw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:/Ws3KpKMZpNl4VHM0hHCoPJQCwvduHFsLdb/5tuMoSk=:EMVzZEn0L5jhc6PCeQWSGk6TFLS4j5fp6qCyWWPD5Zk=;
X-ME-Sender: <xms:ovj2apj6CvaJIOHr4MNZoc1tn6N-VwGzs4dNTMi-ANdmifwXioHVlA>
    <xme:ovj2ak9XkRrlIQdN4Kw5xqCQNnUKWFM9rFLK381b6R9qd_Gepxh4sOSYhOfVXixOR
    2kHO7G0Xjo2TsgX9myvMAi6jRnmCiLU6A0pslTIDMLtzbo3FwhXSZYw>
X-ME-Received: <xmr:ovj2auuRSV8k8UXSoSuM6rSxF23pbVkkiAU5tp5vHpkwjZGtNr4Cuw>
X-ME-Proxy-Cause: dmFkZTGmxDoWqEMuc57Due7UI063KNsVC/6gq6Zxi7CJJS66EK1Q2YGgMpmzbcUcbOnR9D
    sGaSePoyoVvf0+yrEK5x9MSAkjYOsAL/uqSqETSm4OSKAbNHtjBVwOkwpvkvk5VuwfN6M6
    UHcV1eJ6QAmlRs9qFh2WzgkmZFfs/u7b+dZ9S3/TZxJf9VVJOAuV+89kCWduMOHUb1GTQy
    z0l3doot34i8E1R7jHHBcfOPT4LAiaHvIk54p5ohk+0Sxws7Vy64eaLW4HT7m3nHlW2lL6
    DaxcWK/cQqa9IwAXtFx+3W7Xe436zoWGpQsiqR++sNj+y0IyLZZ3m6FtKq/uSSKTZ7zGZk
    SrmQEz/bwE/3cN+HfNZtL1RmSw3mo+2tzw1t5hTMNyu4vXy4u3uLd5lDglziU/caYpfBUt
    CSS0/cxpuQRNXBWJ2em+d/A0In4Cw1byNf1Jde9TQa5BS/7ZGJzOpdzo6kswiBZa+uEHZj
    xwLF4QpK6XK2iRORhLyZk3U1PMf2QA0Bm7Pc/Dl4cmagwEzQtqRdN9esqvJHqZqwLXWwdU
    8isWJLEHsYGnrU5p+qbMD2qS3R53W17dobSK5i8x+NzJAYW2B25QdwyF9X6soF/R2BAeeU
    ryjCRshKUhV5RaRr8SRFB3qLAnOJIyOCP0bmlgBmaDWRZP2x1C8elDvW8TXw
X-ME-Proxy: <xmx:ovj2ajbEhWLd778yNg2aBVBuaU_YtL8xfWO-il8oiLgJ9PpAZrQG3Q>
    <xmx:ovj2amoEKngoIqdgPYr2xoLbK97VnhQFnH2ogP3ffqcBGxKu5vxTBQ>
    <xmx:ovj2ag8KPqmCKKXaPeHjfNFM51RXjQfbHHjq7GF5xz5UnoykZshU3w>
    <xmx:ovj2at_LRiN1031FlFruckAfJI5URIw1briZ-aRzO02msnXXaoaXDA>
    <xmx:ovj2aiiN65nJKQWR5j0iXWv8cmC_AHXzlIWlxpYRTyGpmyczXhJO2adB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 13 Nov 2026 06:46:42 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 548488a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 13 Nov 2026 11:46:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Nov 2026 12:46:17 +0100
Subject: [PATCH 1/2] builtin/repo: only parse objects as needed
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
Message-Id: <20261113-pks-repo-count-objects-speedup-v1-1-7ba4f29e74fb@pks.im>
References: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
In-Reply-To: <20261113-pks-repo-count-objects-speedup-v1-0-7ba4f29e74fb@pks.im>
To: git@vger.kernel.org
Cc: 
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
index 0399c558719..98be90891ce 100644
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
+			 * Commits have already been parsed by the revision
+			 * walk, so there is no need to read their contents
+			 * again.
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
2.56.0.611.g1030f0b940.dirty

