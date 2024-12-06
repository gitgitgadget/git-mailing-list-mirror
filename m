Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110E622C6C3
	for <git@vger.kernel.org>; Fri,  6 Dec 2024 22:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733524810; cv=none; b=FS+FEu83I1Ziu7dJnEZfClU2wrwGuNyPIvvf7WOdo9IkwWIMI688ZLazm7cGqE1VLKAan+AD2vFBKQjXsasAaaU2OZOpByPU3d1xH6nTz2/qxMBPXvq1E6LW9qiRQkTr+6b8SIydHjVojSe8cF2ni3Znoa8x5SazPHs6OPwhl4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733524810; c=relaxed/simple;
	bh=5uK2dePl5OEImcC4CTlJu11dWBKsoNc3x3KMjxEzkqY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nM4NcVdr/MbTIECtCNHbpAqcyiJCKVIB2920GnntULezrLhC27COOMvUGCGN+m+BYn61Pmt+j9QeIJkv32He50CW194AmHkKVauxU8Cvu1xuPKWSRlCGnA7zY+FNBSk+pLkZ6zuPGLnJpnMN1NLj5tw8p2+iQAKdst5ncF9qCQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JPqL05Um; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JPqL05Um"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 170811381D88;
	Fri,  6 Dec 2024 17:40:07 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 06 Dec 2024 17:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733524807; x=
	1733611207; bh=PFC+qyJk+X/8E1J8LIECis9ya8cb9PxlGwCYKs20VTI=; b=J
	PqL05Um8lNHWiWxm8gmFgpngLaX4sao9R4f4BYKFqZrzbN1PqOU35HfsCrX3+KtK
	6yh1o5DTxHWKBSyAUhhp7kKG811zgOgS1WmxDfqQXA1WJfH7/AivJj7t735rCk/+
	gmOxn5iKB2kdWcPM1iy4WkDe8Q4KgoDiNBUg+p8+IPifpMMEc7AmOW34xu8+B2Qp
	M042ApWMGj8do3p03quCw5JjcECrtsD5F0GB1HmbPQokR09ghBSiXtF1++4ty7J0
	oi5feQROS4pClTnUePzxaHbVL6tQ/T0I7xJFPXQQvqESE1GB1ZH8ADBlYLiIPL56
	rh9E/wmLiuucEpChPggaw==
X-ME-Sender: <xms:Rn1TZ97q47IM7WS-bxM5sdFVpv2priW9A16YTIzMUCMn-bt9M5NhrQ>
    <xme:Rn1TZ66QrEAcgi1L49a_zucDO91ucldccYY2vQG-lfLiSTZH8oSb8SSBtsb7OJrPc
    JccEeiN8vK4MW6yTA>
X-ME-Received: <xmr:Rn1TZ0dGPs8rR74NgYZwV2PivvgznIBJjEcNjF6l0p_q1nhg0ltjcadeEHyrJPZChoSb4qkigReRyPlk62PUj5aTyucl8sNKPE26zpk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieelgdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehpshes
    phhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegrrghrnhhisehvrghlohhhrghirdgtohhmpdhrtghpthhtohepphgvfhhf
    sehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Rn1TZ2Ii_9D2v4vZ-8TKr-84R7T6F4UO1BCTuhNfN3FZDm-KjhnO-g>
    <xmx:Rn1TZxJ0ISBA01FZwSlspw_SNVsPdwgcA3sI4iwUYO0zaaPQgRstrw>
    <xmx:Rn1TZ_wzBdpZfbijxHWzmzcLIngyp5HKrXHgivw9GwKOtabYNjCDMw>
    <xmx:Rn1TZ9Ib2WdSSJT9UAvMFZBrV3zh6JkmR9UyIYYNVTHRBJol19Mzjg>
    <xmx:R31TZ5_DuYtvY_8oq5rZZJGNdgxoLVcGgBcj98LVaKMNLB6_C_HNgSmW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Dec 2024 17:40:06 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Patrick Steinhardt" <ps@pks.im>,  git@vger.kernel.org,  "Aarni Koskela"
 <aarni@valohai.com>,  "Jeff King" <peff@peff.net>
Subject: Re: [PATCH] object-name: fix reversed ordering with magic pathspecs
In-Reply-To: <cfc7adaa-ccf3-4f27-807c-2eed70e56aa8@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 06 Dec 2024 13:25:49 +0100")
References: <20241206-pks-rev-parse-fix-reversed-list-v1-1-95a96564a4d7@pks.im>
	<9c7b9090-8cf2-4095-8e86-2c85b6fe407f@app.fastmail.com>
	<xmqqcyi5vxbj.fsf@gitster.g>
	<cfc7adaa-ccf3-4f27-807c-2eed70e56aa8@app.fastmail.com>
Date: Sat, 07 Dec 2024 07:40:04 +0900
Message-ID: <xmqq8qsswi4b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> And the longer syntax doesn’t seem to be affected by any regressions.

That is curious.  I wonder if we have two redundant code paths and
the regression hit only one of them?

Thanks.
