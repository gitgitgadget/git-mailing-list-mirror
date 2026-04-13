Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF99B3B2FC9
	for <git@vger.kernel.org>; Mon, 13 Apr 2026 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073790; cv=none; b=m9OMsm0mWZYsOPL4Te8b1b7TL/Z0bsQkIajgykiC+DKlsDOk8rFYNu1G8aeoCSt9Zargz5HHs7HqUMtKOmKJW75nFb9lEyhDXWAcijvSQUfvAQ8/DrHu3bFIMsFAgh+UhsAIl5NgoY+WQcV3HN2YnTV3mHEqqeQ/gNG9TnjeGOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073790; c=relaxed/simple;
	bh=FIXjilArIddDzmCaMaAlB+/X3pCPzDS1neACV2y9sXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ckd0SmHmPITam2RfH0IJwa/14jXuwHfG2Mu6jYwxtUtxdK4JHyymd8NIxNwkfIt3dMCNZZQZilQNlQMdf259PCLz4yn1+xvdLSjxR0DlLU1L9rrCNt/HaZja6O+NTR3EpMN5VtraLCuq7LLsZJUTo7D2DAh9dMs0A0/gN8Ct3fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qsKnEUWS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=llmHoijv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qsKnEUWS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="llmHoijv"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D4F30140018D;
	Mon, 13 Apr 2026 05:49:48 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 13 Apr 2026 05:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776073788;
	 x=1776160188; bh=8WcoWYU1PY0SBb9n71aUCRHBpaItkiKkJmmDcNBVNis=; b=
	qsKnEUWSx0ArW6dX2SBSXXJiY0nsx+eMaNLdI5VPOJQlixVAR6mbU+jyqD1po33p
	DfC958tDvHjIhipWiyITR8O/3Qt0H/99nDAYbEoQ5x2FSDVxzpCidKVWfVMf1Swp
	IM1O8IGt/tPB246lNQYYn5AePNxhILto6SRicsorO+mrJkKKy5P5irSTPgTjqEdB
	2ayQSyo1hoSZhw6AFr1Vhdebc2sANtaDgA3ABB7932K9/VPT6QjilZUumkJHsbvs
	f6/nJAKxJhsx1bN4s4fNMxMpDd2LhR0FI2U4xUYy5L1DLDMFX8mgmXn1DbkWF3je
	VWmcf1NtCOVSrsLHn43i4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776073788; x=
	1776160188; bh=8WcoWYU1PY0SBb9n71aUCRHBpaItkiKkJmmDcNBVNis=; b=l
	lmHoijvUhhtTKZGKW7IyGkc/aX9ezpmJbTTQOwC+V8OyUuq4oeANHQNqpbMAW2S1
	cLcm8HEmTmz7f99p8j6FaZvNcoYfg1UjxLhu7VaqacCoXNUuRFC64GzoIGatVT54
	Fx0qjiJTtSZfr9s2JfaEo4JSkrOnhMiAt1odRu6t9E3iYHFxPrAog8qHigiX+FBx
	7X04Dwmphfp2e7G5mkc9E8ooq+Hyw7Y01cB/ML8uoJ1Ol4gobMGUbjqAtNk5+MW7
	RoU4q2EtFvSQ4xbCUkPQGju0F9s9TbFzqFwa3nCweZ50rJTE8YoTtwlMkr36zFys
	OEIOoI5mOR8nmCbr0efig==
X-ME-Sender: <xms:PLzcaeB9A0rZ1ipWEKbZy33oCDTqkP7Lz7tB6dfZ4pl9ns4IV7iRqA>
    <xme:PLzcaeh3p8kc1MeesgJ7qJY2BeJqaXzBPV0OXzUOI70SUzV8PwCbJM7cNB1ZUzlqf
    SsazcdqIasbm4LED6LzGZ4DqIS6U7CUatbE_aSacvgMeXxGn2ODVg>
X-ME-Received: <xmr:PLzcafNzMUCPECDr5GwwhxoF-HAuib9wxnIVhAHWs_lxOBN3DxBxc-RRmNVXSUCW1JVWvE-8BXbw737tWJy98xmMJozZ9VTSHMssLILMIO8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefjeeludcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:PLzcaX75GIlNQgAZENB4x91hR50071nEomT9-TXOZTGCSc66fhaSUw>
    <xmx:PLzcaV3st_1StNNzVJ6MkMJNvrhjj9RTDckg9cFwKazMTUyPIBwTMA>
    <xmx:PLzcaQYd_26oawAPdNO-79rzI8IieAVncQ3-G5RLSKY_hRTLQcHYJw>
    <xmx:PLzcaVByz0d2Ey-sdkIukHf4teqqSt9qcRuYxBIK9aBw4t3RXQjlww>
    <xmx:PLzcaRb8TIAwygHIMgOTRna6hAt1L77-CjGiyZAD06y0U-5Enmt_FOMs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 05:49:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8cc22aa4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Apr 2026 09:49:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Apr 2026 11:49:29 +0200
Subject: [PATCH 08/12] t0008: silence error in subshell when using `grep
 -v`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260413-b4-pks-tests-with-set-e-v1-8-5b83763a0e84@pks.im>
References: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
In-Reply-To: <20260413-b4-pks-tests-with-set-e-v1-0-5b83763a0e84@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
index e716b5cdfa..1218005b54 100755
--- a/t/t0008-ignores.sh
+++ b/t/t0008-ignores.sh
@@ -122,8 +122,8 @@ test_expect_success_multiple () {
 	fi
 	testname="$1" expect_all="$2" code="$3"
 
-	expect_verbose=$( echo "$expect_all" | grep -v '^::	' )
-	expect=$( echo "$expect_verbose" | sed -e 's/.*	//' )
+	expect_verbose=$(echo "$expect_all" | grep -v '^::	' || true)
+	expect=$(echo "$expect_verbose" | sed -e 's/.*	//')
 
 	test_expect_success $prereq "$testname${no_index_opt:+ with $no_index_opt}" '
 		expect "$expect" &&

-- 
2.54.0.rc0.707.g0fbf48f4d6.dirty

