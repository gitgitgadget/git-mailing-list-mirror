Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D82720E3
	for <git@vger.kernel.org>; Mon,  2 Dec 2024 00:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733099952; cv=none; b=HoAEkPiRs+Am0yTHi43xfi3wmrMQ5DgseMZQHdBfHZN5kHUDnshwUgh3iF15/V+e3eqZ7KlJdljTptxy/hB01q38mZB6d2FF+5BxKpHIiHR6N9WGHviKdJPfZNymg1Pn74loSBgSNzsqaSxGz+U5j6CpX0eE+FV6gpG7oZLQiEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733099952; c=relaxed/simple;
	bh=rBwWgieZI4CM7Rb0ZjDLlsuB8gV08kBivq8HiEJl+8U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XeCyKfjKBHPPtA68e8khcoejlCkjo0ohEg8qELQxd65KWekuLH45Y2aWQB5+0kkZInpd6oHmQD6PRD0KmGDgkcKJzMCL2Lnqr+P6VIdQq2EniLXF5stAx8DfnfTpseQqvs5v/TR4Ecx1W6qrQG0iNJ5D4LMjkj6xohGt00TDfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wx/qVp+y; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wx/qVp+y"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id A30AB114015B;
	Sun,  1 Dec 2024 19:39:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sun, 01 Dec 2024 19:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1733099948; x=1733186348; bh=S6ppPPCYyf38qgI/k/4iOlClry76N4C6A55
	SPFbaosk=; b=wx/qVp+y679daJLDp2ddGSKuSLHti1n5ChazwRL89URb0qzG4XL
	unDOHFytqArhMxwR1vh5q8qNismEqX7z1rClNGMw3jW7Kv3617jecTQct0MwFJ7z
	E7jiSzI1psZ/InkfixD2tqurKtWvo+gcB6psUrUu6nmLxS5iHqX9ytHsbuJ/sDOm
	olTL9wXPfUlOgsMf2MmY/NwSxWEGQT4acLIFYHnLdj4TM6SWLBdHKw7WIRvbyJae
	LC2aXXtHrgteNRvLwcjFRt08f3vI0Kx9fYARX6iBi8YbXUC5v8VWAY2IkppD7yna
	kSaF5weuZbdph6fBr+vLQVkPNEN9IL6S0xQ==
X-ME-Sender: <xms:rAFNZ8NB0xYWSoH5CktXvd8KuDBfqABkoa0Z1E1Mhl0BQnLh3Go4gQ>
    <xme:rAFNZy9OwobYSccr95i49jeVjWzE1UOCrEVHSfWnU08WDS_7sxpIL1ubK54L_qLnt
    vM5XLfHwmdLXQ98sQ>
X-ME-Received: <xmr:rAFNZzTcrb_pxogXvghVkvcEoKxY6aoAJv1vPcEu8_7JzNcv_BDgV3AlXrEYzGyEzEqXhyocpsOjZOs0QOKscGHdhN1fDFr-xOzYaE8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrheekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtugifhhhithgvfeesphhmrdhmvgdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:rAFNZ0vmsC28fkgDbq_bzMlFWW-c6q36JkgTCOh_8Btfi7SBw3eUVg>
    <xmx:rAFNZ0c0ofa064ylA_Jcldpn-qeZVCre8UFk4Q9FKmu42OvWdiBcSA>
    <xmx:rAFNZ42o9RucV1gp0gcg1sUxzZLcDoxBy-JDvT4h43IPi9WN_B4TJA>
    <xmx:rAFNZ48Dobf1I0ZVC2C7VUb0apY3h76asWUCvy920INprofWc-iNyA>
    <xmx:rAFNZz7Vk1YYgB-NEakp73awSKRxRK7a_obHlpwBKGuByFW9EL-HZaTG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Dec 2024 19:39:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Caleb White <cdwhite3@pm.me>
Subject: Re: What's cooking in git.git (Nov 2024, #10; Thu, 28)
In-Reply-To: <fbda37b9-41e7-4b18-a831-dfb5a9a9c54f@gmail.com> (Phillip Wood's
	message of "Thu, 28 Nov 2024 15:34:40 +0000")
References: <xmqq8qt3q5t1.fsf@gitster.g>
	<fbda37b9-41e7-4b18-a831-dfb5a9a9c54f@gmail.com>
Date: Mon, 02 Dec 2024 09:39:06 +0900
Message-ID: <xmqqy10ylxzp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Junio
>
> On 28/11/2024 05:35, Junio C Hamano wrote:
>> * cw/worktree-extension (2024-11-26) 8 commits
>>   - worktree: refactor `repair_worktree_after_gitdir_move()`
>>   - worktree: add relative cli/config options to `repair` command
>>   - worktree: add relative cli/config options to `move` command
>>   - worktree: add relative cli/config options to `add` command
>>   - worktree: add `write_worktree_linking_files()` function
>>   - worktree: refactor infer_backlink return
>>   - worktree: add `relativeWorktrees` extension
>>   - setup: correctly reinitialize repository version
>>   Introduce a new repository extension to prevent older Git versions
>>   from mis-interpreting worktrees created with relative paths.
>>   Will merge to 'next'?
>>   source: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
>
> I've had a look at the range-diff for the latest version and had a
> query about the removal of a check from one of the tests[1]. Perhaps
> we should wait to hear from Caleb about that, but if you're keen to
> get these merged down in time for the next release we could just fix
> up the test later if it turns out to be necessary - I think the code
> changes are all fine.

Thanks for reviewing (and thanks Caleb for working on) this topic.
I see the latest iteration v6 has added back the extension checking,
so we probably are good to go.


