Received: from smtp4-g21.free.fr (smtp4-g21.free.fr [212.27.42.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC831A254E
	for <git@vger.kernel.org>; Sun, 17 Aug 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755455867; cv=none; b=QDuAvIOYO7QCLXdJhYdrU7NEO+gRu85mRdyiOqq6MqfgABvWNYdFSXr5trFc9Rot5LqqV5hQdZwHQgpKpQIh4ZpBCFw0ml5T+B1vX5E0isld8J93k/pj54x0DZPoPBtcDakg+VyAr/B+LC6gBmFP2uESj4f8ruPixP/hyTlQON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755455867; c=relaxed/simple;
	bh=4EJD06KH4wy6FwyBPfrf1niNl1NDQufKI4d8qsRF0nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTGsBl4drmPhdfM0iv2FixlXfkcXZNulSOpPoWad8GbSOilmh/l9yyanZPjpNdBLpCXH1JuWyUIyVD2SJbLOyhDHQmb/pjyUS3V2O1V1nxwJGM+3fkepwfWNgSu7590qih6ddhMMxI5K4Pcgs8N2Yl/7308vbTEfTAIdRk0nS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=HjUVBQKx; arc=none smtp.client-ip=212.27.42.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="HjUVBQKx"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:e7d2:e88f:af07:5d6])
	(Authenticated sender: jn.avila@free.fr)
	by smtp4-g21.free.fr (Postfix) with ESMTPSA id 4C56119F5C2;
	Sun, 17 Aug 2025 20:37:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755455857;
	bh=4EJD06KH4wy6FwyBPfrf1niNl1NDQufKI4d8qsRF0nc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HjUVBQKxABsHagCLKS2PPvB2jlKOv3WGRMNqeU6gjbsfd9w9OSYl2rLv+4lkAIcng
	 1/0vwGkHD0zh6YtqznusvniJnp3ZNnkQ27bW/8dQBQqyUTOddT5zpvxAUzGWf09RuK
	 cmv5NP8FmzhKNxQP15oLhxPz6NaytmA7XRZpsrCixwK/1DaK7wYTw/GV9vr1aQir4h
	 /m8ctL3+vPQ11RiI3yo4Gp9AWU5z/+FQbB8huT9VReC6BE4XeU2GqN2OWzAECqS79A
	 Fs1bFDPcZbugOCADuGB0XB0aOV8cq6cgdcOJ4rWByj1HCq/vD8knt9Bciwb9FQ1802
	 cSZN5xc226CBQ==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 1/4] doc: git-add: start man page with an example
Date: Sun, 17 Aug 2025 20:37:32 +0200
Message-ID: <3896226.kQq0lBPeGt@cayenne>
In-Reply-To: <xmqqqzxcr1ck.fsf@gitster.g>
References:
 <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <5004213.GXAFRqVoOG@cayenne> <xmqqqzxcr1ck.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 15 August 2025 18:33:47 CEST Junio C Hamano wrote:
> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
> > On Friday, 15 August 2025 02:38:45 CEST Junio C Hamano wrote:
> >> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >> ...
> >>=20
> >> > +By default, `git commit` only commits changes that you've added to =
the
> >> > +index.
> >=20
> > I do not understand this addition. I may not be missing knowledge, but=
=20
this
> > behavior is not only "by default", it's the only behavior of git: commi=
ts=20
are
> > made with the content of the index. Let's not make it more complicated=
=20
than it
> > is already.
>=20
> I'll only react to "the only behaviour" part, without "more
> complicated" part.
>=20
> I think Julia is referring to the fact that you can record the state
> that is different from what is in the index (or, what has been
> accumulated in the index by the past use of "git add" command that
> is being discussed here) with "git commit [-i] <pathspec>".  You can
> do
>=20
>     $ edit fileA fileB ;# assume both are tracked
>     $ git add fileA
>     $ git commit fileB
>=20
> and the resulting commit will record the contents for fileA found in
> its parent (i.e. the result of "git add fileA" is not reflected).
> If the last step were
>=20
>     $ git commit -i fileB
>=20
> then the resulting commit will record the contents for both fileA
> you added with the last "git add" on it, and contents for fileB
> found in the working tree at the time of "git commit -i" was run
> (i.e. "git add fileB" was not required)..
>=20
> By default, after the edit of fileA&B and the add of fileA, "git
> commit" would not be aware of what is currently in fileB in the
> working tree, and records the same contents as its parent for all
> paths except for fileA, which would record what was last added with
> "git add" to the index.
>=20

Thanks for the explanation, I had forgotten this form of git commit. For th=
e=20
record, when I teach about add/commit, I never talk about the direct commit=
=20
form, to present things in the most repeatable/unambiguous form.

The `git commit <pathspec>` form may be of use for old-timers who were doin=
g=20
so with previous SCMs. But as stated elsewhere, young newcomers do not have=
 to=20
fight against finger memory. The explanation that you provided describes a=
=20
quite complicated process with options, so this feature seems to be reserve=
d=20
to advanced users.
=20
The manual pages in section 1 are mostly reference stuff for a given comman=
d,=20
and this way of referring here to alternate usage of git commit is a bit of=
f-
topic to me. For how to organize workflows, there are some pages in section=
 7.

My stance is as follow: yes, being complete is important in a reference pie=
ce=20
of documentation, but throwing a "by default" on `git commit` here, without=
=20
further explanation, sends the reader in an unsure state, which is detrimen=
tal=20
to understanding at this early stage of the documentation.

Otherwise, the idea of the simple example as an introduction is a good=20
addition before delving into more formal and comprehensive explanation. The=
=20
only caveat is to not introduce wrong concepts that may need to be reverted=
=20
later.
=20

> >> > For example, if you've edited `file.c` and want to commit your
> >>=20
> >> > +changes, you can run:
> >> Likewise.  "and want to record the resulting contents".
> >>=20
> >> > ...
> >> > -Please see linkgit:git-commit[1] for alternative ways to add conten=
t=20
to a
> >> > -commit.
> >>=20
> >> In the original, this comment does look a bit out of place (as the
> >> text around there does not talk about `git commit`), but as you said
> >> that by default 'git commit' makes an as-is commit above, it may be
> >> a good idea to move this sentence there.  `git commit <pathspec>` is
> >> a handy thing to know even for beginners, and making your next commit
> >> is what the user is working towards by using "git add".
>=20
> And this relates to "more complicated" part of your comment.
>=20
> I think keeping "by default" above and also keeping this comment
> that hints about non-as-is commits made with "git commit <pathspec>"
> is slightly more preferrable than dropping both of them altogether.
> With only four additional lines, we cover basic "edit && add && commit"
> cycle fairly completely.
>=20
> I am also fine to drop the mention of 'git commit' altogether, but
> it feels somewhat incomplete to not talk about commit when teaching
> add.  After all, add is one of the primary ways to prepare for the
> next commit---putting it the other way around, you want to learn add
> primarily because you eventually would want to make a commit.
>=20
> In any case, only having one (i.e. "by default") and dropping the
> other ("see linkgit:git-commit"), like the patch did, did not make
> much sense to me.
>=20
> Thanks.

I'm not for dropping them, but for deferring the mention of this special=20
workflow later in the explanation, with the reference to `git commit`.

BR

Jean-No=C3=ABl



