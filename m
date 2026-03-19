Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A7B2DFA5B
	for <git@vger.kernel.org>; Thu, 19 Mar 2026 17:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773939760; cv=none; b=Jzx84cWiSka3VCqrjKnXCtNJg1MODyIV2AALwuzoERGwePLD9SgQxYNnfOLf1e1PSMfyH+tIXFOX14CVWHF1NXIZ2pUXxkeHbTDc2+BtvASd5t3YFEQfJkHGZ2E3k69NSEDdYkHOV0hFnlNWthoHhYZLzsTu9vckeuOOtJxoJS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773939760; c=relaxed/simple;
	bh=yMpN71OFIZ7+X9H99KwEAqyNzMmOEJCdSwbNfHWJ4JA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bpk1W3DSXHrdqNkvluVUcxdigKVa8VwFYHDeuHF18Ft1gXfQ5IssajEbDrtcZnZmtMiA5F9MmdH61FTD/Rxw4Io8cqak63oYONkV/0l9MwQL/qvgPSfjP0GZ/cmQ9R0idefhXwmK2I9deParl3RgYt8kVaDKUuqTfOhnzaC/INw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kbJ9l3co; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i25zhjpr; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kbJ9l3co";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i25zhjpr"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4CEEA7A0164;
	Thu, 19 Mar 2026 13:02:38 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 19 Mar 2026 13:02:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773939758; x=1774026158; bh=0v4oVNUOnq
	B0sc9/+URzCNhjznyDLS7mLwz8KQv9vAA=; b=kbJ9l3co7FcgEExlA9C2RCfa/N
	A73R69hf/Y22gvHNQNuvpLBjmiSbYAQCS8zWlfB9m2h0J8bdx7ZIeGcumzXyfBvh
	AMdWNDD1WbFSiIi4IQYfFAd6WDG8d1+qtRQ0WUZsuvObmOKtmjyX/L4/HMj1YFzi
	rTT947DdIAhVPejzXc2bxRdQ96bHSbsM5TIA/fuFpS/pqxokrcH7pTlb/uQxWsgX
	s6oifcKMCBIDlz7K8zSWWQnQZbbZpFRX8jPav4LBciIt7DGLtV/7Y9qXULrALGa9
	C6iwc+gZCZNPxIjNIudQfSfVE++QvgetclgzLaEHXIsW11v4LMI2tuW6oDWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773939758; x=1774026158; bh=0v4oVNUOnqB0sc9/+URzCNhjznyDLS7mLwz
	8KQv9vAA=; b=i25zhjprbAvV6N4ZOMwWHc4oXDSMTgohU72dANTRHrKSaB8cuPn
	pTyERjrHVKVh3DBBzZY1L+9myvliHhCtfNJf9yxg7yowWjC/Pv6V7TEhlMvcNL9o
	ahvkDY3x7ZcwzB/hLEOO5pcUV/0Z+Z16pnai/SrranSUFjUDhG9UQATmcXqtc0R4
	hFgHU+Z5JIXTlMZZEWoOz+Lcax0Cs9M0ffJLnrQnbDeliHb8QBmTfHm86C3r0u2x
	Xe9HW7MnxiFI+Jaoworg2apDibzmDoSO2034U3uvqLJPIeBqVc+llqJGFdycmNiV
	CKY5XWfGnVaetEH5L3u7Z7kJr3kp6PVh9yA==
X-ME-Sender: <xms:LSy8aT0MwKxd83uamFF_vYESvS7UiuuGtUJa8_SYcQie_i6fgijH-w>
    <xme:LSy8aUUIzkVJKkpFHQyF-E2xnxaXwdjMHSQsgev_LTfa02E54bscP6LsbyX1GK8Ux
    I9Z-rgAT7hDSXmw7DKBUzHVKRVI_P97tsMCAY5Yvf9WsNE4P3bsEw>
X-ME-Received: <xmr:LSy8aWJfBzVx3jbd_6fUF1YLikEoWeZfRdHBUXFl84wIuXN00jGeqkX_0wQy9zdC2jnsb3UfXWpBfWi6mMvRFHl6_C1C_hfHkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdejheeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepuhhsmhgrnhgrkhhinhihvghmihdvtddvsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdr
    fihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:LSy8ae0W3axsr6H9oUcKZmE40Plw8p2dMl47G2i0LQTxFQPb_6bPhQ>
    <xmx:LSy8aU6F7Cy2Kjyrj8WDsSAu2CTHoBSP-g2QtZIOXzBPJS6lRL_2Ow>
    <xmx:LSy8af81rnoFqp9VInSMwzBaNb-_zZi3IwFxYoTqt-_6pVJCkzXuqg>
    <xmx:LSy8aTVznh2R4nf4maAAumHTdoneYRp9BIMNmXU5L9m5JkBhmczRxQ>
    <xmx:Liy8aR82ClEidixKa00dZfmI7bfc7sqSebuGBO_KMRU-n3nc7T4nd6mo>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 13:02:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,  me@ttaylorr.com,
  phillip.wood123@gmail.com,  ps@pks.im
Subject: Re: [RFC PATCH v2 2/2] push: support pushing to a remote group
In-Reply-To: <20260318204028.1010487-3-usmanakinyemi202@gmail.com> (Usman
	Akinyemi's message of "Thu, 19 Mar 2026 02:10:28 +0530")
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-1-usmanakinyemi202@gmail.com>
	<20260318204028.1010487-3-usmanakinyemi202@gmail.com>
Date: Thu, 19 Mar 2026 10:02:36 -0700
Message-ID: <xmqqzf43lplf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Usman Akinyemi <usmanakinyemi202@gmail.com> writes:

> +	for (int i = 0; i < remote_group.nr; i++) {

remote_group.nr is of size_t, so the compiler will complain about
this comparison that stops a platform natural integer approaching
the limit from below for type and signedness mismatch, even though
it would be insane to try defining a remote group whose size would
not fit platform natural integer.  A workaround is obvious.

    "int i = 0" -> "size_t i = 0"
