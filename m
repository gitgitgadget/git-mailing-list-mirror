Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A9317A2EA
	for <git@vger.kernel.org>; Thu, 16 Apr 2026 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776338399; cv=none; b=o7vK4G9IDKyGCXQ28ipdv66aAnmlR9yVuW2K+P0iDMWxk7kISlMfB+E0KZ3Z0ynbPkUUXs0APJ/vT802SwQwPZ9qnCxZIqyZ6wuVBkSO9hu1bVBwIEbrgB+5k42nfeKFETmPEc2bwdmeW8loenn1Vjc8qYD39gyhOpUwjn7OBCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776338399; c=relaxed/simple;
	bh=Sqxral/SVat7YZbY/zlwJPMjwZaC+tbEEgeKF5W+yDg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DYprYftfMPtvS0xcihBDCAGyVzcYs1hD3OWDiIyBWS44ztZdP01zpoUZOsfGdiR8YYrVRqA4uYcQzzDyVpx8YD3x6btWGimbctzRHsjZemjBdpIzqXUO5bPblyJHoNqqAYiXxZ8sFUs3Dy8LEtbDDmCfnKRyFvPz/1OJhEUggyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZdEzuEln; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qQ3o97AC; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZdEzuEln";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qQ3o97AC"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 4FA641D00257;
	Thu, 16 Apr 2026 07:19:57 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Thu, 16 Apr 2026 07:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776338397;
	 x=1776424797; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=
	ZdEzuEln6rn9kJotbEbRjLMjSGTRumWwMmqST3+BEfwmxoRcwG6lJ/3FJgFNinef
	47xIC8c1O39wmThritxSwBgu8MD2n2dG1mQvKLREJ1SeMby0ftyTiG6L+mxBPxzW
	3iX1cpV66YcNoBi5hQBrXvHJ4wWo3EMERAi45E3/51518x8gweUW0YiHtsAFjbIZ
	81qum9wG3OfciNY+k3NvSd0NN8abOk1vxy6gb5Aw586WrGQK84iER7ZGaJPEslS+
	sSgTeGRwJce9iQcLlx322JKKJSzOT7Mg3WScmVF9JphQ342bD+FWZVUE8+sYApma
	t/L5Ss+zrlnaMc/MJpZPdw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776338397; x=
	1776424797; bh=XEya7yAAAKPO3UWdxUc352JTS9XG89Av+Nmdra2x60M=; b=q
	Q3o97ACsYwvCdwo+RYbsWNy07R0GvaRrHOR3/MSj7FTI6D5fsz3xvu5zHW9vdOdH
	SuDc7ba8bbJDaJW6aPgs1C2WTcB+ikHAvEwakY/a8oMvHy0cB9FTXFY3gL/3fhM8
	57Qf6yvfmPK8SRdGOT2wqtsyVRONI/859N6zhoWPyrIwyRriEz6aw1Qi0uU/ILEQ
	NLsuOTAtPjDZPspB0PN0fSFNPusJdUx2oA88zvvPZXyDyUdbMWEUPOZ57NytR36u
	3PWO9erDE8uZ1wbvSf8SdjOZVY++rctusZ93oLYR0Z+oJB/gKhbtA3W5BjDJRXmL
	GB+MSREU3gsJeiWIqsZBg==
X-ME-Sender: <xms:3cXgaaoeV3Mwvpd-5YoudKKC1VIPDIXOdDnSe0MsCtanVser07IlJQ>
    <xme:3cXgaQHCLsTvbbtSC8Iw8U0wtkKbAEN9I3ug8P_1VgRL3r-_52PnssKsf1NTfNaS8
    XBI74F_FPlRgLVgt-5vLKPJHFYJBNENZrWnyT3l8qVe1e-0gvg>
X-ME-Received: <xmr:3cXgacmIn3UjYLf_OAnkEmrhGZMx9cKm9jQzts-pL720Tn-sfXeqQvGmS17joet9GzbjaLI2WTvaAa-GJSfwVg5d6ac1nR-zDCYdfgYBAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegieekiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:3cXgaTlX6Lk2f2Q8zsoxvBpDF4ly3yOcnHnatcGyeDbEZwRwbEY2Og>
    <xmx:3cXgadvUNycgVEM7lAI9-ikcXeTTGaMvAqa7dbMCCoQqWOe7pmS7-g>
    <xmx:3cXgaWnkdwqK3yR35dkMz2AMjDXeDQRHb_2e1BrsauEVY7nmlaW8Kg>
    <xmx:3cXgaYug4TjYXnQoYgkrsK96po9eI37TuJ-nSoK-ZS_A9eZr_OqVsg>
    <xmx:3cXgae2FFb1Ef01PhhhvORwhjuQ8oZ4SRm-aUM0IBQl6lgkmyF59YEak>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 07:19:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 292a02a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 Apr 2026 11:19:55 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 16 Apr 2026 13:19:25 +0200
Subject: [PATCH v3 08/12] t0008: silence error in subshell when using `grep
 -v`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-b4-pks-tests-with-set-e-v3-8-7a90e5dccadd@pks.im>
References: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
In-Reply-To: <20260416-b4-pks-tests-with-set-e-v3-0-7a90e5dccadd@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In t0008 we use `grep -v` in a subshell, but expect that this command
will sometimes not match anything. This would cause grep(1) to return an
error code, but given that we don't run with `set -e` we swallow this
error.

We're about to enable `set -e`. Prepare for this by ignoring any errors.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t0008-ignores.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t0008-ignores.sh b/t/t0008-ignores.sh
index e716b5cdfa..d77a179bdd 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,8 +122,8 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
-	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || :)
+	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&

-- 
2.54.0.rc2.529.gd9106f7525.dirty

