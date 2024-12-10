Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04AC1A00F8
	for <git@vger.kernel.org>; Tue, 10 Dec 2024 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733832130; cv=none; b=nTwofchn4pLZ7+Vfa8RgNmFmjayVX1YqDXNN7SqqmRdUpfZohVE2bZUUtRt5q43LU/do0dwmBYQ5Dy6mhMtF8nqjGD6ebc2Sr2gm5JpNm/dxT2TwM9eAm+L58i97gyuuKSvDFk7k4hODm2Kj+oYki3NR+hZ3WyjLDKwCUduxWsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733832130; c=relaxed/simple;
	bh=mpMQV83AowuzqWSs+bB3//z0Eg67AeRiDNQlMRa8pNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FMDuj/fA5Pw/3VPltr6w0xlQYrMUsUd2ZuvpQ5k9ql5GuEGzYCPZpSXnKmu4SEm1hMM/5iKp7ITGOxI597m8mifVHsd6V8SJV39UVuBCVJcWFfPpvMZGsJORBFo85ICq2KtaeEIT7c+ZlhYphhRyys8B6pPoPJ0vV7N+miGMrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=xbb3Fv60; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cpCSZqSw; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="xbb3Fv60";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cpCSZqSw"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 5B4861140168;
	Tue, 10 Dec 2024 07:02:07 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 10 Dec 2024 07:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1733832127;
	 x=1733918527; bh=0cQRARztA0W/Fi2HfSYPDPp4L4gvmTtbzVPsSSwCl1Q=; b=
	xbb3Fv604dSqm9hH3Qb/mB6UQusGisz2UIweQiMBD9T+bOllg/P/IfLqjl15bwsw
	BFue1AhmXYfr8zT2r0X1I6Cp/uHsQiaR0lVtV45yP/ERTZcujSPKj/EefsEpnVIq
	f3RFNtES9i1Wmdh9WTiuk7RfH5W6jhWfzrBHTDnPWqsLXI2N0glkEP8OXRInFhVX
	cdW5WKLH6UiG1xZQ2rHc0tXT4V6b/T/tQ7RK5c1eXzYstTDvO2HFkmJ1bz9jpbYA
	56LQrbaET+p1vwVyjeNB1TUqIK7hT3xQW/twlbRHKspx9/nSc1FaS52Lym55RHfW
	1yYXg76D5ttDp+TBvg8WaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733832127; x=
	1733918527; bh=0cQRARztA0W/Fi2HfSYPDPp4L4gvmTtbzVPsSSwCl1Q=; b=c
	pCSZqSwnGcWn2rug1yJIXAIgd2Ei+djFnrPCNjTWppAsnMEQbaMtx0d3aKjNhLfn
	guLfeE7S1hhpbc3bnLGJYGTwBw3naq8WSBzskBOhY5+4thxN1skxkURWoD4mhVFI
	QcsjS5kiPLuT/OrrXSMRBCZOXBQPW+o7ZPjbUnrhlFPvGsId28Gah1/cISrR3dL4
	VrYJcl/tEIP0eLC6JLVIyb5asQHcDT50bhwZJWVMuu8toQ9FhaaY6ztPvk0Gx54K
	F+ECwdHs1pcit7LKMyCUpNaslFcw1c9mEQsvvuR1kIC1cEEWrmFFm+giqcSywrdv
	yowfa5/jGZZy8RsSSXqSA==
X-ME-Sender: <xms:vy1YZ6mPxmq5-mW5bmqHslKTnr8u3o5RzWMTmbZLqywTUO1tWwCVtw>
    <xme:vy1YZx0dXyGtBjCymzUFxA72elqOtxzxMVkQdpBUjDKSod_6zMVxaACg806M4gXz8
    WUYnfxdlZvwqzdIfA>
X-ME-Received: <xmr:vy1YZ4rLw50-xuqM7M0T1Pz1mv34fmtNukEGA5GbjfnNh9zS3xrGAtPcxWHF4_WJiKxi4q6G22bYVp9ukJNJrKpxikoFTpiB-v1FXODtkz1N>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeekgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepohhsfigrlhgurdgsuhguuggvnhhhrghgvghnsehgmh
    igrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vy1YZ-kRV6k0PPFkqoUl8dKVJSOIpRh51-C6gs1G6nsDTqlKIq2bRg>
    <xmx:vy1YZ426OSGgB_xbe6fZxIriZTL9Lt3RzXWYLhwk19cDODZTa4HOeA>
    <xmx:vy1YZ1u4EcQqhG3JU6s28F2wgDagsqxLTo_Qcw3A6akIpEdPJaGDug>
    <xmx:vy1YZ0XSrrffDqhSl_y7GN4qU_AHo8FaE3btX84m4ZGXqcCQeyPhig>
    <xmx:vy1YZ1yumFfuuLNx7V8NwUfkuCj8XJQ-URcXNjtTQpBmWHXamj9qW_Do>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Dec 2024 07:02:06 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 5f236dcf (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Dec 2024 12:00:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 10 Dec 2024 13:01:47 +0100
Subject: [PATCH v2 2/4] ci/lib: remove duplicate trap to end "CI setup"
 group
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241210-pks-ci-section-fixes-v2-2-e087cfd174f4@pks.im>
References: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
In-Reply-To: <20241210-pks-ci-section-fixes-v2-0-e087cfd174f4@pks.im>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 karthik nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.2

We exlicitly trap on EXIT in order to end the "CI setup" group. This
isn't necessary though given that `begin_group ()` already sets up the
trap for us.

Remove the duplicate trap.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 ci/lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 930f98d7228166c37c236beb062b14675fb68ef3..a54601be923bf475ba1a9cafd98bb1cb71a10255 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -56,7 +56,6 @@ group () {
 }
 
 begin_group "CI setup"
-trap "end_group 'CI setup'" EXIT
 
 # Set 'exit on error' for all CI scripts to let the caller know that
 # something went wrong.

-- 
2.47.1.447.ga7e8429e30.dirty

