Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D9F1FC111
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737964125; cv=none; b=qz60gC8gdV6pLW7j28Msq6ihk799LoSQzYWMt4d4e6SsiP8koWEc6rMT2yAvM1hWnL15D5fPIe52h41+3srjRGH1iXLpc4b2EbY23y42LXPd2lxNHYFjj4uZeVftvsJL1sCDCiI/r0Dn1K3SU73l3lyzGgVDl0p4uctKGXeYgBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737964125; c=relaxed/simple;
	bh=Kakigh2yPEP7gX3PeMRrPVIWJnDerdzLkR7WVxBxDiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3cyADrRbX+wtn+b0NIo6prfRZcEquEiVHRhpy9DFgB0VphNBSt3w9HUl3QP8aUPlqqfx3yf5So73V7LtsgSzeFzHMrb/XR4JBCOPtqyaLspm2DkOyiNIIEWTOzpyDhInDCyuIld72QCvQC/wzXiWcoLcQJ663ATEyRmOiAzD3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cqlSfYgE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tkZw5ZEu; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cqlSfYgE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tkZw5ZEu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id A41121380AF3;
	Mon, 27 Jan 2025 02:48:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 02:48:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1737964122; x=1738050522; bh=ZlUGNYr2Uw
	/EMnBXYdd4paAFS2go43JFqClww5txxh4=; b=cqlSfYgE1GN73Z+JV+fhwvQPHQ
	NTXV96tI+JculxOei6w43h5HvOCnZUR6y87nLHPxKN3UXNrYap2fbpw1ReFPOfia
	EL3abGmBHy3O/LGBR+nqezZI6bXahje3VONq8UgZgvHHq2c6ryjvAs9U41Fo8/Ze
	p6HUOQAoa8KR7JhifJVhduy86Z8nN7H0pHayXQ+52cQnq8AFLSNnR8DqLZxlHJb5
	7iQjwp/ha3Z3aNM5M8nsG4rZBzBmRCqyC5gBrpBth11zsVx0FWNg6ruND8LK69Dh
	DCXT9Yg53MkbalaQfLSurSvNCAILpZ0KmKhJnA+ziydvlTP0Rje+lgASwG9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1737964122; x=1738050522; bh=ZlUGNYr2Uw/EMnBXYdd4paAFS2go43JFqCl
	ww5txxh4=; b=tkZw5ZEuyTzMD67q3jxRU1djygDjBvbKRdbj0XwqGdA1OsbzFND
	idPSqrfKXGTpCIp6WVP4xZxHksg6Fxgv/xEdCom/Aw/4qYb6CATL47JwwmWcjn9E
	Q3twvTk57DaOG7R3E/j+jMiP6+sItu+jxB9gBg0d1E+/w9/4kwqZ/C6LiWb4n+x9
	bIiwdZEsyYZMMWYEeU3nwH6hEOOqzmHTBf3H8kOOLzz+OkCjyrZlHiBpbrEr4I+g
	ZFe7QnwpVU2ZCpPcgecOeOfdR0xD4VZIetwXDXpQ0NNpKTyTzJ0DNvW4B/9nw+RU
	c8niuSOnEoXR5F2hloEFF9Uc582IJZI3D3A==
X-ME-Sender: <xms:WjqXZ8Xixdr0fu7aacYEnlC8hIJzVdvNjGPlXfBe74f0r7nRqW7iAg>
    <xme:WjqXZwmokBvo_doro7SnFJ18W0EIYXPg73UgO5xjRFUjoc0CKPPrLWVPs5vWn-HSn
    3cYNHFdHaOlus2pxQ>
X-ME-Received: <xmr:WjqXZwb6O2FcIrW_1eUYjfGQDtgC0VBum5pWWGENpot1_-zS5yIjA0G512UNDYc8bYbL8DiHmksaTc-zKzW7UjHgL04NGLWuxPwcaPsb9PIM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinh
    esghhmgidruggvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopeiiohhtthgvlhgsrg
    hrthesthdqohhnlhhinhgvrdguvg
X-ME-Proxy: <xmx:WjqXZ7VElj8dqgTkaI5n5ze_d1mg_o_0_tWrEOuene0i1IP67an5TA>
    <xmx:WjqXZ2mj1Z00KYDKEM0dmc8OkywdTs5lngICdfL0EcUatms2teVSHA>
    <xmx:WjqXZweGeVhrQfzxOsVUZTSX8EOkm4UpeBr2CC20xDk6Dl_EuGskLw>
    <xmx:WjqXZ4HsOe0xQveyu8ZATT5wvdwZPF2cxODDj8wvLqlWF9dWDx3KHg>
    <xmx:WjqXZ3Aq8jAHNqWoEYMmunmJ0ZaVM7RHgEq7EoiatA5vhxlGR6o6MNz9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:48:41 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 007cc3ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:48:39 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:48:38 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Christian Reich <Zottelbart@t-online.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] reftable: ignore file-in-use errors when unlink(3p)
 fails on Windows
Message-ID: <Z5c6VlsdNXwYkUsv@pks.im>
References: <20250125-b4-pks-reftable-win32-in-use-errors-v1-1-356dbc783b4f@pks.im>
 <6acb9e8a-7014-4605-b8af-59c4584e9fe6@kdbg.org>
 <Z5ShoLCWREAsWZVh@pks.im>
 <267314c0-3aba-4f69-9f41-89392391290f@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <267314c0-3aba-4f69-9f41-89392391290f@kdbg.org>

On Sat, Jan 25, 2025 at 03:28:28PM +0100, Johannes Sixt wrote:
> Am 25.01.25 um 09:32 schrieb Patrick Steinhardt:
> > The user report was explicitly about compatibility with JGit, which
> > still had these files open. We don't have control over third-party
> > clients and how exactly they open files, so it is expected that we may
> > still see failures with the deletion of in-use files.
> 
> Fair enough.
> 
> > I'd be happy to hear about alternative ideas that didn't came to my
> > mind.
> 
> Instead of calling _wunlink() in mingw_unlink, we could CreateFileW()
> with access mode DELETE and flag FILE_FLAG_DELETE_ON_CLOSE, then close
> the file right away. That would apply semantics that is similar, but not
> quite, POSIX at least among the files that we open ourselves.

Huh. And that works even when the file is still being held open by other
processes? I don't know enough about Windows to be sure there and
wouldn't quite feel comfortable with pushing a change like this into
`unlink()` given that it is used in so many places by Git.

> It would be even better that we do not depend on the POSIX behavior in
> the first place. As you said, the reftable library can live with failed
> deletes. And I don't think we depend on the POSIX behavior anywhere else
> because we would see the "try again?" question much more frequently than
> we do right now.

I have a feeling that there's a misunderstanding here, either on my side
or on yours. It's the rest of Git that wants to have POSIX behaviour for
`unlink()`, not the reftable library. In the reftable library we don't
care at all whether or not the file got deleted -- we can live with it
and know to retry at a later point. But because we use Git's `unlink()`
implementation we get the "try again?" questions for free, even though
we don't want to have it in the first place.

So the proposed fix is to _disable_ the POSIX emulation provided by Git
in the reftable library. Which seems to be what you're proposing?

Let me know in case I misunderstood, I'm a bit confused right now :)

Patrick
