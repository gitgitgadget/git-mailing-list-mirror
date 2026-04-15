Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B211738C41C
	for <git@vger.kernel.org>; Wed, 15 Apr 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776258426; cv=none; b=SHIQxLEgXDBbXFQZUjqgRWo+B34q9IcbUV8m87p1J3HHkcmzYEg2Gmkiv1a55VspoUvE3DZmeFiZtLMj5NUbbEx7VGeq4WwJFpdvtuTwc+T3py99lCjP9BfFVjoPi2uf25eN5RCnQefw54GG81IKOqKt/D++oGEbOwE4zgxzkZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776258426; c=relaxed/simple;
	bh=btpJKUiFNlUXA1LKD9q90pol3SWi1ccsm86g6cgPVbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TrBzZl8PktOcQv/Ldq9S3NeJ5UAiqd/5HADQPH1iyoS4A7PLR556VIeTSW+5POs7u1UtlabyxgIsMXcSLPUgLX2l/4EGmVpGRMH7gRsi4knnz+5FpVhSE1XYacStODSkay1ytPMGeEsZlVm8O03y3OPUAYBWJbWMLJGmM6uKo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qHGWzhbS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tr0O0B/o; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qHGWzhbS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tr0O0B/o"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id C386CEC023B;
	Wed, 15 Apr 2026 09:07:02 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 15 Apr 2026 09:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1776258422;
	 x=1776344822; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=
	qHGWzhbS+Puga67h3YaX2RE/bDmy1/E7fXwzxS/VPZbCRy89J95LfuWbBFXAGNio
	Az9wX8/NjBmxBKs7uLgIEIAXXBswW012ki0l9yZpAU6dA09Wi6R/5FsNsRPZxgvK
	9Ce1kxpWt4HI91Wv+ElRnkegnov/PWIstvv7EOJB1T+ouC29lC0L6J14wdZtA42j
	4Jhyx3m0EuEBAfTAO18/TDGZrCVssGDhLipSbCsubXF13QXU9JkITE10ZR5+5ota
	m3W2uOvKdcNTSyKoBex20Rh31MTkfUJtqHSK/qvc0B4gwR0szg3/oChtiC7Wikc6
	enfmOWfDYBL+I9PlssvofQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776258422; x=
	1776344822; bh=Qec/Dl8HiNegnp6O5X03Pa/AAEyuglTunFMmWaoK2V4=; b=T
	r0O0B/o6ocEG7neVZWYUuzJYmIlIC6/S6MASwQaJMxD2Hmg6vWugxTJzfo0TVo3w
	amwlr04hGN7MEQtC4V35Cwxi4mIZ40x/LMEpZgMPGR5EQfbcAk2H0WSuJu+fnf7L
	EIa61kWsRDd7ZRDmuOKYB6FA+BgD7jAvc6Vfn4TNt1jgOLwyLvkt3hxXbEfRoH+H
	XVHvo6tpezdR+Xx3aX2jgPQYvkybDILSiHImE62pctavO8BrNR9RA1DOpSkmqNZe
	pZgQ90CznRMbuOwyj5ViMxh9n3ldVsqSaCaJySOr9qUvYFMDys7h/L3umimIStqF
	6OrluMMcM4GSj23t9w9Rg==
X-ME-Sender: <xms:do3fabeaiJ3jTccMOGCK7HWc2i3ddsnYU5VliizdZHnGgStltOG0bA>
    <xme:do3faYpBsNKt6wMK8yF4kHbyMp01J3auMGMDbp49fzjRSggFb7AXCHoEWmajjqUrV
    5pR5Id1XyAHwORL2Oa20alkHtRULg4AOeXMay86s_9v6ibcUeB_Lg>
X-ME-Received: <xmr:do3faR7so1u0R3XSdwzOP0JqCjcwTn02--VftH3R6Ptry2dbHDBtKxDWCVLy5qGhWLC5u_t1OqNTdibl3Vf3LXKSTyDUOXZmWfIIFyG6n-c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeggedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:do3faWoAYeOg3Z7KJgXxBFmAapcV3VbQ4YY6PfrRKa9utAqyUBX1IA>
    <xmx:do3fabjkxa4UmJRSUXoWcidYvAdl2uAWmwDGvpxN360BIR39yfdZgQ>
    <xmx:do3faYIz8akDam_JF8eu8Fkp_UWtgiPcY2qmP_iltw-_ewC_RXnJig>
    <xmx:do3faTDEpLW-GnCf7L7Y28od5qqjEC2kw0RjhtiZYZofVL3zwG1oUA>
    <xmx:do3faRYWHPbyUYlO8Cq8kFVvpjPvehVJaYbYaw1tJdgkLbgNmXAEzFn1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Apr 2026 09:07:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1966361 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 15 Apr 2026 13:07:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 15 Apr 2026 15:06:42 +0200
Subject: [PATCH v2 09/12] t1301: don't fail in case setfacl(1) doesn't
 exist or fails
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260415-b4-pks-tests-with-set-e-v2-9-4e4904a96f15@pks.im>
References: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
In-Reply-To: <20260415-b4-pks-tests-with-set-e-v2-0-4e4904a96f15@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-Mailer: b4 0.15.1

In t1301 we're trying to remove any potentially-existing default ACLs
that might exist on the transh directory by executing setfacl(1).
According to 8ed0a740dd (t1301-shared-repo.sh: don't let a default ACL
interfere with the test, 2008-10-16), this is done because we play
around with permissions and umasks in this test suite.

The setfacl(1) binary may not exist on some systems though, even though
tests ultimately still pass. This doesn't matter currently, but will
cause the test to fail once we start running with `set -e`. Silence such
failures by ignoring failures here.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 630a47af21..0e0d07a1a1 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -12,7 +12,7 @@ TEST_CREATE_REPO_NO_TEMPLATE=1
 . ./test-lib.sh
 
 # Remove a default ACL from the test dir if possible.
-setfacl -k . 2>/dev/null
+setfacl -k . 2>/dev/null || :
 
 # User must have read permissions to the repo -> failure on --shared=0400
 test_expect_success 'shared = 0400 (faulty permission u-w)' '

-- 
2.54.0.rc2.529.gd9106f7525.dirty

