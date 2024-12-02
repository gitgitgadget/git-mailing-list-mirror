Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E18F9E6
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 02:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733104856; cv=none; b=ekCVlyjPCwpUrGINK88yvMFvUJ51RSeur/AgYfXrcHp7o4IQIT+lWPoxsCKUXzGCzUNH6hUJg+Tn1hmE2k+50V9yZTpJzpZBIyqtEOjEe52G4q02vXEevTVgChEpk8TPjj+5SdiUe/img9WknrWE/F8AIUD7QWUYwFo8/76QTrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733104856; c=relaxed/simple;
	bh=cFLmFdoUrAkTLoC/W2yBVK36oRDDFgcljFTXgSSwpmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mGt3hqI1teX7MCi4uCnMicufvixpKlENAUnt7eXRZJSW+sFrKHw/wYTRN0vE7wvBNA1npPJltAm0OP6sSR5muSwFX/uspMy5eYyL3HYcO+aGEGmw9BstSHokkaq7sM1Ba41R/Utdmq8WedAa8MW1UMn5Yd1PK6LrJiHLcvf1i/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IBS+SFzK; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IBS+SFzK"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 25D361140107;
	Sun,  1 Dec 2024 21:00:53 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Sun, 01 Dec 2024 21:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733104853; x=1733191253; bh=3PWHQHQGE0vTznCutOp+gMMlJKUoSHpo1RB
	onR2jxtI=; b=IBS+SFzK0DmQurVR6YBTlP5eTlqOYPQIupnXUjLOFBCBXkW04E9
	uBVOaXTi6CNSGA/u5+ErrCnvP+Hg1auy/C0dhspItcUP3+f1OfKKKhfIQP2078lq
	pYykhNAv/FvIKPUZ7kNB9OLjptAHByeCkLCPoBHyp3pvriIaVhHhOZDpFErIaLPT
	RADKoMrAuedOR9HMlupc7L98Yd6HUoM45jrqsF19Ylx8g1fliOlAmV9f3zZJ95ks
	E1fnk1afF8IG3Oi1yt0hB08dwtsSFjKJj+v8YAcHqyGU1LwBuaBAUueMMmyzK37r
	1e8+nUnJi3L5ynhZcgL6H4hZymceEuiROyg==
X-ME-Sender: <xms:1BRNZ3KmLnPVZ70JuyXq4v_hmOOK4M_zZfvWoUhlpwx_lg8uL8DMxw>
    <xme:1BRNZ7JmdYk7l1pA1qr4h2qus7e29efW4jA4gYS_vz4-PmPafMGvtZ7vwkxZGhePy
    Vnz0yQMwGciYlmB_Q>
X-ME-Received: <xmr:1BRNZ_v9uAAwltOWilcyQDZNWUH-qJKnYwCG6N7znJe6HmNjz8dofMs3fnK9o2kbXQbQBKMdF-jtUbEQHAF9dgTeClBRv2tQqH2_9L8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfeesph
    hmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1BRNZwYSO5W1LIHRvsYXsXNFNtyxXeR4hcgpPX7mGTd9ed4FgDB53A>
    <xmx:1BRNZ-bUI6rchx4ULR32XWj05_JxoFZbTdxnm-O7GvEKQBDZVEnADw>
    <xmx:1BRNZ0DmdttEdfJqn-jHkSCZ62LMrcdiaZefpa1aWDu_PcP9rKfl_A>
    <xmx:1BRNZ8YaG3o91F3SePG4lNZ21j_vHYViZIq85wOt_XyaT2pOmN0-zg>
    <xmx:1BRNZ1X8rsC0V_5aMEajkPjbaQsFBTMJT170yx3UlWHFvASlI9_sD0a9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 21:00:52 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
In-Reply-To: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> (Caleb White's
	message of "Fri, 29 Nov 2024 22:37:34 +0000")
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me>
Date: Mon, 02 Dec 2024 11:00:51 +0900
Message-ID: <xmqqed2qkfn0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Caleb White <cdwhite3@pm.me> writes:

> - Add the worktree id to `worktree list` output

I have always thought that we deliberately hid the "ID" from the end
user's view because it is a mere implementation detail, and used the
filesystem path of the worktree directory instead to identify each
instance of the worktree in the end-user interaction.  It is unclear
why this change is a good idea from that point of view.

Thanks.
