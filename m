Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE72F691F
	for <git@vger.kernel.org>; Thu, 28 May 2026 07:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779951644; cv=none; b=reYL8b92RXOWZixMAwdlxIR/NS1ZcjKAyMVdrVZwhEsS8xRvUzoiz50pFf40Ygr3yRXJPu+alrfmpO8qY62NOeHyUGQibVmFYx5UrjnN23EyVKEt5s1aMXv5NIyWPMOvi14ZUrk3YmTdrKLRd6yaRIbd6dzNYvOKhSh7gUkzmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779951644; c=relaxed/simple;
	bh=iwNsS+Kom5FTmLd3M2eZILCukien/TIw3wUf5kaLOAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIIYEH/SdiEoawQ+YsSx48uD+6jcbT4+576zhQSDTgjCe6RCiYDFdsh03rSi2bwOw1Nflj2Uq/qYJcsFKLU7WZlJiyUlZkF5SpPqZDeSqJxo6gnXKDnuA0ImiXVGXBvaBvJ95odJ/pTORlXvtlxmXwM331MUwTbooFvkECbv2cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=hqEWjoKY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rYhmH+tF; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="hqEWjoKY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rYhmH+tF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 047657A00F9;
	Thu, 28 May 2026 03:00:41 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 28 May 2026 03:00:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1779951641;
	 x=1780038041; bh=2oLa47kpvUGyO71hTIQmSQYRpQZLb23lBKf95mm/QJQ=; b=
	hqEWjoKY3SmYE0Cdfs0Ce2PnqkxMcJChzc2OiQURlLocZkSUAUG5mUYzrHhrmHp9
	+V2FXySgC26QoqySDODxjeqGghlAkboCFyzIx6gnFy4RWX5OhdDXiWDNEXjBng3Q
	PfvNPcHYn0QdyPAnJxLxd/F9I8X6djPRt3eB0cybIG0Zb5Q7HHsOHwmZ4HWee87J
	VuLKYPI1gBFiTL35Rg6+sjCyscDI6lSJpCI7MncrcAmCAMajYrnM3PqgJSp1Dv1a
	zmvVYwZInLrPaj/SNKYU2v26ae+gVrERFwShgW6CHX9IT+BThlJrhdCd6Fil5MYM
	88RLiT530gxzFX+g7JSF+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779951641; x=
	1780038041; bh=2oLa47kpvUGyO71hTIQmSQYRpQZLb23lBKf95mm/QJQ=; b=r
	YhmH+tF5KFqB4564YDEEflyv8AW9JENp80gI5Fm3Ugs1YJ63OWP69AFOpRC1SYeT
	CgkE49L6qAxlAGES3Kzx7fDERNuycRD2ekSIXqSRtT12VjygrzkdqE+/UDyn0VI+
	irufdOPadMpqTbIL/QOhYydI0BffNAVDPKI4PtqW/JHiCRSsxUd6FS7gbWfr0Vhr
	NUXcGhWz9hppEYHbhBcsNefclBqUDrlUDE25hklwLAQKzV1CzIkAg1vRPdk9AmaN
	e199lRVfhcpQmaYD4acPWzRhZn057weGH5JYzgO8wy8IhUsvSJrxPUT6PXR1j4+P
	RxqCgZwkR5OyunfVSvUOQ==
X-ME-Sender: <xms:GegXat0fxiel4y0DTkLD7h2vyTtWe40kW4MKCz2AOsInOV8CBobDV94>
    <xme:GegXarHf5lhLtAhEFFEiby2165OA9qce7L7KxbUf-zLiHFFwx9_S8QfO8XC-rVFqB
    5p7VKcn7FrfLdUjglS3tfWCYCIX08e2cSLWr8pmYujVb8HaOsPFnA>
X-ME-Received: <xmr:GegXai5SXGojSeYV6_Xvowsvu-Hj_kRYeERmtVw6a8kSwH9zvG1aEWJZWtDU85-8P9A-fMKC8l7iDHggwxl2PmlA7kEDvWiWfMDxgMw>
X-ME-Proxy-Cause: dmFkZTEMZaH7qT8lZo9EqDNvFoItsdz+i9M2RY+DpV7OUl/OyZH2E53iFXimHILSo/FVOT
    3g0W4T79PEsoVLgaoJGW/n60RnJsCgKaI3VONAqKVPPNJQZe05AgViNw/N3kdO31LQLsTX
    2/cCNOSte0/QNf4A75x/8KDY9dwCoDRxuBnuG84KoG7AMQI+LRP9AcgqUvviOrNwOEDMOf
    ssHcBMPgyRTr8eTsNTeY8vTuVKXSH0LRR/DG3diI3WQDv8c08Kw6t5hjZdSM+0w1pBQCbW
    R2GRq7T9Sz36l2++dJ1p9N7VeUhOxx0l0KEAwpaDHoVZ/w9mC6gm3EstwRzr597mkAkwna
    /XauQF0re/wabxs/24al8YBJO4l1aW2RFtmncEpFSsKiL2mlZ8HSIsiCrnTk+xcrkvhLXQ
    H4BhRwTz8OmZGjFktqXmq2vm0u9awEjRO3rsg2fC8u7nT7Tm8VVdEup7Q95R701TH6BZyB
    cxwGPG5byx3F7OpWtv2eNELcpzw3SJQme+QNf/lwCh6SZW/LgedCyHk97jzFOMvIOuSyt6
    qoIJ2S0hj/gdCN9DWroqkCglp/I3bDv5Gv7WeOBgJ4DikMHDWsIFGBifyrC+xGWl32wYGt
    YRniywdcJYPMQHKaP7K3/fhrsza73fOLziU9oH9VilDbyVFKjZxnUPAm54Xw
X-ME-Proxy: <xmx:GegXaptfrLoQwUDiQJBSB9HCKKJsK0ZjuZliY6xQWPwud1X7s4RAFA>
    <xmx:GegXar4sb5N271_zfOzBT_-zOaUwp74AJO0zrDcLglZn72BsAPc9bw>
    <xmx:GegXasUOR_pSFV1UEvJQr22IKpR6oPv06dME9i77icrsI6yAUPCGTw>
    <xmx:GegXal9bDWO1Tg_7vKt75ppw3MGgmrk57ibzHb4JjTPVDKrXqD_v4g>
    <xmx:GegXaph1ZM1VN1r2zs42drf8VJRgm9aYhXhS3eJRmt538VfJWzrffEpt>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 03:00:40 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org
Subject: [PATCH v2 0/2] commit: remove deprecated functions
Date: Thu, 28 May 2026 09:00:09 +0200
Message-ID: <V2_CV_commit.h_remove_deprecated.732@msgid.xyz>
X-Mailer: git-send-email 2.54.0.16.g8f27b399cbe
In-Reply-To: <CV_commit.h_remove_deprecated.714@msgid.xyz>
References: <CV_commit.h_remove_deprecated.714@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Topic name: kh/commit-deprecated

Topic summary: Remove deprecated comments that were slated for removal
after Git 2.53.0.

See the comment:

    /*
     * Deprecated compatibility functions for `struct commit_list`, to be removed
     * once Git 2.53 is released.
     */

I merged in `seen` and `next` yesterday and found no new in-flight usages
of these functions.

Update Thursday: retested `seen` (commit [1]) and `next` (commit [2]).

† 1: 7821a69c (Merge branch 'za/completion-hide-dotfiles' into seen, 2026-05-27)
† 2: 2f8565e1 (Sync with 'master', 2026-05-27)

I commented on this patch but apparently it hasn’t hit any of these
integration branches yet:

Patch: replay: support replaying 2-parent merges
Link: https://lore.kernel.org/git/920cc022-8b63-4dbb-a41d-957ee01a5efd@app.fastmail.com/

§ Changes v2

Add ack by Patrick, the author of these compatibility functions.

§ Link to v1

https://lore.kernel.org/git/CV_commit.h_remove_deprecated.714@msgid.xyz/#t

[1/2] *: replace deprecated free_commit_list
[2/2] commit: remove deprecated functions

 builtin/history.c |  4 ++--
 commit.h          | 19 -------------------
 replay.c          |  2 +-
 upload-pack.c     |  4 ++--
 4 files changed, 5 insertions(+), 24 deletions(-)

Interdiff against v1:

base-commit: 56a4f3c3a221adf1df9b39da69b8a6890f803157
-- 
2.54.0.16.g8f27b399cbe

