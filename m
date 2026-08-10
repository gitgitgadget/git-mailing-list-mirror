Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA13842125D
	for <git@vger.kernel.org>; Mon, 10 Aug 2026 19:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786390698; cv=none; b=cDYHMEYrux1Z/WMEyCvp2eezU5hkr6HMQ4QAXTrHkczmI4biA9plFU8s1lqeM941lqCR5P+WeuIV7t3boHjrGqFibYyeDB0isYkq25/ASlNsKNV31PCPt3SbaY/0DXEua4iWzzlGhesLZTj9t7CzdxBRQVojE9qf7doydRX/PzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786390698; c=relaxed/simple;
	bh=DLr2PPQkbJQXG+dZdaa26Ptd1GfyhpzGHWQLIyR/PFg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XXYvR0Upu2kVxaiIBH3DGWplRmRRuX2IS7O35MF77EXxjiG0zF2d6Tw/ruaK/aW2Y4TDWP3e7erxdtUM3DWLOpPbzrsj6gYByj/UdwtDhY/hKr/zKHb7VbRSgXaB1Mtp6Gq6mUC38jO4aShYHcdpimdvVBhWM2amSxOeru3LeLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=twied@gmx.net header.b=Gp+ik1oq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=twied@gmx.net header.b="Gp+ik1oq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1786390693; x=1786995493; i=twied@gmx.net;
	bh=DLr2PPQkbJQXG+dZdaa26Ptd1GfyhpzGHWQLIyR/PFg=;
	h=X-UI-Sender-Class:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Gp+ik1oq0hmtzG18Cg0BbAwjhklo9eayCFnr2Gcuym+50XoOXUEFaBCGmdQ8Eaw7
	 rZtFwHHEbbCYHI5W55twBEObpffJ8IZScD31Twlp7Nw3ij6GnYfM6Ne1tLO0cbgOT
	 xDIkwUsBy9vFZVTzp+J7YIUZ4uL4qrpImjw0IKCSCqJ0JRZ4xvAadnSTX7EGgShFu
	 ZI2apjeMsXLLvRViz4Y+LcKsuMRmps0nDmN95xVPvfLsxuM42G3B5NI98CJ02hK56
	 XDGKWFM+N0VgGw17hFZ57EB25dq0hyfm2bzbloj6YAcMnqCvb3CnZiOYTx0Fo8SAz
	 fUpHqcz+nBfn575TgA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MYNNo-1wODag3TGs-00Sx91; Mon, 10
 Aug 2026 21:38:12 +0200
Message-ID: <ba558d0c5e08190b4a130efe43b5644c8c0bd571.camel@gmx.net>
Subject: Re: [PATCH] gitk: add user-defined custom commands
From: Tim Wiederhake <twied@gmx.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org, Tim Wiederhake via GitGitGadget
	 <gitgitgadget@gmail.com>
Date: Mon, 10 Aug 2026 21:38:12 +0200
In-Reply-To: <00ed1592-b2cf-4844-8174-fb087fe0b0fe@kdbg.org>
References: <pull.2371.git.git.1785879839766.gitgitgadget@gmail.com>
	 <82e59e71-5cb0-4a7f-9fc1-e66b367670f0@kdbg.org>
	 <76636876b815ac4aaac77eb7b772e2e55234e11a.camel@gmx.net>
	 <00ed1592-b2cf-4844-8174-fb087fe0b0fe@kdbg.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Provags-ID: V03:K1:UJn98mVK8I0wmCRpmUV5LQW5U7/Yh+cMFhZbJtaRdI4HuIaXV7y
 CqQQqupVD5R3riJyRS229E1SfiytB5YrtTwzP6ab+SDhG72dl0to8xYD0XEKQOltVxRqotS
 Flv5sPB3lXe1NSvLfVBJgF4S+owm52iiLE490skGphFbG/KLAl9t5Tb7EVKDnJiLQwgXppN
 Urhnv1z+BLzUK6lvE53VQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:BjzCRTgZq/I=;LQWdKSdtjPtOaKNhk2sdpG+iRH5
 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
 0f9rxGQ+8gSqs2WVC/pLLRQiw==

On Sun, 2026-08-09 at 10:33 +0200, Johannes Sixt wrote:
> Am 07.08.26 um 23:39 schrieb Tim Wiederhake:
> > If I had proposed a patch to this effect, I am sure it would have
> > been
> > nack'd as too niche, wrong tool, or any other reason. But having
> > the
> > possibility to define custom commands allows users to adapt gitk to
> > their workflow instead of the other way round. I am very open to
> > suggestions on how to put this in the commit message without
> > resorting
> > to (contrieved) examples.
>=20
> The reason why you were unable to sell the change better is that your
> change is a large set of features in a single commit. If you started
> small, it would be much easier to get off the ground.
>=20
> For example, start with "I notice in the diff that a change is not
> quite
> right. Let me start an editor with the file loaded." That is a
> feature I
> can understand is useful.
>=20
> Next, let the editor start with the cursor at a particular line!
> That's
> quite useful, too, but need not be part of the first step.
>=20
> Then proceed to a use-case that needs to call `git rebase`.
>=20
> But when it comes to author, committer, dates, or blame information
> as
> potential substitutions, you will have a much harder time to argue
> that
> they are useful. Move these features in their own patch. If you do
> have
> a use-case, mention it.
>=20
> The gist of it is: make this a patch series that starts small and
> works
> its way forward with additional features in new commits. Don't add
> features just "because we can".
>=20
> > Regarding the use about AI: I used Claude to produce the initial
> > implementation. I do not write Tcl, and frankly, this patch has not
> > changed that. I have reworked the code - using Claude - until it
> > was
> > effectively the Tcl version of code I would have written myself in
> > Python or C or any other language that I actually understand. Does
> > that
> > pass the bar?
>=20
> I am not 100% sure. I take it that you understand what the added Tcl
> code does (that should not bee too difficult even if this is your
> first
> time doing Tcl). However, the Git project's guideline says:
>=20
> > It=E2=80=99s not yet clear that this can be legally satisfied when=20
> > submitting significant amount of content that has been generated by
> > AI tools.
> So,... Any advice from the Git community would be appreciated.
>=20
> -- Hannes

Thanks for the continued feedback.

I think there may be a misunderstanding about what this patch does. I
am not proposing "add an edit-file button to gitk." I am proposing "let
users add their own commands to the context menus." The rebase+edit
workflow was an example of what becomes possible. It is not the feature
itself.

The incremental approach you suggest (first add an editor launch, then
line numbers, then rebase support) would make sense if I were proposing
a specific built-in workflow. But I am proposing a generic mechanism.
Shipping it with only %f but not %i or %t would produce a half-useful
extension system that nobody can actually use, existing only to satisfy
the review process. The individual substitutions are not independent
features; they are parameters of a single feature.

I did give a rationale: enabling users to adapt gitk to their workflow
instead of the other way around. And I did give a concrete example.
"Don't add features just because we can" does not apply here. The
feature has a stated purpose and a demonstrated use case. If the
rationale is unconvincing, I am happy to hear what would be convincing,
but I would rather not have to justify each placeholder individually.

That said, if splitting the patch into smaller pieces makes review
easier, I can do that -- as long as we agree that the goal is the
complete mechanism, not a series of standalone features that each need
to justify their own existence.

Regarding the use of AI: I designed the feature. The UI layout, the
"data model", the substitution mechanism, the execution semantics...
and described it in English in form of a prompt. An AI translated that
description to Tcl. I then reworked the output through multiple
iterations until the code matched what I would have written myself in a
language I'm proficient in. I believe this is a valid use of AI. The
algorithm and design are mine; the language-specific syntax is not, and
I don't think it needs to be. AI guidelines exist to guard against
unreviewed, ununderstood code being dumped into the project (and I very
much agree with that). But that is not what happened here.

Regards,
Tim
