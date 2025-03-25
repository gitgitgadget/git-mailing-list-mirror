Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41311953AD
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 22:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742941455; cv=none; b=JW5lqaH0+q06YvCwdXagf3tyOn+tqcUaIQBhM5t+ka+hVh4/GoFWmYj/q13Zu9jzXAPvEFAFfB2Gbew+f365Q0wKu20FPlfqctC9dXsPswiqRKG77NPrD4JAbP2/JxovmePFMYsdDX0cJAbpUZ/zSxopXHhbtbnC0nVu27XSQYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742941455; c=relaxed/simple;
	bh=rYv3+Go9MXegmA0mpTCwZoa7nYczpoXglZLGwro3ycw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jT6yelRaZzLVgLYvuoVHYa67OQfCJR6E/2Xv15882UBlnsJHqRfWzMeCj0ND0j2syCKBWcGpD3pOAs3IB1nxJqrxa7c+9Wo81HyuhHCOK6YcA2kp/pd3Kl2LTFEwhsCTKNo5/Pef/rYsopv1rqXCvpGh82Gv/cZzWapuhu+RBVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu; spf=pass smtp.mailfrom=u92.eu; dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b=MgNtnmb9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XCiG0tpb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=u92.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=u92.eu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=u92.eu header.i=@u92.eu header.b="MgNtnmb9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XCiG0tpb"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BB5171140143;
	Tue, 25 Mar 2025 18:24:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Tue, 25 Mar 2025 18:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm3; t=1742941451; x=1743027851; bh=1lzAlLQNJDPL+gtELmeou
	xcoBntXsUM2myaWqQc2ywE=; b=MgNtnmb9j4WPJ0s01CQsT+z9xnrP0PeJp7yoN
	JvDA4YjRPEck7trbbWXyv8aff/oxfH5dzn7DyHjEVE3mmGDtMnVv2IyezenJ0ea4
	SDZLpOrHPH8M6xPU54Blkx7EhVl5Xh+Ka6ZM3AEeutwgEt48QW5pleGnnxwZrJOS
	mJsLygfdWrfbYBUt8RL3srALTACha7aTpclJOvELl1ASJTn0LhItxSL2AHU6GmnE
	9RjlVRF3GJaCxGto2y47sMQ63X5ToKIUSZdgGPGzD2xUmCE1swINZrRJMvfhypbq
	700v2ymx0S4kLV2v7ybGMhd9aYWji3iBBFfO/hjinASsSThpw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742941451; x=1743027851; bh=1lzAlLQNJDPL+gtELmeouxcoBntXsUM2mya
	WqQc2ywE=; b=XCiG0tpbkJrHoZb2zYpdSXNsfUigHr16aTCNhF8I4om+w87irhm
	8JTk8aXdhHU9Bs7QN4on2aWsfnSOO4QvkLiXg/M20U20iaVzjhX7XyHqyp0fnDk0
	MWU8Ia1+SSOM9u42QueGKYutcPCq/81bVYvvcnLB/0MJYTHAirFdLzwRaFu4uOS5
	UBtqGFbkWxaIedeurUgrZuhS/jqj77iuA1HmBGUJjNVcYK3/eA8aSU0DBROd2LwA
	9NKmTQICe9KzUn1t5Fjfi1fE4TRcJOYh9awJzMcycmy7qD7xQ6VfdPS6bmSrBduc
	FR3eWlJD26MspUR3qGJSBeLc8BIJeBaLTyg==
X-ME-Sender: <xms:Cy3jZ40DpsNDUoOYEYSjtKaf8pGLhcMGDUBM6kcKlU7VeGZxPP1MGg>
    <xme:Cy3jZzFN0khlnH8eRwypHW0ONoP4ycp5fx6gUfR_lX0o0kbqtIyD9t0d-XwvlDwiU
    TdZcEvXV86VhW7t1g>
X-ME-Received: <xmr:Cy3jZw48cZEevdCcwZFnJrge1jyl0FRwdujRyIm735ZC3sBx7yQ7Uhj-a9_5L8A7XpVhJn_04zEj>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhho
    shcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeeggeegje
    egtedtgeevveefleffleevvefftedtvddugfeltdegveeufeeikeeuleenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuh
    elvddrvghupdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkh
    hnohgslhgvodhgihhthhhusgesghhmrghilhdrtghomhdprhgtphhtthhopehgrhgvvghn
    fhhoohesuhelvddrvghupdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
    dprhgtphhtthhopehkrgifrghrihhmihguohhllhdoghhithesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:Cy3jZx2S9m4Ro4Krsi_UAf9dxiCNxjxs0x6AN5tOsa5o7-LYzHwPQA>
    <xmx:Cy3jZ7EIQtuCYJQa9XsajEe0xSBGMyt12H3YbcETJX7yTIVifCeUmA>
    <xmx:Cy3jZ69V_7CZrAX3CZybBA8kYQsZFlCxmSPYTCthMXM6zVz8FPUzGw>
    <xmx:Cy3jZwlHpPUFCA18dd_ialTq3t08fRLX1ifxGjhD6-ttUtKbaa_AHw>
    <xmx:Cy3jZ8P42Nvj9TfzT0_A73D6fXlo5noYjJjp9pJ8bsXjgMZkVQ8Fw0Ig>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 18:24:09 -0400 (EDT)
From: Fernando Ramos <greenfoo@u92.eu>
To: git@vger.kernel.org
Cc: "D . Ben Knoble" <ben.knoble+github@gmail.com>,
	Fernando Ramos <greenfoo@u92.eu>,
	Junio C Hamano <gitster@pobox.com>,
	kawarimidoll <kawarimidoll+git@gmail.com>
Subject: [PATCH 0/2] Fix mergetool.vimdiff.layout when "@" is used on REMOTE
Date: Tue, 25 Mar 2025 23:23:09 +0100
Message-ID: <20250325222311.400748-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "mergetool.vimdiff.layout" config option accepts a "@" marker on one of the
possible targets ("LOCAL", "BASE", "REMOTE" or "MERGED") to specify which window
(or tab or buffer) will be used to overwrite the file which conflicts we are
trying to solve.

The problem is that it never really worked when used with "MERGED" (for all the
others it worked fine).

In this patch series we are fixing that and adding some unit tests to make sure
we never break this again in the future.

Fernando Ramos (2):
  mergetools: vimdiff: fix layout where REMOTE is the target
  mergetools: vimdiff: add tests for layout with REMOTE as the target

 mergetools/vimdiff | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)


base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
-- 
2.49.0

