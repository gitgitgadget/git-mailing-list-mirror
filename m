Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218329;
	b=lpIDHXS3JNpad+S1vYIjQo+QYAGq41dbez3YaJFiVJvu/HDAuPaxgVgsy8ehJt7REXEt
	 /pFgM3p4cCctnLEN6piFzQq/bQJGtlkBQdluA0482vQYLGMCmMhwmjTVi678Gr2CL4sEi
	 /YG46EcURtgmHGCN5NHiAT4M2tBUr4S2LQ9OYQX63TJWTACqCFPZyUK2p15kaSm+xsif2
	 3857r5DYKwjGJVSnJE95Pgt8Cj59RUe5CySK7dnWz3RC14DdhE5zOvTK2DtUPuo58OazS
	 H0hwVVBO3UUtrHNDD+fB1DMToeXXlt/3jkX0Iiv2W6Kz0zKZmJoxkqdD8YKs+qLX7qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218329;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=n0Tm8JzhgzmdLiwrAJJVr4+cz236zldfBThE/f40iRk=;
	b=v1pRuzKsrZpzqENHBxQ/lH3xwc/9yJ/boNBxIBTD5W6OMTwE4pVBV2RBtFsGHjyrjxaj
	 XtgO7KlE8qWBFrw68AviBKVIy8GzMX8OHqk8zWs18EwfB5WWanrk+2fUuKG+zqdCJAenO
	 LfYtNLxmg5req5m3rUrrUIkLxHmxxY8etv2uwv90l99mc0Chkbfz2Vg+dNGysthsPxUuK
	 me506H6U8WhdvpM6J+2vLl3WSfd023JTvCBs45XyZLpK8OxoaKbA91yqrKS2fA+MOkbsm
	 X/ilAXsApxEJg5BeKULbGI0WPoh2e6Y0yOVOEpKi37ogFpE+oR9RkCdNsAuCS5HE2rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=PisswUp6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ARQWA34i;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF16E606EEB1
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF16E606EEB1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=PisswUp6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=ARQWA34i
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 52A341D00149
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:48 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 09 Nov 2026 04:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218328;
	 x=1794304728; bh=n0Tm8JzhgzmdLiwrAJJVr4+cz236zldfBThE/f40iRk=; b=
	PisswUp6bG88y14JAK75CX/jiHT0lDstpKo+pZ0V9bVOHDoKGskpjGvqahe1Z1AB
	ZrvD/zkihMnV3beulE30tHixtILOyOJPCvLcGeo2DxiNKJ+Fb7FoB8Tp6ha16wf8
	ojXHlIComVKKDjUjTN95sq2W8VZ5ym9ktQp6m1s4Jiq/TcUFvIumAaMXv6tO2Tqj
	GrtQodoS43FyQ82WVhV3TegjIcqKKHN4O+dpNVkGc3Aa2ckCKC1BT78CntaKDsgY
	CFK9dzAE2IN1+N52dyuqK8o9vL6cXVgkbOoQYjybWrZk98pX3UMUCleDgN0fNQC4
	vRRbx/tBf478e5CWcyaQcw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218328; x=
	1794304728; bh=n0Tm8JzhgzmdLiwrAJJVr4+cz236zldfBThE/f40iRk=; b=A
	RQWA34ivj82yNA+Z1O1yrGcXs2v6W/RBjaGyM/OW+cj/lz9/vcfvwTaAmvZZe5O6
	7igLQTadI87GI/OB7AwsgzrHe4gV736bHTxI38BmJ+xhy3Gfj2iekU1wfPfmqJbu
	pxWZf3jChAJHBOvRveJ6/wIu/BnM9pfMIG/iu/EBzmdtpzGGstCXi3WiT+pA6RKh
	755ZPGi5F/y2omEyix+glWaobnekYQ9nP+V1gMwUzXN6Y5RXVq6DvTMIxVlO8jRo
	JKkE8iF0HbUIRsxFKRFBZk3vPbMbvT4t9aMfrardK0KJ0Phdc3EcKvbHOiZxpiCt
	ThQ9cu+XhH4pQnRF5OhhA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218328; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:TooMa7+16x23ZO5lJ4cfPscn8lNUTZR8n6+PaRCoRWLkc9M
	RswV3LNddnVYzML6zi09zV7K5eFm3FmNAkduxeYyXXdOAilq8hoNhXASiXRuuoXQ
	pMoEfavWiVbwESJHUHkoLcT75secug5WJQzPvjiKA7CfNy5qDTnCcZVJPskflKcI
	bfZdfxfjEiSGjOOeKQ2WXEoCtDyPFywiKjmkOziKgYD56okeN9Ogd5lkkKekKLPr
	hKRSmx9ScGEPLQIa4rnGx0RtuBb0OjYJVamz8+czCrlj68W+aimyk8FvIIfDjaUr
	u9G2ApTrgsB9zL4enPOsOxNFFXbL6jMqdheGnIg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:GQmJIjGogflRGLGzDo1ZUS2toHlg8RUNauPigVZCNBY=:QglQEQtjuC9kFqOAt/BKPY7Hf/kiG0Dtp+NK14Q+ido=;
X-ME-Sender: <xms:V5nxau694IIeTVj3RRsLGQJGUk2g4oJRGiCepwbHZZrHgqxxM8yhrg>
    <xme:V5nxau5y64JFM5ry3DjpO_Jje6_a-1Xv1iaaE8hIY2YbD47MEjbV1yaIw6bl2soIB
    NqH8ik082-yZTJozrR8QKM3uQfjsy77bOCWZAf3ANPbKVzl1mJ63WI>
X-ME-Received: <xmr:V5nxaifR0wwjmlIvrNBgUtq476zUpKPbW8NzsDI2RHbplv5odXUCDWtsIdnZOoHwdFkBDNg>
X-ME-Proxy-Cause: dmFkZTGiwaOML8tABvxNB+Xhsl5FZZPhHnkonYmkYRbH50zEaDBdkJESa46J1533mVBeI7
    U9HWby0AedgrBCLYvGD9+ClPSaNjIaoF64ev/Jy+XhCP/wQH060xSDKCU58M8vRVPoAdBf
    BRjSx6opOraX6unaJkN513DzJhxKaDSnFmI9CikUx2lYOYcH34Z9ynF3I/Npig8yrRVibP
    b0vML8ssCNSH1XmcoVnM2tDVwrSBgdkHJQihRSlyIAgUwUh5Ikk4+wD6gmDkTy3ifV37Iy
    q9nDyG+O0IeU5Xub+k3NttaXYxUzUQiN0O3SHSABPLC0Bf0YPQM8cxPUAedTAhYnm+/jA0
    ZTULu8vjfO8N/jLCQ7N+wPy5Xp9F4jTgqXt4y4yAfdf4R60DyI4kybMbgYexbTEyx6S3hc
    kQiURf+uuvUHGc8Crg4ik+jxdS7bExqpDsvWuK7nw3tE9gvbUcQ+IhraALi7uNx9n+JaNE
    6BhV3zsyrgGLlKKHXdNFFQDnIY4ZsPaEPd4iZf4Al85yQliG8RhB0Oin+txHNup0pbTCWd
    G1O7H4dsth3rHLK2jGR34ZeAi6vyEN2RrBwbbsGAjKD5gsGjG6OP5mSUtIIZ4mrim4Wier
    0GYbS4LF6jcmL0kehhCHDnSl/yBJ8l+1GTK2kjbslMQhR678OKlL+U9ptWdA
X-ME-Proxy: <xmx:V5nxaqAlLT_77MHQ3hq7CIciV7Yo5ykClgwdT3E-eOt0CMAR_FpxFQ>
    <xmx:V5nxat_6x5IoSkWk4BaZ8kDjDNRHydj7ZpUz3JK1ejp1szwvvHWF_w>
    <xmx:V5nxatJ4tCDDFhh5oc7qpPTS-L_EHhV7Wke-vMwXrme2JdqcRQ3eFA>
    <xmx:V5nxaugw5xZiwcm1Jkw3_kpcEyumZ-UJvpwyerfUi0Ao0CYYm9zy4Q>
    <xmx:WJnxahwLEq6v6x2VhTBJHiQDaDGYxIxKXKBDiVaUN1POaxpulBinRtMA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:47 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e004ceef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:46 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:27 +0100
Subject: [PATCH v2 6/7] t1092: set up repositories from templates
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-6-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
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

