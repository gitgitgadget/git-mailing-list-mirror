Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794394098;
	b=0XVDHyFQ0fDNrSAe2Os2CIyKK/gO2/ONJ+QM3lKM1FlVEiBR8wjl7br4/kIp1JrntM5r
	 tQZ0xx3aDqjAzpNaESy7XXyzDQ1K0q+0B5vPb3ah7FTY7cUB8xQzVgegD/Rqo0wrPrtRF
	 0JTyJrroecj2j0AAEs+A+VS5Ju9u67m558I9FIInO8ptWq6DTpYARXUP8kC5m/z0CBxsX
	 tkZYQau5QpfdfYXRSRIsnNQSv4Rz3T28iDj10Tze9PUqFKPfATkUTyLg8ldJxNOIIQ1KG
	 vdukrepZiX41uBJWry0blmXJdcZjb2htZB98rAc35GLghcHtFuRjN9ZchmFdWqW8RXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794394098;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=n0Tm8JzhgzmdLiwrAJJVr4+cz236zldfBThE/f40iRk=;
	b=R56ulvH1EfzBgJqxXEcMOQUXy3kEwrV3+PM5s5tAPfKgG/4WXbrW4bDUJ/24OJGVDwit
	 +mP7rDBOW08NfYbf01fCXHIiJWhJva4Z9FtxOEQVFYJfNHMk9OxcR0+bZt7M20Z6AuWM3
	 Au1HhUSHjizB2/NNrLS95Rjld5rL8wl9RQqeU9Obh2avVgY9gjRV7dvuQYM+UxM2gkQ4y
	 64zbVpyylOtaa3UODsElkNbt3RE1A3U26YOv9lvKD6fMRhQ+BpuDSh0BJi6XOIgR96ywV
	 y15+t6quWvoxUUaxMhU0TO7fOEbNG1ru2KvequIpCtJHFc1hZ6eDyEJ7/PI7obSw6kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=eZ9wdgIp;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q6h8JQ4Q;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66FF2606A888
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 10:48:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66FF2606A888
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=eZ9wdgIp;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=Q6h8JQ4Q
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B814F140013F
	for <git@vger.kernel.org>; Wed, 11 Nov 2026 05:48:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 11 Nov 2026 05:48:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794394097;
	 x=1794480497; bh=n0Tm8JzhgzmdLiwrAJJVr4+cz236zldfBThE/f40iRk=; b=
	eZ9wdgIp4Thzt6RbMGLOYqi83NGpW7wZn5BBkeU64tZH/J70QovLso3GNjYrBBWc
	wmQFUyQHge605x8InG53WU8VXExew5a7IH9UZvRwtVrEG5/krIHMa16hq3xEvbzd
	UkbTPeyebTJSGF2iM7LyZyenJNl4hMOoWBS3JhG+nC91O/mYscEcLtkMHFwkl4Z+
	El0fm8M7d+ayC5704GWEnRmIoNwXdbXosy0E2u3SpDDJWlI5gQDiuF9yO6UapYax
	P9IO37a2BPl/j5pqqiA1CMmBWnS3BgfMGSr17ypsogeUsna00htCLGU2TZFuafS1
	wF/xqpTC64Ntnz7mOZ+xiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794394097; x=
	1794480497; bh=n0Tm8JzhgzmdLiwrAJJVr4+cz236zldfBThE/f40iRk=; b=Q
	6h8JQ4QZsHK1S3G84GplKAeXiMHeaiL5PPnq9hgJzO5fXuKvHwJI0cxfIJiuFLCh
	+F2NNS+qLJPaFQCPGy5+sWSyJHPeakg3qca0A+47QyYYJ91d9HxzdY5I+14ROz00
	DOF9sOBUMJGdvjKTq3/ECd0qeZ2IoYMarTVLvgIPDHAlT4snKD2mLnA9OS03sevp
	IZ1/JjjJmCbbyIJrGnGa0lwY79uKeCpEy9dFelPUufkHuynkISSGsZmu/JOrBqO/
	4ql9WfhfmS603tqeOaer/dJFHboRVPTy9zZeiyFm/JKmv26V/1HjnKAxKD5dzW07
	i4RExDQqadZP/MKsAHIsQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794394097; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:K6808IyXi4Xw2TY6KsehCxvEpxvNdC035ex/q50n3ZFu5Ri
	VxGdtXOcfMuNWj2FcG97XqE6rhh5Frcagdg2rmUN41NZH9Nt9fVm7LrRJLJWE9yJ
	ZlOkdqerboswvkz11JNtMyUqAxLA0FBh2eZBMFNBXwdEgOTPqI2dny2Bb3XcQOby
	bBUzS5KjxlPPfyZFOYIqu1ZPnuxVZ72wSuv9R0iWi1ZslnDxIfiQ5VGfBCav6WNN
	uSjldKHikoPs4DnWnZURd9SglNemNl72L22rWrIfIIwOcOTRly92wD1X0wd+Jcet
	mrpgQLWMm4fM5OfP4LuDUubgdWYPdHUpNK9zR3Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:cikWs99JOm9vy3lp4JCoK3kp7WgnGadZUPQwg7LsOFA=:QglQEQtjuC9kFqOAt/BKPY7Hf/kiG0Dtp+NK14Q+ido=;
X-ME-Sender: <xms:8Uf0asaaCDg1T8n9qk32z-z9BR-wZyE6sZRH7oFnUUSKA3gVlj_ljA>
    <xme:8Uf0auaKblz2YVBsbh_hVSeN1oANdel_sncUH6LfcgOiyjOTEpLgJqGLUjU5DZlMr
    FJIbu2dtIM6bzONGqmWzFEXmkJdvspLiTnEFevu-jJnB2W-uP6bhrM>
X-ME-Received: <xmr:8Uf0ar_VzZkDBOD3aNgpawgVm7lRKJrfXtxMI7YAEhy7F95-bg-KGuU3LaHy6l-Eimtldw>
X-ME-Proxy-Cause: dmFkZTFuvSeLfPnWc/SyiFN8F57jHVIvDxg8e8U7PCFgzA7CmxU45BtgNWusxo2ApL6pkH
    yc8zN2vQDdo0qjjt+dhP/i6ZuaTMVSzr0D5x5Ds8+rKp08ttEaYSFNLgQYUGorDlK4uo/X
    QuA+End0G06EYLJQcTaq9mzlgrQErFjt11q5lQUtqtQE4p+QViliKoZgq6Zr+yoedukjEK
    5P1nH0hnMIlweRJiKZRg4kac103BHeqATSrsM5tV5GRa9BRQ5zPUc8cA9/fjRRKrZwcEb9
    LURJ+RYkcSF8AsrQ209FIUDmxFMTMcysOZeUfnKjAXfFozC1+LnBsL6a+mDvqpJJLBTztx
    6jsEyRDdRkNpDHJi813LeVtLfaC8kMRwrDiw4yq+7tM6OvpZs9TcPS0wn20oubfPYauhe6
    T8CQMzHx+qUyNRmBUgZtSY37g7EYLq5EAblTG0431lDDyBIW/Y/OsB3J86jcoO01gk+FB4
    /91QINmwSmyD5fiKKQ9tKMcU00sV4vPujBpMI95/0iQhM+tbCKrEX+O5w2uROga0h/sSLg
    3WUuFfbQORPVqgkuCsBn60+LdekyYOanPtroGnzeC4yd906NDSLCTqJyaHnb0qfmaVlKPL
    gfEuoQDayk5Ri7KFoTx+wkKPA10v0PWMcajA5NSW5rubIyUj+OiHyGrSzkzQ
X-ME-Proxy: <xmx:8Uf0aliq4fGXb_xTuiD7JsPs9xC17DTfwkwdj6ZZY7u9B3wZvczxEg>
    <xmx:8Uf0ajfNgcLfWkX9EJhH4nkTcpsfPbnEM0WWJ_3V8N1XUv6Jva9oNA>
    <xmx:8Uf0akoY7p5QNdRE94MLV1OHj1XljR8ULGeGa6Qa6pShYLsPgFG_gg>
    <xmx:8Uf0agDnVa1hic8Dj1j6ePDKEtgwURcPmsdIoJNu9BGsdMDpyBezkQ>
    <xmx:8Uf0ajROlFpGM9nZflKfl4cN4_V7Yu-KFMYkYk-luXYHMBuva1D8Qpyd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 05:48:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 077dd7a6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Nov 2026 10:48:16 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 11 Nov 2026 11:47:57 +0100
Subject: [PATCH v3 6/7] t1092: set up repositories from templates
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
Message-Id: <20261111-pks-gitlab-ci-speedups-v3-6-d1e34117ee2e@pks.im>
References: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
In-Reply-To: <20261111-pks-gitlab-ci-speedups-v3-0-d1e34117ee2e@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

In t1092 we verify the behaviour of sparse checkouts. We use three
different repositories to do so: one with a full checkout, one with a
sparse checkout and one with a sparse index, and then verify that the
result is the same across all these configurations.

Those repositories get set up via `init_repos ()`, which initializes
them from scratch every single time with a bunch of processes. The
function is called more than a 100 times though, so the overhead adds up
quite a bit. While the tests only require around 30 seconds on Linux,
it takes more than 10 minutes on Windows.

Optimize this by instead creating the repositories once, only. So
instead of recreating them from scratch, we can then just copy the
template repositories into place and thus save a bunch of processes.
This speeds up tests on Windows by about 3 minutes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1092-sparse-checkout-compatibility.sh | 34 +++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 05b54062b3b..5d81ec54c23 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -141,28 +141,34 @@ test_expect_success 'setup' '
 	)
 '
 
+test_expect_success 'setup template repositories' '
+	cp -r initial-repo full-checkout.template &&
+	cp -r initial-repo sparse-checkout.template &&
+	cp -r initial-repo sparse-index.template &&
+
+	# initialize sparse-checkout definitions
+	git -C sparse-checkout.template sparse-checkout init --cone &&
+	git -C sparse-checkout.template sparse-checkout set deep &&
+	git -C sparse-index.template sparse-checkout init --cone --sparse-index &&
+	test_cmp_config -C sparse-index.template true index.sparse &&
+	git -C sparse-index.template sparse-checkout set deep &&
+
+	# Disable this message to keep stderr the same.
+	git -C sparse-index.template config advice.sparseIndexExpanded false
+'
+
 init_repos () {
 	rm -rf full-checkout sparse-checkout sparse-index &&
 
 	# create repos in initial state
-	cp -r initial-repo full-checkout &&
+	cp -r full-checkout.template full-checkout &&
 	git -C full-checkout reset --hard &&
 
-	cp -r initial-repo sparse-checkout &&
+	cp -r sparse-checkout.template sparse-checkout &&
 	git -C sparse-checkout reset --hard &&
 
-	cp -r initial-repo sparse-index &&
-	git -C sparse-index reset --hard &&
-
-	# initialize sparse-checkout definitions
-	git -C sparse-checkout sparse-checkout init --cone &&
-	git -C sparse-checkout sparse-checkout set deep &&
-	git -C sparse-index sparse-checkout init --cone --sparse-index &&
-	test_cmp_config -C sparse-index true index.sparse &&
-	git -C sparse-index sparse-checkout set deep &&
-
-	# Disable this message to keep stderr the same.
-	git -C sparse-index config advice.sparseIndexExpanded false
+	cp -r sparse-index.template sparse-index &&
+	git -C sparse-index reset --hard
 }
 
 init_repos_as_submodules () {

-- 
2.56.0.611.g1030f0b940.dirty

