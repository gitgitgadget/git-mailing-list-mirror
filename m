Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336432C9A
	for <git@vger.kernel.org>; Mon,  7 Apr 2025 22:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744063586; cv=none; b=SYEJGEDgEraaqnqpSKkacQa88jKUJua3Yp3p/59vgMun7haUzaFSzNF2DZbyN6SzQ+TT9848YMwXvcUn0VhBrTVuhUfw348zs2R46p3y+HIVNbXVPiel/iRHTIedh2yPlXYM8IWRZX1cuQdGGZrH0qXltDlHaBJ9JmAJKfydqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744063586; c=relaxed/simple;
	bh=QbzvrUwlv0enLEVb1afCGW5A2BRDQz5FnyuxZyN7n9I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=omO4NjDXEFFRgFHz5HM0w9Oz//zb5qVeXsLZbSrJhe560wDuHkiuL4nsLTdiZ/eKULMZFv6K1s0vIK9ZOslLzGcX7lGRkMbEcRu5nN5dWDIK5JLimQy5nNtdH3SUNu6dQwx8ci8f/qDHBkm3X3fZNvx4vQ6O3yJ9xndoSR9789k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KLd6qVL3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KcktvKR0; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KLd6qVL3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KcktvKR0"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 107C3254025D;
	Mon,  7 Apr 2025 18:06:23 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Mon, 07 Apr 2025 18:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1744063582; x=1744149982; bh=icfakymbWt
	YLbv8IfSf3TaPVA1T3KKEOQIZrp9Z+NFY=; b=KLd6qVL3r8GcxGn+6jbmbNZPPK
	tGPjrp4rpe9LQwUXzoDmXCC9jn628Fhesh2oBOxAmD7jMqBG43KKtisqE2Tqt5/V
	FaawUc9ugcUH2UstZIzZCajIfjpNK+OzWEAwns0h+Yk5rqKL9aHek+oZf7pYtIsp
	o0+lUnNsHIC5uMw9bjbNLQMjX31Nj5ehbYJBmoTF5J5NksHlVw8iImIdZ/YUvbQS
	MZ2t9rAOAb8tS9HlF50hyfWYp/ELgFEP8Vc735Bj5z+vCIj3bC0kklgnlYilBHAf
	o4ini4xS3g+R6I7wEYvm70U9NjyJZqNn3ZQOfw6gxu9prrX7SubPpz0E2lPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744063582; x=1744149982; bh=icfakymbWtYLbv8IfSf3TaPVA1T3KKEOQIZ
	rp9Z+NFY=; b=KcktvKR0u0iu0iVb9MMRFQ6bvTOJ9ZZMPpjrt4OYuUH2hzA6Des
	ArjINUcOMgcAh4rTSfxKiTjZ4R0mOu11KB44UxwjM9lzfVbOk2rBbJs/imbKu6g2
	NXpdxg6BQBPJof6nuUZ48BzS2IATAoBo92L5JzMOuYBEMS+tIaGsVk0eAP1Ys69C
	4Uxh0HN3usmweWKS/ngsCfvxUK28ojBhiW9o3oxOMlX/FqB7k60fCtFY9YIuINhr
	rrPSWU3urt1zTKcy1rPyWrGPHmJkiRx49EhL9tnVkC4nIyAVvb7w/MO5rKcIhoZW
	rChTVX4yHoKsKan9c3TvtPWG4u/Fba4exnQ==
X-ME-Sender: <xms:Xkz0ZxQg5I1L-pK0efFM7AO9-npCPm37vkBMxR6O-So__cp_4zr6DA>
    <xme:Xkz0Z6y8WZEYByHABO8sO1ag93v0icqbvLdpH7HVahf3gFjH0ZjKyBKETg4drc6nF
    y8LvJ_x3iGJWmFGPQ>
X-ME-Received: <xmr:Xkz0Z201qJAzkHFwhSwFRzm9uUaXAOxZD9raKDx-vH2HoYzw2xx1nTlPIyXTuqSbkFITcTVcCt9y0g9--bJrn2WQfi8LfuS0l082>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvtddufeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhutggrshhsvg
    hikhhiohhshhhirhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohephihurhhisehrrgif
    sgifrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Xkz0Z5AZ_sKDDbeO55zp-EI5oDt4-800mirX4Rbn35Lp4pvGigXk2A>
    <xmx:Xkz0Z6gGLP4q3ye4-CnrsCthUwuDCBaQxbECVDMfyw_7Nv3vX9RrKw>
    <xmx:Xkz0Z9phgBrl7k0Kequv2qrAJMOxNbAKXZdwC5LLs6s1TVQMg_SdOg>
    <xmx:Xkz0Z1gXKVQCNzmwV8gblLmyDAvwHWjylpP_KBFvSWamOzOm5iaVDQ>
    <xmx:Xkz0Z50qH1Y_TI2PU6KiwsVb-8OiXB94sYxHK2vK46LdqHQ2oq-aa8UR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 7 Apr 2025 18:06:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Yuri <yuri@rawbw.com>,  Git Mailing List <git@vger.kernel.org>
Subject: Re: Make 'git stash list' more informative
In-Reply-To: <29E4ED32-4909-48EF-86BB-67111B62AE1A@gmail.com> (Lucas Seiki
	Oshiro's message of "Sat, 5 Apr 2025 13:24:02 -0300")
References: <edcd6174-e931-4ab9-b61d-8126a6cab740@rawbw.com>
	<29E4ED32-4909-48EF-86BB-67111B62AE1A@gmail.com>
Date: Mon, 07 Apr 2025 22:06:20 +0000
Message-ID: <xmqqiknflj8j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Seiki Oshiro <lucasseikioshiro@gmail.com> writes:

>> It contains the last commit's subject which often/usually doesn't
>> really describe the stash entry.

It depends on how you work.

I do agree that the work recorded in the stash entries tend to be
pretty much unrelated to the work I was doing on the branch (hence
the theme of the base commit).  After all, if they are related,
you're more likely not keeping the work in the stash entries---you'd
rather be making completed commit on the branch.

However, I find that the subject of the base commit the stashed work
was derived from works well as a memory aid to recall what I was
working on when the stash entry was created.

So "doesn't really describe" is correct, but because stash is by
design a local thing, it is not a failure that it "doesn't really
describe"---the purpose of the message is to be something easily
generated and help jog your memory later.

Having said that ...

> `git stash list` accepts the options from `git log`, so you can change
> look at its manpage to find other options that show the information
> that you want.

... this is an excellent suggestion.

Thanks.
