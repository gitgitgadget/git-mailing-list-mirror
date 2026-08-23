Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10B031B80D
	for <git@vger.kernel.org>; Sun, 23 Aug 2026 15:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787500515; cv=none; b=nMa6AC4er5Bb115J29jwvaRNYrGjuaUzbxoVKlc+FIdDYv8FH/d2Vf7QNALXAB6dAx3bpyHw2tsdBoQqv0vV0vtLIqhdqk3xMKLBL1hbZ8L8xLISN0kbacMZk7FnDRNEaB5mr185npnfwHum+GmnSa4neiDf5n8Jb+UjisGMYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787500515; c=relaxed/simple;
	bh=Hpyp2yTGLFti59irJlsrk+Gz+xWFR6g8Nb+8ZspVEVY=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=XZYTGtuz32bP/xKI3OIFAb13dqgf7nEdnrEqnzgVePOtpurU9t5+7HV0I5dLAo4xACujNwI9o1Jl7Aj6k/QgUxemaFTV2BU5256lV0VMpBn6LHFmQo0ZJcMKu9VC+dz/UdDNHCuEPUJD4j0pTndbELgnJBpy/ZAUUHJuMAQjckA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=jBYc0YJ3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jTuiIKVl; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="jBYc0YJ3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jTuiIKVl"
Received: from ams-compute-01.internal (ams-compute-01.internal [10.64.2.61])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CFF4E1400132;
	Sun, 23 Aug 2026 11:55:08 -0400 (EDT)
Received: from ams-imap-15 ([10.64.2.35])
  by ams-compute-01.internal (MEProxy); Sun, 23 Aug 2026 11:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1787500508;
	 x=1787586908; bh=HVstqBkwV66qOYrJFFq9zP3kWgIJQY1UA1RszkdQEf4=; b=
	jBYc0YJ3d9eWqzyswpL8TB9QS0/sJkkV4tc5GSWHUWnspbjGCNHI0utK5CRorvqn
	tdDfLzUulGbZG/xe6VlVsHbI4us6jTl6McOOmQKXVBfxHUyAL/nVp08MkJtktrGg
	O76RjENOhrztZrJDeIKg3k8PC6v5Cb5aEzzLIk/iAbAY2Ru/z9SMFBOQGLqLhm+P
	cLnqXa2S+h07riWSu2VGnXxXuW8SGi+feg020XcviUVO2eMbtxhlM+uZw4vIQ3Uc
	mr015QhbOn7PrnRFb4B6V9ilsaSxGtj/XYkM/hg6j4mXJKKZrQXF9vdgr97BpoJF
	BUzWD8Qi0FPm5Alva7jAcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1787500508; x=1787586908; bh=H
	VstqBkwV66qOYrJFFq9zP3kWgIJQY1UA1RszkdQEf4=; b=jTuiIKVlkpgbrA6D6
	D9343RlC4EDD/W9JIxaZVVQr6imVrRniMOKWZkh//KNvujVD+2cmFk58QTZWiI2J
	LMjJMqA4+a0CWYshs1UVTmlggV+xLAD1aFbqF+Avy4H1Tm1OHjIc2FpHQ+dIOaY1
	MI/cAWChkN5VBUlQ1tJRtygGumDXp4VDlsHNPHopEw7OfBxEll15G+6ChDZe9CUM
	BoYJ4lh6orcHKwxZ2/Z7KVm6TOQolLt7uJN1ilS3q7PTMnoZZ9RJKZSHdTd81sRm
	lE6lUYNZDsk85/sqvWeJbh4Cvs0sCLzSLpYImcUZ+209RaX/aYoukWTjh37gRXNb
	/kCLA==
X-ME-Sender: <xms:2ReLapyaNbBgYIIw3orD2m_9jeGTrSNNUjP5reioHxASZUmJMFdhqvg>
    <xme:2ReLakHQGdug02o7oie7ZAm6Y1DodK7iY_6-wQmnCXIQQI1cg7wDtGg9ZjZDC2XW6
    xyNEd8KnwYHmgGDm2-mMpnx60QfAKQdJevrUUcXuJ0M3KTejnnzkhw>
X-ME-Proxy-Cause: dmFkZTG4lKZh1g4jzMnKtiMcuiGhkQ7Z5M30KaEyjF+3BljUXnUUI5jq0dbFlg39nGm9lA
    nf2Xm2BX+GEa0bUmZ79q3pJ9sGpIxlMXR9TiPOi2mNk809cnDrGQSX04BEtYbT3a+3+Hte
    Ru4zaettgCSyjoApE/HLl8Dpkfkmw7XPzvYTt1rsHEydgqQcXw2dlEnUtsglJvksBhcu/a
    LSmNQ4WEDvffsOxXKQhLwP62JZyt4yyIJY+2XEvoRZw9E+2LfnkplzRAXAHrAacTYVFIwv
    N6A6FBunvvmA/+TRh/ypYrraiAQ40Xag1TknI3AiWY6tC1jh24IuNNSzFP7KHEFujCIiBc
    P4B1Ew22QRuUbRYMPwDrPdxTkIn8VYNj/zybSZ0G2W1Wyygnuu7kwVuNOkufjfBKoBpKPM
    2QXnl+eTDW0Vwt/XGU/665baim4tfTsxoa1t8Nh+59EP84KjR0F2ouj6dVGGOuYvnohDFd
    j4jrcrjZ6R4svJqZ0IHDOhuNg5fpI/4NC9UR7Ro5JH5N0eMzZPXVgKbc20PAZjXt3xd+gw
    1xktPRtHiAJZeXAmjHwlA/36vajOYnUClPpdd6CGc8DIyKvC9OeF2RxpMCokRhLWesSNX5
    KJss/KC1sP0p+4adYvTtxFWqPajTSEV1eVz85ExCfahuU6vrAZgD+1MYa7RQ
X-ME-Proxy: <xmx:2heLasfgy7KH0W8X8qxkg3fNVJtxVTZKJxv7EPOS8Y8jeaWoQP0Nag>
    <xmx:2heLasLHDz4lzlsJHiKfsKweLGjMBftG8p2k8zCj5a8JjomqLhMQqw>
    <xmx:2heLalHXzuYarj_awxUPaa7gLAUMNJDaa0IwdXGl7br0UPHWh_KoBQ>
    <xmx:2heLaupeyHV8Wio3j6uBYLEWSrrCpHiYInJnyJHqscK2zrcdtQ26lw>
    <xmx:3BeLas0LXUM5LemymF1Hujus-kLuIw96zME3g_mvXBYukyehXQ7AvPKS>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 595AB22C007A; Sun, 23 Aug 2026 11:55:05 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Am38JzCfnC0N
Date: Sun, 23 Aug 2026 17:54:45 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Vladimir Sitnikov" <sitnikov.vladimir@gmail.com>, git@vger.kernel.org
Message-Id: <4a9dd6d8-f5ff-4579-82a6-01ea2f1474f0@app.fastmail.com>
In-Reply-To: 
 <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
References: 
 <CAB=Je-GRbyonmkW4qXCuMRQhWcAZE8zc_Xp32hwC1i61bNnjaw@mail.gmail.com>
Subject: Re: Subject: [RFC] stash: let the stash stack live in a configurable ref
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026, at 16:19, Vladimir Sitnikov wrote:
> refs/stash is shared by the main checkout and every linked worktree, so
> two worktrees push onto and pop from the same stack.  With git 2.52.0:
>
>     git init wt-a && cd wt-a
>     git commit --allow-empty -m base
>     git worktree add ../wt-b -b b
>
>     echo A >file-a && git add file-a
>     git stash push -m "worktree A: half-finished refactor"
>
>     cd ../wt-b
>     echo B >file-b && git add file-b
>     git stash push -m "worktree B: unrelated fix"
>     git stash pop      # worktree B's own entry, as expected
>     git stash pop      # worktree A's entry, applied here
>
> After the second pop, wt-b holds both file-a and file-b, and wt-a has =
an
> empty stash and a clean tree.  Nothing warned about it, and the entry =
is
> gone from the stack, so wt-a has no way to find out where its changes
> went.
>
> This is documented behavior: git-worktree(1) lists refs/bisect,
> refs/worktree and refs/rewritten as the per-worktree exceptions, and
> refs/stash is not among them.

Yes. Both the existing behavior and per-worktree stashes are useful in
the abstract:

=E2=80=A2 I sometimes make changes in the wrong worktree and then just p=
ush
  there and pop in the correct one. So it has practical uses. But it
  doesn=E2=80=99t feel like it jives with modern Git (Git 2015, when wor=
ktrees
  came). It does not feel elegant.
=E2=80=A2 Pushing and popping in isolation also makes sense and surely h=
as just
  as many practical uses for people who both use worktrees and the stash
  compared to someone who only uses the stash.

If not for hysterical raisins, I think per-worktree would make sense as
the default. But with history in mind a configuration option makes the
most sense.

> For a human who drives one worktree at a
> time it is mostly harmless, and sharing is occasionally useful - stash
> in one worktree, apply in another, as a way to move work across
> checkouts.

I see the narrative crescendo in the first clause.

I don=E2=80=99t see how it is mostly harmless. Yes, it is useful, but it=
 could
also be confusing because it IMO isn=E2=80=99t consistent with (again IM=
O)
modern Git with worktrees. So people might only get confused while using
Git all manually, stalling the current session and sending them to ask
SO/LLM; there is no massively parallel cluster of Git sessions going off
the rails as one automated entity creates a merge conflict that somehow
cascades and wastes many dollars.

But the bar for introducing configuration options for porcelain commands
for can=E2=80=99t-break-default has always been, my my knowledge, those =
lone
manual sessions that merely get stalled and leads to confusion in the
person operator. So this could be worth implementing just based on
that. (And it benefiting other cases is also great.)

>
> What changed is who runs these commands.

The reveal.

> Running one coding agent per
> worktree, against one repository, has become a common setup, and the
> agents stash and pop on their own schedule.  The failure above then
> turns into silent data movement between unrelated sessions.  The same
> report has already been filed against at least two such tools:
>
>     https://github.com/github/copilot-cli/issues/1725
>     https://github.com/stablyai/orca/issues/13695

To my uninformed, not-using-agents mind, what agents do with the tool
seems like the least concerning thing. They can be non-deterministically
instructed to not use the stash.

The stash has already been optional, something that you can achieve with
the other porcelain commands. So any code-changing entity can adapt to
not being allowed to use the stash.

And for determinism you can give them a git(1) wrapper that bans
git-stash(1).

>
> I would like to propose a configuration knob rather than a new concept,
> because most of the machinery is already in the tree:
>
>   - refs/worktree/* is per-worktree, so a private stack has somewhere
>     to live;
>   - `git stash export --to-ref` and `git stash import` already read and
>     write a stash stack under an arbitrary ref;
>   - extensions.worktreeConfig and `git config --worktree` already give
>     a worktree its own configuration.
>
> The missing piece is telling stash itself which ref to use.  Say
> stash.ref, defaulting to refs/stash, honored by push, save, list,
> show, pop, apply, drop, branch and clear.  A worktree that wants
> isolation then asks for it once:
>
>     git config extensions.worktreeConfig true
>     git config --worktree stash.ref refs/worktree/stash

Opting in to `refs/worktree/stash` makes sense.

>[snip]
>   - Reachability.  fsck and reflog expiry learned to iterate
>     per-worktree refs, and I would like a second opinion on whether
>     stash entries under refs/worktree/* are safe from gc in the same
>     way refs/stash entries are.

See gitdatamodel(7).

    Git may delete objects that aren=E2=80=99t "reachable" from any refe=
rence or
    reflog.

Any particular ref namespace is not special with regards to
reachability and GC.

>[snip]
