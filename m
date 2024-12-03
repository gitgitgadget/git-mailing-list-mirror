Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A91207A33
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 23:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733267870; cv=none; b=Mbu59zoe5XNZ44s3TNcRqxqkYiuFUluF2f4ptnvGIlBGQy2h4rWc4vmOh9CXfaNYqSgeg2TiH9/J4Zogf1+mYGokJQVeQ4WUwQiUE7ntBi4JxRwy9p+K6yziaahNTxLvI7VAeq7LXkH9rE9qkQ7Cft8gfz8SjDs7KCz5AsnySNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733267870; c=relaxed/simple;
	bh=6UAmmO/XWqCByuUhngM1UJRiqhyhIKebenUSk+0eTpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DxdObvQh594AHmBIIFWxvGXntWiyVuoJbtaHN1wq26Ub5zad/QzzhrhZfVlBzB+6qBk7mLe74ZA6k6Xj2fYmRJyVfqpi0n9xuZ18UAQfUJ3PIztqFFkRJR7Vu5Mj2doQN/SwaLSX/qvY8ODrICKIIL/LUQHqO4sBnVi8EOchG1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CRW22k5j; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CRW22k5j"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 39D59114014F;
	Tue,  3 Dec 2024 18:17:47 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 18:17:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733267867; x=1733354267; bh=DeA/9cL5icA5t55S905r8i4HaLBAk6RaYLb
	wPZk4qlE=; b=CRW22k5j3sRQvVzgWU9EffTq6NejwSbHzDAPACLVbAmFIQoNrgW
	N0jbtkeO/4mK6z9gIHQ+Tw8GPld6gDA9JzCvPEVLzxBqUCZdo0CvJhFQOr4fYlR9
	j3hrkD28m8LfP0298E9T772/I9u/4TQxrLOBluDg4qKy7fBWIY6fH8EZdH502qR7
	qgU/hTsYfQwg4vK+NTaaYifh5Zdc0UDnnS4loQIJb1JUvf3bUweu5BAoUcY7Mb+V
	2oQhTCF1IFTXyEtppwsWiQUN1PZEZ0NLw8UG9yLT1F9hxsnf9M92GeQo2Sbl/+fr
	ZF/SbnN34IiAUgyBBbESfJQiXWG9JygbjPw==
X-ME-Sender: <xms:mpFPZ7SxiAI0QZBm38A-B9rIRz3a24ATaVjcWIBrwpWOP8N9G-NrFA>
    <xme:mpFPZ8x9wRX3jw44_GZXnrwIQcIodolGVRIVVGIK9J2R6GPots9wR9Eg72hN6rftH
    NoZpD1AVibm2Z4cDg>
X-ME-Received: <xmr:mpFPZw0w2PFoR9Au75KrwT1i1HhYJUJ1jiCpZrTsMbFWjLZSW-2u4NmkoxrGjSmH3up4fURUa22NF0dAgB59uYcK8YZ0wJgtvYdbljw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrieeggddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:mpFPZ7CPFws7eFpjwL10CA7JBus-8F9ROZGqO97Q2Z3AtSbG_WkSiw>
    <xmx:mpFPZ0gSpDb5IudXzRSb78kYEIq860lTSplNuyqGWS7x4JJhtwNhaw>
    <xmx:mpFPZ_oUj3fKDhG1BEt44yC0RMKZx3bnjcLbO05YcifoInT7NyeHuQ>
    <xmx:mpFPZ_gb2gmttJi3md2X5ia1iVQnXP_lXUJj98RNjafkSF1LD7ujaA>
    <xmx:m5FPZ8cxRiSBPWUL2c4dzqr6-zrFtQtDCFddOp7YDVF6TL03N7VZh8WR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 18:17:46 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Justin Tobler <jltobler@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
In-Reply-To: <Z08VoOHGZ1wecUx6@pks.im> (Patrick Steinhardt's message of "Tue,
	3 Dec 2024 15:28:48 +0100")
References: <20241127005707.319881-1-jltobler@gmail.com>
	<20241127233312.27710-1-jltobler@gmail.com>
	<20241127233312.27710-4-jltobler@gmail.com>
	<xmqqed2wox8n.fsf@gitster.g> <Z07QqowPVEgJ3sIw@pks.im>
	<i7tvwk462uwe3syarrnmjttgu4p7urtymq4n72kj7ziaptu7iy@vh4td5fd24ko>
	<Z08VoOHGZ1wecUx6@pks.im>
Date: Wed, 04 Dec 2024 08:17:45 +0900
Message-ID: <xmqqy10w9x0m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I think the current version of this patch series is fine as-is then. It
> might be a good idea to adapt this in a follow-up series, unless there
> is a good reason not to.

Sounds good.  We may want to tighten the rules a bit to reject
obvious misconfigurations, but that is outside the scope of this
topic.
