Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF7C28EA
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 00:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733702980; cv=none; b=Zz859GhVQTkwZaPYOPKHDLZzH2Ixj7HpsGROzQi4zPKHTesZ8r1gZBjFNrn0Te50MYxomL1v+bBvlLBDhSdSpom6EdPuZNimoi12R3413VSRYam4OkF2ObsG1TbK+Kudk+aMiyibS6qTTKxGp0ym4maR9qiVRMcMx9BDM31eQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733702980; c=relaxed/simple;
	bh=mzYHllVv7xLGTgRjIj0psb4qXVjjIXkXxz+s4+q+fPo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qcATNCmQFdblWf0aq7+8DC3hhuNlHmJRJ1hu2HBx0Gu6WmBaDQ+4xFZ4Dc7iNsjyXzsdx7NnLUxKf7RBBvXqJG/IB5UfHcHjCOIjI/aIKqE+bNF+Z/ZQcU0B0NLvt6YQm5xSvrxMcXLW6/RzQxNOzkB4HqZBmx8WmqIy5boYMqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GEtIqrZz; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GEtIqrZz"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 55C7511400D2;
	Sun,  8 Dec 2024 19:09:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Sun, 08 Dec 2024 19:09:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733702977; x=1733789377; bh=NpIeH1+wl+E1sSRDclf8F/RRgJzEkBYSvPf
	NmXmQn4E=; b=GEtIqrZzlEDY/aGd7AtPThbKyDxoJYvFVDffCCJnkXsVkp4K2tp
	3uWMJEGvu5L2VZcwAgtGQxqCfAPKtP/CZKWyyJCAJ1Q1CeY51f6c8GstB8X4rddC
	DI8rQTYHjN8Rm/RVzExjS6mknqkrLXuhZfXwQHO+G6h29PLwM2yPFV1X+efU9k7I
	633Eew+pOujk5zpojP2yFvZ+oTpA9LGneCp1lL6I3uPgp/O8F/AzHTZAit8c78Vt
	X9/kDivyV1i5+SZ41vF2p4/SzB86BUhYY1h9yX5u/1eFh46C1npnxxHpd+TEEe8S
	L11teiYi1D/ZcBxn2R6yqW/kox6k7zeriJQ==
X-ME-Sender: <xms:QDVWZ42nfYvmj7D5sKVPXKOzIiqzNx_QTbpENlU1xFVFV8JIgTU8OA>
    <xme:QDVWZzEh-0xaF0lGwHj5vBc8Su7m5RY-UoJPs8Ma-RSFXXR_DFixMvi-FYN8fJ6Xk
    S7v7Yk8y1kaB7YLNg>
X-ME-Received: <xmr:QDVWZw6AS3XHv-YV9wkA28ZCNam0pfyZcG_rdFTXxVK97NEyvejxLgqjspvM5Oef0nGJk60qrNAKMJLsfdAbxz92Bcm_7XLKbjPh_9I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggddulecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QDVWZx2G_TuHe1on30BK0a9FZMTPlE9_7jUyTrCtcy7qRM6gwgT94g>
    <xmx:QTVWZ7Hsb1aM1biXBiVe8h9ywqP3XXib854NdlixaJNWBfOKcT3jjw>
    <xmx:QTVWZ69pYY4zqjeyV0-3kW48NxvsjEQ2clE8G5KB1hEJ5KOJtTLv7Q>
    <xmx:QTVWZwnLXsZEkVFtBwhl-2J2PiYHJQEBIMcRKYOuNsFdBWD8QuiEtQ>
    <xmx:QTVWZ8OsbSBtntnYG4ZDqUVL6qm5u_fpaHOsqwQru__u4n5M6lNslaBb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 19:09:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  shejialuo
 <shejialuo@gmail.com>
Subject: Re: [PATCH v4 08/16] pkt-line: fix -Wsign-compare warning on 32 bit
 platform
In-Reply-To: <20241208195703.GA1231962@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 8 Dec 2024 14:57:03 -0500")
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
	<20241206-pks-sign-compare-v4-8-0344c6dfb219@pks.im>
	<20241208195703.GA1231962@coredump.intra.peff.net>
Date: Mon, 09 Dec 2024 09:09:35 +0900
Message-ID: <xmqqttbdra2o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> ... Whenever I think "but no callers
> do X", I always try to double-check: "might new callers want to do X"?
> And in this case, I think the answer is "no".

A very good piece of advice for those who are watching from
sidelines.  I agree that a return value that tries to tell more than
"yup, I read everything as instructed" would not help in this case.

> They are asking to read a
> whole packet, and it is an error if we don't come up with whole thing.
> Showing the partial garbage we did get is unlikely outside of debug
> tracing (and in that case we'd probably put the tracing inside this
> function anyway).
>
>>  pkt-line.c | 20 +++++++++++---------
>>  1 file changed, 11 insertions(+), 9 deletions(-)
>
> The patch itself looks good.
>
> -Peff
