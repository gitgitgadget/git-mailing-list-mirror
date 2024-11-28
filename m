Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10258467
	for <git@vger.kernel.org>; Thu, 28 Nov 2024 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732759080; cv=none; b=K49QSBLPcE38v+JJ4t1on3AzNFsPDqIDYqFIAVQ6uVEJqPE7IfrKWxqaKFSLTvqBH80vh1Qx00tZz0FZDRKxJZeo9dJLQ4ikFGn0KcPHtUz7N0qPGBt6HY6y+1Hq63nPGqYvYTr+JZTQXR7TBIuVWsCP/Bu/7PLsHOvRaSNa6CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732759080; c=relaxed/simple;
	bh=tK1h36/s1mmytLvQiMSXDGZWDAW/3tkBeFLl5faXcto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nXIIUzQSk1DMRsveNVDqWbTzMjPfA44PRoynV65MswsKDPbGj3+92B1PKq2ZeTSCN5gmycm9li0h2vbTCou8n5FlsHpbFABAyEA0ic1Lgvdtu3NxjLr2V6QAFsnBl/jsliMDaXJmmFgc4DCprw91/tLRmVvSWZXkG0KQw0QCVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nt2bYkom; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nt2bYkom"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D3D7211401E3;
	Wed, 27 Nov 2024 20:57:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 27 Nov 2024 20:57:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732759076; x=1732845476; bh=7jJYZt93eXN3av9As0VhFLNhQjRv1J0yPlj
	a/4HRfpc=; b=nt2bYkomHNiH5Yi86OYWkjov8rFfkXNJHR2pjglwn+xAvlgslbU
	CFaIx6WvqBfHHHWB2mCou8JoZYzMlFUGOg6EnUIS6XPUvuBl7g1shx4X0bCvIGxD
	3UKDPI/l2pXULqcaI2UKeTBRwODcShq3aKj0DqAcC3MZ8FLPe1DNJVfomejGw+bL
	2pCJCwkEVm3BsBPQRSBMgKMdf8GNUg6zOMMVri5ewA3wsOc2t93JAiReJkwu3MMJ
	M+qXso+RjZDprzyeHLvFf7eS341vvVG7KnShzUcOWhPxoZSi5v1YxOVT/zC8A39c
	+MzYs0cz1/Y43cQkRvisxP/vsOYmHbvkFnA==
X-ME-Sender: <xms:JM5HZ8C3JThE1KbedqirKr_pXDXaBSr8vWtPvcsy3uV8mFxnr0YoLA>
    <xme:JM5HZ-jYG_iQpy5RHw10zeY1be4H0AveG_QSe3EHORaU_wtATAxTtocbBXmLLsmd-
    rNogckgsuWdN2ItPQ>
X-ME-Received: <xmr:JM5HZ_ki_MXQwG5pdjoXvwDRRuq-iL_eNfDgxjdy9p3SblM-TLFNKClT5uv1N78wOrIPxaD1YHq5CTxoSb8TL6Xc2fBPsFosFgVpVlQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrhedtgdegtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    rghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:JM5HZywGNkQH8ORjZb889xEhyilSfK__uDk3vi7_iZY_0If_46CgMw>
    <xmx:JM5HZxTtX6lCKwsl8sRKxFQlqgiI4jBGJUQxGn3QH3qHt0C6ybhQzg>
    <xmx:JM5HZ9aFLrRgH64JIcNQbzqz_2SMHMdOtdd-bKu66Cd1NxIW2xjc7w>
    <xmx:JM5HZ6TR8uug25aow8F2fgFSvBHWp3GChkZgzM0mA6vKlzMSGdEZtA>
    <xmx:JM5HZ_NwJ7hkd6QjYOT3d6C1wzpJrYzx2zz5o_GeLG4RaeDScGFUXQRA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Nov 2024 20:57:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: What's cooking in git.git (Nov 2024, #09; Mon, 25)
In-Reply-To: <Z0bYpiP2JDEzqJXr@pks.im> (Patrick Steinhardt's message of "Wed,
	27 Nov 2024 09:30:37 +0100")
References: <xmqqttbv4ty8.fsf@gitster.g> <Z0bYpiP2JDEzqJXr@pks.im>
Date: Thu, 28 Nov 2024 10:57:54 +0900
Message-ID: <xmqqy114p1b1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 25, 2024 at 05:07:59PM +0900, Junio C Hamano wrote:
>> * bc/ancient-ci (2024-11-01) 3 commits
>>  - Add additional CI jobs to avoid accidental breakage
>>  - ci: remove clause for Ubuntu 16.04
>>  - gitlab-ci: switch from Ubuntu 16.04 to 20.04
>> 
>>  Drop support for ancient environments in various CI jobs.
>> 
>>  Needs review.
>>  source: <20241031234934.3451390-1-sandals@crustytoothpaste.net>
>
> I've reviewed these changes in <ZyixnuBY5TcyrHEj@pks.im>, even though I
> don't feel a 100% qualified to comment on the GitHub changes. But given
> that bc/drop-ancient-libcurl-and-perl has been merged to `next` by now
> it would be nice if the above series could be merged soonish, as well,
> so that the GitLab CI is getting fixed.

Yeah, I think we saw on 'seen' what these changes do enough (at
least, it doesn't seem to break everything ;-).  Let's mark it for
'next'.

Thanks.


