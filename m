Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A3D19923A
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 16:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728663591; cv=none; b=YONBpuo4UNQuMP0nivcKB76Ry406ZF1Cn2wmIt1YALF8v3quI4MqjMuX2Jo8byjGgpEEdrqPLlm6TzrHqBbTFHT/IHvB85rLmj4choX9k0iIs6CcLlxP36kQNNerlzl5iZWaHnXQogR5iQ1rzrDYu0q51iePnUG5IrMbWHNuBMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728663591; c=relaxed/simple;
	bh=/PU5c1T5L2s8Uz2GDnzNunECBwQEPlOGfCH1PNEjSsE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=cPqXtTKqZKKWL581awGcB9kCCY1BWsx3lMNpjzpxp3wqrPpGOPz/pDgcCdNuGJw9GWpBwrzM57vp03OO40/sHGMdAVJ+pBJBZPaSBC/8vg71AQZEgsff8+4KKxWcYli7Y1Ixe1C2JmBgAzwg7A0TrT3VHsVzfRp3GLVd5hopifo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YrciDe/6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HtPYc+cO; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YrciDe/6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HtPYc+cO"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CCCA111401D9;
	Fri, 11 Oct 2024 12:19:47 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-11.internal (MEProxy); Fri, 11 Oct 2024 12:19:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1728663587;
	 x=1728749987; bh=kUxpziAzNN/r6uf6TzG+ca1EG8q2I0UOq0m+qy38g5A=; b=
	YrciDe/6g3jeAOYy/frjzEaIG7K559U0TRZ/SyQko2VP5RnmR4W0lZDMDQKJL4Ou
	8CBx4uiTiQ0ZVWaI1Eq/9tv4oX5/b0dLMKWGOGfr9SCy+yq0uvKwwjZTrfVJgLJy
	Q48CvZIwkraBehRiKeYFSu+bK+mAS/zsOGu+zN5kay/vo+58fsFuM0hICCVu2Cfa
	2KjDVe2mkywE0ERCrf2mP25TXDygynx+g66x8JCvlVG+sMQ+oKdT6c1/TNlFfpui
	qD7/aMpU5WSlxFgshtuOAqDujUnSa0/wGEQaSXkJonLpDpf49uUjWkdo2pYMgCse
	UjRkJc8sz++SDPuWf/ZdzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1728663587; x=
	1728749987; bh=kUxpziAzNN/r6uf6TzG+ca1EG8q2I0UOq0m+qy38g5A=; b=H
	tPYc+cOjp5D7gQAOX8M4SxU4P1oW02ZgKC4XURFER6WeflH/uXb9BqA8CeEatGEt
	GxpJi0lV0zuz8QPoFp0/et1gtNNqXPSG9a6J6TgKj4IynB3Qs0QLkl0vOJXN6YRe
	4hIONv7Zpv7nYNtshCDqFD0fQBTfVj/+TpFVRo5E2uSJYcUuB0STD3MhOVLCIkd/
	rt/qVOsrBwV/2noiJx6ZwMEz8GkBg8H4mgCjYg45IEB6miwwCUipqp2o74BGy5MG
	E/AaDj+sKVjCd5tl1AF7qyqSbtO5kTgsYKZBG2NLnV4Z7cP3/aBxusbbbUXUsYuI
	SwpjGRen0QGT4V/HxEVWg==
X-ME-Sender: <xms:I1AJZ1UQBBGc2ss_UXemQJqErXG6uFJ-xXh3lQ4Vo98BZzD1cBiJrA>
    <xme:I1AJZ1luufG4idnRGj1wHrSkZUY7wXeMuOKy2JE1igp1iRYsAQwLuhuDvYdCg1-TT
    a27WWhKRvkZJE0iE1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefkedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftfgvsggvtggtrgcuvfhurhhnvghrfdcuoehrsghtsehfrghsthhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhepffejhfeitdefvedtuddtveekhefhveeu
    tdeifeegtdeuvdfhjefhteevtdffudeunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheprhgsthesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtugifhhhithgvfe
    esphhmrdhmvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:I1AJZxZKhGTCFBVQj-534k0tAwkzvmdbwcGr8D06MRp0j4mEKEQqlQ>
    <xmx:I1AJZ4W7DkyAqlfc5ViS4hA2u5FINznB7m4UfB0u6EP3j7tGm6fMOg>
    <xmx:I1AJZ_kZnw-N5PuMKI42lAOcfK-nWh7ZR0M-2G3akrHsy929tB49Zw>
    <xmx:I1AJZ1dhhvj70vcx58GXuIbNqs21mxM0LjtQ0zKAsjK1mEBR80tTaQ>
    <xmx:I1AJZ3vS7cRKzmJndU3gYh8QjROkkhxmWY2SlTdWmvbcf3BQrtleTids>
Feedback-ID: i445c46d3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 67C1C2220072; Fri, 11 Oct 2024 12:19:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Oct 2024 09:19:27 -0700
From: "Rebecca Turner" <rbt@fastmail.com>
To: "Caleb White" <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Message-Id: <517c8829-f98f-4fed-af4d-b84182fb253e@app.fastmail.com>
In-Reply-To: <D4SQFBEB1HYZ.QDOLCYY80DIZ@pm.me>
References: <D4SO70M9Z1QI.1AC4QF9ZG8T4L@pm.me>
 <444a412d-bf4c-4bbe-8250-18d8bc86fd21@app.fastmail.com>
 <D4SQFBEB1HYZ.QDOLCYY80DIZ@pm.me>
Subject: Re: `git worktree list` when bare repository is named `.git`
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Why would you move the `.git` directory? If you're trying to move the
> repository, then wouldn't you just move the directory that contains the
> `.git` directory?

Ah, I should give some context here. I'm using worktrees with the layout you
describe later in your email:

    my-repo/
      .git/      <- bare git directory
      main/      <- worktree for main branch
      feature1/  <- worktree for feature work
      ...

I'm writing a tool to manage these layouts for you. I want to provide two
features:

1. The ability to add a new worktree in a slightly more magical manner; in
   particular, I want to be able to do `git my-tool add feature2` and add a new
   worktree in the same directory as all the other worktrees.

   For a non-bare main worktree, that directory is the parent of the main
   worktree.

   For a bare main worktree named `.git`, it's the path of the main
   worktree. (Nothing in the `git worktree list` output indicates this is the
   case!)

   For other bare worktrees, it's the parent of the main worktree.

2. The ability to convert an existing repository in this layout.

   This requires separating the `$GIT_DIR` from the worktree and then
   reassociating them, in order to convert the non-bare main worktree into a
   bare main worktree and a second linked worktree. (In particular, I'd like to
   avoid the cost of copying all the files in a large checkout.)

> I think the main reason why the `.git` path is trimmed is because it
> doesn't make sense to show it in non-bare repositories. No one wants to
> see the `.git` path in a normal repository.
>
>     # global git
>     git worktree list
>     ~/sources/git  3f20f8dd05 [wt_relative_paths]
>
>     # locally modified git
>     ./git worktree list
>     ~/sources/git/.git  3f20f8dd05 [wt_relative_paths]

I definitely agree with this!

> I would rather not have the `.git` show even in bare repositories,
> if a user has moved the bare repository to `.git`, then that would
> indicate that the *intent* is for the parent directory to essentially
> act as the repository (and be moved as a cohesive unit if moving).

I suppose that makes sense? Perhaps this is an area where the documentation
needs some additional notes.

> When I was first doing research on this, I found a ton of articles with
> all kinds of different ways to do it. Some folks put their worktrees in
> the same directory as the actual repository (intermixed with their
> code), some polluted the parent directory, some created a detached
> commit that removed all files from the default working tree and then
> created the worktrees, some used a bare repository but then just created
> the worktrees in the same directory, etc. I finally came across an
> article that showed the `.bare` method above and I thought that was the
> cleanest method. However, after using it for a while, I realized that
> I could just move `.bare` to `.git` and it would work just fine (and
> I could remove an extra file). I've been using that method ever since.

Yes, exactly! My frustration with this technique is how difficult it is to use.
I have existing checkouts I'd like to convert to worktree repositories, and
`git clone --bare` doesn't create remote-tracking branches, so it's strangely
difficult to set up repositories like this. I'm hoping to ease some of this
with my new tool.

Thanks again for your help,
-- Rebecca
