Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813DA1C7B82
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 22:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732143331; cv=none; b=NeFsuAx5E8nyzE8QcO0SRSLJSKj037+S1mHNYwd946ogpC0M63DS3rGZvauNDsIK6KT48RSV+O4heVug3NStQ7bdGfnDgfdWU7ixc5Paisjo4sr5JDm1HtAXC6xYBTyn5MY9tZ1YfiMoklNvtRoESLHHSPoX/5X0szj+Uj08Auc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732143331; c=relaxed/simple;
	bh=OiNNcN+fup3JprVP6K6wVOIE2xqC6YgNinOfsda5J6k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VM8jH7i+q5t4EiI7NREH6YsJxeIDL5GpI+Z8fdgmEhVEuvtVMB+qaL6zFay/Uf0aQZ6ZBosFwSN7PcT7/lRnekE+LlT3RTrZkY0wV93sJw3qIRegWBPFAfdZ2AUm+9AuMIxJYnuJwik7nRRYIKC9lB1h6/EFPWZdNpVjkqEsXRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hWkRdeFh; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hWkRdeFh"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9565D254015F;
	Wed, 20 Nov 2024 17:55:26 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 20 Nov 2024 17:55:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732143326; x=1732229726; bh=iDiDpxV53CS4dF9qUUjsqw4vHCQ4Elr4yeJ
	E6Y85kT4=; b=hWkRdeFh+oxsTFa0pNlIpafXXJCO4Ba0Dy+C49j8F2mSg+BjMSd
	kDZjbIC1p3sqC/53raHW9d32eRUDGtjzzd/R4/f5jxxy2cWJbZCQAdEbBAcScV3g
	yX6bTT4WxsbL+VSZoXzUJdMAjDahoTpzFDVzj3mj6eu2vB0P6rp9gspdb8Q2eAEC
	oIlvlebxwXstcuvvRu2ugdCgrEwRjBgoGOudF0P6b12wKMGooa/CUmXObb5pS+Bm
	6El/IzVUbZIWG0oeBs0dhsnuE4y0Q95nA3W6kJFPLRwW5OQx5QmAKwiq3T/Mp6sc
	tPP32w8ykVndShbmPnoEpGHKOcC9nIZaiRQ==
X-ME-Sender: <xms:3mg-Z69vAmoc4epRyBnwAgOdgRXA3aQLadz3nc6R_7ekTDSaabNc6g>
    <xme:3mg-Z6vjqlIo7KCMUclYTXpWz66pEqWd4uY5ji313E-_ZpM1193jh2-w3KLhZJNlz
    kc1BG-Vttle93bH8g>
X-ME-Received: <xmr:3mg-ZwDqUt4F5ut5SOMxV8P9rFwqNozEUzTjP7J86lCbPn2lKaQ2U-ASNpHGvaJUvuOG55Wv0D4Iu5tJRxLkdFOR8JgnoXDnMa7Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedv
    udegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhnrghthhgrnhhtrg
    hnmhihsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsuhhrkhgvrdhlihgssggvhies
    shhhohhpihhfhidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:3mg-ZycObSSTRSW4F9c_bq9zJzmQsHIxbHY3jKP5J-yiqhMs55Nzow>
    <xmx:3mg-Z_PUXZdLlRjv77hZeg8qFOQfAn65rE9Zq-IiwwH7qayQdfrPRQ>
    <xmx:3mg-Z8mZMEsq-S_AOT37lYKpGxYtUF-GZU8xQSiySPvpEGAQdolMgw>
    <xmx:3mg-ZxuixTNc7YKurkgtP04GdwL3JMaW1f93i35M9pClgT6QnYDuQQ>
    <xmx:3mg-Z0o5AfSkiPsZk7i2zNGxZZGw9m9K9og4Xe4Y9zArXTS9j92k0iEX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 17:55:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: Burke Libbey <burke.libbey@shopify.com>,  git@vger.kernel.org
Subject: Re: git-blame extremely slow in partial clones due to serial object
 fetching
In-Reply-To: <20241120185228.3204236-1-jonathantanmy@google.com> (Jonathan
	Tan's message of "Wed, 20 Nov 2024 10:52:28 -0800")
References: <20241120185228.3204236-1-jonathantanmy@google.com>
Date: Thu, 21 Nov 2024 07:55:24 +0900
Message-ID: <xmqqikshikgz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jonathan Tan <jonathantanmy@google.com> writes:

> Technically, we do need the contents, ...
> There are other ways:
>
>  - If we can teach the client to collect object IDs for prefetching,
>    perhaps it would be just as easy to teach the server. We could
>    instead make filter-by-path an acceptable argument to pass to "fetch
>    --filter", then teach the lazy fetch to use that argument. This also
>    opens the door to future performance improvements - since the server
>    has all the objects, it can give us precisely the objects that we
>    need, and not just give us a quantity of objects based on a heuristic
>    (so the client does not need to say "give me 10, and if I need more,
>    I'll ask you again", but can say "give me all I need to complete
>    the blame). This, however, relies on server implementers to implement
>    and turn on such a feature.

This is an interesting half-way point, but I have a suspicion that
in order for the server side to give you all you need, the server
side has to do something close to computing the full blame.  Start
from a child commit plus the entire file as input, find blocks of
text in that entire file that are different in its parent (these are
the lines that are "blamed" to the child commit), pass control to
the same algorithm but using the parent commit plus the remainder of
the file (excluding the lines of text that have already "blamed") as
the input, rinse and repeat, until the "remainder of the file"
shrinks to empty.  When everything is "blamed", you know you can
stop.

So, a server that can give you something better than a heuristic
would have spent enough cycles to know the final result of "blame"
by the time it knows where it should/can stop, wouldn't it?

>  - We could also teach the server to "blame" a file for us and then
>    teach the client to stitch together the server's result with the
>    local findings, but this is more complicated.

Your local lazy repository, if you have anything you have to "stitch
together", would have your locally modified contents, and for you to
be able to make such modifications, it would also have at least the
blobs from HEAD, which you based your modifications on.  So you
should be able to locally run "git blame @{u}.." to find lines that
your locally modified contents are to be blamed, ask the other side
to give you a blame for @{u}, and overlay the former on top of the
latter.  
