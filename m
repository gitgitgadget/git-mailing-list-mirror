Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [212.27.42.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EF8341AA5
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 20:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755808603; cv=none; b=msEigRgTaIrC+3S7LFps+hNW1HUBt9x5ruPnLbcSe6YW3cFkISv1+VDfxAVaEtYVW7O6OWle8piDddfD+UGnjYb539Af4/88nCB5lrnT0sKrglAVcnyiZmg5X0lsGlaNp6bXUi9oz5mZE6/k7UqRmmPjYL5BhObtmwmSgN/a7GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755808603; c=relaxed/simple;
	bh=rbf/i90KMKyuLx8TSMvA2r/8Zm5dwcKL06Mx8TqXFHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kZJ+NLc3tnnGmXlgE+ZxxZw1bDrL4IsF6JY7kMdmiEG6J4iDlZu/WbVCNnnOpoRGtKzS4njPTlcO8sAgKNlwsZnmsdvi+GPWJ8F6+9bhLY15RboA5+2fHZ5v8SdT8qoXeDxcQ6cMHPMI6q3S8QzduMSrtKGP2Bw4USlkmSgWQIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=XGvaIH7u; arc=none smtp.client-ip=212.27.42.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="XGvaIH7u"
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:a2fe:cac3:5774:9094])
	(Authenticated sender: jn.avila@free.fr)
	by smtp5-g21.free.fr (Postfix) with ESMTPSA id 9855460128;
	Thu, 21 Aug 2025 22:36:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1755808595;
	bh=rbf/i90KMKyuLx8TSMvA2r/8Zm5dwcKL06Mx8TqXFHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XGvaIH7uhlk3NBvYwTIcaTRJUeSve7JGYGZNE4FUCvFMoEjhPFcRQyh2vcIXHPbB1
	 9r9tEzPyi1zzPC8FbzGa+KLJwJjKRDKZomshOQ74g9hDOkbMsbnvU3WbaETI/+6UAe
	 6ACY9080SrBE13dZ43cmZnfamt2718qUSAvTSWjI3GXaHoywLZXdK9HWyFB4CeiBAj
	 uf8ZjLX7xqSihv0snNwZCOIVYoiI2IJs6aYrVW2Sj/o8gJZVwQiMn6h8iWHGysyRMY
	 RzDWimmkbmF+WZwF8ZKUI4QB9k9z0BBmBzioSXr/2r6QqTZFa+HrylT7V1fMx1Hln5
	 StPilFi1jrk7Q==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: Junio C Hamano <gitster@pobox.com>, Julia Evans <julia@jvns.ca>
Cc: Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org,
 Chris Torek <chris.torek@gmail.com>, "D. Ben Knoble" <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 3/4] doc: git-add: make explanation less dry
Date: Thu, 21 Aug 2025 22:36:30 +0200
Message-ID: <2320029.iZASKD2KPV@cayenne>
In-Reply-To: <007dd7bb-352e-4682-8ca2-8256d9a47e07@app.fastmail.com>
References:
 <pull.1952.git.1755029249.gitgitgadget@gmail.com>
 <xmqqsehspdtr.fsf@gitster.g>
 <007dd7bb-352e-4682-8ca2-8256d9a47e07@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, 19 August 2025 14:57:07 CEST Julia Evans wrote:
> > Yes, you can lose your novice status and it is hard to take it back
> > ;-)  I agree with you that the next best thing you can do is to see
> > how well folks who still have that status do.
>=20
> I've returned with some data! I got feedback on the `git-add` man page fr=
om
> 13 Git users. It's a group of pretty experienced users: half of them have=
=20
been
> using Git for 5-10 years, and about half for 10+ years. Even though there=
=20
are
> no "novices" here, they still provided useful feedback about what's=20
confusing.
>=20
> Here's what I took away from the feedback and a summary of the comments.
> First, what I took away:
>=20
> * The term "index" is hard to understand even for very experienced Git=20
users,
>   and even for some users who say that they are extremely comfortable wit=
h=20
Git.
> * The second sentence in the man page is too long and hard to parse.
> * The "(quote your globs before the shell)" phrasing is confusing.
> * I thought mentioning that you can use `git reset` to undo a `git add` w=
as=20
a
>   good idea.
> * Leaving something similar to the existing phrasing around "snapshot" se=
ems
>   fine, nobody in this group was confused, though of course this is a gro=
up
>   of people who already understand how `git add` works.
>=20
> Here's my summary of the comments on the existing man page. I collected t=
hem
> using this little tool I built: https://text-feedback.wizardzines.com/git=
=2Dadd/.
> I'm happy to also figure out how to best share the "raw" comments if folk=
s=20
would
> find that helpful. I've quoted the current man page text for context.
>=20
> > This command updates the index using the current content found in the=20
working
> > tree, to prepare the content staged for the next commit. It typically a=
dds=20
the
> > current content of existing paths as a whole, but with some options it =
can=20
also
> > be used to add content with only part of the changes made to the workin=
g=20
tree
> > files applied, or remove paths that do not exist in the working tree=20
anymore.
>=20
> This was the paragraph with the most "this is confusing" comments. Here a=
re=20
the
> main themes:
>=20
> 1. 7 people (more than half) said that they find the term "index" confusi=
ng.=20
A
>    few example quotes:
>    * "updates the index" sounds like it increments something"
>    * "Is the index not just the content that is staged for commit? Do I a=
s=20
an
> 	 end user need to care about the difference? I've not heard the=20
staged
> 	 content referred to as the index before, even in git command=20
outputs."
> 2. 3 people said the second sentence is too long and hard to parse
> 3. 2 people said that "It *typically* adds the current content of existing
>    paths" is confusing (What's meant by "typically"? When does it not do=
=20
that?
>    is this referring to git add -A?)
>=20
> > The "index" holds a snapshot of the content of the working tree, and it=
 is
> > this snapshot that is taken as the contents of the next commit. Thus af=
ter
> > making any changes to the working tree, and before running the commit
> > command, you must use the add command to add any new or modified
> > files to the index.
>=20
> Nobody said they were confused by this, other than continued confusion=20
around
> the term "index", like:
>=20
> * "Why quotes around "index" here but not when I first encounter the word
>   index?"
> * "I'm guessing index is used through git man pages and staging area is a=
=20
newer
>   way of saying this =F0=9F=A4=94"
> * "Can we just say staging area? I don't think of adding changes to the=20
"index""
>=20

=46or the term index, the glossary-contents.adoc file says:
[[def_index]]index::
	A collection of files with stat information, whose contents are=20
stored
	as objects. The index is a stored version of your
	<<def_working_tree,working tree>>. Truth be told, it can also=20
contain a second, and even
	a third version of a working tree, which are used
	when <<def_merge,merging>>.

"Truth to be told", this definition of the index makes things even muddier =
to=20
me.=20

If I understand correctly the first ages of git, it seems that the index wa=
s a=20
file containing the list of the staged files (deletion included) with their=
=20
stat information and hash, the actual file contents being stored in the cac=
he.=20
So it was like an index for a book, keeping track of the name of changed fi=
les=20
with pointers to the contents of modified ones.




