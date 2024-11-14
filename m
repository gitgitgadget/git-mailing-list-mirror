Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5D818E029
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 23:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731627385; cv=none; b=YERtWWXKMsHXYsGXyvqIxSuVuZWvrw2TpWBZAN6f0wgd235v+l+8RGJtIC/clM1xPQmWPqoRgB6xXQQIj5eimDsjYuHrmqYsiJza4ldgD7rNCTzIE4TQ/85wDY6rvAo3yS39wvIzfE3AdhqcQf8qLgzP7k69U21Tcu/vImqeGHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731627385; c=relaxed/simple;
	bh=VGsQZHCd53qa85R5sRi99sG2vkNtfHJzkyvvJL0/Gz4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WQLESZZYly2jwNpaw27rAnIcRNK4tlcO0TKrxTqxs+Ym21T0PFSPLCpi0SATeagXCTCyFjU6S7PtEkS5kj4/w6jtU/JX9gF74kN/D1s4WCCWzBPPuxFNuSVNbugK1EY8r/9XYFqPYp9AFU1qM80X/z9sCeJA1cPodV+sEBhQ208=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P4QA+lUr; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P4QA+lUr"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B9B161380550;
	Thu, 14 Nov 2024 18:36:22 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Thu, 14 Nov 2024 18:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731627382; x=1731713782; bh=4dy2FoAGeaSajCWSmrNiTRZsvFk8UxRBCbc
	fdhvosqM=; b=P4QA+lUrViAx78CBkk+Rbks+wvNC5LpxN2mYancfhXP6FdFH/uY
	A07ZXjc7wjdDEKCSiF6kzzpdv2foOOaFkPJxWLItRT5gJet1oIocHDEOSsgTwJyu
	Sm6+ulwR6OHKuhDPkFdak/MntFcqtCjnNPCvJ92qfGAVPEapiHV1e4AirsEIPwkn
	NQEZYv8/5UFTYYvdbAS72uHujL1fNGdHmQk41LFPqyq9DGLGinuatb45xkhk6tDM
	SW6kszO7ltFzE3Er2iG/E2dXeZE3V07DuuTv91E51elIIzyUuezxCmHvQMyp51eN
	sycIb+3cS3/55KkNy7b2iz27rYlL7rWHCCw==
X-ME-Sender: <xms:dok2Z3TXaz0E-wOkeJqXhBv7wr-sPtrQ0E1vamyzR4zFRfs967vNvA>
    <xme:dok2Z4wQY4kKbdo5pBd9kITzmY5ATqYxU0vbusruRtpt2Ipyer1OWg-QdQuhGF4T0
    -E9q3qQpOJ0R3cNpQ>
X-ME-Received: <xmr:dok2Z80rfCANmXcLy3SiKpLLeIg_1SbGgaHYhggdML3m-C0pXimlGuCaqIb47PS3mEqZaOpuDGEWhfpIoWI3xwluxEyFAOxSfStA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdefgdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeifohhrlhguhhgvlhhloh
    drnhgvthesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeiihhhihi
    houhdrjhigsegrlhhisggrsggrqdhinhgtrdgtohhmpdhrtghpthhtoheplhgrrhhrhies
    vghluggvrhdqghhoughsrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:dok2Z3BAGNCb-xbZWZ5u9VpuwnsQl9J8s4hW4ZhAUNxd3-Ktg16cqA>
    <xmx:dok2ZwjUuyeK-YInIb5z5pX7PQv0szfp3L1ViR6eTL4h_Lqpm-fCwA>
    <xmx:dok2Z7oTv5OgZVToGAv02ax_jwNHDALJJxIjR4QI3y1Ir34eeCr-eA>
    <xmx:dok2Z7gTKoK60pbJ8WU6ODTp9eLNF7gIMZ-3K60hOkygkmf8YgZ_aw>
    <xmx:dok2Z7UBDjzl5lLaugV4TjcGzZsDbj8PswG7DWAiH8beI2PryCmNorpW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 14 Nov 2024 18:36:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jiang Xin <worldhello.net@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Jiang Xin
 <zhiyou.jx@alibaba-inc.com>,  "Larry D'Anna" <larry@elder-gods.org>
Subject: Re: [PATCH 2/2] transport: don't ignore git-receive-pack(1) exit
 code on atomic push
In-Reply-To: <CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
	(Jiang Xin's message of "Thu, 14 Nov 2024 16:57:55 +0800")
References: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>
	<20241113-pks-push-atomic-respect-exit-code-v1-2-7965f01e7f4e@pks.im>
	<CANYiYbHGdJsTgdzJj1r4sPdTAcZCf3C-qA538fcXbD1jjB1BUw@mail.gmail.com>
Date: Fri, 15 Nov 2024 08:36:20 +0900
Message-ID: <xmqqsert5qx7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiang Xin <worldhello.net@gmail.com> writes:

> If we want to print "Done" in porcelain mode when there are no
> errors. (In dry run mode, ref-update-errors should not be
> considered as errors, but the opposite should be regarded as errors).

Hmph, should we allow dry-run to deliberately behave differently
from the for-real execution?  Wouldn't it discard the primary value
of dry-run, to see if it is likely that an operation will succeed
(or fail)?
