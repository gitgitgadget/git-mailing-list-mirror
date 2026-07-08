Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2074B8DF5
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783533517; cv=none; b=BuW9I2W/SFAYi/0LHCo6EWNjBLlD4jlOP2X9/c8llrDjV5dX7iPS6op95sMeJ8MKzmjvQhwzeV+fN2wEsf0BnZOuQH+62eOmBplTLaxKcNmRyA36iXlfBbF0z+UasXwjj2u7mh3kqVNk74WFsYOeK1+5UlK6rBlgaC+DPsH2Dh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783533517; c=relaxed/simple;
	bh=0ybYi3KSOAtb1jPidZ5uUXXIub0tI1R/yfRyZ134AdU=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=kH/jEkyN3auTpNkdAuys6t/2TZQpceEbmPBBgxJA+u0b926tMd+U3jKy++LE/sGTVqzUe97BtOPaBiIdfsY1w/GUbE/1FzPygfzdwxBpuFD10lUlyd23oDimmeBErC1o3yNW9RreLz5meSmwXaNgg7t3uRpwBgtKYy3vKlAD4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=kXCf8EMe; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="kXCf8EMe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1783533503; x=1784138303;
	i=johannes.schindelin@gmx.de;
	bh=KYMnvkVryL/CBS6xIrkM1gHXBvVAkszyj/fR1Sw/SkA=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kXCf8EMezwHCq8NzTNeyAohp/2YGnWR9uDiqDyhf0JyUhAjq2gc6r0KEFjReIuif
	 c5EPWR/W62cW9/RdAWZKVz4yrj2SxoiG+VWaMwGqElPQlP1IBKdYJByOH7av36w6+
	 Afg8wAzlaLt7zn6QfHcrmWTTPK387vMaypZgM0IYnV3pHgnrPotJMaeFUSFCFSn7t
	 9GNN7G9uay2ZM0wsGAlJgD8gb1Tk4haOFBKT6F1+UeFUNaaTgjPL/x/uOMtI+MzlN
	 J2bHsQ+QRkpFJTfasIxsjfZOe37zmGolpQVMS/ofJd5ByycfZrjyW1O0UFZ+tJNpH
	 uZ2y+RpdcXkDrDzJtg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNsw4-1wSCbX2jua-00LOW3; Wed, 08
 Jul 2026 19:58:23 +0200
Date: Wed, 8 Jul 2026 19:58:24 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Matthias Beyer <mail@beyermatthias.de>
cc: git@vger.kernel.org, neikos@neikos.email
Subject: Re: Programmatically edit the git rebase sequence?
In-Reply-To: <akei64goQf3nFhX4@hikari>
Message-ID: <32e8c83a-69f3-8ef3-8d9c-f9860fda2fbb@gmx.de>
References: <akei64goQf3nFhX4@hikari>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Provags-ID: V03:K1:Wpzk4bQox/EoM/uLpmXnMg0xmtU/Wwc4imOCINrHmEpPid+x8fJ
 8OT1z/DilsSSzLEA2Xx9tBzD/wiYzZMeW9ZO74hWmRDaaRjED+L8++IiBz0j0ekPbk5QmAx
 Uc1XqXOQtUKrS3ZstfqVgp+2/uTS3yswjeoSzX0iC89+iWFBKLVpCG3m0qUGdIJPyztkvkg
 xD6e342oVdfz9yGQ2TOmg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OvQYxpxbXzQ=;vmWSNeh25EMyIs0Yqf9lPrUKuiY
 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
 gwKmOobQj/4dfAYTshbtRJVfrkg=
Content-Transfer-Encoding: quoted-printable

Hi Matthias,

On Fri, 3 Jul 2026, Matthias Beyer wrote:

> in a recent conversation at work, the question of how to
> programmatically edit the git-rebase sequence came up.

The easiest way is probably to have the interactive rebase stop at the top
of the rebase script:

	# insert a `b` (for `break`) before the first line
	GIT_SEQUENCE_EDITOR=3D"sed -i 1ib" git rebase -i ...

(Note that this is GNU sed syntax, with BSD/macOS sed you'll have to get a
bit creative, or write a real script and refer to it via the path.)

Then you can use a script to transform the rebase script before `git
rebase --continue`.

I frequently use this technique with LLMs because they seem to be unable
to control an interactive editor correctly.

> I have a branch that touches a number of files, adds some files and
> removes some files.
> When rebasing, I want to split all commits that touched a certain subset
> of files, for the clearity of the history.
>=20
> I look at the output of
>=20
>     git log master..mybranch --oneline --diff-filter=3DM -- "./subdir/*.=
rs"

Noting that the OIDs in $(git rev-parse --git-path
rebase-merge/git-rebase-todo) are expanded, you could match them via the
OIDs obtained using `rev-list` instead of `log`, to enumerate the OIDs
instead of full commit history, then turning that into some kind of regex.
Something along the lines

	regex=3D$(git rev-list master..mybranch --diff-filter=3DM -- "subdir/*.rs=
" |
		# read all lines, then turn newlines into `\|`
		sed ':1;$b2;N;b1;:2;s/\n/\\|/g')

	GIT_REBASE_TODO=3D"$(git rev-parse --git-path rebase-merge/git-rebase-tod=
o)"
	test -z "$regex" ||
	sed -i "s/^pick \($regex\)/edit \1/" $GIT_REBASE_TODO

This _should_ work, but you'll most likely want to adapt it to your
particular use cases.

Ciao,
Johannes

>=20
> to find all commits in that subdir that only touched the files. All of
> these commits are to be "edit"ed.
>=20
> Now I fire up `git rebase -i master` and manually(!) match the list from
> above `git-log` call and find the respective commits to edit them.
>=20
> Is there a way I am not aware of to do that manual step programatically?
> Something like
>=20
>     git rebase -i master --edit-commits=3D"$(git log master..mybranch --=
diff-filter=3DM --format=3D"%H" -- "./subdir/*.rs")"
>=20
> would be convenient here, although I would understand if that is too
> much clutter for the already very heavy git CLI interface :-)
>=20
> Maybe I am just not aware of the obvious solution - I would be happy to
> learn that there is already one!
>=20
> Best,
> Matthias
>=20
