Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4073D9474
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732147773; cv=none; b=slsJvnMcmsTBlSEDmr5gYFQKUO9BDZf5WEABMngRmC7e/MCR8iWWzS9PC1nOIDKdZ7yz7y8QRN3oGZdHtIzaKuWtLF8jLthoDCxdiLp6zrKmAKsR7jKdVPNTeysSGv28OeA1XtZzJRn52E51Z9Ix4G9jP54m0SpJyjeHyxjERnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732147773; c=relaxed/simple;
	bh=citXsoeMVim0vb3ENxnaeSshaTP9JkuywG/AXS02aO4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EbFK4sroWdicB8pXy/YsJfbSkw9CVerqJbHwf50G89YaYI6VEvB1/ghNhaecfWkfwxgl5RP2+O2zRSMeW0JZLoXN9UEP+Gk4ocK4J7QS2B1MqAtm1KCKujWp6IAM8EbqkF8d3w/1UXcTCmRxEHrn3HHCuHzzG878oszqduNBP4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FH2wbZRh; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FH2wbZRh"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0CE612540152;
	Wed, 20 Nov 2024 19:09:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 20 Nov 2024 19:09:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732147770; x=1732234170; bh=+95NQzXNqwxYVDw7+eyqDYTVoQnLtln7zkb
	HsCn6kvw=; b=FH2wbZRh+HDFsVpvxlsFBl9rHqqH9IjahOW316Ii7rU423D4vlu
	WqYc8SAo7y0Icgtx29XWy+Vfktx0rDVy0GHS7jaGz4RB5MPAJ6MhRjLYCRmBW9s6
	qB8I8EWRTdstqAc3QsnuHrirByMIOlR62GmY0NU6KU+s1JhUWcTnqGG3fXCnYkf+
	T3CtPICTMLFnSx4esVMlKZkuTzvlKhIRp1PAKDFq6CCheV9DvwYqFhWwx2/2VIT5
	18xDoHLEvkR7jESiD3ccLMqoPEQaWExYgpjqGtjEYna6bsrr4077izS8hULp3KRM
	LQn2iuMZi7q6jHIYaOvwleTrymj1c17p17A==
X-ME-Sender: <xms:Ono-ZwRHpiTrBHNyDJIp1d5Nh1fLvXDODhjPzEz4TKrc7TF_aB_rTg>
    <xme:Ono-Z9zwPzaEEyw9zpBo3heoDzsAvZ7BPLWKEHa4AVxTKmDUzFgaC8mQlGTEwMSHi
    V9I6NKw69NWPVtWAQ>
X-ME-Received: <xmr:Ono-Z92Nz1UMRsHkX0z4jhaY4PDVb869a2Z0-OBA9qKTc47iATLTBNyYEE6-Kf6XRtkPeXTuUzw3gpqAOvF2Zyz2mSjK2G1Q9DSW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorh
    hrrdgtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhs
    sehpkhhsrdhimhdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Ono-Z0Bhc7WWGDFUGOuDFtnZZ3xMLp0iEw1dLs_YI7fV50LYf98edw>
    <xmx:Ono-Z5isw04N3JSa4jZgyJh2KVCtT7v5GM9kCLanAsUsg3fNmpEiyg>
    <xmx:Ono-ZwqpZ8POIbYM9iuQGrC5ucROfZS8Ha0PlCsn2TKcwN7JTXRJGA>
    <xmx:Ono-Z8iG10gF51fMmPlAybIvrF4368V7EQfL23XxXPgQtu9TufUaUw>
    <xmx:Ono-ZxhqN9wTcF51BKUFQLPBDaCN5WkY9A-SkYa1icOJaxkVmVFz4WkZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 19:09:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Christian Couder <christian.couder@gmail.com>,  Karthik Nayak
 <karthik.188@gmail.com>,  git@vger.kernel.org,  ps@pks.im,
  shejialuo@gmail.com
Subject: Re: [PATCH v2 00/10] Change midx.c and midx-write.c to not use
 global variables
In-Reply-To: <Zz5hgZ1DM9XRdXqj@nand.local> (Taylor Blau's message of "Wed, 20
	Nov 2024 17:24:01 -0500")
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
	<20241119-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v2-0-e2f607174efc@gmail.com>
	<CAP8UFD08qQ2hm98dKfMNEABs19Bbs_O6T6EMLpHOofQ9=A_WpQ@mail.gmail.com>
	<Zz5hgZ1DM9XRdXqj@nand.local>
Date: Thu, 21 Nov 2024 09:09:29 +0900
Message-ID: <xmqqbjy9h2h2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

> On Wed, Nov 20, 2024 at 07:20:33PM +0100, Christian Couder wrote:
>
>> Overall I like the way it's done. I found a few improvements that
>> could be made to some commit messages though.
>
> Same here!

Thanks, all.  It seems to me that we are getting fairly close to the
goal post on this topic?

