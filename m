Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC3D10F2
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 00:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733186778; cv=none; b=cgsKk3m2Bqc+nr4Xy59RMUGnRywpaacFjwe9Vhv4j0gkryDKMHQKAB6aX0DVarj8hLGdzOlVGv8/Trj0g7VLp0BNw9vstu5jDHmUbebDcuXgviX/ZA8DmPXWNcpv0xIpHUD4xKMK+FtGTYCNs0Ef/9natJrCfQvesO0xS8QOGzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733186778; c=relaxed/simple;
	bh=AfcRAFk/5ddzdgsnua001PsWD3Z/ISf5WUfMcas8POo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UmwSc14tjSDvWhELr8zOKxWf1+SZxRIC3YX/I868kghHgf/O/GbE/0IDQKLctUNgl2n5b5eYUjo3RuPh9lkjnkwbozfkOSVDmZhgYbp6VjkjdJfIsyIEqUL2uNG0AnTdNvqnf5xx0rYVXJsJRB1LJ2RmKu6TJE/NgFGDi5F1V4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oH2qmtH6; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oH2qmtH6"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EB07A1140170;
	Mon,  2 Dec 2024 19:46:14 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 02 Dec 2024 19:46:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733186774; x=1733273174; bh=r0Q/49XydPfVQipKMeRVOSqhnDqmMZHcMQG
	716+fuXw=; b=oH2qmtH6iG2slWBzCebvkL7MQ1P+XazpaWUG7iNJkD70cYz6fUI
	VpzUd7Ln4cr4DUYT8oTb/mYfeqQNOJQm7rIkKD0CtYbB0rBHGwulLb8V/qU4tPhA
	jOQVTqjCOtmqNWgNMkffqJXMAmHXFm6X8p6tyavDiINslHmbNE5dCLiqOTijLRCO
	Z2qGZnYtuC/qX+0IY6wi7FspZzvyYRKOHsVJ1M2EDGDdjYsjDANmt7AdXDC+PT1l
	Csiaz/cagj0AYpCoW1M1f+xzp6bkw9KeYxo+ljkDXdUhchz1k4U73jryoHFu1fXH
	B/zNUxiLXceGxyn+j39ipCzFAGUN6OlD0Tw==
X-ME-Sender: <xms:1lROZ46dr6poEx0cJ9Y36ruUK2N5VZl2S0ezWQgXrWmdsPlKE-3PjA>
    <xme:1lROZ57FMR8F_KcIqflYss2ZcbBsoBMUmOMEj5V4jb21IlDynSS5DOqEamomPpYCt
    LyH6kIOw_kPYyK7CQ>
X-ME-Received: <xmr:1lROZ3dwxShdgZ1XpSSkcogPOBrnv7zcLWu0h35x5lFgy-rurbRDY8Pi1dqeCgf9ocGwAg3GssRD6Yfwt8WlM2L787RKe8dHOQFsJDA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedtgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshhgvjhhirghluhhose
    hgmhgrihhlrdgtohhmpdhrtghpthhtoheptggufihhihhtvgefsehpmhdrmhgvpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1lROZ9I4s-NoW4yUKGl5jlYroBV7k9aa3lUtsaJBhMs5yWtN1WTquA>
    <xmx:1lROZ8KhN7JTIqczA280bM67cZ8Y2OMsFjlJ6g3gi-0uAqvDyD9w2Q>
    <xmx:1lROZ-zHwri3qzLyQjK6AL6M2LhbqcnLM8rxLEYWoVDPkNGttYcbxQ>
    <xmx:1lROZwK5uhLkcLJa9t9CjsshzPTLY6YrrWlMV404Es6BHQyt6pZ6ng>
    <xmx:1lROZxGmNbN5Mzmc7xrIaSFq2B4jMZr7nS4nbBTvCB4yJvoZ9jwlC9oI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Dec 2024 19:46:14 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: Caleb White <cdwhite3@pm.me>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
In-Reply-To: <Z02eKA8i51QyXgJ-@ArchLinux> (shejialuo@gmail.com's message of
	"Mon, 2 Dec 2024 19:46:48 +0800")
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
	<xmqqed2qkfn0.fsf@gitster.g> <Z02eKA8i51QyXgJ-@ArchLinux>
Date: Tue, 03 Dec 2024 09:46:12 +0900
Message-ID: <xmqqed2pioff.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

shejialuo <shejialuo@gmail.com> writes:

> But cross-ref operations between worktrees must explicitly specify the
> worktree id, so I am wondering whether we should allow the user do
> cross-ref operations in the first place:
>
>   1. main worktree symref points to linked worktree ref.
>   2. A linked worktree ref points to another linked worktree ref.

What is a cross-ref operation?  A worktree is either the primary
working tree for a (non-bare) repository, or something added with
"git add worktree" (i.e. whose .git is not the repository but a
link file into the real repository).  Are you adding another mode
where a worktree points at another worktree and not the repository?
