Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8532339D6FD
	for <git@vger.kernel.org>; Sat,  3 Oct 2026 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791060993; cv=none; b=fSV1kWnZ3+qX7+S7DlC7ODolGXQ/dYHhuWJ2VgBio19ZmMTKYo8ZfQgQQ57xattPo+Jfb9jtcunYUXHzrdfe1MGT5rgrDZMRVkxh672ejL3dIjHa2/WfFxdYKYOg9gh3/KOOEKpgZDubEhAgSPcT5WqPn6eDbPAYyAbcrE8zjuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791060993; c=relaxed/simple;
	bh=SFnoFr6CQci1TE875AJjTqoq7sLAAHZDet+ptF/zX8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbDZmu6IIUSNGVj0r5FoBSs+yquPjw+Kp1L10HrcDJxoWRhp6YjvOGnK0DehqOlb4nOJWaPdFmiR9ZJ3jZ5l1NyYjITC+RZBiY84FjkO1r3uO29iD/C3Xdwp01aL4Hhel/i0JPTdZO84yHjjO0IRQcStzC1YuLL885yZHE8d3AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5ZJN4sJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5ZJN4sJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91D81F0089B;
	Sat,  3 Oct 2026 20:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791060992;
	bh=es+t+HSi/WNe7GjJCkc2VV5+ybmVA36Jh0vPZO71Y+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=k5ZJN4sJmIRUvpNZ6xgZEF0bsJo91Qz+Ym+Rbv6GOIOgCC0MVQiFwhy996kMnMbqO
	 ZxtsYRpNUZpk2WEnKgMfwIlmXOalswq3yN+lYj1aUiwb7YXbOQpeGXDwnfnzMG+HWz
	 VnMSKL6uNTzOk2I7wcFs55/BCSF3JdKvc54iY5gvCJSOMW/Ad4XqVHWin/yWfmYmR8
	 6PYdN6htZJsSEBbMQmufWIybeUKu+ADINJdMghECXSACGwzwl4VKCKPTxAky4kgzUf
	 4cGZsPnKta09W6joo8vUfvNVERhLGLPfrO32O7NgSLzrE28TzbHwaMrJYHHFgGDR7N
	 N738QYNPwHJxg==
Date: Sat, 3 Oct 2026 22:56:25 +0200
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFoq4gnl1caJM2U@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="aibs4zynvymb32ar"
Content-Disposition: inline
In-Reply-To: <asFoDZKscLKqaIf+@ubby>


--aibs4zynvymb32ar
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
From: Alejandro Colomar <alx@kernel.org>
To: Nico Williams <nico@cryptonector.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org, 
	Ben Boeckel <mathstuf@gmail.com>, Viktor Dukhovni <viktor@openssl.org>
Subject: Re: [RFC] git-brebase
Message-ID: <asFoq4gnl1caJM2U@debian>
References: <asFRVdMTpshsazgM@debian>
 <asFoDZKscLKqaIf+@ubby>
MIME-Version: 1.0
In-Reply-To: <asFoDZKscLKqaIf+@ubby>

Hi Nico,

> Date: 2026-10-03 15:39:41-0500
> From: Nico Williams <nico@cryptonector.com>
>
[...]
> > It might be confusing to have these three flags being dependent on
> > another flag, and not being able to use this within a git-bisect(1)
>=20
> IMO that's not a problem at all.  There are a lot of Unix/Linux commands
> that have flags that only make sense when used with other specific
> flags.  So I still like a `--first-conflict` or `--onto-first-conflict`
> option.

Yeah, it could make sense.  I'm not sure, but it could be.

> (I really like `--pre-exec` and `--post-exec`, BTW.)

:)

> > session, unlike other git-rebase(1) operations.  That might call for
> > a new git command.
>=20
> That might still be the case in that this will be such a useful tool
> that it deserves a name.  But also, `git-rebase(1)` should always have
> been this useful, so that argues for this to be either... a new option
> like `--onto-first-conflict`, or even a new default behavior.
>=20
> Does jj have a feature like this?  What do they call it?

No idea.

[...]
> > while test $# -ge 1; do
>=20
> I normally use
>=20
>   while getopts +:<short-options-here> opt; do ...
>=20
> I also have a getopts_long-like function (see my gists) for bash if you
> like.

I think getopts(1) is not usable for git(1)-related scripts, because
getopts(1) interprets '--' as the end of the options, but git(1) uses it
for distinguishing commits from paths.  If anyone shows me how it can be
used, I'd be interested, because I've hit this issue in the past with
other script.

> > [...]
> >=20
> > # Set up the callback script for 'git rebase run'.
> > mktemp \
> > | read -r callback;
>=20
> I like to set a `trap` to remove temp files.

Hmmm, makes sense.  If so, I'll also try to filter out the line that
prints the name of the command, since 'git bisect run' prints it, and we
don't want users to try to open a file that doens't exist.

> > cat >"$callback" <<__EOF__
> > #!/bin/bash
> > ...
> > __EOF__
> > chmod +x "$callback";
>=20
> Here what might be better is to have a command-line option to execute
> this callback without having to write it to a file,

How would you do it?

> and use environment
> variables to pass arguments to it.

The callback doesn't really need any arguments, since 'git bisect run'
won't pass any arguments to it.

> > # Perform the conflicting rebase
> > git switch "$branch";
>=20
> Ah, that came from:
>=20
> > git rev-parse --abbrev-ref HEAD \
> > | read -r branch;
>=20
> which means I can't use this in detached HEAD mode :(

Oh!  I wasn't aware that git-rebase(1) supported detached HEAD mode.

> I work in detached HEAD mode almost exclusively.  I know, that's..
> weird.  But it works for me.

Ouch!  Indeed.  :)
Out of curiosity, are there any interesting reasons for such
self-implied pain?

> Can we avoid forcing the user to be on a
> branch?

I guess I could keep a variable that remembers the state of the HEAD
across all the rebases.  It should be doable.  I'll have a look (maybe
tomorrow).


Have a lovely night!
Alex

> Nico
> --=20

--=20
<https://www.alejandro-colomar.es>

--aibs4zynvymb32ar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEES7Jt9u9GbmlWADAi64mZXMKQwqkFAmrBa/kACgkQ64mZXMKQ
wqkeGBAAm/RBB7bXP/+uWhz4FS67edzgeRcrAuzBAaN4qef++NwjeClMBtqR+q23
83Clvl3fB1m9C+ke9bKHRGcQVZyzlSjJQyxXGecrNYes6YvHuK8vJZ7fu6ijpHxk
+VoEs2pGxh57orh3jOls6s5+MYi0NKaDRB5g0WgSyijHNPa/kthL6+OVxdR8bxYE
XnKwcHWQQPlhaTDasd3fL8fdYo9AnQu0Lcq8K4DuXim79lRB2F5s+0X5kl0U2hNz
5GGqceewclO8YbmzcQlAp/aI90KPqmk56hxiGWo95m7pKIpx9R9o8ExPprh2mic3
9dP2Uv2BI5OHT+vy7UaupirWkLh0+3l8B+kYrtwtGLxlzuOkumjeKL2gOjMu0PdU
TnsHRY9cjPLznyFh8F1ql512YDnYmVQUAL2mU/+LWFvO6e7ik9t6e1ihhvNjDqg8
Kc19ZFVFs9rUA8+Hn1at+Mj87GJ3HOvflQHjvR3CPvlyQcgxkerEg54n62mtLgtI
jig6okDZpobipjuHsSK2dpnDKlcbBbFFl+cz6ZQdMJZhS5nuQBqvi0DCXeyw6KzY
zJmRNlS6GepxccjvHnRQ0yREzb+ChFx0jEhfS1Lk8xVFivmWMP1X+gj04vE+u8Ls
KLFB2pKVF5pT2FAUfZyfoTECTD9kwfzN1uiMXUpwKk19D+eOPMs=
=Bm17
-----END PGP SIGNATURE-----

--aibs4zynvymb32ar--
