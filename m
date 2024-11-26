Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686431401C
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 02:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732588164; cv=none; b=c/SJW8ksGgiQ+eGhPUnbwjv1cvo16yPsBMRFlQfWKe1pcDck+2UbdoZGh2fsrDBGd7MIg2TH3b3yMWZS8qpcLKU5PVZPALeanh3/EeAEfL+TxEcNzfp0e0wuT7b0PV9VFbp/T8pvbtYtteH5OK23Ry+W8JibmjLfpvuLNj1TP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732588164; c=relaxed/simple;
	bh=bngLQHpqeBdJq7z3MY8bpe4SS++Z1k0bEgxRLcWeSaY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WWH9VtrJj15es5jt3Bvn4LNrklgoEZVAQnQn2rJP6xCPI3TZ79yVEojSQryiZS9WkqYs+bztvyYhf1tsao1b4dmKws7rVAE+KdiVOgd5tr79qxSjJtFCLOqBSK630ETxzGxzimL9DBYcfQvdurENvWcglOJHK/vH+9+HWB8pW4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Zds1+HKl; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Zds1+HKl"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 509F113803A2;
	Mon, 25 Nov 2024 21:29:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Mon, 25 Nov 2024 21:29:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732588161; x=1732674561; bh=pm6rI1j1rhovMgF9Za6MRCb+9ymY8tHF/nz
	DGtcKyEo=; b=Zds1+HKlCRQkXMTYd+wRxCB2XbJ2W+iiOwLR4kybJIsfgRJWd8b
	q4HHvTcV4VSwe9To8vBvZmWUP2FeqhiRaR9NdsV4iF+dOODC1I+wygpSe89ZqLjG
	zO23Mj2w9tQ9Fl0bhpcKVS4xCyrLhGu+jpRKKV8CAPpyquHX/+1QBVZb187DwjMP
	8LVb3AEc2rkLSMG9Mm3A9ptBhMGcyT/PueVLKk7I2B/m8LmKcfnTB/vjgPEcRnub
	YVDs202jNorOAG1t+HEDwZFMHHPUNCNtIjKcvrX1o72zYEzpMymxzSipr0U7hNLD
	++APNts9L2kH4i8FEUCdPQ7s79/ZAjPdadA==
X-ME-Sender: <xms:gTJFZ-c44oienDQYJrq4I693ZI9aPrTcxh0c_vxMRlBtvQWK9llNlg>
    <xme:gTJFZ4PgW5ZUKNHnrp3KVQbFqnsETRE5DlZdhckHu8g5S77-9Y7gm1f2-cpocjxid
    -BCMiaaKEEnIVEryQ>
X-ME-Received: <xmr:gTJFZ_ih-BrYTrIRnbd0BkKLbulIViiZinmE-8wMfJ7K-umx81wtAmviDX7bkiEskwY4Nw0CH18T2LCYJVl7fiWlMxO2FS8Lfu0VTUk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeigdeghecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrd
    hnvghtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:gTJFZ78y5YJ72ABgHbFNqKSVjRsQOYFCirOXEUD1DQockCsbGsed2A>
    <xmx:gTJFZ6v5hU2_RgQCLLchZdB8LZ0etLTmBLJY1wzcK8hwZNH1ktpUkg>
    <xmx:gTJFZyGM5VT3jyeNQtQD2E0fM8VJ0ul29cVc7SYn--dHkTgrW993CA>
    <xmx:gTJFZ5Phq6BgnuHhtMT7jqe-uwtToF6DIk2jr6y3f4nB6neC-Dz6sg>
    <xmx:gTJFZ8LvcrOJvd_3NodqaMt6MmI-GxwoKyWP0JvQgcUcL05e1iLI7VjA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 21:29:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] bisect: address Coverity warning about potential double
 free
In-Reply-To: <20241125163543.GA13033@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 25 Nov 2024 11:35:43 -0500")
References: <20241125-pks-leak-fixes-address-double-free-v1-1-d33fd8ebf55b@pks.im>
	<20241125163543.GA13033@coredump.intra.peff.net>
Date: Tue, 26 Nov 2024 11:29:19 +0900
Message-ID: <xmqqplmi3eyo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> Drop the `else` branch entirely as it seems to be a no-op anyway.
>> Another option might be to instead call `free_commit_list()` on `list`,
>> which is the modified version of `commit_list` and thus wouldn't cause a
>> double free. But as mentioned, I couldn't come up with any case where a
>> passed-in non-NULL list becomes empty, so this shouldn't be necessary.
>> And if it ever does become necessary we'd notice anyway via the leak
>> sanitizer.
>
> Nicely explained.
>
>> Interestingly enough we did not have a single test exercising this
>> branch: all tests pass just fine even when replacing it with a call to
>> `BUG()`. Add a test that exercises it.
>
> Seems reasonable. That test will end up passing an empty list into
> find_bisection(), because everything is UNINTERESTING, and the revision
> machinery's limit_list() removes the UNINTERESTING elements from the
> revs->commits list.
>
> I wondered if a topology more like this:
>
>       one
>       /
>   base--two
>
> could produce something interesting from "rev-list --bisect ^one two".
> But no, we still end up removing all of the uninteresting commits before
> we hit find_bisection(). And anyway, "two" is obviously going to be the
> output, so we know "best" won't be NULL and it won't hit your new code.
>
> So I agree there doesn't seem to be a way to trigger the new code that
> isn't just a noop.
>
> Thanks for fixing this!

Thanks, both of you.  Will queue and merge to 'next'.
