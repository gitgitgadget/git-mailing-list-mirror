Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D113AF665
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 10:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776423087; cv=none; b=ZRY3QB9druLmKfdlvph3VtSgFGrMt/ZMe5VkmTfeqB2bY8FmedcEmozArPIoyx503FjrSuoudYPNVjGzNc31WfjMHobIvq4MFJJdTctZQIzzeOjHnn3n8B3SrTyI6ruLuamv98D8P2EdwV6tuSt01RZrBkFduumwFTRbL0y9L0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776423087; c=relaxed/simple;
	bh=lf6HseCjtohku+/jC0a2mmYAPGUwz1dsu22ocKpLTkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KCYe3I2sTx8L4rGSDNfMmzrbZAwKyFGHA+C3xiMRk7suINXrnhtIwbEjKGLHEzP8fZJJC3b5yK1zO3oejWfTzc4SIjppJVAEFPxG0buD7yUa5gSWlQiarHP5KAWUw5kUYTS8WC2uEkbyXfR8+XIlU4FCpUtjTJvykqP/vDeDICE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dOpBfpS2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NjpoPuC+; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dOpBfpS2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NjpoPuC+"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id E0449EC00AE;
	Fri, 17 Apr 2026 06:51:23 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 17 Apr 2026 06:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776423083;
	 x=1776509483; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=
	dOpBfpS2Xy4LatLxBfnhC2p4S/ReCFHGQs2s4jeIvrAHJsSVOSwhW+5bvaCKz7+G
	FbrBRGQzmhIktenZAicd1yMUOGeu4LiWW1Xh+ijh5UxanYWJRYEAMRY4EU3SWxDp
	t8erpoPvm1NKIK+28Kmn9fUEu+qtmbhg5AyJavhkLSeD96y0RXR4BEvtlRSnlwoF
	ui9/JjkrVpmEC/+08Abhs5dW62k9p59yi/TokVJVHFLtFR/Mg6/MA+rSAgsd+rva
	x03MRnE0CU5VESVuwg3+EcXczwWf1sFJLd5w9n54/bbrtwvXdpk2U8kWBVZtbJya
	7EEyKbV5Y1UnGm13IvA7FQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776423083; x=
	1776509483; bh=aaRIbo5vrCDNLnoBzRKNfGSIO9qynSrUUu1iu1DJJpc=; b=N
	jpoPuC+zwiuBzJ7dGm+C/7VFz6R7Ryftx8dUAHSEX4dHLUGYH6p3lqkNo+xFqLg/
	AC+dhtmVbILF04MezOjyWfi50nlb5WEMfmpGGFmq646wVK5vfbnfwJkJwfP+ZbAA
	yn0YFSmzxQ90g5C6R2C/JFbk9NpmLjCh7keGT+C82icjrMDnSg+NxdXkAM7wC+5Z
	j3Zizh2U67uTmbPrgeusioOgsHRbNlEfFPeiPbCRK3qufwKolAuRoL0/pZFqbDTi
	qhiPrKL30VYSWwksCwNVvT16woCENCK3JMLdn7EkhTjzLLDMe0LLB/YNouBbrvJu
	qL1UVZz/0UCeOt2n+Sqww==
X-ME-Sender: <xms:qxDiaRiqARIDI5z14yMncXa8Jp43jUHgYMOSEezmkz2u5pyJFmc8EQ>
    <xme:qxDiadC81SpcQNFclI-zNu96bo8lL59Ip3NQKc1YH2DxTLy-mv8a2vQYVcf-IzW9R
    coSfD3l8unjlvjHLfNLM-VcqGlaYBF6IZ_xhif5JazwS2-wqgACUg>
X-ME-Received: <xmr:qxDiaWFSTiLvaB1u1SjRZUCB__SLibI7vofQAZsA0pUSgJsGYRzyslTHf_6L6XKOJY6hGEGjrHbMAKTLfBLiTQHRWEEVIoXJkNxgAgzZFI8E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegleeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehsiigvuggvrh
    druggvvhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhg
X-ME-Proxy: <xmx:qxDiaVJH6OEWUNsqWviamW_TLNO1ZYcVsXrzdqDJTImDZZwT4Rw6yw>
    <xmx:qxDiaak_02j2J696jH-NlnxLq-bdbcWl-PM14tCWUPrKtmYIxby_aQ>
    <xmx:qxDiadQ-hvn9fhl7MFE8GUHCEGPKrvrB2z7RhlPUwQTA6H7tY0J65Q>
    <xmx:qxDiacJL9iUkfQFY2G4uFrU1I-nnGaUYqUMvQoJehvjVk7OrTScPuA>
    <xmx:qxDiaQCQzdRRAgnKoEE3TrAyd5wzs1fzaD4-773UN3FjYfZEhUPUgrU0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 17 Apr 2026 06:51:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4aedb887 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 17 Apr 2026 10:51:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 17 Apr 2026 12:50:56 +0200
Subject: [PATCH v4 10/12] t6002: fix use of `expr` with `set -e`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260417-b4-pks-tests-with-set-e-v4-10-44d43efdafb1@pks.im>
References: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
In-Reply-To: <20260417-b4-pks-tests-with-set-e-v4-0-44d43efdafb1@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
X-Mailer: b4 0.15.1

In `test_bisection_diff ()` we use `expr` to perform some math. This
command has some gotchas though in that it will only return success when
the result is neither null nor zero. In some of our cases though it
actually _is_ zero, and that will cause the expressions to fail once we
enable `set -e`.

Prepare for this change by instead using `$(( ))`, which doesn't have
the same issue. While at it, modernize the function a tiny bit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t6002-rev-list-bisect.sh | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/t/t6002-rev-list-bisect.sh b/t/t6002-rev-list-bisect.sh
index daa009c9a1..f2de40b5ed 100755
--- a/t/t6002-rev-list-bisect.sh
+++ b/t/t6002-rev-list-bisect.sh
@@ -27,13 +27,16 @@ test_bisection_diff()
 	# Test if bisection size is close to half of list size within
 	# tolerance.
 	#
-	_bisect_err=$(expr $_list_size - $_bisection_size \* 2)
-	test "$_bisect_err" -lt 0 && _bisect_err=$(expr 0 - $_bisect_err)
-	_bisect_err=$(expr $_bisect_err / 2) ; # floor
-
-	test_expect_success \
-	"bisection diff $_bisect_option $_head $* <= $_max_diff" \
-	'test $_bisect_err -le $_max_diff'
+	_bisect_err=$(($_list_size - $_bisection_size * 2))
+	if test "$_bisect_err" -lt 0
+	then
+		_bisect_err=$((0 - $_bisect_err))
+	fi
+	_bisect_err=$(($_bisect_err / 2)) ; # floor
+
+	test_expect_success "bisection diff $_bisect_option $_head $* <= $_max_diff" '
+		test $_bisect_err -le $_max_diff
+	'
 }
 
 date >path0

-- 
2.54.0.rc2.529.gd9106f7525.dirty

