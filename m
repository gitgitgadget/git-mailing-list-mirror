Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9892C9D
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 00:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732581091; cv=none; b=P9O/jlPOE0un5KiyEHw10FnIKdaNWPApoaGlhLPg5sDZRDPxhL1aVmEUYbhUcuHXiYKLmL71btdeML0u4K8aXCWxfXbOmCa/Csbrx3JFbq2To86DJg37H0RUcTpyJgwPVy1RHjQGqLvB8h64/eRyOam9KIVzcsUSxu1sZpHWceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732581091; c=relaxed/simple;
	bh=P24/YhVO4A/sSdI3YkohnJdiE2excLH0djTdl+buaEs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eRNQaK96zoJwyJoq4rwHv/0p7s0DkV/ohq2mcE7K1rfOrlOtmVxnveYZkRFCzkAIDhd3Clp8EwLzJs6XWL3iag6gHRc5tTh+2GIWcibTX/GG6S4+VepUr9Pw6nIqO0FMXQ/mpGWnZFeu5HEhpLvn8Ba3abWDPezvfFFZ7UjH2j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xb2ThOiY; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xb2ThOiY"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 9578C1380268;
	Mon, 25 Nov 2024 19:31:27 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 25 Nov 2024 19:31:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732581087; x=1732667487; bh=0HNR/ozTPOLwxTHMujYwVHOBvXZl3mMK/p4
	IYyFKCYc=; b=Xb2ThOiYt45NKgq7zyZpJluNcyVRtrUaXcw5yUpqoQO6rp7NXbK
	TqYif5Hc+u+cZVxQjQuMFj7NQPjE96Zg/vDhIbxMfQwY8viu4ZtEfhHM4Ri/tHYT
	bLnbrQE1F1FCOOi2Vn5Yc3KL/XzkZxLPDr5/5MNvAlJYNDgdhFQFIXLfOXyZ5JIY
	e2/a99fPdIzB3YAB01bPw8V3p2EhQHx7j68JKNvRIuE3nG5FfJ6fzIp3uRrST5qO
	5LR7bsBtUdt6dAFBv3IdtJN8DAKZwgtv6+A7gCv/RqcrGy+LVoyoSt5GNqbIANzJ
	SDBaQgxXggrVHXBFVXR0rcK5Nm+CAEib1ng==
X-ME-Sender: <xms:3xZFZ5mXeR0M4wDqypGGA_aEbE7BQ89inKl2p2uWcT-cjhghXDntkg>
    <xme:3xZFZ00e-4HNZsxC61wOQ6YC3SsLOFrLsxX2TbmtwWLf0SISOS3Ud1E6uWy-hLkW2
    -na5nZ1Nz25gSwiVg>
X-ME-Received: <xmr:3xZFZ_psgaGzqHv7CZO1SyEzrljj4dHI-1WAzFSe0lNQ2B_GUYru1jkC46tPYnTuw-B_CX9Ni0Lbj2L6i48vAfl-ErhyCX_lbVUYw1Y>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehk
    rghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:3xZFZ5luX5Pveb_0xYn9FCOdzRRGfI7zukNS7ug-qnqBywWkeYHELw>
    <xmx:3xZFZ31RT1zL9xv_5m6iso2Tf1rANKOhFXp10Fq2yyYgXv4dlPq2wQ>
    <xmx:3xZFZ4ucHpckw-wlUSfYidCgspna2lHbhz2QKcEdKFzQkqTlO6SWjA>
    <xmx:3xZFZ7UabyUJy6LPLmJgP7smS-o7K00z77PH2d4NVritaWuLLmBHRg>
    <xmx:3xZFZyRrA3Hu3JbvujZFZCSPyy55MBUuM7uA6WrZ6yK8Kl_KdC_AkXyi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 19:31:26 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  karthik nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 2/9] refs/reftable: handle reloading stacks in the
 reftable backend
In-Reply-To: <20241125-pks-reftable-backend-reuse-iter-v3-2-1d7b658e3e9e@pks.im>
	(Patrick Steinhardt's message of "Mon, 25 Nov 2024 08:38:24 +0100")
References: <20241125-pks-reftable-backend-reuse-iter-v3-0-1d7b658e3e9e@pks.im>
	<20241125-pks-reftable-backend-reuse-iter-v3-2-1d7b658e3e9e@pks.im>
Date: Tue, 26 Nov 2024 09:31:25 +0900
Message-ID: <xmqqa5dm4yzm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +	 * On the other hand, reloading that stack without locking it feels
> +	 * wrong to, as the value of "HEAD" could be modified concurrently at
> +	 * any point in time.
> +	 */

"wrong to," -> "wrong too,", probably.
