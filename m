Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501B5BAF0
	for <git@vger.kernel.org>; Mon,  5 May 2025 07:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746430577; cv=none; b=j5fjrADZyeIJiWgIX9Y/zWXuNhysDw/jkM7hVdPR6FQAjKWNl59fVXRybwRqJ6pgooZQh4jTU58Dy3CbAxx8p76XCMXpe1z8c4lUQFl4SKuuBGFqSiriT99QEa5F9hl/iTQn5ESy+NGSvS4GUhNeukMXRWuxv/i/IkJYeLu+rxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746430577; c=relaxed/simple;
	bh=i1wC4Q74DJZVhuQhJWu7imtvF7VWHlibEE0QlRIr0As=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=TvFY4ovUc1JtSST3jwuhla95fTW4q5QMpJT1ykaFHCqB73v4MRjJ4xUhkdWyJPDAwpQQk+vl9ihg9vlZNst7QCAsVYLDM3soBQuvfcd5eycVck9YkE2+RGYyluoYVRHw9tlFb5A8yuvkbYtLqW8f8M2rU20u6VQajbHXHL/Aj/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=Lz1qLFaC; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="Lz1qLFaC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1746430567; x=1747035367;
	i=johannes.schindelin@gmx.de;
	bh=i1wC4Q74DJZVhuQhJWu7imtvF7VWHlibEE0QlRIr0As=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Lz1qLFaC3dF22wGyRTxExcnGfx6LT3T3865x3NEE0oURJRVLiDXrv7/qj13qwFxA
	 UvKT0lbN/9CtEkaJXJNOw1paI33ew0Mi8UD1fHn4m0Ke6208Cie3HE0rLNWyWvVVp
	 uvU/uSWCNKWkv2HdjOsj05BIOsf/mMLhIjLB6i457NXrwrIILjsQMwv5TqHIDmC6C
	 UztaQs6SIHDGrAgV+SBExq4St2b/1jrgIzNib/9CAGvnF+vasUeT40gFnTBEeYMsK
	 s0JGQIiujZ5lOzPCTCy2sgMYKeQT+rskSfwNMXPmx5Wil6bwO4nPoKv1c8FHvRFGM
	 niTgpUxXx1Uyjyk70Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.214.189]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYvcA-1uXkvv1A1I-00Xq2I; Mon, 05
 May 2025 09:36:07 +0200
Date: Mon, 5 May 2025 09:36:06 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: BERENDSEN Arnoud <arnoud.berendsen@soprasteria.com>, 
    "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Cleaning up "contrib/" (was: git svn clone failed)
In-Reply-To: <aBhZHA7av8bWH9Ac@pks.im>
Message-ID: <5ffefc29-75ee-e278-448c-9124740d02fb@gmx.de>
References: <DU0PR07MB8465C407519BD5A8C8F933CE9D8D2@DU0PR07MB8465.eurprd07.prod.outlook.com> <3f3a0ee6-49a5-8013-7fe0-65c9ba8bfc3a@gmx.de> <aBhZHA7av8bWH9Ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:4X30x4c4h/KbaOJZ1QK6SyJzNWK51oo2QgOYBxo6kFK8W4k7jTe
 Q8wRCquHJ88HZUAOChkzpOJxdrS15LzyGZXY8OgxXov14oTRJvfuDYQZ977tMDW49kL/vPF
 0m5TEX51G64ibBG4F7XryBxyLW5Y+/L8XrjvkwNo+OR1uEAzQ/ivosWHOLPiyTFr8mu4LJY
 FUGL0hmsffJ0mXrxBt2Nw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:+VGaXQ+ozJQ=;EYnXEc2sIT2tYzb8NYCasOHgeIB
 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
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Mon, 5 May 2025, Patrick Steinhardt wrote:

> On Sun, May 04, 2025 at 10:19:06AM +0200, Johannes Schindelin wrote:
> >=20
> > On Fri, 2 May 2025, BERENDSEN Arnoud wrote:
> >=20
> > > [... talks about `git svn` not working in Git for Windows ...]
> >=20
> > In Git for Windows, `git svn` is quite a maintenance burden [... then
> > suggests to use Windows System for Linux (WSL) as a workaround ...].
>=20
> I sometimes wonder whether we should move such basically-unmaintained
> scripts out of the Git repository. They do a disservice to both us and
> to our users as they create the wrong impression of being the sanctioned
> way of doing a particular task even though they have only been gathering
> dust for ages.
>=20
> Many of the tools in "contrib/" fall into this category, and to the best
> of my knowledge there isn't really a clear strategy for that directory.
> So from my perspective, we should either rethink whether it is worth it
> to have "contrib/" as part of Git, or we should at least do a spring
> cleanup and drop bits that haven't seen any love in the last couple of
> years.

While I am thoroughly sympathetic to the idea of cleaning up `contrib/`
(which is a mixture of things that are quite well supported, such as the
Bash tab completion script, and of things that are the opposite of
maintained, such as `contrib/workdir/` that should have been dropped a
long time ago since it encourages relying on Git's internals and has been
superseded by `git worktree`), I cannot fail to notice that `git-svn`
isn't even in `contrib/`.

Instead, `git-svn` is in the same category as `git-archimport`,
`git-cvsserver`, `git-cvsexportcommit` and `git-cvsimport`, i.e. Git
commands that tried to facilitate transitioning from specific version
control systems that had been a lot more common than Git at the time, but
no longer are. Maybe `git-svn` is not quite as obsolete as the other
commands in that category, but they are all merely dust collectors in
Git's codebase.

Ciao,
Johannes
