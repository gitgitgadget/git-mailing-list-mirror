Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794218324;
	b=OQ5PCd9KVARCbUNhFZOiZdp/207r01Bun6NhWgqp1XBRvTOWpS3VYNSChI4mxiJAkuOW
	 3lJaysE+QwoK2vRZ6v8Rj8HS4LVMRH0WMMNFCiSRFuttHMmUUzFdjbTNBBsWDAOSpBOQR
	 QgCnihuTnfLUTUpWCoZrE+sxU9PYSLwEwebBUCIfOfvD1Sex5AXL83WKXlbgPoErfrHCP
	 zG8QP6a2y3ZqQH+W2t673/20GSc8e+eexsiWUD1VEx0+lFH+TC0V9DbZmb9CCUeJw2z86
	 W3zmlerTuutvxhFBJCuipFywdkkKcTiTZ/wmru+jCPFQ5WVNeLmeKori1fqtfyAow3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794218324;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=IHopi/oz79EduL3nZTprMle4BwNjMR+3w/BB+vue4ss=;
	b=D9QxNrLiWmNdexhJAdNNBiCdEm+8OmNnjzThZxJiCVMOPr8dQcR3Zm+4gdSfKlK98YnV
	 acYyOTa2i+Yl2QLjoEIyaKGwnVJ26z6Pv0K6chKzIsxPEWyekjJ/qmvvEFb7D0xo/S1sQ
	 yMBzGDeEuxn/D6krbl9HW7+PNdesNqFgOx5XremSso1Wcl48eXZT/AaN6+JsStBPenGHw
	 WPFYaNx6gAdUrKdiT5vOhk9/maZv0fuhcoGXVN0rrh3erxQhGqw0XmWrY0F0Q9QZ8dRxv
	 u5DyoRAKZW+UxhaESynZrMLk1gxzRCCxK96kewXP60Yck+FMeW7YW1m9bGNm62XZZig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=yW3tf2Un;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gqFFF5rV;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F62606A331
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 09:58:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 94F62606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=yW3tf2Un;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=gqFFF5rV
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 09F1C7A0142
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 04:58:43 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 09 Nov 2026 04:58:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794218322;
	 x=1794304722; bh=IHopi/oz79EduL3nZTprMle4BwNjMR+3w/BB+vue4ss=; b=
	yW3tf2UnG5wxOfCBq9O8VaAWr1YGTecMRg1v+8+VevvMrGOjHQoBV4bGjZ87NZ+H
	ih3/c3Cz8dqh8OQp5/DaAef+wSghAKEOuNpOqJALJRZvCnIfpQ5lGp4I+Lg9+++s
	0vTQ33vXSntr8klIvzQfTMftgxEOaYFyOA0q8VLegbX+SiCJ7xNA7FKuZy4fxdv5
	S2UjpkRsnoCPW3qdCOjfhc5+uYFg1Pdv0TjssX3xwK8BGXtwhwJmwsZu/Rr6DPcp
	GjMLrl4KrPmUmfJfZN3ruLf8o4m3p2w/ZZBMgTiA8Fw/tTNq7i55eP6HzMxGYVVq
	SHQZWS+UGuKLJSnCam+4Qg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794218322; x=
	1794304722; bh=IHopi/oz79EduL3nZTprMle4BwNjMR+3w/BB+vue4ss=; b=g
	qFFF5rVKKLo+TiUP8Y2U7mj37TOvMquSeDOKwDOIUn6gVzWvq17UwhFbaPytbs3f
	OeQKa1CeI/Gnhyiroqz2DiLUO+N03DuOMWqUc+fJzWVG0wt2FQJ51quo9r888RsA
	JF0roMM0YQEiWU1pYS9tNJ1HcZnqR/8+8BcYVRSzMD3KE4IOc+ZeUGB7htPRQyZw
	Vd1NFg9ZtLDUnocjdgzcM8m+LY89OyKARg3vPmhG0pIRC6PCZ3OXeEWfIi/QaXJ0
	pllFZ56P3hvqn+n30PNkPZdR4trnxN5kR8FIPZaVgs3iVSjztNd/EBaGc3AEzMYL
	k0W2eDupauDIwSqg8xVfQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794218322; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:xEQlgud0UHQgyjPYpjOUl8jmxzVf0FXth4IW1YHwuPCEnqK
	YA+sFvtTLEzOX2wY7zNNibLc1ePzpmETmRqLEeobaXmyNsi1BO3ThDbv7i5RPrU2
	sH5PhOc7GTMObDQRFymh4Cry+vp5pvZVtrZsfnkOluXkQox/0TgKPMEZzwVDYGh4
	KqnUdFT0RmQ5xDwsFOxlBUbkasQzDcJLO2GDOCpy9T/f+L9n8pnB2jDl4VhY01C+
	E1toYugJX/cFVP7+pu6sBj3XwoqquPGZqDHZtuK+YGna9v1E8AQguATXVYxegjWE
	U8N7qEfKCKUXyTwtdtitiF9U8nv44l8lRbERbtA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:nUAImmoWxhmbd9ArmoBr9XRvdoe8ZiSSKDvYwbwj6rI=:CLSHGDiGDtjslnY2DXkyTZ6JuLNDhx2ZtrfP8hTONDI=;
X-ME-Sender: <xms:UpnxapGsWBdaCIvYfvwIEPsXNwR_HPxVsuPxPdVxPY_M7fPGq2Oueg>
    <xme:UpnxalWAptIm6KaPKJ4R9HKMsVAIc_xpwR_-URTjFfIw6e6IETAZz2pMDBZVnafs_
    Lp-5_sEkizyv44wE6gkE3dSKSr_QTN88yAbqgOg-jJ19E5B6n_yf7Q>
X-ME-Received: <xmr:UpnxagIQd7pyULbD175kZsWbfUzwhu7rY6zt_gGNqLbq8_sKNrtbNLoYjZuLKLZ8mJIJAmI>
X-ME-Proxy-Cause: dmFkZTGiwaOML8tABvxNB+Xhsl5FZZPhHnkonYmkYRbH50zEaDBdkJESa46J1533mVBeI7
    U9HWby0AedgrBCLYvGD9+ClPSaNjIaoF64ev/Jy+XhCP/wQH060xSDKCU58M8vRVPoAdBf
    BRjSx6opOraX6unaJkN513DzJhxKaDSnFmI9CikUx2lYOYcH34Z9ynF3I/Npig8yrRVibP
    b0vML8ssCNSH1XmcoVnM2tDVwrSBgdkHJQihRSlyIAgUwUh5Ikk4+wD6gmDkTy3ifV37Iy
    q9nDyG+O0IeU5Xub+k3NttaXYxUzUQiN0O3SHSABPLC0Bf0YPQM8cxPUAedTAhYnm+/jXM
    vHWyt3UjQxY9ky/mSrFBCOc7sHXK9pCkiRCgo9R4gkFM4a/GSHoEbOixoFnlWhGa7WoMP/
    1hoCZ18+eD8YPHN0Is3wGvweuFyq8yepEZUOe4W2NHvH/p6calg46Qss4oo3nPlv4Azwb+
    yShknUrx0FYWHRiRjcsyOIoY+Zl9pW2vgYW4myfsqL2jqbFiqt1Q3ufsRPu2c4ERySVHUj
    akkEoV3GQrabvt33GML14lJgNzP8CXeUPvVHLEYCa/ghaPQ8CZk/r7j2cw7kw2XoN+lTd2
    os/sZd9kxKDwlXIb6iFpxFDYU7Q62mNlLFdiwWDcJvQbPNwG+E2Tz3BcrrUg
X-ME-Proxy: <xmx:Upnxat-qC7S1Ri61kyARVg2WQGDX_eMjveCc4qgWruwf6tTdtzWUqg>
    <xmx:UpnxarJQUbnk8Jdk7RFacLBY_pt7uIKGE8BcMFsSY88MgTSppOIuFA>
    <xmx:UpnxaqmVzQSqGuWMIyjcthZNARTnsPl6fg8s5o56nHPgtYg7un1SJw>
    <xmx:UpnxanOitc19jszQ_QAp21-m-BBP9Zxknil-PxBN6brvNvoaRakWRw>
    <xmx:UpnxakeFVUlhhA4pzKDNA8tglNDUnYuyobzHI_XocPCkyoKXS5uqEYMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Nov 2026 04:58:41 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4c6c0817 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 9 Nov 2026 09:58:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 09 Nov 2026 10:58:25 +0100
Subject: [PATCH v2 4/7] t0027: optimize how we reset repository state
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
Message-Id: <20261109-pks-gitlab-ci-speedups-v2-4-508832602d0b@pks.im>
References: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
In-Reply-To: <20261109-pks-gitlab-ci-speedups-v2-0-508832602d0b@pks.im>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>, 
 =?utf-8?q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: b4 0.15.2

In t0027 we verify our logic to convert CRLF for all kinds of
combinations of attributes and configuration, which ultimately results
in 2600 test cases. This is of course on the heavier side, so on Windows
this takes more than 10 minutes to run.

One source of slowness is `checkout_files ()`, which gets called for
a lot of our test to set up the initial working directory. As part of
that we both remove the old files that we care about and then check them
out again via git-checkout(1), but we do this one by one for every
single file.

This is of course rather wasteful, as we have to spawn ten different
processes every time the function is invoked. And on top of that, we
also have to rewrite the complete index in git-checkout(1) every time.

Speed this up by instead using a single invocation of rm(1) and
git-checkout(1). This reduces the runtime by about 20% on all platforms,
and on Windows this reduces the runtime by ~2.5 minutes.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0027-auto-crlf.sh | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 49dbf09da77..504a7ea54bb 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -305,11 +305,12 @@ checkout_files () {
 	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
-		test_expect_success "setup $f checkout ${ceol:+ with -c core.eol=$ceol}"  '
-			rm -f crlf_false_attr__$f.txt &&
-			git ${ceol:+-c core.eol=$ceol} checkout -- crlf_false_attr__$f.txt
-		'
+		paths="${paths:+"$paths "}crlf_false_attr__$f.txt"
 	done
+	test_expect_success "setup checkout ${ceol:+ with -c core.eol=$ceol}" '
+		rm -f $paths &&
+		git ${ceol:+-c core.eol=$ceol} checkout -- $paths
+	'
 
 	test_expect_success "ls-files --eol attr=$attr $ident aeol=$aeol core.autocrlf=$crlf core.eol=$ceol" '
 		test_when_finished "rm expect actual" &&

-- 
2.56.0.611.g1030f0b940.dirty

