Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9651C3BB116
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 16:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885853; cv=none; b=EbbEGmBT/uP3pwQDVinf+SWMpDXsWq88NM8XzZbUxPiALVddtHcrW6B9F6QuP/ow9xsEnz2C/j6hGP/MiLvCBLJKM2sev5vVDuPVjiDEcobLHz1IPc/CcrNXRXc51oIu/r8Aptw++e2T9YLU4j+1hJPTWtmNuKenMhk0DdnzYqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885853; c=relaxed/simple;
	bh=oPh321HzNMl1gNkmtQWASDoBh2J/yw11Lqku8+Snmjk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Pky4TxHodHOmeJdslmuC5rvymHNn9PDvK6UtWkmfuYTbdx1BvvxqYhV6IwNmXcYv/ewF26MS4VjfpMExh79D+GcrogKVqQ7SEh4bcQs0Qzio/lJ+pnZtobyvQwKVzb5iCGsRiPyey8Ak3Zucf32fo99IyGyLynP+EGxKllrBduc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FFTAQvvz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RR8m7ZGs; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FFTAQvvz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RR8m7ZGs"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7B8AF7A012D;
	Fri, 19 Jun 2026 12:17:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 19 Jun 2026 12:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781885849; x=1781972249; bh=/+LnQ+K5O9
	UUYowoy4MeXugFUkrqHDsq0mVRGnCPJ+4=; b=FFTAQvvzDbmZCWes6JdGf/P5d1
	LnBmyBPgcUIrDTkVBqnN0uzMAX4ClKoEn+V1T9n4VO/gU2pTlgZ8Ca9h/QUBaIM9
	mZg3eC4BxsalbYTHLk19rp5XEVv8FegNed9z30kih0A8nT6ME/bP/8zmEfX8iMZf
	Jg+w92cRT7Gr8ZyYeom6KeNKDBNdeFlYNf+4Rd7WwrZ9yUVov3ul3eWggZCRRQDq
	ddpR5wDUeUGnVfr6oDxMBqUcbJCHFThJ5ZiEm/MsO34ka0HCTqAna2z5WYkfWFFi
	pNaSJIZZH6PFUzNLNdq9PphiW2UhEldHHhvkjVpwdVptyNnIxurEavVGcVvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781885849; x=1781972249; bh=/+LnQ+K5O9UUYowoy4MeXugFUkrqHDsq0mV
	RGnCPJ+4=; b=RR8m7ZGsi38ZoTtiTNukdCo0sHvd1fNJJgqaLhKI2Lz4FBlGEEi
	YsOhcw4FLuRVsNZ5RJcxbGjxZaVQyJwZyNdtiZEW7EcLeErd69iUaWpU378n2F8y
	rLuCWQpiOjJbvuJ62M6HvURBNJHpGeklZ3jETHSMXtIqPot12aWbjFqPbruJtrS2
	Mtit355oNH01qub2192bRIis58C2GT7OZv+kA4f5VR2BmvOH0voyDjuiCTdEZxBo
	ueiWoY3m+MYuZfl4+t59FejRWDzqUCyBi37TA5iVrpvpecKx0cb0wy/ChBh/6IYJ
	6hx2EXpprkgtDB6Tjz87FNh98lDvPiTmx8A==
X-ME-Sender: <xms:mWs1anxeulOFOR_5RhiW_kgvYVyhdjixOlw6E_IDpssluBRfqZc9jA>
    <xme:mWs1amRjvBy12YjdhXzDznv69IvQynn1fUMPD3getjwROwMgMHIh7G73bGrMBSO5x
    vvrOxhPQc3atvOTNo63rwUyy07qMeytK4T5OP8xf6VyLExBNiml>
X-ME-Received: <xmr:mWs1amU3nEMUd_MQT8q9FMYnWbw9W21455DP2yb5ax0qegW_DcahSP0cLTjJjiDeCe0gCyGA3cG7bljN7WI0LgK_E3jCiGEjNrwz>
X-ME-Proxy-Cause: dmFkZTEAovaZkaMeqHNv4pvnuXDZJAsHBlkDZPgT7Q1mSK5vQVSp//N7HuVJXhCaUvyuo+
    KBaPYiwjBzklpO60Af+WIs6paNetKfdkFZq/jN30CSTHTR6DV8cX0ETvwpH/XXg1arHd/k
    /r3u4Vupk2wTwPbQz4PEXyVw7cW9HxCydr45319ywzatpaXUxyfCwtYJd/FBjvy2Ce+kDP
    r429mUXfXnc1FUbF1TVXPuk75v4+xw3b+4wrLcUgfYoWDZkpjEGQ586x5E4fbm6EmEgp+l
    TysYpego8ALU8+itIb7YCl7gOC/F2TPXdH9+fP/ZJPxdv6M9VVT9IUuPK9NlFkIu6b/xE8
    k59Pp/xTM23h3Yhua9wiK7YnjTz/mik5IC6lcuynvaGEn05dYOp6xd/uZgf6B7nBFtexzA
    XnmACMyp7hARRH8DxlNj+ODd64uk2nI4TB1qB6ILUePBs/tbJjKrokBHpN2k6QarghaR8g
    Ofd38QiNnC13T+HfRAfiKIBppLS+LiwvTLLUOIa1437pg+9mZ5UhxtRHJZIumgm7frz7iE
    uAvoE7sRkra8CfT/QfffVCEwyebk7PJw8xFVLmxGQn/P+LZPAvE8uj1WPWSvOyr3YJyycY
    v1bqWY4bCbIRmQCzcyxiMakACeiuCSznD1fyzdfQobqi8qsSB05wrwjdhJNQ
X-ME-Proxy: <xmx:mWs1agZihKP3_EGj4ORZUEYHhXxQLkzPpzWMnKV-oSuQ4XFFNnTeCg>
    <xmx:mWs1ak1WOM6KrS4qfbNog9fzwhAPEInI8gMuCWEfLfdn2TwrJEnPnQ>
    <xmx:mWs1aqg6GA_wEyVFVGZLgqjYjrFgcxTN258pJtpiSP1i5T1uaQjrCQ>
    <xmx:mWs1agb9znz3GWhAr2_06Qa-FO4NMdDHpFbipQABeZ7reVMlUa9vng>
    <xmx:mWs1at2tYyZ8cUxP-D5cS_nMaOSMA-2MyruXug26jZD5ZQkL1hsbVclU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 12:17:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Michael Montalbo <mmontalbo@gmail.com>, Kristoffer Haugsbakk
 <code@khaugsbakk.name>
Subject: [PATCH v3] SubmittingPatches: address design critiques
In-Reply-To: <xmqqpl1oteoi.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
	18 Jun 2026 01:50:53 -0700")
References: <xmqqv7bhxiby.fsf@gitster.g> <xmqqpl1oteoi.fsf@gitster.g>
Date: Fri, 19 Jun 2026 09:17:27 -0700
Message-ID: <xmqqik7eld2g.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Contributors sometimes fail to answer fundamental design or
viability comments from reviewers and submit subsequent rounds
without addressing them.  When design decisions are resolved on the
mailing list, the final justification should be recorded in the
commit messages.

Instruct authors to be particularly mindful of critiques regarding
high-level design or viability, to defend their choices on the list,
and to accompany new iterations with clearer explanations in the cover
letter, responses, and revised commit messages. Also instruct them to
explicitly document the resolution of these concerns in the commit
message body to keep the historical record complete.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * Updated a bit after reading comments by Kichael and Kristoffer

 Documentation/SubmittingPatches | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index f042bb5aaf..a9789e5303 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -51,6 +51,21 @@ area.
   respond to them with "Reply-All" on the mailing list, while taking
   them into account while preparing an updated set of patches.
 +
+Be particularly mindful of critiques regarding the high-level design
+or viability of your proposal (e.g., questioning if the feature is
+worth implementing, or if the chosen approach is appropriate).  Defend
+your design decisions on the list first, work with reviewers and other
+members to improve the design before revising the implementation, to
+avoid wasting effort on an implementation before its design is solid.
++
+Make sure that any new version explains and justifies those design
+decisions more clearly, in the cover letter and in the revised commit
+messages.  Aim to make the reviewers say "it is now clear why we may
+want to do this with the updated version".
++
+Topics with unresolved fundamental design critiques will not be
+considered ready for merging.
++
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
@@ -323,6 +338,10 @@ The body should provide a meaningful commit message, which:
 
 . alternate solutions considered but discarded, if any.
 
+. records the resolution of design or viability concerns raised by the
+  community during the review, if any, ensuring the historical record
+  explains why the chosen approach was accepted over alternatives.
+
 [[present-tense]]
 The problem statement that describes the status quo is written in the
 present tense.  Write "The code does X when it is given input Y",
-- 
2.55.0-rc1-129-gff98d784de

