Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB4B132103
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 19:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731354964; cv=none; b=UtnqHejI6fchnh+z7pHtCEJ7raMcAAvfIqUOtAorCn33Q1Nafs/oflBw0uoRQUfHuOwCoedQgOOGYuqAfWObjWwbWNt7fUQdXA4g1l91VhJX3Y+pCI+U11MVn4NnqVqJ4bIbnI9pfHNnXwSPwQpR4WiNUS3bJXhgXJVJuUr0+v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731354964; c=relaxed/simple;
	bh=fhNz4tofzBTxDfVdxTivpJiWoc+9JhP2vUw0xEhh65Q=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=P2RE/yTMTSFAzdWFrsgH/oS49Yo3cMSmHPcc2uk+35YlU/nFSOLRM7uf0VrbpNLZgeAIMsGs4lxmLP5K/FCADluVei7m6ks6UYbwaJvIAVVHh47Za4pmawz7Z3UtecdOLNErhhvl7II0UVf6IE0OCDJAmorSe4aZF8EmAmldxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=d37LEUJZ; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="d37LEUJZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731354957; x=1731959757;
	i=johannes.schindelin@gmx.de;
	bh=4GxCGSCMlRW3Fj+jU/MrwS9K3h0PD2xJiftQvgyxZPc=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=d37LEUJZ3m0SP6XEBPGP05c/tswH4z8o/60a9CF2jyng8w3ZjPWlkh5kbUX0rUjB
	 9bmAkJK12opgVBuioN50frDm4+8Gb2KML7ccLcGoX3rhuW2dtqz3h9QTIQEPYtkU8
	 dYwF7nukTZjfUHibf+p6KnUcxINu0p/V/EjMx1MFy8d5LegMZi9ixMgkkFCD2mw37
	 /90x9oytNB5momWqP6oB67NdjMe2rJGwzv6QWuljJBtHEfP71dKPzwK+eTl9voxw4
	 7S7rDyw8c/2VzrVio+zJveG8HQLTR7PAXx83+uQ4nu2pLMePYNj315V2snSXfkMP/
	 ydwoteA8PuPmQnVqng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.65]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mv31c-1u1SBR1kfY-014Pr1; Mon, 11
 Nov 2024 20:55:57 +0100
Date: Mon, 11 Nov 2024 20:55:56 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Elijah Newren <newren@gmail.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>, 
    Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs
 in the analysis
In-Reply-To: <CABPp-BGeSwDHNeDdEwf+mo5q33GO3f0UiFpVOpjiLF3msEvrfg@mail.gmail.com>
Message-ID: <c7c71d10-5795-6c93-6ff4-1effc534c6a0@gmx.de>
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com> <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com> <CABPp-BGeSwDHNeDdEwf+mo5q33GO3f0UiFpVOpjiLF3msEvrfg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-430442179-1731354957=:108"
X-Provags-ID: V03:K1:YX2YkfOmvenfaUd37Kf1llXY9XrpQpubNA2IwgfhRTjrVGh7fYZ
 +gXxrr8vm/i3r/+FO7yMRap3JpPE7G3bX4/fK0umahVWkaLu38prhfIMZMWqWyeJahXjanX
 AKc/btby6ibG5QxO2YBxpUtzGDu2RbMp+8V1XVpMWV0FlFJb86SBhLyN5kXiuvCy6IGR22x
 GLrYPLiUj/WQTInywos/w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VpawYAt7RL0=;9cuG22iZZbfvjYWHjT9hYTpDxJo
 3+DkRxoN2QUomDBOWNUHK73RsfSLZGvKIccaNuAlDjq959i3WzC1ClGRjg8wodMSDkhkpch7h
 xyZ99GCZml85INMEdqAqaUUQu9bXNXFonq2gKbTmAQtOz/yjcT3i/hJeuSijCJpsSZulNHFaG
 5Wy/HW6LzA8Nrjnk/fLSHCA7joX9OwRNYtYz5g7bk4wMJAOtMOtb2wG4PWJijIGwe1Pdsw/DW
 yujSauiX72bD4AOYS1FwndTK58KbqKEuIjYxCY6mBWOcwuCZZHSyhY+s8UIo1BPn83XTw5JJR
 M6L44cm2WvQgz0Q/OaTtqNziWA1qYX1oG/VR7I7cOKFlpAqeQAHHSUw/qtJBQemo/OqVJ+nls
 6WdNkXih8EDcaa+MSznT9UdK/l6hGAD9tzwsZhHUXIRC1F7007E2cMKgZicgutuU1Q1rd2Zm/
 uubw0XsIjoWSTyD6oypwi4ly80RGZGb5p1t/soT1Qfl2q5WI7q0/0nnshfOifKeMbr/Ubm7oV
 vKdBW6+1gioXVAvaKghXfnSAffeWe7Xkb+PBdjwPWv+e1l9d74EqeEad9/7o53xFW7ISh6fbz
 gKp2tagOjj9mjpByyXgG32742QjaA54edKaNSTK30ex281arZycn+11ohXPBxlVZ5FsRb3Tg1
 SfkAcnMaIh1udFZhbouGg2R7W/0BzPmod4GxWkohjLtO4j9miqROkbrJZzMOLtWMMTCXH7OLd
 6BeXN85HFH/WYFhZUS58mZzgiRW8ufKSHw0zDcrVVe6aNu+QR1+HSNrh0ekrxT6fZZgoZ00yT
 GBPf0RDfVzGHHKogdhi5tRoQ==

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-430442179-1731354957=:108
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Elijah,

On Fri, 8 Nov 2024, Elijah Newren wrote:

> On Fri, Nov 8, 2024 at 5:43=E2=80=AFAM Johannes Schindelin via GitGitGad=
get
> <gitgitgadget@gmail.com> wrote:
> >
> > diff --git a/Documentation/git-range-diff.txt b/Documentation/git-rang=
e-diff.txt
> > index fbdbe0befeb..17a85957877 100644
> > --- a/Documentation/git-range-diff.txt
> > +++ b/Documentation/git-range-diff.txt
> > @@ -81,6 +81,15 @@ to revert to color all lines according to the outer=
 diff markers
> >         Suppress commits that are missing from the second specified ra=
nge
> >         (or the "right range" when using the `<rev1>...<rev2>` format)=
.
> >
> > +--diff-merges=3D<format>::
> > +       Instead of ignoring merge commits, generate diffs for them usi=
ng the
> > +       corresponding `--diff-merges=3D<format>` option of linkgit:git=
-log[1],
> > +       and include them in the comparison.
> > ++
> > +Note: In the common case, the `first-parent` mode will be the most na=
tural one
> > +to use,
>
> I think we need more wording around "common case"; I believe this
> "common case" is when you are diffing against a merely transplanted
> series of commits (a series created by rebasing without inserting,
> removing, or minimally modifying those commits in the process) that
> `first-parent` makes sense.  And it only makes sense in that case.

I tried to reproduce some of the common cases (which were more along the
lines of stacked PRs than transplanted series of commits), and you're
right: with the remerge bug fix, the range-diffs are much more easily
interpreted.

For example, I had to squash in a few fixes in
https://github.com/git/git-scm.com/pull/1915, and I try to combine all of
my currently-open git-scm.com PRs into the `gh-pages` branch in my fork.

With `--diff-merges=3D1`, all of those single-commit merges that update th=
e
various translations of the book had diffs identical to the diffs of the
commits they merged. Which confused range-diff quite a bit, often picking
a non-merge as matching a merge (which is of course suboptimal).

With `--diff-merges=3Dremerge`, these trivial merges had no diffs at all,
which made the review much easier.

> I think `remerge-diff` generally makes sense here, both in the cases
> when `first-parent` makes sense and when `first-parent` does not.  It
> could be improved by suppressing the inclusion of short commit ids
> (and maybe also commit messages) in the labels of conflict markers.  I
> suspect that issue might make `remerge-diff` less useful than
> `first-parent` in simple common cases currently, but I think it's the
> right thing to build upon for what you are trying to view.

Interesting idea about the suppressed commit IDs. I'll play with that.

Ciao,
Johannes

--8323328-430442179-1731354957=:108--
