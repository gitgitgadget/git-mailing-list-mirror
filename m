Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E184274FDC
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 12:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765022445; cv=none; b=EPJA3mPRjearBcwTEECHecRyh4pCVHnzsgiUyxzltOfaNzUswV5WONEMidJcKszLcdsSwwIMSWmXcbvu7n1FdfMt+TWzXA/0TNJIFlB4786yr/nXklk9pxdlR6kBJeiK/YT3XcnIYm+xN9wnUyJwAozFDutDcHrg3KQOCCa1qTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765022445; c=relaxed/simple;
	bh=V/9IC/sxhDWkcBSJlKKp+TjmRadfN/TK8/n2+Vt9zEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPDINNeoyT+DEIsBLQjLwuZHdXc/d+e/c/mIgOePxXTIySp9jAtvnEh2F6hDAT6gUqHtPdd3Q/bOZ6JQ4CPlSX8rqZP+BHQtXV8zEs37sFBCvob1OMRr3+a/ctmT/99+FZuHjmzFe7O6lHVfnebMjWqVKnaQiKt3D8c8QBCP9PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=uApUpGfF; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=owQzu7Ce; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="uApUpGfF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="owQzu7Ce"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 64D151D001F1;
	Sat,  6 Dec 2025 07:00:42 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Sat, 06 Dec 2025 07:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765022442; x=1765108842; bh=4pNouF1AMN
	0D5478XsY/eWkXjabdoJgKd8wMN02U87A=; b=uApUpGfFC3xpc9Uma6u/pfMwBO
	aJ11MWL+GTjHsg9qf4pGJvjRTs97nIqvVLY9SizrD/vDmHUuP0+oTAZDKu9Ba/Z6
	t19L8CZT6nQyLHWPsVZn3FfzK8DfxK4W9s6I3lloCOCqV5TSca6HhtwMbk7rmgjE
	GOKR3qyQRkOlBJM9+Gp1hjfrkatfUOgYBdBMqs/ItMCFfnVsVTb80c9iMgpmbBSk
	shJtuN+Mp2Pns7QKBrUbZeAUAMaRBMVZUyJAPYx9glRUN3kCMKjLgIyMlVg535yZ
	gO6rYcmvx9M3L8H17F6MZ9ezx/dQL0/tDORawjIUXCUcWWsNRGSUNoYNerCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765022442; x=1765108842; bh=4pNouF1AMN0D5478XsY/eWkXjabdoJgKd8w
	MN02U87A=; b=owQzu7Cec4vT1GxQaJSCathMl1eYW1QLeI9Og/pS4p1pQFPMSaC
	PZYF1EhkgRIQbLP52ZbvmHk65iyN0vu4aJX/eCjoJLhXWA0w7rJIl7xHQFtMy7Do
	B0CkOysOQf2vE+707xMfZ0TMA4h3ohxYZoOvOOErbFwAG7v7bks/VZiuRMmQ8HlP
	i6arRH5cOyk9naOzYAkBvEjKEIvK5ex9Ga6XkTRwsRYeneVldVRkEETX3UdgcHSj
	CpNZZSFWTupb/X52LPTpYI2EGzGS95jiKEui369CmrUNV411mlCtXKuK0KNYitQa
	gVu40uiwlbjXMumEBmiSULPmKdKkV8tqx9w==
X-ME-Sender: <xms:6ho0aWMGq7xCXLJtvR7aCJg8NQuugwwDyRvNQ6rcDxS60gqh2Z_xqA>
    <xme:6ho0aQwVBHdTkFsthvN1e9uaXvwjUVQ86-Fcb7AnOy32rMxVrNKmkzzSFzQjLslNa
    V3EZm6DrPGwPgvMZNU4IqKmYgRyGAJcQztV1KXtMoj1-80-9HDKLQ>
X-ME-Received: <xmr:6ho0aYr3Bu_CEVmymY8h4XmHbY6LwmG25zIJXJL57GDD52YGu2mvc9_pfcdDLI01m8Q-w-OiN7oe5ASBzYqmgNw0yW_rJKtExdwP9PVi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehsthgvrggumhhonhes
    ghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesgh
    hmrghilhdrtghomhdprhgtphhtthhopegrrghrohhnsehstghhrhgrsgdrtghomhdprhgt
    phhtthhopehjrhhnihgvuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:6ho0aQOfQxocgEC6YuB6y5BBGzd0zdkbYuneajde_rdZ-PdzfAWj2g>
    <xmx:6ho0acf89WZPVIlfBNmr4vBxBbB4BHFquoj9Cp8SMVfSMbv-osKLDQ>
    <xmx:6ho0aWU8SpyYB77d6UXFjgK-0edniOz0QY6eJMuFeUB0se7fnWiNjQ>
    <xmx:6ho0adCCk0qG-o2xYepQgkBcuMklw-CdMkL5hhnDvWQBFhHqEn34vQ>
    <xmx:6ho0aTpm6hoG4IJNi_EAszddeir4-RhhOkzvAw9wG81vRQkB8MZqMzzl>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 6 Dec 2025 07:00:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7080fb9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 6 Dec 2025 12:00:39 +0000 (UTC)
Date: Sat, 6 Dec 2025 12:59:24 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Adrian Ratiu <adrian.ratiu@collabora.com>, git@vger.kernel.org,
	Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Brandon Williams <bwilliams.eng@gmail.com>
Subject: Re: [PATCH v5 4/7] submodule: add extension to encode gitdir paths
Message-ID: <aTQanNSlj6VxDY-n@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-5-adrian.ratiu@collabora.com>
 <aTLNwHpLUcy-WsZs@pks.im>
 <87v7ikeng2.fsf@collabora.com>
 <xmqqqzt87dgj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqqzt87dgj.fsf@gitster.g>

On Sat, Dec 06, 2025 at 07:47:56AM +0900, Junio C Hamano wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes:
> 
> >> It feels somewhat fragile to me that we unconditionally handle these
> >> cases and try to find old submodule directories. If the extension is
> >> enabled I'd expect that the submodule configuration is the _only_ source
> >> of truth.
> >>
> >> May I propose that we instead always error out in case the submodule
> >> configuration does not exist? In the best case we'd then give the user a
> >> nice error message that tells them how to run the migration manually.
> >
> > Junio told me to not do any kind of manual migration and just attempt
> > new names until one works and then use it consistently.
> 
> Indeed, but I do not think that has much relevance to Patrick's
> comment.  What I meant say was
> 
>  - With extension, we know that the repository will use the
>    configuration item as the sole source of truth.  Unlike the "we
>    now store submodule dirs to munged paths" design that we saw long
>    ago, which would have required us to sometimes move the existing
>    directories to match the munging scheme, we do not have to
>    manually migrate the existing directories.  Instead, we can just
>    record the pathnames they already use.
> 
>  - And with extension, when we add a new submodule, we would need to
>    give them an entry in the configuration that does not conflict
>    with those used by the existing submodules.  As Patrick mentions,
>    this name does not have to be done with any reversible mapping,
>    and third-party software and Git reimplementations can always
>    refer to the configuration to learn the path without knowing how
>    the path is chosen themselves.
> 
>  - The above two would ensure that the configuration would always
>    exist once a submodule enters our system (and "git submodule init"
>    is done to cause its gitdir created).
> 
> So, unless I am missing some corner case that still exists while
> bootstrapping a new style repository with extension, Patrick's
> "error when configuration is missing" sounds quite sensible to me.
> 
> I am officially still on vacation, so I'd stop here for now ;-).

I guess the one edge case is when somebody manually turns on the
extension after they have already initialized submodules. In that case
the gitdir paths would of course not exist in the gitconfig. But I think
blindly falling back to a source of truth different than the
configuration is wrong, as it would mean that the we have "a single
source of truth unless we don't". It would kind of defeat the whole
purpose of the extension in my opinion, as implementations cannot rely
on it.

Maybe the right approach would be to tell users to never manually enable
the extension and instead to provide a command that both:

  - Persists the submodule gitdirs for any populated submodules in the
    gitconfig.

  - Enables the repsitory extension.

If we had that then we could count on the submodule gitdirs to exist in
the gitconfig, and if they don't we would die with an error message that
indicates that the repository is broken, maybe even with a hint for the
user on how to fix it.

Patrick
