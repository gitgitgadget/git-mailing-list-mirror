Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961014;
	b=zEogxyI5yuGFDntbO7K/3NWsRi5id0XM+XZlNqNdWLTG4AgfkHnzR8EGNi3AwM+p6Eai
	 FrC8N+E0SvKndax6PBi6yl2p1K/0SV3lzpJFQNfwNvvfDPz2iRbJZX8o2OwGeTCRsmemz
	 X20Ds1DUKCM7CxW8O4rKrKG9l//zS2Ynz8L3Q3SUwMPsLl/WltcLnJ2f5XMNevl+zbwOo
	 0G1ayrrq1qWJXwO792LeyEqTd2wQ6jAF8LtOMd6MxM8ExnBoaxW4kVTZjrjZnf950Ogn5
	 Ti3MsVscYiMBrPFF8NwL/n74nTNv1a8RifFjpOhXbvKKWxqikk33LLdZ1afAPg4isRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961014;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=bEq/r7hg9oPcYDVDAZcghRgs28ExRMrQIdTk3Ck0m6Q=;
	b=gip1/GHqmARwvH/0XbNUMW+6rhJuolEgVBZnwGIloK1zIWWbpSz16Usmr6exSh6zhemf
	 ompIsvtYs8ujnZewMX7wCsN0wrKMnKbK5zb9Ei7F3NJ8WekKIUhuU/mAyr/ZntvLsXRDh
	 AldH3uBcqQarm2tEoh+pfh8cUh3ACz1jOVLa6yNgH5qqAY9oi4kIqD/XftxV0G40cEX6L
	 AS4yZnz2UolRpnukzBTrJ3Q5JurhiSy1Yeow0YhQ/6XOnM/6h6Ohsuvdbjz0U8C3n+i5O
	 rcTFTbUHBWGuxBuNR7TTZNSIsGoNM14yn86qmdwlKBJ3a8U9NUTZssUiaDuJICRbYLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WmFXo381;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nO54kXMm;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2472C606A32F
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2472C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=WmFXo381;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=nO54kXMm
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 55C08EC020D
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Fri, 06 Nov 2026 05:30:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961013;
	 x=1794047413; bh=bEq/r7hg9oPcYDVDAZcghRgs28ExRMrQIdTk3Ck0m6Q=; b=
	WmFXo3818Yt+eIuN7dSOqNjVHEUpWWbzD7ro59FcwImuajTnPucCInb98HbcmI9K
	4ZBDeEDNNS3FS7USlTyud+IQLmZFdPNSxNuJoRB/3MJiExzcouYefgzLt/TijCCH
	mdyx7pr+v55s07C//+ErsdaiwOwW2NqTfiicn8msR+fimGHdVdn1izRKw19k8FKZ
	fg13NdoHDmLmlMkdqm+hXjs/nHDzPtRN4PhCia/9tz2LzYomIlT/PGp3l7UHr5fx
	m21IYRxnEegGjTXFU38M+y/Dj/MUfy1pHGWPdR0H1HZlzRn9yWk3P97sYCUzhxTm
	xgef3mYxR2h3JgMI4JABLg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961013; x=
	1794047413; bh=bEq/r7hg9oPcYDVDAZcghRgs28ExRMrQIdTk3Ck0m6Q=; b=n
	O54kXMmTFrEdgYXH5NK9KgLAnbIpFGCAXxiVXhNO69CO9sY/80A86XLi/VTj5B9G
	w3l1DAIGMsBuJDJvVVN+fnPhKj4r8lcC0NWwHYZsRZO5/EQj/Qs8lOuNsP5seAFN
	j0Hw8Hv6qZbc6qsBG/+cMS5/Qmc5zi5p0WePrhbNOZtnLX4z2E2Mb6pfTB23OXEU
	oBu/rL4qBPmGff3GTuwIuJsFML8Ctq4l1Whmho+B3HXJkA7PXaGH6MEAwC2SpBup
	MIPNJ6Z7s7sqnfdg1+8trg+cMZJZ9ABVwvtaVASt6bRJ7RTponU+cQG2wIRqA+gg
	fjNeJt238GA97H0mE0KnQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961013; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:mGyxncssVx9oOy0XnBoeS0HTCrmtJJhizivc6yo0U1Yw1HK
	ITmC+xOjWe74Wt8y6WopNY121aPbaoSHKXbVtyAAFwzE/1XjTETsFIe7bwFebavs
	hopZ96D7U3ufscExOvhLkzV0EIGT/0lHJhu+9wYzBxTt7VZ5hkVDj7DOF3BPBYTa
	ORbVp8J93bi6qQ3jO4lXugUtzOFATRIxwsEIU8y8Ue+ULgTzFU8UCeLg96D3DeHa
	54/j4juISNUVTL2zaiKUplKTsqh1AHGHqgftb3izPf03BtjtFrFo+oBSJrs8f6tI
	epz82KkcThjS+i7fM0j+s4tTJDbkbjBR7dEDoeQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:SOvDyWZzVGSaQ0RIXgxNAQFGDm5WQJAOZS6MrS6b3HA=:yHe48ndlEDqEjaPoWvnbBS4FD6C808A9lhwHk6hcNCE=;
X-ME-Sender: <xms:NaztajX5grXMK9zo2ZwNq5zZGZg_EHi9WurgG1xjjjVUP6ZV4C0YsQ>
    <xme:NaztahlZGYBI6A3XPdl0IqciDUeXbuTCsLvWt8Zpn9g_byUIU7IyvRo4TbFt6Qftl
    7hkMeQtiWUd5bGrqy80rU3C7xAyVQz_ukNy6zo5sq1x-0bG29nKw_Q>
X-ME-Received: <xmr:NaztatBbLFZ_7KwQNMKLmPheXsvEwjxmO0LR7MXNnIKCKHUHFh_ceIKsGpgT3zLcNrhaSg>
X-ME-Proxy-Cause: dmFkZTGy77yXrjJS9/3QcuR7pa91rjJ1dPHPAmws2vnFDxHmVCZo6/qAJbB8zn+b2xX8hx
    2jNUqL0gYmXt9xXzGKEDcwA1blLEETl+6XVOGQtnMu+Ta9t5IU46E5JxbMAmgkNiHg1MGN
    VAG4GvEz1F1J+wueIPkWbgt24Ugo1ngfnHYpa/Z3EAxOam9qrqbygvrjFqLNScL/8IhS+8
    sTI/RoIWbNkQFt1lWWykvjNhwEwEtIvQSYAsoyoJmt+rvTiqMJnjy+sOSK4vZskVf8VYle
    aeqGxJm9Exev1XYrfNyRB45oA9OHchQZMN9BaUT+E5s4Qy1+zrAarY0O0PGLzMMK99uciw
    LHcOjSeel5QR9ff4qaPrxImQ7ACipbzrsIh1BKKx5sThfQk2WwNKpIEBuW9GS9W+a2rqfg
    Qj+kcC0Wj6tXv3gbnIAeaGR8ulCl33WfbVevrxfV8jmbinjMHhSMkDBT8+rmHgL+vVRWFh
    o9OfZJpWni10iV440VWQtkAd/0S3h9s3JsirymO+ZVN1j4irW9Agu9dsLUz3Kq1M2thI2+
    O3BrRRFscdnSXuggzWc/gHGetL1Gl4FHfsdewUn7DhuUJ6czECp1s9N568IEzVvjF8lSyu
    7SXQj4xRtoLH5pHZ/TTZ5KxuQvr1bHoWGtaYLnroXkWgvqMPm/GPlISRa1uw
X-ME-Proxy: <xmx:NaztapdA-rbHopQrAybKhgXWtzHGUv_UIi2O1wu6prd9nfZfHKNGZQ>
    <xmx:NaztagKojyVcW23Iu8lsm_RykWumrIQ7mIebJUT9YudMSDveKaYlrw>
    <xmx:NaztakdAjEqFCXhiwlkneBQKC-7aeAdmKKt5Pnr3BaE3lqrKUl6NUA>
    <xmx:Naztav3af27jnK8V7gmmjwN466bYkyIwRIJtw79gT1PQmmIEToJmsw>
    <xmx:Naztak4ZdGXIOihv_kSJ8Sfj2xA70X8pIf8ew3oGBY6CjIF6N6D2kHZM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id edd2e672 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:12 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:02 +0100
Subject: [PATCH 2/7] gitlab-ci: exclude intermediate outputs from Windows
 artifacts
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
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-2-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

As running tests is very slow on Windows we shard our CI tests across 10
runners. To avoid rebuilding Git on each of those runners we have a
preliminary step which builds Git and then passes on the build artifacts
to the test jobs.

This archive contains a ton of intermediate "*.obj" build artifacts that
aren't needed by the test jobs: the artifact contains ~2300 files, out
of which ~1800 are "*.obj" files.

Exclude those files from the build artifact, which reduces the time it
takes to download and extract them from 34 seconds to 17 seconds.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 .gitlab-ci.yml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.gitlab-ci.yml b/.gitlab-ci.yml
index 15419a954b3..036d2f3c7f2 100644
--- a/.gitlab-ci.yml
+++ b/.gitlab-ci.yml
@@ -194,6 +194,8 @@ build:msvc-meson:
   artifacts:
     paths:
       - build
+    exclude:
+      - build/**/*.obj
 
 test:msvc-meson:
   extends: .msvc-meson

-- 
2.56.0.500.g5d06dc02cd.dirty

