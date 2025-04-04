Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D74146588
	for <git@vger.kernel.org>; Fri,  4 Apr 2025 11:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743766873; cv=none; b=rhQNaCzD4ejxrObCdrpShwZ21pbsGUyf60oXSQEsgXJZDIEPs98/YLeR3KQSUlgZjD6vTqhXISwQ8zBcMPWfhL5qtkMY82KFPalfnA1OSXjodnDIs5JWIgDJ0Z/Tp4bHqVZyiFUB73UUHEt0Y0jeMi3b80kf0XQgD3G2XwFf1vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743766873; c=relaxed/simple;
	bh=KzPdPb948uOZfGTJ1C2fj7pKe7996OtyF68a9O4R6V0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=MfCdn75XrZ0oydZji9LX0coE6QJlVmtE2VXUz9EWqDAx9AxQeICAcNu/UaoEmuX9rXFH0VrETJBrwPRCHI5MuBRJboHbkkd0xvtEGI+sSm80y72MQy3dWmsBwK7lCGXdRaRhKbn49Wjn7BaIBvVKik8R/Ap7IexwgXSvhzH6z3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=BLF04wrn; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="BLF04wrn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1743766868; x=1744371668;
	i=johannes.schindelin@gmx.de;
	bh=eUj4ds9jFHhbsC3CFbG1G1shtKcgZrubTgKaqM8EtFk=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=BLF04wrnyr3rJG3mCUoT76Bb1v5xx032GRdMH1PH5Tuait/UzjqQ1N2ADhcNCkb2
	 5paI1NROMPTXzX1Sym6u1S262FUrSkT6+t6MDqBe4NtoKjvPJAvyyCfOoV8rjNJu+
	 V/H6bJ9nBohbpH6yLlz2F1CJskgkGRUwZ+/fJRxNBuo1j/wN0GCxzB0g53petk5fn
	 2Ar56HFy4mWjAfyWIOw9hkZyInd58jZe3m/Ri+Lp2aYTV7kxTldxFvyMu3J7kf0OU
	 xUrbyxWJ7NcGuNxNYfM1FtL6p4F8uR+cfSzXe5ukHU/dKGvRA+AZAmDb8OLyqhk22
	 gxxngIa3tZkZ5Lhy1Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.156]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1ML9yc-1tiS2w11ww-00KTKM; Fri, 04
 Apr 2025 13:41:08 +0200
Date: Fri, 4 Apr 2025 13:41:07 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Phillip Wood <phillip.wood@dunelm.org.uk>
cc: Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 3/3] wt-status: suggest 'git rebase --continue' to conclude
 'merge' instruction
In-Reply-To: <08837a1a-b46d-4456-beba-5c889fe9e674@gmail.com>
Message-ID: <c2f93d99-2f4d-ee6d-7087-42320c6df0f2@gmx.de>
References: <pull.1897.git.1743181401.gitgitgadget@gmail.com> <db01acdd062a17b1cca62428eba8c3ed62ca7c6a.1743181401.git.gitgitgadget@gmail.com> <0bd7e0c1-fe73-9e16-0737-d6b175a60dd3@gmx.de> <a81dbb21-b50b-4358-b2d4-7f804b66bcbc@gmail.com>
 <15222e69-9452-fd61-6ffc-8c8de0c68d8a@gmx.de> <08837a1a-b46d-4456-beba-5c889fe9e674@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:rAB2Zs4nXOjfdWYXWnpIrCNWtS3jZvOeu2o2JkrZ2+Lcle1y9Gg
 rcYqcFJRKMsjvvxm0vXW8+eK7alluNRdEqyOsDCbdDEyK/REWU4x4YE836FPX+tFlewnFVu
 uRg8xIZkeywdyeXQHbpXATnwMDG4iBWi2Be0qhpYFCJFfM430cMiTeMRmIs15NZZPDE/jmO
 DR52a80ataGkTHzL5u9+w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:q39F26HjZOo=;B7LeorY/oTgSAiIU3B7yVrA+M2k
 oZg5CA15XMiZU11yVfKH3AnTPvQm+uAQfIZQXxpsM4Rslp4kHhWUyEe2E0UCmdezGcqsM8jzG
 ut6Z6dWN4Ab8g3qGfZYsEmy2sDTHw9uBrb2vI3U1llZbbmao2Dv0lgNpJSoiyao15nKTWgZQT
 iDsfs2aQGFdCb6VUpOraAz2lvopcz+TYXyJn8gCZAWDTqezXEgPdojVYcowy9R7ea5lUWwO4W
 5a0JpXfPaJBd8HcXyAcvytO7EDZWi9vRZQdwuo0Z2exxFT4YthXCUO2Mh6DReAfQhbPuMNyBT
 rMkysUNwWsH7jZdL5HKTYiehiibgBJwgas7ZXTYgmdnkDgZwmrIwc0dY3YjzusnYH7hp57Xzs
 W21kDS/686XK1elwI3YzBYWXozYdB1IsGzF+PlcMS0m0qG9qRAoV/Ha5iCaXDJB1UHo8TYo0l
 jLSXB8iLWRVtR8x4MxQnzL2lcUgGNEaSJEZ0FOo3PSSrsvs/nYttSvdC3k5xh/+aBhEsawJuA
 6CcVafPJ+8YMML3pQMk5VB6b4AXI6EJaD1a00VNvxZyk34pWtbQFH3ZEhIyqzHunOmwM/TGSx
 auYEyukYhr3lAeNGOHgEjsk7ly+MU2gz7d4eAUMLI5QjubrpIJie81zrHlJ1kRzL/lDQ68UdU
 XNXRsLrJt+VoDMljvUmSgUEU+R+260Wb4/bSYie0TXteHR/yITnFaggLrfli0CBFoOxval2aC
 RV9auSMfhKdhIPxKLdugjGB+duDSjmdeEjO7IV/lpJeMnM6YuhoDtYkgJgaOT3xbiySKdtUnI
 7Vve8ZMmReRPaJf4o4HJXb4OKic/JfrC/V6u5DRm+r94LgpFwFfU+QoUIKpVShQ6uakTkuoCZ
 IVurrN/D9Ui5aShNe4nI52ojwTlJ3nMwr0QzAJ6fVw3AQOSSx/6OhSFNmAPhs3EPghPtBaD2Y
 3WuEaTx6zACDKqHKr80hxwx/RMt1F2u4ngxHSZpHiSjCAslKu4dzucw6o+mFfwmcbGZdczldq
 zu5L2pOmjGUjWHwoFaLpU+fkHZuMxC2vwzvg42lzDSRXAE2hYv+7g+p82xwYQSYydTiZ4+7zm
 rhkueXDhoU/mv9XLrNeCji6hB5bA28p2p2qn05FvgevLPL4LImW+fRejD2WEXr6DrduUMJxTI
 XHfnFec1S9uqCug+ttmJlDDwamaAvW7e+gISZSMONwLGFMKwsvsRbRK51QdsZbuMK1vTkhkcn
 W0t/6VUtTz8NHKitxCjIJmNnuKSFYZr/aaap+nvsRxdVFCDPyKScnqUVhw+N/pwivDm+RB6Jq
 CHLi/NEnUAAsbIqe5DJf68WhB3+iZbukDA8gg7zWd6CRIsAtqLX4sm6nyfFU8tkvjkt2ezeZG
 Q3HE3KZ4p/E93qiKL2ESx+EQmgwkTsp3tkcqBl4aYFVQUCAe9kwpLXWZ7WhpeOhUjQAgjqENg
 N7nP8fJ1L7IXXnw4JxTPqPPlw2OmnAncot6k8meS85TgvRL6Y
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Thu, 3 Apr 2025, phillip.wood123@gmail.com wrote:

> On 03/04/2025 13:17, Johannes Schindelin wrote:
>
> > On Wed, 2 Apr 2025, phillip.wood123@gmail.com wrote:
> > > On 01/04/2025 17:22, Johannes Schindelin wrote:
> > >
> > > > It is unfortunate that we cannot fix this, as `git commit` with an
> > > > interrupted `pick` _would_ retain authorship, right?
> > >
> > > Unfortunately not. Running "git commit" rather than "git rebase
> > > --continue" to commit a conflict resolution when rebasing always
> > > loses the authorship.
> > >
> > > > (Why is that so? Can we really not use the same trick with `merge`=
s?)
> >
> > Authorship is retained when a `git cherry-pick` (what an unwieldy comm=
and
> > name for _such_ a common operation!) failed with merge conflicts and t=
hose
> > conflicts were resolved and the user then calls `git commit`, though.
> >
> > Why can this technique not be used in interrupted `pick`/`merge` comma=
nds
> > of `git rebase`?

[Fixed totally garbled formatting that pretended that the first half of
this sentence was written by me, the second half by you:]

> `git cherry-pick` retains authorship by writing CHERRY_PICK_HEAD which
> `git commit` uses to look up the commit message and authorship.

And why can we not teach `git commit` to use the author information
recorded in `.git/rebase-merge/author-script`, too, and teach `git reset
=2D-hard` to delete it?

> When we're rebasing the sequencer removes CHERRY_PICK_HEAD and instead
> writes the commit message to MERGE_MSG and the authorship to
> .git/rebase-merge/author-script. I think the reason for the different
> behavior is to avoid confusing things like `git status`.

The reason is probably more that you can mix `git rebase` and `git
cherry-pick` (why does this common operation have such a long name,
again?). I actually do this quite often, I frequently even have something
like this in my rebase scripts:

	exec git cherry-pick ..upstream/seen^{xx/something-something}^2

> CHERRY_PICK_HEAD has been removed when rebasing since it was
> introduced in d7e5c0cbfb0 (Introduce CHERRY_PICK_HEAD, 2011-02-19). Thes=
e days
> rebase supports --reset-author-date which means it cannot use the same
> mechanism as cherry-pick.

Right. But it can recapitulate cherry-pick's strategy in spirit. After
all, `git commit` had to be taught about an interrupted `git cherry-pick`
so that it _could_ pick up the necessary information and use that.
Likewise, `git commit` could be taught about an interrupted `git rebase`
and similarly pick up the author information from what `git rebase`
recorded.

> Personally I'd much rather we tell people to use "git rebase --continue"
> to commit their conflict resolutions as using "git commit" has never
> worked if one wanted to preserve authorship and I think making it work
> would be a pain and probably fragile as I'm not sure how we'd ensure
> "git commit" knew it was committing a conflict resolution created by
> "git rebase" rather than one created by some other commit run while the
> rebase was stopped or by an exec command.

Even I, the inventor of `git rebase -i`, have run afoul of this authorship
resetting on more than a dozen occasions.

This is proof enough for me that Git is unnecessarily confusing (no big
revelation there, right? Git earned that reputation very effortlessly, not
only in this particular scenario).

I'd rather like this usability problem to be fixed, even if it is a pain.
If the pain stems from the way the source code is organized, well, then
maybe this hints at the need to clean up a little?

Ciao,
Johannes
