Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808C807
	for <git@vger.kernel.org>; Sat, 20 Jan 2024 21:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705786731; cv=none; b=URiu81Ed3iOttpcjIIWkXHFPdZav3tqdKCC/a070Duxi4gUjhBZPqsXWj7k4a2NI7hDzrBN6PweInrlTjse0JfuL6ztKwY6q+xmCJpiAflD9lo7AkRkMsRZfwoRW7yG18WOuz1b70OJ19obL0Mthg4jZQLajR9ko8HAJyN7xYu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705786731; c=relaxed/simple;
	bh=IQeAmFN4zisYOdiHm94J2tMjzq2TNTbOO7JLZd8jwWk=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HxRmGdKwfQwCL+EPWn/6bBQCvk1MEm+yBoa9vw8BwIRb6OUT0N357hR3e/z/5TTDuqaFBak+lD8gO+s9Ca8tDIpNWVke5xSrei6DpD19xaSPUoLn1svMOSjQRG8JybPr3GP35PumMuDr3lj/1SaqBzELyFsLexYLFV1YQqC3SPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=RqqzSBtU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pt93CJ4K; arc=none smtp.client-ip=64.147.123.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="RqqzSBtU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pt93CJ4K"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 783D4320030E;
	Sat, 20 Jan 2024 16:38:47 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Sat, 20 Jan 2024 16:38:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705786726; x=1705873126; bh=+Ps/kq8iOsPvrBeVJXaKciHCXFR5C36p
	Li16ZJYbJ58=; b=RqqzSBtUbjpsfsOPqYVNYnSwIfjdjqk4+scGO/t3zW59AbX3
	gjUFXI/+r5XHvEbVuK+OMugk4SIyzk5QgafKfL8+5/DIE/75nJbm0LTvCh0bbuMl
	SRznavqT19qtM9XyRITInfXTBC4cS2UUf+4cH5lCku/xt0WZDo8dxiCsN6p9Ks9c
	ULwNMJzAckeU9/s1Z0Bpna5mht7HuIGTNV572gMj5djIpypgBBQtYlJ5Ht+hiXDQ
	mOT6NmEjWwqC7+Gz+Uw4CMWBHs6e1GYNCEe95P02MPcUObS2HwJ1FZORZNMKviEo
	GdpUSn/MEsFnBJCROLxuJnPI5aMJ+HNTInAuew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705786726; x=
	1705873126; bh=+Ps/kq8iOsPvrBeVJXaKciHCXFR5C36pLi16ZJYbJ58=; b=p
	t93CJ4K4HZdqNg9GcBeVRYT1svGC6nU6+gDnTZYsEHI9X+i03sYbyrzvtMHaLbvT
	K7aUNg+XvRSaPBa4Aw737fPrvQlfNHBZHziRo3fS/M4f6/0nzUQRiFXAIsUeT3ap
	bABzZSNWgKGTlbI0h82bsYZqyZMcsqPV33pLxV1HZDlj7at9tw2abjYo00MpZ1Jy
	8OiT8paQHp/oVYYRAFPZrE/GKRl1JRsXzLvON/Fsy9m+yLV2euXLIgxY8XkRieet
	h1m3EAOtyXWY+uTzOP/VgQTBVFzLf0m815vov0LcREM/WUVYUL6x6QkUEpxbkjtX
	Jh4Bq5QcX3otVSyPjfcDQ==
X-ME-Sender: <xms:Zj2sZaN7t2VdkR5D2IL1uPPmi1MBgoM2F4g7h_dfFeV5ODxuKZ2p1rE>
    <xme:Zj2sZY8ybsRIBp4PPaUayx8KODmg6wbxyiRgMRSj-nYtcnLHY_KJ42RgB9sUXflI6
    RrPlpTNjhbzTevgwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekvddgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdekudevtdfhleeuveehffehvdev
    ieeuieehheduheevgeeuteetuddutdefleeunecuffhomhgrihhnpehkvghrnhgvlhdroh
    hrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegt
    ohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Zj2sZRRZjDmzdtt1Z3vag-QT6Q38NBAKQKPeI_sQjy9dFN-bqmEZOQ>
    <xmx:Zj2sZatRHVQMYBwRtYdy5DOawE35W0ZysweoLXGK6-9fXXREv57h2Q>
    <xmx:Zj2sZScsw_c_U2ZT6wYI6tzfXzuYW5mOppCoDkSyTnugMFgLhBClSA>
    <xmx:Zj2sZWHHjit753tlvlog-KYPkTnaOgmsAMadwTKJQ765WUDHX0FWVA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9D76715A0092; Sat, 20 Jan 2024 16:38:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1374-gc37f3abe3d-fm-20240102.001-gc37f3abe
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d6361ecf-82bc-46c6-adfe-3c6ab25d39b2@app.fastmail.com>
In-Reply-To: <20240119060721.3734775-2-brianmlyles@gmail.com>
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
Date: Sat, 20 Jan 2024 22:38:25 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: brianmlyles <brianmlyles@gmail.com>
Cc: "Taylor Blau" <me@ttaylorr.com>, "Elijah Newren" <newren@gmail.com>,
 git@vger.kernel.org
Subject: Re: [PATCH 1/4] sequencer: Do not require `allow_empty` for redundant commit
 options
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Initial discussion (proposal): https://lore.kernel.org/git/CAHPHrSevBdQF=
0BisR8VK=3DjM=3Dwj1dTUYEVrv31gLerAzL9=3DCd8Q@mail.gmail.com/

On Fri, Jan 19, 2024, at 06:59, brianmlyles@gmail.com wrote:
> From: Brian Lyles <brianmlyles@gmail.com>
>
> Previously, a consumer of the sequencer that wishes to take advantage =
of
> either the `keep_redundant_commits` or `drop_redundant_commits` feature
> must also specify `allow_empty`.

Previously to this change? It is preferred to describe what the code
currently does without this change in the present tense.[1] The change
itself uses the imperative mood.[2]

=E2=80=A0 1: SubmittingPatches, =E2=80=9CThe problem statement that desc=
ribes the status
    quo =E2=80=A6=E2=80=9D
=E2=80=A0 2: SubmittingPatches, =E2=80=9CDescribe your changes in impera=
tive mood [=E2=80=A6] as
    if you are giving orders to the codebase to change its behavior.=E2=80=9D

> The only consumer of `drop_redundant_commits` is `git-rebase`, which
> already allows empty commits by default and simply always enables
> `allow_empty`. `keep_redundant_commits` was also consumed by
> `git-cherry-pick`, which had to specify `allow-empty` when
> `keep_redundant_commits` was specified in order for the sequencer's
> `allow_empty()` to actually respect `keep_redundant_commits`.
>
> The latter is an interesting case: As noted in the docs, this means th=
at
> `--keep-redundant-commits` implies `--allow-empty`, despite the two
> having distinct, non-overlapping meanings:

Huh. I=E2=80=99m used to the git-rebase(1) behavior and I definitely wou=
ld have
just assumed that git-cherry-pick(1) behaves the same. :) Nice catch.

> This implication of `--allow-empty` therefore seems incorrect: One
> should be able to keep a commit that becomes empty without also being
> forced to pick commits that start as empty. However, today, the
> following series of commands would result in both the commit that beca=
me
> empty and the commit that started empty being picked despite only
> `--keep-redundant-commits` being specified:

Nice description of the current problem. All of it.

> In a future commit, an `--empty` option will be added to
> `git-cherry-pick`, meaning that `drop_redundant_commits` will be
> available in that command. For that to be possible with the current
> implementation of the sequencer's `allow_empty()`, `git-cherry-pick`
> would need to specify `allow_empty` with `drop_redundant_commits` as
> well, which is an even less intuitive implication of `--allow-empty`: =
in
> order to prevent redundant commits automatically, initially-empty
> commits would need to be kept automatically.
>
> Instead, this commit rewrites the `allow_empty()` logic to remove the
> over-arching requirement that `allow_empty` be specified in order to
> reach any of the keep/drop behaviors. Only if the commit was originally
> empty will `allow_empty` have an effect.

In general, phrases like =E2=80=9Cthis commit <verb>=E2=80=9D or =E2=80=9C=
this patch <verb>=E2=80=9D can
be rewritten to the =E2=80=9Ccommanding=E2=80=9D style (see [2]).[3] But=
 here you=E2=80=99re
starting a new paragraph after having talked about a future commit, so
using the commanding style might be stylistically difficult to pull off
without breaking the flow of the text.

And =E2=80=9Cthis [commit][patch] <verb>=E2=80=9D seems to be used with =
some regularity in
any case.

=F0=9F=94=97 3: https://lore.kernel.org/git/xmqqedeqienh.fsf@gitster.g/

> Disclaimer: This is my first contribution to the git project, and thus
> my first attempt at submitting a patch via `git-send-email`. It is also
> the first time I've touched worked in C in over a decade, and I really
> didn't work with it much before that either. I welcome any and all
> feedback on what I may have gotten wrong regarding the patch submission
> process, the code changes, or my commit messages.

This part (after the commit message) looks like the cover letter for the
series (the four patches). `SubmittingPatches` recommends submitting that
in a dedicated email message (for series that have more than one
patch). Maybe this cover letter style is just an alternative that is
equally accepted. But most series use a separate cover letter message for
what it=E2=80=99s worth.

Cheers

--=20
Kristoffer Haugsbakk
