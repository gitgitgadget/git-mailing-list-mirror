Received: from smtp.bit-artificer.com (smtp.bit-artificer.com [172.105.170.90])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 668753839A
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 07:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.170.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712041810; cv=none; b=WxJHy3+LvDVl1iO8wWy/XgAs2nIhvAaeVAgjHN86qmEoMr2YnQb+owsOJyMv5jbjPxy6Pf07W8g8JYExk41KbU7Uhj5ZeHpGUL29Q08AStMK2qUD6dfQX7UPdfr5yVU1/eZTbJCXdA6IsKHc8X0bbVMdPHA6bXwS6YXqxK6DD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712041810; c=relaxed/simple;
	bh=LpwJq5dLEOvmorbuwq8oCLwY8RE0sojo6fMRvmFYs1M=;
	h=Mime-Version:Content-Type:Date:Message-Id:References:In-Reply-To:
	 Cc:Subject:From:To; b=G8WWPjRs6PkXkP2FkUGrUXSV4Xu0EeohiTc36iZ4Uzi/pAY8dw6rO6QSpGY/mnx66q7b3q6RfM7j2N9ieMLyQOZp/86fiGRz6bRaLNGI9hUu1JKuc4nc77nmIKpAXCV3i82Dnv6F6hm1ASe4ly0Z4pSRFSrYuwB5prXWpIRyMug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-artificer.com; spf=pass smtp.mailfrom=bit-artificer.com; dkim=pass (2048-bit key) header.d=bit-artificer.com header.i=@bit-artificer.com header.b=DEKp90N0; arc=none smtp.client-ip=172.105.170.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bit-artificer.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bit-artificer.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bit-artificer.com header.i=@bit-artificer.com header.b="DEKp90N0"
Received: from localhost (193-115-84-163.tpgi.com.au [193.115.84.163])
	by smtp.bit-artificer.com (Postfix) with ESMTPSA id B9E823C498;
	Tue,  2 Apr 2024 07:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bit-artificer.com;
	s=20230529; t=1712041407;
	bh=LpwJq5dLEOvmorbuwq8oCLwY8RE0sojo6fMRvmFYs1M=;
	h=Date:References:In-Reply-To:Cc:Subject:From:To:From;
	b=DEKp90N0hY0bZd/kb/0mpcww9F6a/XJzRX2y6+mFXIYL7L3empDCFOE9bRECBCIU+
	 jBEtGcyD+N0r1CwmrSiqain61H+155aj+JSO5oqLFuZRjd8bwI6WJ427mxFa7o37Vq
	 TmWrlES9lxjBSK4Vx9SNAsQM6Yipo7TWqJTiGib/wLsLdqlk5PLtTNGJ9Wzsn4K1h8
	 VXCIWCaCIUCkBDmEW3XfkNfxQyKdyV5mTk5sdoVbFK3hGtWImQh70xctK9VtUW92d5
	 HengFwS2P59cJl8GZdJxqIrfJ4rMhbww12+3ogSigUmHEzIcBOo8mlyKC4aZVsOb7m
	 TWwdJi6YcJxgw==
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Apr 2024 17:33:26 +1030
Message-Id: <D09G10B0SW3P.3ORJXEY5FUUU0@bit-artificer.com>
References: <CZU56XWOUT4P.1WZ2BSE0VLN01@bit-artificer.com>
In-Reply-To: <CZU56XWOUT4P.1WZ2BSE0VLN01@bit-artificer.com>
Cc: <git@vger.kernel.org>
Subject: Re: Expanded worktree tooling?
From: "Thomas Lowry" <thomas@bit-artificer.com>
To: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
X-Mailer: aerc 0.15.2

Sorry for the slow reply but thank you for your thoughts, I'd love to
hear others thoughts but it doesn't seem like this has caught very many
people's attention.

> For these two I use branches and commits. Like a WIP commit similar to
> stashing if I want to get the changes out of the way quickly. I don=E2=80=
=99t
> use worktrees for this.

I'm pretty sure no one uses worktrees for these scenarios, the main
question is more "IF improved tooling existed what kind of workflows
could be streamlined?" ie things that you can already do another way.
Thinking of brand new things you could do with a tool is a bit too
open-ended, plus if someone is claiming that git would be so much better
with feature X then they may just be happier using something else
anyways.

> I really like worktrees. I might use them for two very different
> versions of the app. so that Intellij and other tools won=E2=80=99t get a=
ll
> confused about their build state and indexing. Or a dedicated =E2=80=9Cde=
ploy=E2=80=9D
> worktree for deploying the app with Docker (so that I can do whatever
> else in the main worktree while it builds). There are a lot of
> use-cases. And for the hotfix scenario: I might use a worktree when I
> have to both commit some hotfixes and deploy them so that I can have a
> dedicated scratchpad for that while I work on other things. (But also
> not too much: too much multitasking is bad for me.)

I haven't played much with these kind of long running worktrees, mostly
because my projects don't currently have months old active
feature/refactor branches that I'm slowly working through, also my CI/CD
processes are fairly short so I don't know if I would be saving much
time yet. Maybe in the future.

> But I don=E2=80=99t see how worktrees enter into the picture in these spe=
cific
> outlined scenarios for me. In particular I don=E2=80=99t understand movin=
g hunks
> between worktrees. Moving uncommitted hunks like that seems like a
> version control layer on top of the Git database, like an extra step.

Well in practical terms moving hunks is just a stash followed by a pop,
so its not an exra layer on top of git just a recontextualization of a
toolset git already gives you.

Maybe another way to describe the use case is that someone is creating a
worktree in order to commit a fix they already have instead of debug the
problem since they were able to debug and test the fix on top of
whatever else they happened to be doing at the time (yes sometimes work
in progress will conflict with debugging but everyone has they're own
strategy for dealing with that)

A fundamental question is whether expanded worktree tooling is even
needed, I'd say that there is existing evidence that it could be useful,
for example https://gitbutler.com/ is arguably taking the core
idea/problem of worktree's and turning it into a dedicated solution on
top of Git.

I'd also just like to note that whether intended or not Git is a
toolbox, not every tool has to be useful to everyone. For example it can
be argued that the primary use case of git (linux kernel development) is
actually a minority use case because of how many people just use git
with github and so tools like git-am have valid reasons for existing but
is useful to almost none of the total population of developers.

Regards,
Thomas
