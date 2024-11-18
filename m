Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A713DBBE
	for <git@vger.kernel.org>; Mon, 18 Nov 2024 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731973894; cv=none; b=rFI8jplLWN8MGnf19GzDDlJ3TUiIKVsXAJSk9v+XjDf5o3/99lk5hDDNrFQbO/S3QIUwKZAsjiappuqBwgqQONA+SaStjW2bnnasLorQOhd3cqFUt258nPrkAWbZDSVeWHYj3ZShPLi0Ygvgg6WqzI86Qutb+peADzFfbgsHPDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731973894; c=relaxed/simple;
	bh=Cy6MeTvqWtaFsnioya/ynQ0tlM6NybBJhYg3w42f+Kk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZj+CY4Ak+L+ZfMHrSmImQUqm095dWHfm3+CY5YHh4wHpB+6X/5whSZhYqYQf2HFBGcs4fMnfkqgq1zXPxCVsJTBLNySA7DQ6X/0+TqjOneaAbG3N81Cu9jycD3kA5p7XuF4LjvSdfL5MieDXhlFi8MB8rOM/rAS7aIqn+NAETk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=akfW1Cam; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="akfW1Cam"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 0BCF3114013C;
	Mon, 18 Nov 2024 18:51:31 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 18 Nov 2024 18:51:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731973890; x=1732060290; bh=13IzTRCH+/GOgp1JbnEC5nQovn2BJMKFa8O
	emM6qXP4=; b=akfW1Cam0ky3WsrpR+ETowZ4Vn2eTtliSJRtKUROjGffQJb43sI
	4rm5iWMbuhQsc1zCn/GyJSPczyDpKIbnFiXRX/qozhyJMU7dl9mDKMYADFJuFSHX
	QfD15x2U91TY5b6M4OHqOitknqTnMMBu0IL/pa+Y4LrXV3dU9xsnNnGRm732RkGB
	p5Z20rJjl2B/KpY0LSdZRpqb6CYA8YZ//PmzPQ55JPRF5kAE2j9VEGiJ3rvtjoDA
	JY8qvonMcAenSWRUlaom9oziz0SZ0CNHPeUWX5zgAimZUU1LdfUqgL0fvFIKZHAI
	qkyZX8ycxLjQ7X6aIaFH6BtPtSQC8zl94ew==
X-ME-Sender: <xms:AtM7Z0OVIIg5g5sIQ0TjRhe_oj-gO5k6kMK2Iwl-GeJU_11mmpUf2w>
    <xme:AtM7Z6_bszdgwTx3EIkGXOKtegsAWTuNwVcZK1Mg4yg2UB7M5KJTlsgRaM5fMK22C
    stsm2Q6IWrc-3N8iQ>
X-ME-Received: <xmr:AtM7Z7QbqI3maJNGYdPG3Aj_NWc_nqvjO0FqL32Ag4mW-j6-7LnYwAf2jqIXIUhOwX39cd2ru_3bCuc16SgXuLdpk8xbRnboVrTE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfedugdduhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:AtM7Z8vvSkBBN9N8Aa8B15jWk9L0htUoHDd_WRF-AMzIHAXTKipYTA>
    <xmx:AtM7Z8c_wAi261Q6VMb37ML3JBnS6wN8KKnW49e9QtyJ5TQOadXv6g>
    <xmx:AtM7Zw2OglHD_wg3taB6P0A7Aw7pyt_fneRsDhAByqCkX4wdyDSicQ>
    <xmx:AtM7Zw-7z6x8Hfr5aZ7XOgBHqexbVGE4cOjgpXhddPVcsW4rTXbD-Q>
    <xmx:AtM7Z07IlxjAPVrSwOaVWdUlFHqG3zpumA3RcnoAjxkF00faz_E9mrWO>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Nov 2024 18:51:30 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: malloc: *** error for object 0x1: pointer being freed was not
 allocated on MacOS with git 2.47.0
In-Reply-To: <Zzs8JJO_HCLrEBM0@pks.im> (Patrick Steinhardt's message of "Mon,
	18 Nov 2024 14:07:48 +0100")
References: <5FFE9429-7496-429F-BEC5-9D00C8409AC3@enrg8.com>
	<4ca84916-c5f5-4d52-8f6a-08b729bb66b8@web.de>
	<xmqq34js1kd2.fsf@gitster.g> <Zzr4cgk_5MJNcHm1@pks.im>
	<xmqqjzd0k92c.fsf@gitster.g> <Zzs8JJO_HCLrEBM0@pks.im>
Date: Tue, 19 Nov 2024 08:51:29 +0900
Message-ID: <xmqqy11ghzi6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Nov 18, 2024 at 09:42:03PM +0900, Junio C Hamano wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> >     ps/upgrade-clar
>> >     wm/shortlog-hash
>> 
>> Unfortuately, these were both based not on 'maint' but on 'master',
>> and cannot ever be merged down to 'maint'.  The last topic may
>> deserve to be cherry-picked to 'maint' when the time comes.
>
> We got several reports about build failures with clar on esoteric
> platforms, and ps/upgrade-clar fixes those. Distro maintainers can of
> course cherry-pick those patches, but I think it would make sense to
> pull them into a maintenance release.
>
> I am happy to  provide a backport for ps/upgrade-clar if you agree with
> me.

I am primarily following the wish left by the interim maintainer.
If a fix was based on 'master', it was deemed not critical to be
downmerged to 'maint'.  Other fixes may have been forked from
'maint'.  Cherry-picking is a declaration that the initial choice
was a grave mistake, and I'd rather avoid that for a small thing
that are not critical to the end-users and only affects developers.

In addition, for those building themselves, I'd prefer to nudge them
to be on the latest release, and not backporting developer features
at fringe like testing is probably a sensible way to do so.

Cherry-picking I can handle myself if it is necessaary.  Accepting a
new patch from you would cost me more time than that ;-).

Thanks.
