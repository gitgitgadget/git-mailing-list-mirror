Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890932;
	b=HPyCSteQ8vHHNWKl+C0zArBYzEAlMiyatJVjxb8sPA2j5Nf4rj8LVeLA5g3b9QuhUusW
	 AqOre++yaKpchmx0ubP2+R/xLrJL5uaA1hG0KBqARF8ypt6HgQsxjAJDIpcr5d/r+q+Q8
	 4NYfDoC2/iQTiuzN18yk+IyPzXaCxDMBzuQJaYQ2sVILcFjjWKagEv8dQGQYxvfXOPVNx
	 2sWgS32tdrl23fs+zJdFaLlh4GNJHMeluT8tfvltII1FwO6Co0+vTw8dW9mEbRbgr4SZu
	 YtgDn+5x+sOaGcFcHTpm3szevUvo3aucfouM2jWCPMRTWCZwb5iErbPX/qu/ArUfeLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890932;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=xAdYcomvQKSpq6ittrK2D9qZKhR3SvUtaPG9gwlDYwg=;
	b=G2KsFm9Z1XX79QQ4pI4Yglplh8SH9hbWMrTz8kU+FbNTaljnf3sWcWNIi/VRhUS1ywva
	 b7+WELcSmVF0OdHpKYDjTLiGe+7ECjGW6HluVIG4Q0RaRDJwG6KsYqZ3+5zVmM94jDIVE
	 MLsnwMmbJSvNexiGH5zXOUCaPuNQ26jPBPPeYD3Y/Tu787MOpLGllRZfFU1NK2pZKKIDa
	 YBpa+lWu0NWGF9R5E656cIjmhjYK7hZZaa5nVpao2IvXI+9w7Jr+5waSJ06bBsW0Wii7v
	 coAry7/fuYb9QCRkltTp7BAD9oXaxKjI3mlAJUrb4OcQKEhi3C+6/ruoN6/aDQpd99A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hVeTJrl1;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N2MT9aZL;
	arc=none smtp.remote-ip=103.168.172.145
Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68295606A334
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 15:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 68295606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=hVeTJrl1;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=N2MT9aZL
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id D358BEC01D7
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 10:02:11 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 05 Nov 2026 10:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793890931;
	 x=1793977331; bh=xAdYcomvQKSpq6ittrK2D9qZKhR3SvUtaPG9gwlDYwg=; b=
	hVeTJrl1Tuiig3aUeBmBMzLCueumxe89L/9FYu0axWSN3fMDXbwgw2eIXjTJ9zok
	gyqfI0ItglU0YaxqH51ch7TzsFsQhO3tnthesvYxoOlF54JJ8NtiOO91wSOnpmMI
	gRWd7k0NmZ+5qRZake50E6ALbyZ7VDQ0NUx5ndsJIXRDvdhG2PKEO1RlP2Q8Rqto
	VtxxaiXF8N/HTydQrKinD+5pG2ZZzU4N3S33sjcdBrkX8nqeG8WA20hbiiVSkm2h
	OJQYdQa4jKn/1B9M0WClDYNA7ZRNYH6x8YA0t2BFkOyF/vl1hfEBQ8ZpSr75tach
	zH0eAF2K8anAATyj+cJBvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793890931; x=
	1793977331; bh=xAdYcomvQKSpq6ittrK2D9qZKhR3SvUtaPG9gwlDYwg=; b=N
	2MT9aZLjjHTuNVqoz+SuSFFDcmfB+Ov14zL6KfsTgbTZwQ+5fLEIhhgNqXwOXU4f
	iBlW1a8YNYhxMej3ETIp0dAjtU37SZMLE55L1NN/sh7Urv2CVcZrCe5yU+LpELVX
	S4oiigf1zAnhu1SzpfVykVUsnhMdb4ipakzA/Re8adt4QAQQ+HYbopd2fnsupTQL
	iTsSOMWTpL25lp0jJnxrNMGvjWp0JzB9L3lnQPeM9AZJYjfRBrQ5fEphD3p0nA++
	NG+SaGHjUP4idTXPejIum/pH1x7aqCIPAnnzuzHiNgYbtTPKk4pTilkfq5IJfyR0
	4rEtA/brCBD02iP/LFdCA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793890931; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:TbECM8/G7Ng6evJtqA8//j9+emKVDKCxlBEWf7rAg4o/yLj
	7ATUDNiG2PnrB27UaQmNUCz5/xxmQLfkBj7XiUg7nWw3XgJfsfSBaarBamn4VA/1
	xEVTr1XLcP6ZKe4DPShsDnUlaiOThkHsIhgOHUD4LGTS6IXSaRBiOJoAsG+WA1xc
	bP6ppkJ38A4k7jz6/eyTIbRjrZoqaOp6ccXgaLzczR5zZThMXucmGVHuozYskgtE
	0K1wb0sNWuBFy6Dy9aALtW0PA3LkcTQ+Cwcez7V6nLMPOWjMZewivmH9l1GHxQfb
	8IPB1QT/t8ez3fmJ3bG48IGfoCu95v/ULoKALrg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:yGvh9KzB64mYPqD3oHzXhVn4vCNh4CJX4eZFwQorMs8=:YftQuvSYcRE72EDKhDr1HG3wRT32Kvcga/9lLbKx74c=;
X-ME-Sender: <xms:c5rsapo9OK0QrRXVJFMVI1R_UjsSGgGVXyya1D1PJRABUVwIuFidqA>
    <xme:c5rsaimr4kTz6cNfM5Gx7tBO6wu5RDXzC383pGrZGMnb_zSMyTO5hZywfMJn1sEWK
    y_DgSPomxgqunsCJMSyr-k6RqoJ6eSXg6eahQ_55Juw3Co5pRyL_Co>
X-ME-Received: <xmr:c5rsar0hOM4Ozp56whJF2fe-zxBBzv_A6l8_ZBBJ6gX9eCQWKyr6Nw>
X-ME-Proxy-Cause: dmFkZTGqtABMV/Ng5DPpJnKcqa/f6eamioVcKyE6/bDZ5WBL3jEqqBxrtFxVMCtiLJAgJY
    mBLrBuN2AF2kwsfF0Qes9TVosqOyScdmOuCblWuAw42/c5XS8xOFxs34vvPTvyZ44mOf02
    a9XyoJsfBm2gsCrkzTIX4eTJQpYiHwEs8z2RmoA4aAcOW5fgoZLqp6cBheKxcJQht4FqxK
    wvOec/TsgLHDkrqXlPa6AZSM/YfhwXRwdeAHlIdggR0o4ciOiW4HcZLBWP93BkQuUwZFKS
    2onmbQDox5lGtDDWmVDbnN32lykStH9d8vqcpCi/poZ2EuQ251IJ1ZZ2QOkgoISKIvIQmH
    P8tX8j0x7WiHVCCZ4YX2KZSvD+3lYTaYLinb5KnD7bK7FE7C8fz23uVAKf2y3dGAvCeZn2
    eymZLpQBU7UBu9XqYZtcPgs5mOGy/om2VQm51uOiXBDTavQCel3EsBP/EDW+Rx0i+P43/S
    QKhoxj8m1hSRRpeH1WjdCUWiJvR+1Cbw21H5ZvRtdg5a5e0QA+kf2k0/+gMNXh3LFp74HM
    bd0zbRL1TkxqSeHpWRHUUhLTdCU1OEGtJeRuEvV3IEAgCjCEb863l0ilKjgMi8SlPl3286
    TtTBTduvkcTVlOqnfUNTIAuCwEkaNSgIzhIgZA9BV9op7JNVZHcIHXKrEV6A
X-ME-Proxy: <xmx:c5rsaqCs56QFEsCYoY2ewFxxOjPpihtW3yNhQheGXDp-tmdXK5NkaQ>
    <xmx:c5rsaow1YeDTx_McR8Cobz8avfQap1te3fqIH1Fv1lZnQDRBTI1mfw>
    <xmx:c5rsaomBOmb4emVecjo4mvCH-RTTR_qunT3TDw1Xr2BOrRwbm575XA>
    <xmx:c5rsatFGlV4Cui9XaCskpuT4-mWWGR8aERobjjVk8mqI8E8aoo7iPA>
    <xmx:c5rsahJkoEixziIgsP3JYfmRhNMmV7mLIJEJwpm3qc6bfIxN5uYIVd_6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 5 Nov 2026 10:02:11 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 1b35b873 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 5 Nov 2026 15:02:10 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 05 Nov 2026 16:02:03 +0100
Subject: [PATCH 2/5] odb/files: create leading directories
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
Message-Id: <20261105-pks-storage-format-improvements-v1-2-870bb4212518@pks.im>
References: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
In-Reply-To: <20261105-pks-storage-format-improvements-v1-0-870bb4212518@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

With the same reasoning as in the preceding commit, create leading
directories when creating the "files" object backend on disk.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 1 +
 t/t0001-init.sh    | 6 +++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index 6b423499fe5..e7503548e38 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -97,6 +97,7 @@ static int odb_source_files_create_on_disk(struct odb_source *source,
 	struct strbuf line = STRBUF_INIT;
 	int ret;
 
+	safe_create_leading_directories_no_share(source->path);
 	safe_create_dir(source->odb->repo, source->path, 1);
 
 	strbuf_addf(&path, "%s/pack", source->path);
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 23317e0733a..735ab9d8475 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -944,13 +944,13 @@ test_expect_success 'init with --object-storage-format=files://<relative-path>'
 
 test_expect_success 'init with --object-storage-format=files://<absolute-path>' '
 	test_when_finished "rm -rf objformat objdir" &&
-	git init --object-storage-format=files://"$(pwd)/objdir" objformat &&
-	echo "files://$(pwd)/objdir" >expect &&
+	git init --object-storage-format=files://"$(pwd)/absolute/objdir" objformat &&
+	echo "files://$(pwd)/absolute/objdir" >expect &&
 	git -C objformat config get extensions.objectstorage >actual &&
 	test_cmp expect actual &&
 	test_commit -C objformat A &&
 	git -C objformat rev-parse --verify HEAD &&
-	test_path_is_dir objdir/pack
+	test_path_is_dir absolute/objdir/pack
 '
 
 test_expect_success 'GIT_OBJECT_DIRECTORY takes precedence over extensions.objectStorage payload' '

-- 
2.56.0.500.g5d06dc02cd.dirty

