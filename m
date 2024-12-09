Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB9BD19B3EE
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 23:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733788273; cv=none; b=b69NNonreTgg392pI4bvl39cbrd5jxiIrMusnUfXycrGzd+ezuEGVYoPEWJGgyQfAvs1Sdv4KazGksJOfxh5+17ucaEl0KtJSBIDMEF5+v65oIiTpvwzQvAqQFdNG6L3a4TXXOu3KM/1JHWeRUR/mS1h37DvC2vX8yp/pdc0tlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733788273; c=relaxed/simple;
	bh=4Z8cv0KSRkXkV09EBhBcvqlSLAOriLDZKlS+mgvpYFg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hmq4LYzwM85tcRnNIS2iqQXzpbhOgREtHeNpeHpxqcrBsYE+Ri+7oTIiy+lEU0XVqDu1H0xt4Ht0AKQ3b5ruyaK+6U5YX0OGrsekyKxw/GAwpfBBDkrKa4zXD3jjYee90oe+MIBi2S4EFTC+WdhyHvZjl/kIE0VD9Q9niyBxD8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V3o7JjJX; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V3o7JjJX"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id B886E1384151;
	Mon,  9 Dec 2024 18:51:10 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Mon, 09 Dec 2024 18:51:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733788270; x=1733874670; bh=nvVZlYZQn0aGogepGnDU/wd2Ocl4NjDJ4aF
	w81VgL4I=; b=V3o7JjJXVsMuiS8umFMU9InTUCAeem24lNItZMr8+2U6axDzV6i
	gZib7QR34Y6YnE7dET227ovuijVpOGq6YB4S/aO4/vpO7qvgpTd8jmMeOaAH3QUq
	bFJOUhR9zrFMme2ARtQ+j85+SCdZSq/R2hGp8cNTu5THqoY6fr3We74J4pC36pjE
	qQ1/anoCknYOtOsjkqrzb97fxr1KqJpFd4PZ3e2riigNo5b4h1hFywxtLXmz8QCi
	bW704/p9rYGk6w91YDTz9bqgPUDkyPAWFGULoUsXbwF6P6VpQOrH6vJpzOQUEzSA
	ggDoWS6AZJkc5FG9TL/kcFcz0rTr1JkDOpg==
X-ME-Sender: <xms:boJXZ_8B9TWQ4Ly4QcM52-GZX5bgh4wLQPWZzMSrpKXS0U2CTzdcag>
    <xme:boJXZ7sPJ1rJ2nSO51YBAE9SAxn_2_WPASiq27X265qNRO9H4xYrz1O0k9ovx83dh
    rjYcZ4Biv6CGXBrgg>
X-ME-Received: <xmr:boJXZ9AMiBznJetEVtHiLgAzyV-D-tnT-RyBAcurW-HcPwIhO3g0rqTLliQH9-I1b6WGwzxMkqC5DNCBTnF6WiNeDYdqL4JTy8k5vh0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeejgdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefujg
    hffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhho
    uceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevte
    etjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesph
    hosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhr
    tghpthhtohepjhhonhgrthhhrghnthgrnhhmhiesghhoohhglhgvrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnhigr
    nhhgrdhtohhnhiessgihthgvuggrnhgtvgdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:boJXZ7fAE9ZDa4NqSyR28YRc2Fx3nknEmkg76DYkV2QYKUVSWVEHHw>
    <xmx:boJXZ0M8hXymuQwD8LyKq2y0MgLo84_CWmQusw-vKtbYj1_V3F7igA>
    <xmx:boJXZ9l2ieHxHr6rII6sszEsLqlzUENqAjquFEdck-Vfiio9U7T6XA>
    <xmx:boJXZ-sh-Lh_4mGEjMrYpfoH2K6crwMCs8Y-lHmWo888fwvAgcBzjg>
    <xmx:boJXZxrj9SVUC8PfkZjac_jgva16aQ2N7X1hypAISceMQYB-pzQxpXFM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Dec 2024 18:51:10 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org,  hanyang.tony@bytedance.com
Subject: Re: [PATCH 3/3] index-pack: commit tree during outgoing link check
In-Reply-To: <20241209202935.799059-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Mon, 9 Dec 2024 12:29:35 -0800")
References: <20241209202935.799059-1-jonathantanmy@google.com>
Date: Tue, 10 Dec 2024 08:51:08 +0900
Message-ID: <xmqqseqwmn4j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Copying and pasting the diagram for reference:
>
>  C   S
>   \ /
>    O
>
> I looked into this and I don't think that making O, C, and S have the
> same tree will make this fix testable. If they all had the same tree,
> whether we check S's tree or not doesn't matter, since that tree is
> already in a promisor pack (O and its tree was previously fetched from
> the promisor remote, and thus is in a promisor pack). (We are checking
> trees in order to repack them into promisor packs if necessary.)

I see; thanks.
