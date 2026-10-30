Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793355716;
	b=RScLldloE6VephCrNykdtl7MSMKoV46Ov70wqFwoF3hnL2mgq9lVmFCGCOVuIH6he9Yg
	 xlQ+gCyVHchpamBiMg/hJnI4owVJKjJiUzqet3EnK5FgQD2SpbqU9EXgM16IUVgGe/OxQ
	 mfmPEujt8v8nwyBRb/JaUsgiHgMSoBE0Y1HOEYDa3kDb/lXJLdyQ0vkQJlsWPlxgcS7Sr
	 V5q06i5JL5mPXzSI/bFcbazk+kdtgLriZAftHTIuQHVKNPqqYBM8sLks3NkNxPlBzQi/c
	 /HumBd50tSpJhMCUOzXVJns/E4uYScbFJ3k/34thBJSOpV2awo8MmOEiX+5EeRk09Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793355716;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=PZhvSpbs+FQD1B9O9jYr8OFYf8FozI7PPT27TecGtts=;
	b=to47h+57MjvQwBhk1wURzw/NsOpgOMjbVCZWssgClHrfZgVEeyeGAwB9ZK+r84oaB7vZ
	 ZbVrcgde4hPcjmzcYmpALm7wiT0S+8gArS9El2m2TOoFimdCr3jqGqWz20UPBdEomGbTQ
	 kvvUtmNza6jOIlj6fcApbJJ044p+U9+m/T/06UEVP+KyoQn69rXFF/nxnmaFgOEvH6OtG
	 IfGOQuFpzJ+g2xp1Ci/d4nrsqw3DoDpP1zkJxkCv2q/jidzEs2zRTDMHcD/SHcznsWnkv
	 F+Ady82JjZdgWRT1J1jOQ45jR/uvCh5qL91ZoiCR/9E1atZYbJrvNfhmk4rYbKua8yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZxkBbhs3;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=l+a0d0ke;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EC606A323
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 10:21:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C8EC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=ZxkBbhs3;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=l+a0d0ke
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 93B191D000AB
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 06:21:55 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 30 Oct 2026 06:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793355715;
	 x=1793442115; bh=PZhvSpbs+FQD1B9O9jYr8OFYf8FozI7PPT27TecGtts=; b=
	ZxkBbhs3+2Q6PnDxuBDweqTy2UryTzayK2XbO9sGQ0ZlnklEzyGWFhd1DC8o/Kd8
	kpyGf8jYz1O7M+OL9nRafcNv65BQ4/x6oL2QL0km9jIQiHvEOSmRcc4Qd3kxxsu4
	XWVqIP6DsCcCh9dpM7QFgParjlmniI4qnHIfWagEvbXY8qIkF0/86DImHuJJaDof
	NlKxRNPip6zcBHgmnx7SL9ap3eAyo3GLQzQGBijKOAb0BAf9AaqkOTQfZH37pvyN
	qGwcWMpEhpIpSthqRlmbGLqAynwr3GjP8Vmo1D1UNxidw5/zS4uqZcUmdTbA9Mdg
	fENYKzduqgAZ97EDKpK9Aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793355715; x=
	1793442115; bh=PZhvSpbs+FQD1B9O9jYr8OFYf8FozI7PPT27TecGtts=; b=l
	+a0d0keDkO0YTGVSt+ztvmPbjGfOIZ+9UeJAj4BN9PkjrDt/rq+eSnw6OrxhLXP4
	Yp4Ug3bWoKZfCY4WXpmIEq2xipPhyyHi2oeDt9YEImKddm4Y+fw3zwht/6DGif54
	JgMOeDWWF1nyPxMjsE6kdvRsU47SqwltJwYnJBNqyH1DpiM5W1wi2dlWjKrbHD7O
	haTd1kGJmTjvfN58yJaU3LZM4M30Oa5rhIaMc8JFYw9RcJYEVAUksyzqknyvGktR
	oys6yRdRprpnA6PJwzsEIcFNWbJ9b3rSDoyT/ndsRnv5i4vKC4dnZay7OKas75Fo
	6lZL64GhtmtMiUuaSoXXg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793355715; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ksu9KoFDEx5iM4mO0/Z5v9i8+waGYBCbFpn8pZpE3PAGvrK
	DPVEIjzFoL4PmaH10s7ZDhVsgg00eVMEDDzX3x/fuW9Ct780O08RTKixcBYiQe9g
	q/Z0xtVU+rxU563bcakr9PwYnh92Q0/JwLHcnWXzJlY++JiAAkoTLIOOMlNummWQ
	uzPYlIjGQ15inJuqzQ7oW14MXBQcgoNjgqtsASFXkiYifBL5g4miaRZdfbc5pvlG
	NTGYdh+J5FVTpH5tJ+d7HGyGOG8JpIbjjsaxgptLXT2KCWaWNGn1QebP4eb33EBA
	adiO1S0BtwppdojKjY2DG7/XcmH+JBHETDxZo5w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rVDD+s5IevFql1sHD3QO/VPrBOjQZwvXqkTp4XyJb7E=:E5WFQ3UMYkT1/YzKFiGdhvhsIK2btOejQjYn+Cxl/CE=;
X-ME-Sender: <xms:w2_kaiFrGczlEo25QbexRGGutM5M01onKJyf3S84-RAhvioFBLzTew>
    <xme:w2_kapXiEfZUzTcxElOyzMxEvuMzJJpMe2MuDl-ACgtZDrp_WkVNSy3SVUMpzWGTf
    ra4iBGtGWf2ip8XFQLxpbSMTVqtMXKBD2p7KPED7S65iSriZSTtOA>
X-ME-Received: <xmr:w2_kapxN1CIzvgWlFDF-VWAMAT14a-uv2u15cX-qHp73R_3jTCRb9_uC-LuDBoyASR5Fdw>
X-ME-Proxy-Cause: dmFkZTGnfjP8Ce7Y5OxQEoi584NpxOS+ux2/AlFQpPqlCrctePrPU9xtuXEN57EydbMOeD
    uKCcBR0ZCHWL0JVVKdP2toch8j8m9MhSLZNd26rU3Jkm3/zUqEF4IuCZTnwIxaDY0V/tLj
    HPCCAd6edAcH74Fb6dTyZnpJL5lchwnIo77DZeDcJBpULBOuV/npxiguobs5HhHHcKxRwg
    DnXnPCidbyg13/FKdrwVIJXASUfEI7oDWJDcbK+MVWvtcezD0lEuTpE1YENU42Xjiy9+7a
    aou8YssUOX+9kEmTzwmAUrwGE6OIrCwqv8eeOqikEaid85oaqsh39WchJPYMjdWG/Q1aoE
    W6afvULI8GRkIfCysuvIyy9XRUYGejyB9Z6D3tdRfYw6jZXGbzbWT9Eza3kwofUbax504J
    l8YdhJyZKkfEZvDcH8IbffbEX83Ta0Oj+zGSs2vcC0ZT+58troOqbsKsvswUw23VH1AXAO
    xeVhtpLpYwEigd2YH+gt5NpqHiTOeCPnwQB6mWh+bLjEPRSyjp6lBp7JnIgCfdY2/1Q+55
    WrmR717ukBb1SbNJZAabPrHMOTFCfmsttzrhYIZNcI9nvba14ib70sB7MisaeNGzKND1vK
    YCXxspHiSpDhFJMKX30A76ynCdxFF4pW0m2yqY6Hj5ngQAvXNQw0t+g+waLQ
X-ME-Proxy: <xmx:w2_kanN8yY2RWcxSftvZLp9IOwHlgxLmuJ6ibP1BfmEPGD0c-GGjKQ>
    <xmx:w2_kaq7MY8JgEaAxiZ2Z0Lv2mvmP3XIuy-kBdGjEqqmxWERy79SPpA>
    <xmx:w2_kaoNlYqDwJY6_whRQIlAlcYJz4z7i4dZ94-PEIhp_UU-jaxfxMg>
    <xmx:w2_kaomdcbuoJGPnGhPwAsFkkIg0uDO76bioU_kiO1cVCWH8YPI5Zw>
    <xmx:w2_kai1wIv8jy6otXApXorhZylUqvYqA1BoxCx_JjnWoTgG75e1HD4KS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 06:21:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ca31a28a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Oct 2026 10:21:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 Oct 2026 11:21:47 +0100
Subject: [PATCH 1/3] builtin/grep: read submodule trees via their
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
Message-Id: <20261030-pks-grep-recurse-submodule-v1-1-d4eb5c87d8fb@pks.im>
References: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
In-Reply-To: <20261030-pks-grep-recurse-submodule-v1-0-d4eb5c87d8fb@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>
X-Mailer: b4 0.15.2

The function `grep_tree()` searches for a specific string recursively in
a tree. It can recurse in two different ways:

  - It may either see a subtree, in which case it recurses into itself.

  - Or it may see a submodule, and in that case it recurses via
    `grep_submodule()` which then again calls `grep_tree()`.

In the latter case we continue grepping in the submodule repository's
object graph. Historically this used to work by linking that submodule's
object directory into the main object database. But in 93cd344e34f
(builtin/grep: stop registering submodule ODB as source, 2026-09-11) we
stopped doing that and instead expect to read submodule objects via the
submodule repository.

This logic is broken though: while we indeed know to read blobs via the
submodule's object database, we didn't adapt trees in the same way. The
result is that Git fails to read the object:

    $ git grep --recurse-submodules -e hello HEAD
    fatal: unable to read tree (935cff11a11f8734cf4e0d40955d1e0e5c12038e)

This went unnoticed because our tests only cover submodules that contain
files at the top level.

Fix this by reading nested trees via `opt->repo`, which is set to the
submodule's repository via `grep_submodule()`.

Reported-by: Root <rootminus0x1@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c                     |  2 +-
 t/t7814-grep-recurse-submodules.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index b045f8a488d..22fb365eeac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -653,7 +653,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			size_t size;
 
-			data = odb_read_object(the_repository->objects,
+			data = odb_read_object(repo->objects,
 					       &entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3d149d34c15..f51c5181805 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -631,4 +631,27 @@ test_expect_success 'check scope of core.useReplaceRefs' '
 	git -C base grep --cached --recurse-submodules C
 '
 
+test_expect_success 'grep --recurse-submodules with tree-ish and nested directory' '
+	rm -rf sub super &&
+
+	git init sub &&
+	mkdir sub/dir &&
+	echo hello >sub/top &&
+	echo hello >sub/dir/nested &&
+	git -C sub add top dir/nested &&
+	git -C sub commit --message "sub" &&
+
+	test_config_global protocol.file.allow always &&
+	git init super &&
+	git -C super submodule add "$(pwd)/sub" sub &&
+	git -C super commit --message "super" &&
+
+	cat >expect <<-\EOF &&
+	HEAD:sub/dir/nested:hello
+	HEAD:sub/top:hello
+	EOF
+	git -C super grep --recurse-submodules -e hello HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.56.0.341.g393f52fd96.dirty

