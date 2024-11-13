Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E573B18E02E
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 23:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731542193; cv=none; b=AkUL0k+EaMrCAbyGargM4tGT4mSKqqLSPsvUvLRKiJuo5EsVvFtbOn8ykDyFjAoYVzhaGOx11PKtHClGGmqpYcf4OQi9jz6Hu9EyZAPM+bz1dfu41Ry5FTFv0vePz3E+Ddk3B4nh2e61wAV049JCLH5YSWtu67YgqHUIy7U1A24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731542193; c=relaxed/simple;
	bh=pqeRIt3YwmKrLltsgV8G1wXAPpsEwNGAWc+P7kI9pvw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VBG1fQqPx4V4N9LvShGkca80YxEPV2WOypqtykZx6G4MF5lf8PxCjYZ6ttkgRlCEKVgSaS56R97avRR/2Jxjmz0L33xNKQ9j5WBK9mju0e4ZiIHJrH6oGp0DasYSwnvvrzO8G8eHBDjhaHAs88gQqszCjs5pfNqxDSSHey8QVzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NoHgEPSi; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NoHgEPSi"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 091C411401D4;
	Wed, 13 Nov 2024 18:56:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 13 Nov 2024 18:56:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731542190; x=1731628590; bh=iBfB0bhcp0BVPgrl98F21bXPRoQ+3wbC90D
	K1eDdVXM=; b=NoHgEPSidQPBV0XQD12ucm+s+gVh0yp6MI9Vpfk0lhw88CobGIr
	h6ncpa+VmLLq+vSRS71J4X3Nyi+dwqms7BZcnVNpZKr7Oj/WXUtHX08UzPhSt2aq
	ls0Y2KhnMMxd0PxqHcQmNCFN4vc+NYeq9o17BdNkqDxNkAwlJ5hCPl+h+Ngw4OF2
	t2qfrqtbts/zGw3XCFR9MHXGbDRt1oPoItaZw2c/F36hpGD1W+p0AXKl5+15dvtD
	Y6m4dHH/p0NLeIJxKkItLLK6MWGQHtFHgNFxMMieT1wJh2sVcz8gXKMnNfOEUQXu
	UinxifVqUQbur8lgp1bxKYQDlC+1J+Pmx4g==
X-ME-Sender: <xms:rjw1ZzuMs8nGvYAdg405ePUOVPfrJ6dI-FylTq7POvyUsFG8wzmo5Q>
    <xme:rjw1Z0fTyel64OycBkBBW0sYVkTo1_R4s-GiN8bC0GXIEBkb1CB0WkTEiHvjknuI-
    1k7vC_ydMRYcj9MvQ>
X-ME-Received: <xmr:rjw1Z2wXlS0Nu6_oRr77KvMq9-5-3GZx0TNI0AsaK0iVOiWb7l3QhZAF9tN-xIWp1bfJh_V5i3bCIGWQZKTI744Of1YHbzCrk069>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvddugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrdduke
    eksehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rjw1ZyNt-d_Iz4whjruCTU9BhocNlFX7yyG5PR5EJxPLzc1J41s-hQ>
    <xmx:rjw1Zz-uyKfzsACCGrgfMDo-LOsQKIyxHLoPPSHE08W0CaYg7A9Bgg>
    <xmx:rjw1ZyVn-YG_C8Vm3RK3J41CuSQ-wP1U2sTqtUYvMKFTBvuvQn4ksQ>
    <xmx:rjw1Z0e6lQhqBTscG1eemMm0_R0sOG5HqWGh4vCQAHPidwY-fHIvSA>
    <xmx:rjw1Zzx22PNKsCpmw0ekIqRwXE_m1CyJoriBSgyCrG2SsTARRb-3SalD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 Nov 2024 18:56:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: Toon Claes <toon@iotcl.com>,  git@vger.kernel.org,  me@ttaylorr.com,
  peff@peff.net
Subject: Re: [PATCH v7 1/9] packfile: add repository to struct `packed_git`
In-Reply-To: <CAOLa=ZTmmpqC7xDLMop=O1_gV+wj9P+dGqT18W7doo09XW3hwA@mail.gmail.com>
	(karthik nayak's message of "Wed, 13 Nov 2024 05:04:03 -0800")
References: <cover.1731323350.git.karthik.188@gmail.com>
	<6c00e25c86b495c75182ee5dfc9e82ca659f5aaf.1731323350.git.karthik.188@gmail.com>
	<87ttcbi9w1.fsf@iotcl.com>
	<CAOLa=ZTmmpqC7xDLMop=O1_gV+wj9P+dGqT18W7doo09XW3hwA@mail.gmail.com>
Date: Thu, 14 Nov 2024 08:56:28 +0900
Message-ID: <xmqqh68a8z83.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

karthik nayak <karthik.188@gmail.com> writes:

> Indeed. I'll add it in locally but will avoid a re-roll just for the
> typo.

FWIW, I'd _strongly_ prefer people *not* phrase it that way.

It is very much sensible to refrain sending an another reroll
immediately only to correct a small typo.  IOW, "avoid a" -> "avoid
an immediate" would be very much appreciated.

But in the end, the final version should not waste all the work that
went into reviewing the series.

Thanks.
