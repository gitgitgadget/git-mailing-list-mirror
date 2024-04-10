Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38DF6159560
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712740472; cv=none; b=ZPopH5xuMDxoz+m70kRrAf6W30RbEnYVBgix+kEVengXAAcD4thWlawOrzGkyCa48Un3+8A0HLgRLH/RqdP9oO3M7bVakcZnKAInXfsO4ND1cLFx6267L8G37DayzJ7M8vyZh0D64nEcrsUYSw2Srn7chjLsZXLRP57vKGVnBxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712740472; c=relaxed/simple;
	bh=HO6jjXYN8MHMBc54/cfA+ogylBbCg+qwDONOmKwHuu8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0aL07nQGnpcqgm5zcXuZz8fuUvM/hbA45SgcZ5oQ3GdTitAtByQ9XsACOLrMnTvie3L6xv7c/x7UO09nbtAGWSvFOm3aLxPWm+BcTr0b+N9o9DffjyjqCQQYm0rmvCzSK7cFt4OyL36coib9pSwclZ86Yt+YAHZEmwVUg0ZHdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=Xr+7+95D; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="Xr+7+95D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712740463; x=1712999663;
	bh=HO6jjXYN8MHMBc54/cfA+ogylBbCg+qwDONOmKwHuu8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Xr+7+95DYpZNKXdspWU27uhl1oUAUsxZ0Cdm+mPkgPZwqD59gQwefBLmb+rH6rEng
	 AExYsIaFkRHY/BLtLK/nX6MYcZrON51dTt3o3ugTNgT2dJ6V+2Xtl3Ti2XfxgQfOAU
	 MuBi0a0uJSXLfRBjyOdNeyZadZ41y0+fZxC0XTdbYc/TEYfSAtKKWkubVePyMHzw8/
	 /xCsHIGiZD8dCUVfGalx+J2iFRsbK0A96e7VOrjj8fDZaZK+/Vk8vD/ZPUSpdD2inr
	 Dso066mycQCr1nToPjfGUv+rqN752Axk7Q6K87CzcagVI/VbLKvWLtNG++UmAzcVKJ
	 kz+UXKsLmO13A==
Date: Wed, 10 Apr 2024 09:14:16 +0000
To: Chris Torek <chris.torek@gmail.com>
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 1/8] fast-import: tighten path unquoting
Message-ID: <6C467327-0DB1-4E1F-8CB5-23DE45271348@archibald.dev>
In-Reply-To: <CAPx1GvfUs-dR_RbqnBT3YhDJPMB7b=+fzyow8qjJgJQnJwg0Pw@mail.gmail.com>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <e790bdf714bb4c2a67708c016a97cf4f9e79ac48.1711960552.git.thalia@archibald.dev> <ZhYxNYR33ftEfcPk@tanuki> <CAPx1GvfgC46n_5fk3dHxg7dn393UVMi0CtHKqQ_GAaqnV_ECCQ@mail.gmail.com> <784B5318-F155-4D93-8085-62ACA63432E5@archibald.dev> <CAPx1GvfUs-dR_RbqnBT3YhDJPMB7b=+fzyow8qjJgJQnJwg0Pw@mail.gmail.com>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Apr 10, 2024, at 01:51, Chris Torek <chris.torek@gmail.com> wrote:
> On Wed, Apr 10, 2024 at 1:47=E2=80=AFAM Thalia Archibald <thalia@archibal=
d.dev> wrote:
>> strchrnul does what I want here and I=E2=80=99ve replaced it with that.
>=20
> `strchrnul` is a GNU extension (found on a lot of systems, but not
> part of C90 or C99).

I can=E2=80=99t speak to Git standards, but it seems broadly used in Git, i=
ncluding
three times already in fast-import:

$ rg --count-matches --sort=3Dpath strchrnul
add-patch.c:1
advice.c:1
apply.c:2
archive.c:1
attr.c:1
builtin/am.c:1
builtin/fast-export.c:5
builtin/fast-import.c:4
builtin/stash.c:1
cache-tree.c:2
commit.c:5
compat/mingw.c:1
compat/terminal.c:1
config.c:1
diff.c:1
fmt-merge-msg.c:2
fsck.c:2
git-compat-util.h:3
git.c:1
gpg-interface.c:8
graph.c:1
help.c:1
http.c:2
ident.c:2
log-tree.c:1
mailmap.c:1
match-trees.c:1
notes.c:1
object-file.c:2
parse-options.c:2
path.c:1
pretty.c:2
ref-filter.c:5
refs/debug.c:1
remote-curl.c:1
remote.c:1
run-command.c:1
scalar.c:1
sequencer.c:5
strbuf.c:1
trailer.c:1
transport-helper.c:1
utf8.c:1
ws.c:1
wt-status.c:1

Thalia
