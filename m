Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709821;
	b=oK93FW3jL3rNe95R152Mf+XhoS8PhN0resW6XVMLbIrGGahI2fgzd9zBU4ociJl5Fwih
	 rsR4j27oHPttJQUNSnLLOVvIENHdyrhBei07sv3PYrLDNtxhTwAYTZtZNR8vSxgNcZlFD
	 qgEVNYGhbR7HxsIcSILzWTBPHyyb0ubYiXJYl4Q7B2OPXEbT81tG17QcX2hbSfHRxe/gu
	 18pjmdJ7XaBZnQh9C3A7eArM3/PzXltx6u1ZYcjV8bpNTpAEfEI4MVgnrl2MEE6XcUvTb
	 xFLtZtkpKfhTyWu+hA8y9KIz18TIRqEy2Z808us4iF2EHgeevHbXkHLEGgR6s9E50Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709821;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=JYfoqFWK0739SnceN/xw4tw9L8sMqjdV4FyqM1pNvJM=;
	b=fvcUAlAPdv3sfKdPdeTJLeerLSZb8qR/JGVi4PCP26XCafy/8TC3fLWir3+ZR/kpiW8p
	 m/xmu1+p7nG2i5fMHYI/YVpYSCTlbaBZf/O01PdynrrZGQm/0LH/8Gvp4arsqHBn0yHu4
	 MRXRIDk6ePqLD2E1Bu3BB85Ozmd9neHOIRvqLaebqLlpzCKS/Of7gKlkdwRMcrhoHkLAa
	 TA74yzZ7Fh0HB3MCqFMv5i0fWLx56/LICwDVHL77B1IwwXC1InwkOKIHtCu2C89x4wqlg
	 6kK4P9/T81FgSV86F0s+7DVW0Va7U611plYVgwn8djKa970cchxQi9Re2MA/z4Hu3lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="sXUY+/QB";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MecsXbu6;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FEF606D826
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:43:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0FEF606D826
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=sXUY+/QB;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=MecsXbu6
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id E1CAB1D0021C
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:43:39 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 03 Nov 2026 07:43:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793709819;
	 x=1793796219; bh=JYfoqFWK0739SnceN/xw4tw9L8sMqjdV4FyqM1pNvJM=; b=
	sXUY+/QBY+v+4ldGmNGXKMpTeQiTKOjDbrCUN6qL9ifTLbs0I7e7WMtWIeeMK4UK
	iziLVpCTf4LWvejDinFDeUmMbLhxumdy7xBxAR3eNdUGNJNVlQrBShpF6SawQ6GW
	VBaZO7a7H2/wLfytmP0vZt1VfomSk+gfeR2lsDT10CJ0M4AZn1+K/y3JB7Lx4XiP
	DAS4HWMU/X/80cyTDUUVX2fYxuc287f7S2Jx4HcOPSSBJRkA45xk3SybwT4Amy4K
	m9FnHJFF3CBokoIo+8Dzf+OjwARaWNGXuw/wOQVPjoKQSt6F7Cb/SDQsOxGUSDhS
	DMk1Ryhl5tAAoweWqR2i8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793709819; x=
	1793796219; bh=JYfoqFWK0739SnceN/xw4tw9L8sMqjdV4FyqM1pNvJM=; b=M
	ecsXbu6tZdLX0uDteG9bs54i/FV9SY2EEP1bPf3+FrhVKMvBN8/tuw93x2x/2JMA
	KHzWMS0tpm7wuvZCxamH0AaSX8TwiU0kjBfpjzkKErmY9W7ljN0AY+8cmppZFdSs
	ZXZ1IYE2FjLw+34eXe7gfyZvHre8Bs2k/IKYb+f+QwAQy+XoooGGyJljrgxmUvMa
	XcgoQ/5XzbxFBWt53ZpX+/EHKeU6+Sp60e1Q7zU6UCY8LaE7A2/qRd2DkScc5pAg
	aiuiN5qFerOpys6FbpBWqDpUamX2rcOYvFp9geZYO8bWgRhFmu6ga3vS0K9m1wP0
	7KRysQRF23PnCVx+OFwSw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793709819; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:fGpwye6SxvGu27czoqItRzoDhDgMlC6T4xYaKuZ9PDUcNsW
	XfEdlo1YQhWqOPfqXUmIC9WYkQMimgqvzeGCK3trCjY4j96d2iktkl8l7gGR5z0C
	o37San6H/mTe8hKjJdP0soLmeIkJ9s305hijuD+kNo6aPdZ858J6bM5P+NVT2uJ1
	Nyh+cP93Ku6XcNCKrguEsuCeaQMEmL3nln7rSW8L1KQZESCfuQsTKR0JQfThIcf/
	DOuPOtc923RWYWCW7zmqDx35hQStTJ50Zv6jEcWG2tUfeH+5242V//q/W+R1bmUi
	1UQrHXU/r+8UUN3mtz8byqwgnyAPPUmYXYlgibQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:XJc+iEyjgGp7MRPu4orLxXyPA+hSoFCQZ4ggpAjQzqA=:V/3Ya6KrG9+i+/oddDQZHAPEa4k0sp2cpK4Q8bDzj5o=;
X-ME-Sender: <xms:-9bpahamB3ZBzgKgJtVpOl32wdJLwxfHywj4oqd24EVDs710u-n6lw>
    <xme:-9bpav1ykwL8OMOWIHcC5lF2UlmZHHbvu6Pu3dabE_boOPgS_1wOo8TYj6ZW4nVIt
    EIh8Z1yLPZFRFSewB1o2art_9wXmKGg93qImaB-r6OQznINm3Yd4I4>
X-ME-Received: <xmr:-9bpahVM0S2J1EagtxYOPBtjlBPrQKrvKs0O72nHMFVtJPX4n0ww1w>
X-ME-Proxy-Cause: dmFkZTE9bw4aj8XCg136vA1W2XqjbzgHyCXkD3W2aEoGxmPmbuT7HUEaH8jvX8ZAAoGKqi
    K8YmCh02A6o5Ky7MwGZWHdBS7NHduZ5LbxezUDBzT1WBcemr9rWzcDEbICZdGnMppriJWO
    YP2La3UWeDvaFZTQlI7NIZ1OYxVOfvHGT/UhI/XA93Lx0fLGcYy5w4K9bUyBwXSQY0277W
    tYLf0hdtX4ZFBrxQ9Uga52S+iwolc1B+rAu34J3FNa+m96qz2zYLLF2zxhdpkwO5Fbx+Co
    5zoN0xxDhzOqi/I95xcRb/JpI5wEZllriYHMdjWyOWZN9/QA8T/GYok/P/P8UVohTe1pO4
    M3IgOmC0T3NBvYrJIU2VKkoF4BA+frRvSGPFUtoX3sxKAOoKuu9RYRgA+F6rr9qGz9xDSO
    rP6aQYsTnrzfRFY8akw9yIeds7d9x0XDGOvKDaJdWZNP+wfl7jps2+iKHHh6v0WaZOzoYo
    f3Fky9e9I9uZdoKCDwVNsG/ggr8PqpdfULB/kxFsRz+Z7Y1B4pBx5r56x7W4rxRspIiKnX
    wDd29TCB8+bst7+GdmS4Qil3ylr64EvTiFZPW9fzG2nnU2mnSKjeq8vlTmB6D1456EOL4C
    T59DQzJ/bof/dRFPOFnq34W3wR92PYISdjqZcvsn/JT2zNLPzPiZKSFrfIKg
X-ME-Proxy: <xmx:-9bpapXGns4FYyuYd26JTG5M1y81es3oqfG-NnPzWwhIQIsCbjwOgQ>
    <xmx:-9bpagfnwVHdP8Ali6InZ6CyH8iRLQKZ1YIu7Sc9-RN2o3-6dZUz7w>
    <xmx:-9bpaiUpJRyVVtWaJyZ2eDO06h75hPId09RWvUfxnIl-z6wQL2fM4w>
    <xmx:-9bpapfMuNDuCZD9wUbkPlfAIgcgE_d96g6NR8AuCszelaSTQ_R0iQ>
    <xmx:-9bpan3bUlknKXgqpdBbCXbJbNvSE54ktklwKP53SMrwQHX3PvqxevcC>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 07:43:38 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6805357c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 12:43:38 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Nov 2026 13:43:22 +0100
Subject: [PATCH v2 3/3] builtin/grep: read ".gitmodules" via passed-in
 repository
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
Message-Id: <20261103-pks-grep-recurse-submodule-v2-3-b00e3b3dc865@pks.im>
References: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
In-Reply-To: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

When grepping through a list of objects with "--recurse-submodules", we
call `gitmodules_config_oid()` to load gitmodules for the specific
revision. But instead of passing `opt->repo` we pass `the_repository` to
that function, which is somewhat fishy.

This is again not a bug because `grep_objects()` is only ever called by
`cmd_grep()`, and consequently we know that `opt->repo` is always going
to be set to `the_repository`. But it's a code smell regardless of that,
so adapt the code to use `opt->repo` instead.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index cb518d8155e..22f0a1b0d0e 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -883,7 +883,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 		if (recurse_submodules) {
 			submodule_free(opt->repo);
 			obj_read_lock();
-			gitmodules_config_oid(the_repository, &real_obj->oid);
+			gitmodules_config_oid(opt->repo, &real_obj->oid);
 			obj_read_unlock();
 		}
 		if (grep_object(opt, pathspec, real_obj, list->objects[i].name,

-- 
2.56.0.500.g5d06dc02cd.dirty

