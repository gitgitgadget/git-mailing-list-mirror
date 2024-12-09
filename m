Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB11320B
	for <git@vger.kernel.org>; Mon,  9 Dec 2024 01:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733707247; cv=none; b=QHGQbmyqbVjv0bZECHtQTiLvJ6o/jFxdXBCNiXgHbSGQmldrZktOBsL/hH5iXGn3ssEXng06kcBeBcLL3Z3i9aFEm56nlwxz85ETUbUXZaswfBl628hybH1nzml2N26O5LSa9YLDIzrx/SocTO4IwjjJzgayNLVamsNEiytJrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733707247; c=relaxed/simple;
	bh=iRVO0iBmsMo9qnGOvH65mhxQasVPjlPsx1qFzJqLxEI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H9qq/7i4NWi9GtPzxo9xiFR96cvQmsWensd5yJO6s/Jh5KK3hNLPyEDYUuaCBusvFNV3gdCPMEeKoiYfi8UnPv8SGWF5NlG9Lk+9Ml1bfed2sj85rKSg42VI0ZkVfHNtwoqrJCZhvN8zn4iq5QsrpqRtdss2cWlR2wcHzqBST9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F4zwrkI9; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F4zwrkI9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A321A1140132;
	Sun,  8 Dec 2024 20:20:43 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sun, 08 Dec 2024 20:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733707243; x=1733793643; bh=I9KRE581lXXWestenYBj0gj48Vy9GjsJ2tN
	TfsumLpo=; b=F4zwrkI90JMyrLW4SWXOxedLPpG29k87K7c1vICtydNVJQxlb+Z
	SnUNQsXDoWuRXAyl2OiQ0l9Orj81o1JUZBA7fVATPzUtfzMb5OUNdmIZ358saSdG
	epRKYPIjLMSwQfIaETkWKnRHjrH0ybOel+BgNJcMGFBpMcvk+LifAsk73uyTCRwV
	uXtj72q6amA5jHBuohvnfqnNwLKzZw7teXQTQBuGrQXouBvsZKRrB5eJSkBa8AiL
	3cN4EousyTMPXy7iq0VBg+/cfQDf0nuVzYUKpBmD9/jvqAfoNQOPEoADaoLytNA3
	TAQ6ImayeO71GsiqA4b3scPehZ/09b7A67A==
X-ME-Sender: <xms:6kVWZwzlhA7shhB7sE-2SO9oIb5vs38sbs-vfP8mFCVZgsYsDnSD0w>
    <xme:6kVWZ0RqZGv49MiXOvuGvLrJPgL0evda6p-u5DimvOwc96Ja6NXE6EmULJUgtRnXG
    5noLMjso8dH2QDklQ>
X-ME-Received: <xmr:6kVWZyWvStcaKh1POYV8QhAnsU9ldi5nT3O3-O6IPfIpb6v1F9dUINHRIVqVkPpdkSgZjiRfkoSLseAckICiks2R7zRgbzDGuO49n2M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrjeeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffieejgeefhfdt
    vdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgv
    rhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhmpdhr
    tghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopegurghvvhhiug
    esghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:6kVWZ-g8J5Wb-U0rbIA-efv4uw5w7YYC0YbG-lKdR78d8l48jR9lLg>
    <xmx:6kVWZyAjkVRxtv3WZec8SalLWo57X40Gb25xZKMOLJL1LQ5F0qT0Mg>
    <xmx:6kVWZ_JQwQlgk_pWpm7R8MpkgJfYcGZBl8RUkdbBovl9w4gLhyigWg>
    <xmx:6kVWZ5B0vsP_JI-wNQZBNStGFG54mnLkGOtTqZI6_5qYhARy4RqVGQ>
    <xmx:60VWZ-64MKhxAlkgAaOUUcnsvWsffo6qIawWrXU5xSnOjnIyOusS64pH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 8 Dec 2024 20:20:42 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Ramsay Jones <ramsay@ramsayjones.plus.com>,
  Taylor Blau <me@ttaylorr.com>,  David Aguilar <davvid@gmail.com>,  Jeff
 King <peff@peff.net>,  Johannes Sixt <j6t@kdbg.org>,  Christian Couder
 <chriscool@tuxfamily.org>
Subject: Re: [PATCH v11 25/26] meson: fix conflicts with in-flight topics
In-Reply-To: <xmqqikruswtd.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	08 Dec 2024 12:00:46 +0900")
References: <20241206-pks-meson-v11-0-525ed4792b88@pks.im>
	<20241206-pks-meson-v11-25-525ed4792b88@pks.im>
	<xmqqikruswtd.fsf@gitster.g>
Date: Mon, 09 Dec 2024 10:20:40 +0900
Message-ID: <xmqq34ixr6s7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> I've split this commit out into a separate fixup-style commit such that
>> it is possible to test this topic both with and without "seen" merged
>> into it. You can simply revert this commit to test without "seen".
>
> Now I had to reconstruct these "fixup-style" commits and they appear
> under ref/merge-fix/ hierarchy in my broken-out repository published
> at https://github.com/gitster/git.git/ (and no other fallback URLs;
> it might make sense to have another repository for redundancy, but
> it is an unrelated tangent).  In addition to these listed four, a
> newly added ds/backfill also needs refs/merge-fix/ds/backfill to
> adjust.

I now have merge-fix changes for the topics that add new sources and
test scripts that are not covered by [01-24/26] of this series, and
dropped [26/26] (the reversion of [25/26]).  The [25/26], adjustment
for topics in flight in 'seen', is still at the tip of ps/build but
the merge of ps/build into 'seen' is now a no-op, which is a good
sign, as these merge-fix changes for each topic are designed to make
resulting merge of each of these topics successfully work with the
meson build infrastructure, and ps/build~1 [01-24/26] is merged a
lot earlier on the master..seen chain in preparation for merging
them to 'next'.

The next step for me is to see if we want v12 of the series, and if
not, merge [01-24/26] down to 'next'.

Thanks.
