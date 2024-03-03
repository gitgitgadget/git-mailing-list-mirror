Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF9479DAB
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 20:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709496247; cv=none; b=FwbyWIXOmwCgyClsWkrIkcPicKBjDkJVIpPyqYIbBsJBT7s+JSTOSCv1Tn9nm/eGoZb4tUdHgF7pRkPHX8Kpyw5dB1siuCDCxl7CNLfVAwj0x+Y+J1nFknOzmzaP9wMOhWM5cMIvtvkDqfz0QvT39QjlVkNE9VTNzzG73c+F47k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709496247; c=relaxed/simple;
	bh=LxhCNhCdx1MwSu0/JcGGg/RufTupR7UXH9lCqdzuoN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=E5jLA2pq4eaTl0mc2MrT/Q5rkRb7yN0bcNioSnsOmDfbGKji4T5yIMsF361zq1hOC4U5fHuX8WX6m4FAnv2tA97zgbsqTCti25PjPFHN7rrXsY6O5bygQ+Ep4BAm0E4wYiG/BW6A46CURw/XhoIX5SxD5qbRSsie8fCOg6/zvM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=c+Qf0C/R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gmZCdCRT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="c+Qf0C/R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gmZCdCRT"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EEE0611400EB;
	Sun,  3 Mar 2024 15:04:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 03 Mar 2024 15:04:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:message-id:mime-version
	:reply-to:subject:subject:to:to; s=fm3; t=1709496243; x=
	1709582643; bh=yzPbTrx2cQ/0SpyMYWMNiYRX7yS7RkpQuu6XTsHDCeo=; b=c
	+Qf0C/RPKT+AvEfK1Pxbi8TDX8UhDsgHHAKU4UC8IcVHUmG4wii+C9Fctc2ukJzW
	kjzHOUh5OwIBxIumjx5Fh24JBKK/UYxQ+BKC3qCNBj31TMgEsv+OvlG6uNCHwAP/
	/27XrVff8voENpHP3+jEpzbm4m+PgV+Kpx9sik91BIqGHINB3zXfyZQYoIOZ2k3Z
	mm1TchoR898kFb76Mzona1i1o7V9WwSY/QCKOkhBi8qAPHQ3hxl0oD/L+n9o1D5s
	uv0j47hfjGqWZL8U43If86JhRmMz+WYv/cG/55XT9vJeLSFZAj0h+sybkrr6h2P4
	01HYAkfANYAmOwineKVSw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1709496243; x=1709582643; bh=yzPbTrx2cQ/0S
	pyMYWMNiYRX7yS7RkpQuu6XTsHDCeo=; b=gmZCdCRTYIo2idKjvafKMO2Rv/swe
	ko5sLsDkU5BKDV14L8Sg+wsZRPhtNM+wuQFt22MKPvrn1aP/TUfwqKlZfZ7w7MNW
	dCpgv9Cg1EirZmuTWiRdFT82S0pP/uJb4ffGQp4As9MyuTvQFTwVLa8kcLPHW2AY
	Z9etkZZ3O8hv9iZSReQXUNwtmwtIckdYGmFyq/+LuwSBJlLNzf7IDdsmbueXLVAt
	0WhlMfU0Vpg/kq+OMwtVbArMBVBakt8QbEF9xObWdpWhat/sTaZJjol0IbNBe5sV
	AVL5uMioPB/JVx9gYD/u82Ds19fbqsDZ84fQNcfUAgSZi0T0GU3iOUA4w==
X-ME-Sender: <xms:s9fkZefcx0VXnY8wjnlMjXDrcsnSt6-70Y6DTAbZ920dn4WlKG5L2do>
    <xme:s9fkZYO0eoV6Kyxt8KexpJfptXn_9E_tWRuGhwakukfBjAZaKVD6Dock19WtOHvoS
    c5-eK6ygL92rrEuZw>
X-ME-Received: <xmr:s9fkZfjlkA0xWAU-sKc9I2MQ0ILc3Ls30OUd9GTbwIcdXPYVCHHWEvf6yFr_PHCMm9-F8Ojqzr5tlOo-XKJERr2_RZnvU4CW1tbavWIachYCSpa-zw7BCI8OYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheehgddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffogggtgfesthekre
    dtredtjeenucfhrhhomhepmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkuceotgho
    uggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeuiefghe
    euhfefveejgfelteehkeegudeluedvjeettdeiudejteffuedtudffheenucffohhmrghi
    nhepshhtrggtkhhovhgvrhhflhhofidrtghomhenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghm
    vg
X-ME-Proxy: <xmx:s9fkZb8m0kpGWBkg2dHk5x9D2_zH5CYcMQxMAJBDv1k6lssrnNkXOg>
    <xmx:s9fkZavdoUBDRfExG3Smsx9defNdctzcGLOuRuzoY8GYzktdZQzKhQ>
    <xmx:s9fkZSGgnRY-UDvKXICY37QSO_Jqav717yUZ9sqWHcwadehR2sLGCQ>
    <xmx:s9fkZT7VDNkoMDqsyI71Pzab8nuGoubdOYCZ0cKNluSAhmPegk7z7w>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 3 Mar 2024 15:04:02 -0500 (EST)
From: Kristoffer Haugsbakk <code@khaugsbakk.name>
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH 0/1] rebase: teach `--exec` about `GIT_REBASE_BRANCH`
Date: Sun,  3 Mar 2024 21:03:36 +0100
Message-ID: <cover.1709495964.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.44.0.64.g52b67adbeb2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following patch adds an env. variable for the branch name that we
were on before the rebase operation started. This is for use by `--exec
<cmd>`.

The need for fetching the branch name came up while making a script for
`--exec` and it seemed that parsing the name out of the first line of
`git branch --list` was the best approach.

I thought that was inconvenient. Why not an environment variable set by
git-rebase(1)? (open question)

See: https://stackoverflow.com/a/50124157/1725151

§ Implementation

The implementation is inspired by
`builtin/branch.c:print_current_branch_name`.

Kristoffer Haugsbakk (1):
  rebase: teach `--exec` about `GIT_REBASE_BRANCH`

 Documentation/git-rebase.txt |  4 ++++
 builtin/rebase.c             | 15 ++++++++++++++-
 t/t3409-rebase-environ.sh    | 19 +++++++++++++++++++
 3 files changed, 37 insertions(+), 1 deletion(-)

-- 
2.44.0.64.g52b67adbeb2

