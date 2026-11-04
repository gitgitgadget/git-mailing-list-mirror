Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.146
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793807859;
	b=0mXEiBOx6+6CVmKaHZv3zDAtoNV2diwlguwC4cYuCNAdflcq5RKtg4fWKFA78h018A1L
	 OpxngXaDNykyPvzjRrCRzQ+pDIZdffaFdIOlp99bs41/7UJH4vlXaxZ7XXe+EylZIiSL9
	 ukDKE1u0cXYgiEJ62AIDtad7uttbwYogP5a8q53xJ8LydMzt6mPnvVfWH1trC/0l71eek
	 A03ZJgCivulhYFoQrR6CI/9z4zyP4mOYIZe6ZR8bpy1jzsU1+8NSw3MWrExeCSvGtWEDl
	 j2rNmhUX47MBqHWHXjdLsIy915SXQdhVUeNY9QuMPyKzkcLoe51RgrtQ9mqtaGSeZPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793807859;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=EnZk+C0tDfnEQvn1rIcxqGPgf1Ye71gtbs8yJ/vDdeI=;
	b=1h99A/fvwEUIjPOqkK2jzQUQN5RlCTPqUMwI2L7Fq0YwDRmGliuWT6fo2JsASWjbesMj
	 ycC3X4mOOLC4m5SmnHvUwpj56NtHd6KIrT2cQlNt/DPRtYljQqFx+DdyZVoA+Y/HA1efn
	 QQeo5L65yex5+wsd8pjDEE23X6nhl0ef/PjkjOrvld727vdbGjfLfH6bCWH1BEciO2zr5
	 sZE2mgSMORuheRduLmokvIWJFmuS1sEcyabjEXYlMP356+gTBMIk7aChaeQc1SVg8akQ3
	 L8eiBrSxM2XxpV68bks7+zUXaqBhBVGQVqEmR0m5fUrAkc4h9o4M3Lii8yvKIBXeaLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b="azputT/W";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hLxtKMVO;
	arc=none smtp.remote-ip=103.168.172.146
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE560A3831
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 15:57:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDBE560A3831
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=azputT/W;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=hLxtKMVO
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 229C7EC022C
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 10:57:38 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 04 Nov 2026 10:57:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm3; t=1793807858; x=1793894258; bh=EnZk+C0tDf
	nEQvn1rIcxqGPgf1Ye71gtbs8yJ/vDdeI=; b=azputT/WzhGPoE0Ug7pr4EoMpW
	vNXi+kMxOgLepEDmihnML9pZ/vsfAwTVYrhlHjcnMx7AMqKqYnSSDsL5cX1c5uD4
	bQXprhsyHElGXXNVGs6bSaU9S9xxb6knbjWwahrRH19nELSgrz24hnF1it0abCFh
	qvKgrrAgk2nYMGOZ0jhOZLMeJfUXTPAwSpLxbLuouqIGDVwHezLOPev9BCp1k9hQ
	J9BLAxJTBgLhyjPL4jh5Y+Eb41f9y62BwmkUIk6dwOnHOS5b54ChBFc2SGAVvlzY
	dIVgm1uH93aJFg0xBi8belGUli7K2C2lKp+uwukdJR5EZYrzrJd3VxAdZlQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1793807858; x=1793894258; bh=EnZk+C0tDfnEQvn1rIcxqGPgf1Ye
	71gtbs8yJ/vDdeI=; b=hLxtKMVO6lhDb8OTUXlqzZ4VYH1/QMcGjJwwz6bKp+1k
	Fii3fZ4Ze2MzlQ9S12ofekLzp7F1GnlruiuIL8QSp3cMhOTWc7qTSfBzeuvAHvcD
	dz/+7UN/o9DhiW73kk2LeW25DXOk9RW2hmnJsW3/6LCDc1lA8hGZVflE3QV6cB+w
	YM1h/V76fPh/FyM0GZYUgH8c+Rq0v6Zt4jC4RKWBAu3IiVKj9a+Vbw37W3FJnhcU
	CmkDBxOcvn98jiiqrrXefAAOog6mnbfxMF70dGJVvnESiDBTPbFxDWtleEx3Il1C
	PLgLbNJrWZvclVQxpgV67XZvqXzCiG1Ygb4+Cw6gvQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793807858; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:diZo5XhlSHpIRxYqIP6UBD9e7HDj9zma8v2zfMOtk0R70El
	R7QA1mntuBDb+kuzuIKlpbeRur4K+NwiXLmORZVl/jsbd2W6kI6i5drnNWEeuBWJ
	bmlU0lTmBdmOVZp55ttOEQqhfZXAbwlIo4ihjONQ9KH4Bm6z2QoS0H37OuwqLisG
	smU3DQaLe835nxmrnS/wevFVsoDTuILOGAsJZ1X2iL6kyWPgwDow9OSZ3BWQwanu
	fR3++UjtRI68gCuxwBA8yKh0POK82NNNkstPSsvwJArK88Ii3S1pfxnnLbehpDbn
	GvyW5i5k0jzzv6ETthDC4Q3bCfuS/F7ZAaayVmw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:vS3rXFawwelh9CvZkswrNqNKYOHw+KhdeY8eCqQL974=:pU90xwp+xZvBEEYDS6p+uTjr58sJn+QATcyZdncqJ/0=;
X-ME-Sender: <xms:8lXraitsSAANL5ZImDp6H3pWIofZwEy16sabyGhhoat-bFq5v2my9A>
    <xme:8lXraubESNi9UUNT6LgdrQXyk7TlUg7h4lEiEsz3DAr698eS86s7KHgx04BqmoUGV
    _j1Lnc93DgW0msKzBfgO9QQIxtPrpKUToiQI6bZ-yaMQodeLBpv-w>
X-ME-Received: <xmr:8lXrajblDOx3EcyswCdKdI-M25AL6g-msHLomq2Udj4cH8aUQAfga4gfnwSAM69pklTq0gE>
X-ME-Proxy-Cause: dmFkZTE6is9QjyNGOEvBYDLs4Y7+9bI2C+DRHMDSG7gPFppujFT1c61O8GXbe5n5yU7Ia4
    NWMOoHGvEYSNgMPB/EIzS6mzazg0qHQzBMXXUewmO63MGkEDt39XkRAdxL8Ixrz673ee1C
    kMAubMbTR13/Eg7I/p9a5U1jWpRBsQOMPIDfYx3crpdsKI2Jnn50+cjHJDreuyB2otl3za
    mKyWvNqkNjKqweOjYZJjUklj2sAEZWyr5OSUFKvZQEOIAUzQEbkbVXIkGtKqLAEcKzQ7/0
    Zryt2L9A85EnlLnjtrbyZLFLigCEbpGbAuVSeO1Frezbe4b9CQGo8gELCE6in9iHnyD9sZ
    0VIm2Ty1jyzZcZ+vmutr3ZafLqhZVACByGu6pVP759BHJSoIuQLtq+u66ovstK6ceATpTG
    Z4uzg2VnwMbtW00XzYmpb+delZwT+ns3bv3ggYiPCVWBdrOqto2nT2J6RraGfxgocJwIX5
    ghhA1zvC06a9zT+NqlpJscIcPwlhlQ0jRmh0GvuMEwFLkY3pOBlB+7LE7bYWIrPYSWy0ol
    zSiph/s28MPRf5jl8EvQVWzT7FQwOOzaSZF36KFIJzfKksas3DDQgo/WoO7u+J+csQ6bde
    ZiQFKhpPelCqxlo7n5gI22l3OtjjSnxFiTf3Am5gGXa1f0RHx0g0aCqvi8VA
X-ME-Proxy: <xmx:8lXraiWdqaEUuRgmdcktfvTqhCgjsQmqfX0Z6O1acPZzrkmdiizwPQ>
    <xmx:8lXrai0cqM39AMJMnnJv8lOo5tj4KIr3q8G38mO51kR1dA88JKuAQQ>
    <xmx:8lXrahZaC1ugUw7-B5fRZaPHNL-fU1CWNxNv1wlcivAnglFMnCSPYw>
    <xmx:8lXratooDCY_DUeAybDaCMNjASquAfLWa-zXreeizAFgOvHLm_aoew>
    <xmx:8lXratd_A9aMT75EOdd9vr-g_pk9lt3NGmUS57LahXWrAat6MoGhcvlb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 4 Nov 2026 10:57:37 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id dca18aba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Wed, 4 Nov 2026 15:57:36 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 00/10] commit-graph: several refactorings for writing
 commit graphs
Date: Wed, 04 Nov 2026 16:57:22 +0100
Message-Id: <20261104-pks-commit-graph-write-refactorings-v1-0-d013d9401a59@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXNQQrCMBCF4auUWTvQRCjqVcRFk07SUZqEmVSF0
 rsbdfnx4H8bKAmTwqXbQOjJyjk1mEMHfh5TJOSpGWxvB2P6I5aHos/LwhWjjGXGl3AlFAqjr1k
 4RcUwnIKzlsJ0dtBKpa38/r1cb3/r6u7k6zcN+/4Bp5Xdg4cAAAA=
X-Change-ID: 20261103-pks-commit-graph-write-refactorings-f68fb22efd9b
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this patch series includes several small cleanups for the interfaces for
writing commit graphs. Most importantly, the series refactors options so
that they all get passed via `struct commit_graph_write_options`. These
cleanups are split out of a bigger change to make reading and writing
commit-graphs pluggable via the object database bakcend.

The series is based on 750f5de7dfe (The 14th batch, 2026-11-03) with
ps/commit-graph-cleanups at cdc7d6b46c6 (builtin/commit-graph:
de-globalize options handling, 2026-10-28) merged into it.

Thanks!

Patrick

---
Patrick Steinhardt (10):
      commit-graph: rename `struct commit_graph_opts`
      commit-graph: pass writer flags via options
      commit-graph: drop `NULL` checks for write options
      commit-graph: drop redundant flags in write context
      commit-graph: merge the two commit graph writers
      commit-graph: move remaining write parameters into options
      commit-graph: fix mixup of write/verify flags
      builtin/commit-graph: set flags directly
      odb/source-files: verify commit-graphs as part of fsck
      commit-graph: modernize function names

 Documentation/gitformat-chunk.adoc |   2 +-
 builtin/commit-graph.c             |  82 ++++++-----------
 builtin/fetch.c                    |  23 ++---
 builtin/fsck.c                     |  20 ----
 builtin/gc.c                       |  15 ++-
 commit-graph.c                     | 183 +++++++++++++++++--------------------
 commit-graph.h                     |  40 ++++----
 odb.c                              |   2 +-
 odb/source-files.c                 |  25 +++++
 oss-fuzz/fuzz-commit-graph.c       |   4 +-
 t/helper/test-read-graph.c         |   2 +-
 11 files changed, 183 insertions(+), 215 deletions(-)


---
base-commit: d00aeacdaa9e157548863b0eecc019044126c621
change-id: 20261103-pks-commit-graph-write-refactorings-f68fb22efd9b

