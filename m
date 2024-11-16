Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83EA372
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 00:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731715604; cv=none; b=sKRdrmhMR3nv2+H/AwTCWmAD+sVtwpOsv6zcn0r/8GnhQojdduD8+hxRP4yv+0iJN9wmEH6U7aF2Z7TWcUYiGHWJcdxP7hv7UGqjAyqoM8RvpQ/YKaOYEP2tTL4UYQlIUxsR7qQDFcjTxCFRUlA3eOmXWVcAzMTCorE3V7h25XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731715604; c=relaxed/simple;
	bh=/RWIM4WygK4zCJ1hnnfjhuXnf952fV4VgJG+5Eli6uk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6w8akDqu7jsERgVakwojpAozGyxc7Q/7vPpvLMs8geo70ChfNnROxTPDdIS4A1J75IYMVKXVLLRv/JrSnTPy0xWlLrpqRgRpNs1ergnokP6p1JWmBGyOjyIhPeJ7QtEKXQzANIVOvRq5RKoRLHbHRRK6HkWgwDFWZMugJ/CWKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ELfejdFB; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ELfejdFB"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C4CE92540193;
	Fri, 15 Nov 2024 19:06:40 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 15 Nov 2024 19:06:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731715600; x=
	1731802000; bh=LnTS8JKSxcJz150fJWp3goMlfPmmuOf1y4msx4OwK2M=; b=E
	LfejdFBuJL5D/U9m0AZcJdneDz6IYrzefY/Lo6QDSrJQ+b/nJDRWpT4eHlUoaW1O
	ipshlIjP6f0/Oqy/IOgJgnO/ETDerh3uAuo5N+mTKXAiTnawt2q3sTeN6k8NLcYf
	c9y8+uukJU9uT83LIUWqhuGh2vpZF78eEdJQHBf8F6VsIYfob/uH/37CLIGkfwFN
	PSawcSbkzoNH8D2xQ063YV/noc4TqkizMHlg1r3HlN/+8kSCq2Hpu1Y/FzKxGC66
	yk3rgB+H9O/z+a6rb9YyschCZLLnA7+7rujIcQzYHvTzSn1vmjyY45+7CPEdSE0h
	0N9OgU4AbBra1bHDvhEVg==
X-ME-Sender: <xms:EOI3Z03z4bUoa-8d3AIsV89ju2h3QQtbJTkCpBkeWxK9VuBS33rfJA>
    <xme:EOI3Z_HhvcqBmi0PWfP3rleEutSRqVW-9Z9Zn8z-ZaFDBqhGaZtxV2tk_-oCVwgRJ
    iW-7nJTZB_eF1hvNw>
X-ME-Received: <xmr:EOI3Z84RZCvB2XrA79DVqDL-W9ypkhCGsEkYh7psNapAgMmdUym7PdjVEATw_hC7PNzS0M_5PTsNsjML3V6PNq2jMmJ-5HMWPAYp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdehgddujecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekofdttderjeen
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepkefgtdeuvdejfffgheeufeeugefhtdejhffg
    kefhhfetieffteehleehtdfghedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhgtvgesfhgvrh
    guihhnrghnugihrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:EOI3Z90UZrRC4KJfIg7XGyWy3uyDQ-svpTM3bwP6w_Air9P4QHISIw>
    <xmx:EOI3Z3E0NaT0z3Si_nJfdoWOzNC9FRl9JYCvcFt5j3untKo2GespXQ>
    <xmx:EOI3Z292145IaayCUoX5i5ExteZfkQ6ozp4L-DgyrFh5PLNH_FooaQ>
    <xmx:EOI3Z8m4Fkkoj9KjVe-CSPsd_ZA99PWJ-Uzr69YE2VaI6ud7o6dWvA>
    <xmx:EOI3Z_CaCDHNZ_cVcKgFx5loqmQ96QZbWEyTFPjPZsWmp5FQlHiYQK-Z>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 15 Nov 2024 19:06:40 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Bence Ferdinandy" <bence@ferdinandy.com>
Cc: <git@vger.kernel.org>
Subject: Re: log --format existence of notes?
In-Reply-To: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com> (Bence Ferdinandy's
	message of "Fri, 15 Nov 2024 23:00:30 +0100")
References: <D5N39IJA0WDQ.2WH1MNIP77X2J@ferdinandy.com>
Date: Sat, 16 Nov 2024 09:06:38 +0900
Message-ID: <xmqqsersyrch.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Bence Ferdinandy" <bence@ferdinandy.com> writes:

> based on the man pages it doesn't seem possible, but maybe I'm missing something.
>
> I would like to put together a "log --format=" which is similar to --oneline,
> but where if there's a note for the commit it's marked with e.g. a notebook
> symbol. There's %N, but that prints the entire note, so it doesn't work well
> with one commit per line.

I do not think it is doable.  Unlike the format language in the
for-each-ref/branch --list family of commands, the pretty-format
language in the log family of commands lack more involved
conditional formatting features.

Unifying these two formatting languages to port features from one to
the other would be needed, I guess.  If we had a note support in the
latter,  something like

$ git branch -l --format='%(subject)%(if)%(note:amlog)%(then)📓%(end)'

may have worked.

