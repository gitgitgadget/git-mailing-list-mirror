Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793089116;
	b=cDUZPEBftCy6YpHuDz0amylikckr9wcB9m2QgcvgbblFYkWmH41TbfhKepJNECfpmHRV
	 JJSinoH90lfkCuiXlAUvEEqpZaxLeKYKgzVpToRRhR5Z4OV4dloPzRk/k8JydfwlmZDnd
	 NznZaLTiJcCDV2yi0YLd1gQc5IB3iqdPC1zNvOo2/1yc8qoBeb2xhdIJ/BHI9eZLyl5uA
	 K/8ndEhfTxyz/PTSiuy0hd0LRs1fyngqeCJBEGKseCQRx6+v0rvOiKVJeEmKVBFamyD4e
	 IhdpI0uvvqDxgeEDZM0rjqyAMKLlWXzp3pVFPTZ0M0cbBmak9Q8IUkzXTahrJWTm5Lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793089116;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=ASbHliRETNLR29eobBxUXz+7GoAZ9kLjp0jlTsr72Eo=;
	b=Br1KNSdWtpbrZ5ElU5tN9URa1AZR+tpZKJ7f/tw2QRz5iNV0zyxisOfRmAPFa7VXnBJt
	 perz+q7WHXjJ4piGFRfqfOuM0MGmE4yx0nbDUEkTWj8BUjpBqFcZkeUcui0WxQe7U48t5
	 03cpf+0nnywGm14myjoQ7hR8i2ZEDXDKj7Y0A9KV7sTqUOAZDTDp6BHisW1qAPxzJS1kt
	 DxTtvQ8nYVT+mJWNmPEobJCRlnpHws5oq/zLfSEmlGEYXuYnWjtBu+koW1uLgblrZSmcr
	 tVeTUz2jOKMclEhhklSgEHE/nECkQg4t0/Ek5YswTQHsSHKx0Vgom/EWSGNQF0764zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VOSTsc4A;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Hu+6vKE1;
	arc=none smtp.remote-ip=202.12.124.146
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0054B606A328
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 08:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0054B606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=VOSTsc4A;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Hu+6vKE1
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 1254C1D0008A
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 04:18:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 27 Oct 2026 04:18:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793089114; x=1793175514; bh=ASbHliRETN
	LR29eobBxUXz+7GoAZ9kLjp0jlTsr72Eo=; b=VOSTsc4AeNuEeAMB1xAnAys5tq
	S/JspijpxJVYF/0Gxf6okOYgIUW5OlWW3ow1MhTtj3X7Vix27wj/NsXmh7gxR5T9
	CqjfdxcypL522iFcq27mFqkkKs/YhrdOC+KBn0Dv667FM/TuHtkS8LJH34D/zG0P
	+QmJxWM3Tc67qlzTKTH/8mf0NJWSb1Iur6YZH1KGLQa8z0Vu9YtFlAw7ttC//6zG
	wP7OJkeJUcdGCCNCHJ5LJNa+G328qh+gjqYaGHIbdf6qPrKHwvNluglGoxCEw/Do
	D1FTEeWyRBZkDY7lNK1lKbsMqbNB88/Wi5Ecf0hW00XS7ltUpOgE+DHl2y4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793089114; x=1793175514; bh=ASbHliRETNLR29eobBxUXz+7GoAZ
	9kLjp0jlTsr72Eo=; b=Hu+6vKE1k6PxBGAUPudqHcwdepm7JDgH9U25AZa8EIpX
	E5+jjGUBkrcEr9yJAdHtC8IhXj2Jec33+STuvi1gDE8gAtOxO8mBwqqKSt3Q43BA
	zhb0xWdzJZ00AaCbQeEnL66ZWSVpp/8a4yHP7MTv2RO4nIl+PJvqukQxEYPvj81q
	ayBCk7bG3uSQw1gBUMHZNuWIZ4n78mSlTLjK2ETfBbEBX3jncSNBTT9CsyaO7gdy
	273IyhVsJLAioOFLkvUSXWgBc3zLdXLowKyFYiA+fsHRIq2DwXMF2/4ZiI90ZJay
	ZPtYHNEgsn6ur+ACTd0EcsjxlOLQVtwWpk56aAZ7wQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793089114; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Ajp4piYeUgFxODbjP4XvvokBITDWQh4SK1xkpU7fKg2Uy5Z
	U1vk9a1DZ1y7NRWN234Lh5S7MGVwCcRuYGo83oltw0raesSFqUI+VQqdaR+0yPr6
	JDWffAB0wg5+P87snDZ2qJ4SSwj8LK2v8Fh3eKniGY3S5SnKi/yTx9/UVBxF6TWu
	/xrYM/udky4qUQ3bQsd+MDofClQr0TtmApB3aYVoLVDXdrr1fZsmPw9lzITXFefe
	QVOOnldAonKErZB7XOYBGZrpfBUlATPw3qUA9HJ4mK6O1+Jb7XGl6CKYfNgz4NQz
	ClbpNlOYEDTB3lgmCjej7xchFMDjwoiudbASW/A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:SO5vkThPRyIjkXMiUhzrtLC2Tu51dZjQ/DUrfhPnD5Y=:0dmC9Yvs0GkB1uTvIORsEOBqlwZv0zkDE+vnM2epkoo=;
X-ME-Sender: <xms:Wl7garIip-z6oyfC1OTnXFvhJiWKwwcXnQYs9fnNeSoFoT3ygfd9gA>
    <xme:Wl7gapu_V7JJl2l7ou7nB57eypbuVpTAItR9QDeUDgjnHHcjgXVQBekuOKkk4COFv
    AcQUkq5DoWhnE-8RG_ArpVqz2to5mGOiHP6_3zKOorpldDm2Gje>
X-ME-Received: <xmr:Wl7gagTlhasQEdxwCUatLVwY6YPfKMzSqp1tWRr-vOGBKhbj9YgGTA>
X-ME-Proxy-Cause: dmFkZTF/yzkEqh+Ezgc+Q6Pvfg/YR6LUrJ5fcDmwMKxko6sf1ZBvUN9KVvyaHOZyUlk+9x
    /8auspJ6o0AHjbSuYinqB89JhhJL6fPO1302rmWIU6NsEGTxeHlhAz8A6CoOhLoYu1PEPx
    EVMvycGTQEFQ99q4R0S+VHvPzUWnT9MtT9RhDs4BCDAJf/xEYtUfLikTM81ztS3Y3mmPlV
    NgBKzh/DoGC4Pam6OcRgUUXD+IQ6X2Kz5W2A1AN37I1uVHDXOXaotqsqnrzhal9pAKTfVh
    fo/2HcOHUTlG7gNmjh0rTOLbRzGIPB4uAd03PMWMKWDAixv1qm/PfPoZcMv77+s+rd9Bic
    6vbJO0/YWJQlDpixZG3ulnDu4MO8B9tCqzEE1WWrP8hIPFm8g0X9mh5i8H4uc/8DzL+wSU
    OtoxsA8JuuBrhRTRIreQ2Ic8D6RJ2BKEgO8ar6cFouBzONPtQLPywBcX2ENtOwtcUw0v/W
    8Mdwu3gtYgaHedzw8gCjIQVtLu7ea8B1dm54IRsRXS8a4svhGPM+Q4Kq6FauhmIK3Ud4vJ
    jhfz96WeGN5oVBJZB7H6riKYL16/m86BJcYHlzGy85GZfjGpkDKQGEFeMepYy7mLlT/hx/
    ysISuR/Xe8bFsrKWIfwTb/AynywGE1ZMxQA6bjb+CbBnZZp7KGHi6Rnb76BA
X-ME-Proxy: <xmx:Wl7ganNQtZg93RMzgOVO7mYWuzkAAX7IxkPbGfc3dRD_-vFceKHVEA>
    <xmx:Wl7gatbgFB7ewk2xesT9Ct5q6_TctEs1VULV40ZTxhF4bt-kI9pfkQ>
    <xmx:Wl7gapwSF_LPuyWKgzE552zp_ZJiXLtbFdNrrKGBuIJfhUat1SKpEA>
    <xmx:Wl7gagL7h1n_1j17poDmbTmM8r-5JS2rkfcKvWj8l40Ayj-JCewvmA>
    <xmx:Wl7gaibwDO48f5ah7lALmhE10rKbmUpSCKR93KhKrYXfdWNX0XHj9rOF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 04:18:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8763266a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 08:18:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/8] ci: consolidate test variables
Date: Tue, 27 Oct 2026 09:18:20 +0100
Message-Id: <20261027-b4-pks-ci-test-vars-consolidation-v1-0-f28edf79bd6c@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTuQRA3Fq4iLdDLVUUlKJi1C6
 d1Ndfkt3v9WUC7CCpduhcKLqOTUYA8d0COkO6PEZnDGeWusx+GE00uRBCtrxSWUhpw0vyWG2tb
 YR0M+nI8UXA+tMxUe5fP7uN7+1nl4MtU9DNv2BQ92X5uFAAAA
X-Change-ID: 20261016-b4-pks-ci-test-vars-consolidation-8d0c6a53ca28
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: b4 0.15.2

Hi,

this patch series consolidates our test variables as a follow up on the
discussions in [1].

The series is built on top of 37b3475fb53 (The 9th batch, 2026-10-25).

Thanks!

Patrick

[1]: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>

---
Patrick Steinhardt (8):
      ci: consolidate setup of test environment
      ci/lib: always set GIT_TEST_USE_SET_E on Linux jobs
      ci/lib: deduplicate test variables by pattern matching
      ci/lib: merge switches for specific job names
      t: honor default ref storage format
      ci/lib: add another NO_RUST build using glibc
      ci: don't override initial branch name in testbed job
      t/test-lib: make feature-testbed job more accessible

 .github/workflows/main.yml |  3 ---
 .gitlab-ci.yml             |  3 ---
 ci/lib.sh                  | 34 ++++++++++++++++++++++++++++++++--
 ci/run-build-and-tests.sh  | 44 --------------------------------------------
 t/README                   |  5 +++++
 t/test-lib-functions.sh    |  2 +-
 t/test-lib.sh              | 25 ++++++++++++++++++++++++-
 t/unit-tests/unit-test.c   |  1 +
 8 files changed, 63 insertions(+), 54 deletions(-)


---
base-commit: 37b3475fb530c14109211faca33716a173db61ed
change-id: 20261016-b4-pks-ci-test-vars-consolidation-8d0c6a53ca28

