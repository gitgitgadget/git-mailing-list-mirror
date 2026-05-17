Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988DF2D8DC3
	for <git@vger.kernel.org>; Sun, 17 May 2026 11:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779018102; cv=none; b=GcRX8Zyqsm6UwDs9NwW4J6emvpu7Xg78vrdrwzgO+r46LeVG9mZ3NJsjuaYB+AO0XRJNJlsjYbMbeq76stub/TmSQmnOshNd09pb/A7g/3hj/e84erbe2WoYech4fP9ZY7YmxKEtGLfOlxXWet+LLpVoWYbm4y5QiYfo9yqDrao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779018102; c=relaxed/simple;
	bh=qkJJuI8mqPqdJAkgEREsYm1qonilNZcY7s6AlW+e0cI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=OxMEoKYIqyzX3y8uJpMlGvIQPiaLhcR62MtQJzY+zdvvjobdkClBTqicd3LWLbxldTeYmJ/sVcS5kj3if18yAofdGj83f9UsugKUlhOnZgyC2aP1uLuzOIhO2vzkX9WnPYidIodRLK3AReyTBvKCPr6hnGcdXu6KUYQxM/rSdgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=e8uJuv7o; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="e8uJuv7o"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1779018005; x=1779622805;
	i=johannes.schindelin@gmx.de;
	bh=OVGzf+J2S8jUMtQ4+/0ysAB9oEyDyuKhW3Gt1R/eIjQ=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=e8uJuv7ov87YVrYKwxIUtHH1Wf4iOlBYKzJctTLYUhYFWnN9v1pd6k7MXcQ5k2QZ
	 kMJvSgy+6wdLtoxJXoUpKoQvZPdL45yv3MXIJ++1QreAlNlCyySEC9qE1sT4GNLOh
	 GcPZ1BPpITCcm2HyeJCE16U/owcFIQkFGwF793V3I8lM4wSANCk+aSM356UlBhVh9
	 6dGnYDhkKOyzQ0wpBMx3WCMah1StAvGHArOPDFZMzHtf2fDN5SN7WQraXQP7BQWuN
	 0lI9llWSNTb0nunxp+h87YMt4TLv5VWIT51DkLdCLyydmy2aeo6oCIGWqlLV5B7Vq
	 E+axV9kOp6ZT3b+V1g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MUosN-1wojaO1kZt-00IwOM; Sun, 17
 May 2026 13:40:05 +0200
Date: Sun, 17 May 2026 13:40:03 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Toon Claes <toon@iotcl.com>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH/RFC 4/5] test-tool: add a "historian" subcommand for
 building merge fixtures
In-Reply-To: <87lddooq2t.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Message-ID: <13abccc6-60f7-64ea-db38-e61abb42c159@gmx.de>
References: <pull.2106.git.1778107405.gitgitgadget@gmail.com> <72c486312cde9a9fd2dedb60bc43c5c3e40a0d64.1778107405.git.gitgitgadget@gmail.com> <87lddooq2t.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:fPXsnBMKoTe/DgqWJCMYR4syG1psGGs7HDQxRWsRV4jucjqHwoV
 Ze5MvY0SUJtWECGHohJB++VF6q4MYyOLWe7WvtI+ENAlJ9ifRaIRrV1/H1lyIjfMEZpSKxv
 3SxDn4lSJbubJ1yvZavK76uuR47hMpvtXILjcldQbNtr37fWBd5ygj2xIfT3IKuZiELjz1k
 u5K/7PQq/S6FK1vkyEULQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:DQtB7FG62L0=;vAjspa/Qw8vX+4D5ZCU/0BgDVSJ
 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
 JxCLjA==
Content-Transfer-Encoding: quoted-printable

Hi Toon,

On Tue, 12 May 2026, Toon Claes wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
> > diff --git a/t/helper/test-historian.c b/t/helper/test-historian.c
> > new file mode 100644
> > index 0000000000..2250d420c0
> > --- /dev/null
> > +++ b/t/helper/test-historian.c
> > @@ -0,0 +1,189 @@
> > +/*
> > + * Build a small history out of a tiny declarative input. Used by tes=
ts
> > + * that need specific merge topologies without long sequences of
> > + * plumbing commands or fragile shell helpers.
> > + *
> > + * The historian reads stdin line by line and emits an equivalent
> > + * stream to a `git fast-import` child process. It also allocates mar=
ks
> > + * for named objects so tests can refer to commits and blobs by name.
>=20
> Really appreciate you're introducing this command. I'm actually
> surprised no else did before.

Heh. I am not surprised, though. Given that it is _really_ hard to come up
with a decent Domain-Specific Language to describe commit history for
defining test fixtures (testament to which are your comments below), I was
debating whether to go for range-diff's/libgit2's approach and simply
adding a bare repository or a fast-import script as a fixture. But that
would make the test code even harder to follow! And I did not want to add
to the amount of hard-to-follow test code.

> > + *
> > + * Input directives (one per line, shell-style quoting):
> > + *
> > + *	blob NAME LINE1 LINE2 ...
> > + *	    Each LINE becomes a content line in the blob; lines are
> > + *	    joined with '\n' and the blob ends with a final '\n'. With
> > + *	    no LINEs, the blob is empty.
> > + *
> > + *	commit NAME BRANCH SUBJECT [from=3DPARENT] [merge=3DPARENT]... [PA=
TH=3DBLOB]...
>=20
> I'm not sure how I feel about mixing named arguments (like `from=3DPAREN=
T`) with
> the `PATH=3DBLOB` arguments? Obviously this tool isn't made for anything
> that's even close to production, but still feels strange. How about
> putting a double dash (`--`) before the paths, or using the `PATH:BLOB`
> syntax instead?

Okay, I can see that's a better design. To be honest, I did not really
optimize for unambiguity here, but for precision of defining a test
fixture. As such, I am mostly interested in keeping the definition as
small as possible without losing readability. Changing that `=3D` to a `:`
to disambiguate keeps the same length while clarifying the structure. I
like it!

> > + *	    Creates a commit on refs/heads/BRANCH using the listed
> > + *	    file=3Dblob mappings as the entire tree (no inheritance from
> > + *	    parents). Up to one `from=3D` and any number of `merge=3D`
> > + *	    parents may be given. `from=3D` defaults to the current branch
> > + *	    tip; if BRANCH has no tip yet, the commit becomes a root.
>=20
> At GitLab in our Gitaly suite we have a similar tool as what you're
> introducing here, but there you have to specify the parent(s) for each
> commit and if you want to assign a ref to a commit, you have to be
> explicit about it. So I would replace `from=3D` and `merge=3D` with
> `parent=3D` and allow that to be occur zero or more times (this would al=
so
> allow creating unrelated histories). And remove the mandatory argument
> BRANCH, and instead allow the command to accept a `branch=3D` argument.
>=20
> If we'd take an example from the follow-up commit:
>=20
>         # Setup:
>         #       A (a) --- C (a, h) ----+--- M (a, g, h)
>         #        \                    /
>         #         +-- B (a, g) ------+
>         #
>         # Topic touches `g` only; main touches `h` only. The auto-merge
>         # at M is clean.
>         blob a "shared content"
>         blob g guarded
>         blob h host
>         commit A main "A" a=3Da
>         commit B topic "B (introduces g)" from=3DA a=3Da g=3Dg
>         commit C main "C (introduces h)" a=3Da h=3Dh
>         commit M main "Merge topic" merge=3DB a=3Da g=3Dg h=3Dh
>=20
> I would suggest to rewrite that to:
>=20
>         blob a "shared content"
>         blob g guarded
>         blob h host
>         commit A "A" a:a
>         commit B "B (introduces g)" parent=3DA branch=3Dtopic a:a g:g
>         commit C "C (introduces h)" parent=3DA a:a h:h
>         commit M "Merge topic" parent=3DA parent=3DB ref=3Dmain a:a g:g =
h:h
>=20
> I realize this is less alike to git-fast-import(1), so I'd understand if
> you'd reject this idea.

That makes sense to me!

I'm not interested in keeping the `historian` code as small as possible, I
am interested in reducing the cognitive load required to read and write
those test fixtures. Therefore, the `parent=3D` way is much preferable.

Thank you!
Johannes
