Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793961028;
	b=GzW0m1qap8QdYrlY3a6DXLhA2ScbSc36The4Mzb0uFFuSzsrgoYFw6Dnh4Z3OB3rwnyA
	 RPRNzjENYvtpY20XIFfY1kEMT6tryWyBxM7rqLkGCq75pCwFMEOFLgXkXkH22xdccKIHE
	 f7nTejT9DmyPgbmxGg8Yr6/OD1Z9jOW9ZRuRh4qKT8Ax8pQzYqtDlX5MZeMQdUWGzsWuT
	 fAdZric+8uzi8AtK/vUIQfGgWEFTat4ePFr9vo//Kc5ISpIT55pzigUXZplxXbDSHcJIV
	 snu9Zgh/E2YC+Yf3oq+BTKrTo1iN3WkBsqv/OS76mxAbA0M+RUzajJUW6W86EfF8o9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793961028;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=yYKomnCIfWxAH4EP29bSA08zIAjdSEFcCVxQyNUiboE=;
	b=z4NR+NYoY9ar5VRGa2E60MOX2wrC4OufQ7ytldVV2qzK/zvtn83j+2Hk3/IZVK8qxiJm
	 4JpKAf14wT/68lufgJIx6ouI78QxdVs0tuhoA8hYZvvTmx3HwpKyh/iCUKmnX/qWcAS4S
	 fkC6OKDSCQjaF2JXDwkiQWstxSQ2O87dKw7rCLfnmOJZJdOIs9jnJrFWPTyvJneStTOei
	 TaX86Wc2kWhV+cnREnCmxmhs7XQHMw1q4L4+CGkZgEKSMP20aGZL9cMuuGgRuPRvBeZ20
	 F+RUvaMG7PE7fbTBqpwJmP/UwiiZ+adVlnQCeoU1gyCuItvbJo1jKLd0dWdQalmyRdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wHkcp8HI;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="sG8u0wo/";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BD5606D817
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 10:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15BD5606D817
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=wHkcp8HI;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=sG8u0wo/
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 590A014000FB
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 05:30:27 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 06 Nov 2026 05:30:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793961027;
	 x=1794047427; bh=yYKomnCIfWxAH4EP29bSA08zIAjdSEFcCVxQyNUiboE=; b=
	wHkcp8HI9g629ngCLogQLWACbbYVuhPOC3GqgQCHZZZMgavzr4t7XxmXGFyt8019
	3xCl66ABvnIboSJYfKK48NfGk46lI/O7Hm+aovzQef2FtoNtbCm4X3VGIEkFw6a5
	H67+WRigEN5hTYt9hdLxjAxKHIVCRmndvxeDHW1MTHDLnnss+hhKhdC6eB5AJoIe
	LDkOJ24pPadfFsm0X8pVt7Ng/Ad6c+XO7qQutTKqdeSkvN2bLtQOs8LVuhosBt7g
	7R701CuR7dRWKYnuLsRV+0szFXBwV1uYWhHPFqepCLSi8sEAeNWPj4Ma3wm+ij2O
	5DWCmg1MtQifpjd492AQTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793961027; x=
	1794047427; bh=yYKomnCIfWxAH4EP29bSA08zIAjdSEFcCVxQyNUiboE=; b=s
	G8u0wo/f3+HbsSjjcSmlhGcMfQF10mPW5TgjXpTkY9ujraW1SQAT3UCxhJG4v+bo
	t60YBVrlcuU5E7Km9qewdGlom1Z/yngnPHO28QVfuYP0B+mEvd0hC1He2AeYiofc
	l4R6ZtazWt5iBo29veAMCrjRpcXuhaENCGDmYYiFbJjAm5//ntki78Szy/P125us
	/H9U77ST4VvzlDmMAwq0yXg9whfOu0r+T/6PN151eunCgc1E9rPsBjI8gcejun9C
	R1InpmUCYI3xNxM7dTAzYYPAgR+5NZao9b+FYhnTxzJDTKrFBMnULUQtEEmH/2OI
	7V1kh8dtRYirWlgDCB/cA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793961027; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:L4W4CTG3K0bV2q2TFyqHV9hd1c7WG4ECfZmiecSWOKBh1RV
	VX4peOjlbmwkBC8P43MUKfMAhNAmGN/u2ihTMgKBdxmKGpROeGeaNa1oOmjS5xdQ
	rIHvr/IWNMppCit9uT7EmKFwWKUf6SivLiWJs4VqCkLylxYPC7+iYWjhnNkSDRqr
	C2MUT9Zv9VKGiEuEXb/m/+qv2lcPEQupnlS+Y5xum5M2K3TNmyf9vuTY5eHW7vo8
	TnrYf6/D5OnSD8U7OkfyIkxRnFuPIpbSYH4x84VkjIpm1Z6C1x0GhooWHTz1czIn
	9d749vZ7n89LYVAI4CzbNuXtHYEa6SJ8blxHQrQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:zAjViJFheBwPx4wWy3DUDigQ6/k0/7Ga9hIZ0sDWk9g=:ACQg5kZpEhk+J01who9+835u7QgbVxKFPstMQerDSOE=;
X-ME-Sender: <xms:Q6ztaveXGzhfOn_6ZTy2hsjenbDFsno2M_IrgcHZLU2pInrXSXq9Xw>
    <xme:Q6ztarM9j9Bc-FYVSrHGM_aDFD5Sm3MzhZ15ygP9TV3ln9wHcLCJrAjg7DekdG-_w
    rTGeuwvFJY3IZ_5Et97GC_X3MDR2CddlovE_t690tfU3V3wxLW7QQ>
X-ME-Received: <xmr:Q6ztamINuc0gMwQjOxk_dX2SHuA7-qpzY51rIpnLLG15wBLASPAJoqADUGAYsZ28AR1Sbw>
X-ME-Proxy-Cause: dmFkZTEZVJcbWvsn6bqpLHxz54dfxRcTeC3FkTAMrfmLPbaadqttkUF2Bu76EJfvBhVAi5
    yS5euLDAZNFr3mvFT6L6adnUdWXVHrIA8XWe0bJVb8N6Tas2p6NsVInaxpkKJjW5mkZfOO
    nwUmPA2p4TiVeekRjqO0fQAaqfMC9zE/McriaVpviO4AYL2rtmnb/bPOFk+fLIbP5JzDur
    A57vCkKnxuxzpf7lClJCjMsBkrVjCEOhLoh+ZkOSoKDW5Tptb6efVj1QCd+mVTa0KdpLhB
    qE4UawWa4mmI3xDXlXrdgKSYJVslMy1KyltP+0NDWblJK8bXD21qusSG1UrWnG+q0X8iC7
    /VEF4Dtyc/aO1sC0oSP2nfhnp37pUcXLh/WUvQgE1+zSy+f4WITg6uPcfrIusqVsGIAyjB
    B1OzCBwOHwsYOMr5Abi7l1xCPFasOiw42POejyUAcV95wafxHDLVNOVGURhFEOKpRNCaJ+
    M4+5YjK3uGORqu3To92jGKfuN7X80FcDr0Yvlx1JNzRKvTapgTuHtFl+IvJa/fp5rGhcUf
    VyV8dPmlbxCO0HfvjXmMz30Nq0Qa2F96rCapNRNpN/FI39o4dea/UqxD2aSOaKXkOjvXbu
    uFpk+MchC9JQxYSdqD2xMQUYcpd/LvIlaUWL3TQ/4qyNsUWjOqrpIJijGMkA
X-ME-Proxy: <xmx:Q6ztasEHA1Q-TOBDLUzltz8sqhaBEs2NUwGoH7oBSx2DhuQzkFS_9A>
    <xmx:Q6ztauQw9OtdmsdkpnjysLyyJtQR5H5UVTJbA9ESx6pIM8wK5eiYMw>
    <xmx:Q6ztaoGUrUL7-jXo2-zuU1jHUMLV0Hzi6Ig8XZgmUFdaBN0gMSBJrA>
    <xmx:Q6ztaq_T1PdHdYehXFmvTzicnOJ0wnGRzecqi9h_pfqBJ8oQit1aVw>
    <xmx:Q6ztajC7CEYWX9Wxru6eMVKE5T_HYT0g5hxITwrhKpNM3ODwBQvHAaFO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Nov 2026 05:30:26 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 14f00fdb (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 6 Nov 2026 10:30:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 06 Nov 2026 11:30:07 +0100
Subject: [PATCH 7/7] t5551: use reftables for repositories with many refs
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
Message-Id: <20261106-pks-gitlab-ci-speedups-v1-7-1fa0374c7287@pks.im>
References: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
In-Reply-To: <20261106-pks-gitlab-ci-speedups-v1-0-1fa0374c7287@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.15.2

Some of the tests in t5551 creates almost a 100,000 references and then
verify that those can be fetched. Naturally, creating this many refs is
quite involved with the "files" backend, as it means that we have to
create this many individual loose files. This is tolerable on Linux,
where the test takes around 2 minutes in our CI. But on macOS, the same
test takes almost 20 minutes to complete. And to add insult to injury,
we execute these tests a second time via t5559.

The system under test here is the HTTP negotiation, so we don't actually
care about whether or not the ref backend handles this alright. So adapt
the test to instead create repositories with the reftable backend, which
is significantly faster in this case as we only need to write a single
table.

And sure enough, this reduces the runtime of this test on macOS by a
factor of 10, going from 20 minutes to 2 minutes. On Linux, the tests at
least speed up by a factor of two.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5551-http-fetch-smart.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index 130053c57aa..34945059531 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -412,7 +412,8 @@ create_tags () {
 }
 
 test_expect_success 'create 2,000 tags in the repo' '
-	git init --bare "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
+	git init --bare --ref-format=reftable \
+		"$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 	(
 		cd "$HTTPD_DOCUMENT_ROOT_PATH/many-tags.git" &&
 		create_tags 1 2000
@@ -421,7 +422,8 @@ test_expect_success 'create 2,000 tags in the repo' '
 
 test_expect_success CMDLINE_LIMIT \
 	'clone the 2,000 tag repo to check OS command line overflow' '
-	run_with_limited_cmdline git clone $HTTPD_URL/smart/many-tags.git too-many-refs &&
+	run_with_limited_cmdline git clone --ref-format=reftable \
+		$HTTPD_URL/smart/many-tags.git too-many-refs &&
 	(
 		cd too-many-refs &&
 		git for-each-ref refs/tags >actual &&

-- 
2.56.0.500.g5d06dc02cd.dirty

