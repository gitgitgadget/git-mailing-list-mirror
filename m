Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A6923CB
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 01:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732843917; cv=none; b=jGEKkOxs3VTZ88V4Bg7d+2zRKT3OeBCzouZfFx327xx15QXWPfclpNq45I0titLejBecxPN4uPbSqU3IcDbup/C77j8lWcQQoBCEwqPynXz8YLPPXdAX9lfRF/mSDuy1suZwQYnjfEoDC81nZXMc+UILAqH1Ih/Icol3+eM7Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732843917; c=relaxed/simple;
	bh=+xGvELTJyj3V+kbElUczxwo3onf7lXghuZvsTWSvRdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WDkKBUrlLbY9gikUrFQto9BtoE38ZU3Ss05KLjrJ++2N/MODXYo9LVvHPJ/wtJCi6giRzuAP5/O3wK0fT7i7rXZliwg6lW3k/9sqbf++Pfrtxmxy9kZXEEdiTqlGPHCEvBrhuI94kmDyDLmc99e+HHHyAkaeToSAP5PbtGeRnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I/lRKNkO; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I/lRKNkO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 97EC41140154;
	Thu, 28 Nov 2024 20:31:54 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 28 Nov 2024 20:31:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732843914; x=1732930314; bh=AyQFgcJVCEjtVsgfgl1SAPp4uefwG9QQB4F
	siFF4qBQ=; b=I/lRKNkOP1Cuu3h70MoepOcKcUu07wvWOLi3wGcXEvSiiOKR1oq
	rmgpDMlys+pXkLxXRrvzh1n98BxR9cadiS7bKk+d+2A01ZLX8CJ7GpSQyWWqAqfB
	xvktUqAaxRW0dE89BspINVG/WPRQ+1JKofXa3X5+rPsAmlN+nFNOJt+iGEoZMoPU
	cwpUjLGFSzi7dReKmFDlx9TBtZw2++6RMR0GRbhgpMhnPYqh6E+Ld9hWuq9z0LCb
	TWK0LMv3euyMEU+VsDuesE//bZWCha4CRjeq0Sbj3O3RpQUu1COpLu9r1nS0ZObJ
	qu+SoLj+RZWGyiO+OLWtjDstY+Vg/x/tgWw==
X-ME-Sender: <xms:ihlJZz3NU85sLdatzAp8bcPJAS9EMYB8VmtMNxAZrXTjs-piZF25pg>
    <xme:ihlJZyFNRYbNBcQQkaYlXQ02pMswsOjjcsKl25nLOBL9LgmfaBTGB_1noH99eRtSb
    Cv2ZHvxV-Ql3m7WlA>
X-ME-Received: <xmr:ihlJZz7VmR4tFXWNgqOmlFzIwWjyXVR0_nwrr-XO3byb0otQyfIAoZ2DSnb00MXx-OB3qpHyTaRSivdh8rEVQE-2rWcFbnj8Jh7vGRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepjhhohhhntggrihekieesghhmrghilhdrtghomh
    dprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepmhgvsehtthgrhihlohhr
    rhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtoh
    hmpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ihlJZ43rINv7UkOKahoCLOaMRjw8qWJLxMdmJg0I58Cov8i9q_fLsg>
    <xmx:ihlJZ2G95Ij5OTmlQh840I7QZXCbxfF_l79TpA6PoaS8xmuv0Xpceg>
    <xmx:ihlJZ59k3P8Y2G0dVK6SC2t8VpWg7riaJg9zBy2sHe7j6WoV1jC00A>
    <xmx:ihlJZzlDbwqE_TRBv4Iweatxn7SMJOZcC0AP8-sPAeEGRblcSZC0Zg>
    <xmx:ihlJZ0aJgBCXWSRZBWyyMFiy8YspHHV7Jk-i5M6Tr0fnEg335wDp1jS->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Nov 2024 20:31:53 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Taylor Blau <me@ttaylorr.com>,  Eric Sunshine
 <sunshine@sunshineco.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] Add 'promisor-remote' capability to protocol v2
In-Reply-To: <CAP8UFD2pAtX6UPD6FATuepwVk+0wGkmU5rt=nWpWHejeCe_6rg@mail.gmail.com>
	(Christian Couder's message of "Thu, 28 Nov 2024 16:31:03 +0100")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240910163000.1985723-1-christian.couder@gmail.com>
	<20240910163000.1985723-4-christian.couder@gmail.com>
	<xmqqserboqot.fsf@gitster.g>
	<CAP8UFD2pAtX6UPD6FATuepwVk+0wGkmU5rt=nWpWHejeCe_6rg@mail.gmail.com>
Date: Fri, 29 Nov 2024 10:31:52 +0900
Message-ID: <xmqqy112n7uf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

>> > +     git -C server -c repack.writebitmaps=false repack -a -d \
>> > +         --filter=blob:limit=5k --filter-to="$(pwd)" &&
>>
>> This --filter-to="$(pwd)" expands to $(TRASH_DIRECTORY), which is
>> "..../t/trash-directory.t5710-promisor-remote-capability".  I think
>> that is the cause for two extra trash files that are _OUTSIDE_ the
>> trash directory, which is an absolute no-no for tests to be safely
>> runnable.  Next to the trash directory, this ends up creating three
>> files
>>
>> trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.idx
>> trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.pack
>> trash directory.t5710-...-980d3ff591aae1651cdd52f7dfad4fb6319ee3c2.rev
>
> Yeah, right. It should be --filter-to="$(pwd)/pack"

It would create "pack-*" next to (not inside) "server", both as
immediate children of the "$TRASH_DIRECTORY".  I guess it is fine as
long as they are not created inside server/objects/ ;-)

>> The first failure in leak check seems to be
>>
>> not ok 5 - fetch with promisor.advertise set to 'false'
>> #
>> #               git -C server config promisor.advertise false &&
>> #
>> #               # Clone from server to create a client
>> #               GIT_NO_LAZY_FETCH=0 git clone -c remote.server2.promisor=true \
>> #                       -c remote.server2.fetch="+refs/heads/*:refs/remotes/server2/*" \
>> #                       -c remote.server2.url="file://$(pwd)/server2" \
>> #                       -c promisor.acceptfromserver=All \
>> #                       --no-local --filter="blob:limit=5k" server client &&
>> #               test_when_finished "rm -rf client" &&
>> #
>> #               # Check that the largest object is not missing on the server
>> #               check_missing_objects server 0 "" &&
>> #
>> #               # Reinitialize server so that the largest object is missing again
>> #               initialize_server
>>
>> but I didn't dig further.  Can you take a look?  I'll eject the
>> topic from 'seen' in the meantime to unblock the CI.
>
> No problem with ejecting the topic from 'seen'. I hope to send a new
> version with a design doc hopefully next week.

Thanks.
