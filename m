Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E9D5FEE6
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536387; cv=none; b=jZ32M3HT1g1yJtO6epwi1wPlS7aQtW3VOVRZer6IvRHmwycmZkK55tSn6XaRm0temTdtY24F2stJjXx/C6yV/g8/OsP4CWLd0JwQ5+8SEgwRQUy2bLiUVbs7vWwqNvbmXXKhUmP3hzqvskDbF7naeOeOGmq128iz55fUUMaKoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536387; c=relaxed/simple;
	bh=Oeea9T3JAcO8t5fuN+em241MW5knT7nGZ2Ho6upxht4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOVvx3cIjF+26gwQ0hXXTNmh+bWeFQ6pgfxH05dAKCKX0TNo2VcDWPWS2SpSjBE7+kxxy4feeBxhKD+hARplNRhQI5FHdi9GD4O8/9qrxeu2+jnps9VLuggAbkvI3fq35+8nxrLEh15fmrFDEt1ZoaLiT2xj+xTcBvbJM//WyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Loli4qqO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Oat0Qfxa; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Loli4qqO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Oat0Qfxa"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A47D2540061;
	Wed, 18 Dec 2024 10:39:44 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 18 Dec 2024 10:39:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734536384; x=1734622784; bh=jwSzGvoA+J
	8ZX8kjrNzcROY0sqWM63ZCcys95jYx2Lc=; b=Loli4qqO2HIiDTzVIBh69UTCao
	XTHTbQkkXWThl5v7woi9XehCefOhtERRod4gFqS1w+qHaC0DaSpglx3U7e0/bL4K
	x8FDm0ye65pJ67DuLQmy5afYaqgdrqKsb8u4SJgr2NJ6sgWVbTZ6XWY8IJGTFEgf
	1UcGgGHR2QZOZJKqrwZQbdcOQrB7IYJEG/W3+MAI3uWPiqgCvE0n3mwvK1JXB0Cc
	VgZo7wu312010bxKy3fhqqaQfYtvdTWZqmC0g38btmdymsSfp42N5G2ffj/yBVGA
	dc9bAHTBBIlW7M4a40C/WEaB582b05deRLXK4MDQOai2IHkoAyuCrjDujs8g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734536384; x=1734622784; bh=jwSzGvoA+J8ZX8kjrNzcROY0sqWM63ZCcys
	95jYx2Lc=; b=Oat0QfxaqNlwjYgZdIvMFgiDhlE3k/PypsgUleor2zQjtW9lhwo
	xiTwBAe6Ky5MmAqW0E4cAINKMjxywBUC/ED9CKIOxNWhys22hhUpPB4nOABpgIzl
	t9JuksFBU4om0lc/BPToj0bO9v1Xfdf4/jIqX2LxmcBFMIbt2RKSvL9Y8Zq/abOW
	T3lM4eJNmU753tIUhG4R//dLUepXxW3BBySyhkMLwEZnVkDtBfeSw1V6qm3Q3jtX
	ZrZ26dyKnzre2XwALDzgCTa/BlB9nwzWFNEMt69AHB3qKEdc7o6mBSzFcooV9LU1
	1yIfy+uwOPUNwOs/lh+OtPCI2zUSOPYK2tQ==
X-ME-Sender: <xms:v-xiZ-8PB9fS9UHRmnBfPmLefjfzYwgVRYAD5KyaI7ioAh27E8ycpg>
    <xme:v-xiZ-uenCB0EKLgbxGwW0hU2sQoDecFl281rXWouT_RLBwDyPnpq4XaGR_15gOr8
    U5VcsAFvy7ejNw9nA>
X-ME-Received: <xmr:v-xiZ0Ake9tn6QEMiMQozmdqaWG01t1-Q3SmpPxAi-0V6NPbf-XPtcopfuabqrTOSzmhPbuPMTMrVF1Se3_jrKCMW7P1i1L_p5tMZyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleekgdejkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggugh
    gvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithesjhgvfhhfhhhoshhtvghtlhgvrhdrtghomhdprh
    gtphhtthhopegrvhgrrhgrsgesghhmrghilhdrtghomhdprhgtphhtthhopegsrghgrghs
    ughothhmvgesghhmrghilhdrtghomhdprhgtphhtthhopehgfhhunhhnihdvfeegsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepughorhgvmhihlhhovhgvrhduvdefsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:wOxiZ2db40Wcm7r6fTfC9WLiOTgV8HWJr8ZSf6Ky5eDsonc-xOYHlA>
    <xmx:wOxiZzM5JNdQcOAp-C9uXOse98z-vETrnfHGQxhQqrxa66QXVkujTQ>
    <xmx:wOxiZwnJupvo-bj71bbALMU7urQFe5HJzALjmnXoNYOrDRr0uQoj7A>
    <xmx:wOxiZ1tAD7QhTARxHw74Oq64JZNib-8zwH1BIaSb8aI6oLYIo7NsLQ>
    <xmx:wOxiZ8icO1XFPUOPh_qRnuXezPEurOtDQE4bp2QznDuEnSg0w1dY2i2P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 10:39:43 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "AreaZR via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "Jeff Hostetler [ ]" <git@jeffhostetler.com>,
  =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason_=5B_=5D?=
 <avarab@gmail.com>,  "Bagas Sanjaya [ ]"
 <bagasdotme@gmail.com>,  AreaZR <gfunni234@gmail.com>,  Seija Kijin
 <doremylover123@gmail.com>
Subject: Re: [PATCH v10] git: use calloc instead of malloc + memset where
 possible
In-Reply-To: <pull.1390.v10.git.git.1734485187081.gitgitgadget@gmail.com>
	(AreaZR via GitGitGadget's message of "Wed, 18 Dec 2024 01:26:26
	+0000")
References: <pull.1390.v9.git.git.1734483511642.gitgitgadget@gmail.com>
	<pull.1390.v10.git.git.1734485187081.gitgitgadget@gmail.com>
Date: Wed, 18 Dec 2024 07:39:42 -0800
Message-ID: <xmqqr065t2yp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"AreaZR via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Seija Kijin <doremylover123@gmail.com>
>
> Avoid calling malloc + memset by calling calloc.
>
> Signed-off-by: Seija <doremylover123@gmail.com>

Name mismatch.

>  remote.c    |  4 ++--
>  submodule.c | 10 +++++-----
>  2 files changed, 7 insertions(+), 7 deletions(-)

I somehow hoped to see that this shrinks the line count, as you are
essentially replacing two calls (malloc + memset) with one, but that
is not what is happening, which is a bit disapointing.

But this is a strict improvement, I guess.  The reader needs to be
familiar with the CALLOC_ARRAY() macro to understand it, which may
make the code less newbie-friendly (as opposed to malloc+memset any
reasonably competent C programmer would understand without any prior
knowledge of the conventions used by this project).

