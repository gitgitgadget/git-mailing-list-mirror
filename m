Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C518F58
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 02:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738203500; cv=none; b=ibyHWxn7lZS86/FUHzkniMfPad4ZVcVUbRB8SGJTM8w21KKm5sVYVyvD+D4O96WDGUu5nY6Qo5V//8nSMwcmdx6PDy3xd6ccLsjWgqmRbET8ebr521w6bAeCRkotsP5kk+23IPbHZJthNO/eQdW9vl50xFCq6budm9heAEmcgtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738203500; c=relaxed/simple;
	bh=tLr+eSq+1RzrG0w9rbROBJb5on+qiqPzClT6F4LYP4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TX4gC4xIgGdc7vj5VgR3TFwpfU0epecdmYhGwL2vefeGLBxE5GzhjzEsGGFz1p+b03Zp/h/tcDtFfZhHeehibzxABjU+7v6kWN9J3PFXblMac8S16rXsiF9o/ibXrAggEgTRwTxdCqkUKl5+lxdfcp3fKHirukjKqQpne4cpVXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=1XV/IT9A; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="1XV/IT9A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1738203489;
	bh=tLr+eSq+1RzrG0w9rbROBJb5on+qiqPzClT6F4LYP4g=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=1XV/IT9A1dZ54GyLXPkkjWgsOxqGpR3rIAfQ2bA8OiT/STv+3izzy0bep6GXSOgso
	 Np45HC+le7SiFyDbz8qK94iM4bYu7Pseny0umqiomLciOVbJuHJukUZEgxxqbytgyJ
	 572zWr8T5vj75CcvgJo3pUl5QYcE+EAIJZ6j0WEyPZqxcBapbpwe1SfV3skP+FEx2X
	 rxfXRPhb7GjFnYiwNu1FxwWcCxKH8bFH90iSxPlTaw1h4ev8uZw+LIJbFbGOmsWKyL
	 nSkHCAvpXgPLQZzmHLqbOM+szvlswMIJmhwumpxkWdSgx6LB2wV+9hUZ8/kZpO8i7J
	 Wjh2qrit4rVreS0lOjV4G0U2suKUbWfgPv0tCYzJ/RJhbtSbRTK4Mtfn7Qwg4ahant
	 1K/ohEfzv9iJ8Oplwc4QuEh7Afa+4bYQH6a1f0baIM3H04JEEGIJvRES5aqALc+7ik
	 54ypNZPE4ch6Qgd/z4neiUAeQx7hxq9fQeqAD2DQA44xyiecZi7
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id D465B20042;
	Thu, 30 Jan 2025 02:18:08 +0000 (UTC)
Date: Thu, 30 Jan 2025 02:18:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Mike Weltevrede <mikeweltevrede@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Feature idea: Git hook for pre-checkout
Message-ID: <Z5rhXrkbhINwFDXT@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Mike Weltevrede <mikeweltevrede@gmail.com>, git@vger.kernel.org
References: <CAAE-bwUQ+0ERbvC=SS=-R_K4H3p2su+=Ogf7BSkyq5J4GmmRYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YEwdjvAX6QhYd0wP"
Content-Disposition: inline
In-Reply-To: <CAAE-bwUQ+0ERbvC=SS=-R_K4H3p2su+=Ogf7BSkyq5J4GmmRYw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--YEwdjvAX6QhYd0wP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-29 at 10:49:15, Mike Weltevrede wrote:
> Good morning,
>=20
> I had an idea for a feature in Git. I am not sure if this is the
> correct channel, but I could not find anything else. If not, could you
> please let me know the best way to submit this?

This is the appropriate place to make feature requests.

> Below, I will explain the idea and then the problem that this would solve.
>=20
> <The idea>
> I have a project that is using Git hooks. Besides pre-commit and
> pre-push, I would like to use pre-checkout (rather than the already
> available post-checkout). However, it seems like an active choice not
> to have pre-checkout given the existing hooks, so I am curious as to
> the reason behind this.
>=20
> <The problem>
> I want to do branch name validation when someone does git checkout -b.
> If the branch name does not meet the requirements, the user should not
> be allowed to checkout to it. As such, the post-checkout hook does not
> fully meet my needs. It helps with doing the branch name validation,
> but if it fails, the user is still on the feature branch. As such, if
> they are ignorant about the error message, this does not stop them. I
> am currently combining post-checkout and pre-push but would prefer
> pre-checkout because this would prevent the user from doing work on
> this feature branch and having to move their work.

I don't think this is likely to be adopted.  We intentionally don't
place a lot of restrictions on local actions, since we assume that a
single user owns the repository and works on it, and they may make a
wide variety of local changes that are not pushed elsewhere.

In addition, this change wouldn't really be very effective, since there
are many ways to bypass it (such as `git branch -m` or `git
update-ref`).  All of those ways also make it very easy to rename a
branch as well, which one might well do for non-policy reasons (for
instance, if one made a typo) and thus these approaches are assumed to
be familiar to the reasonably capable user.  It's also possible to use
one name locally and push to another, such as with
`git push origin my-feature:refs/features/foo`.

It also sounds like you're trying to implement a policy decision on the
local system, which is the wrong place, as the Git FAQ outlines[0]:

  How do I use hooks to prevent users from making certain changes?

    The only safe place to make these changes is on the remote repository
    (i.e., the Git server), usually in the `pre-receive` hook or in a
    continuous integration (CI) system.  These are the locations in which
    policy can be enforced effectively.

    It's common to try to use `pre-commit` hooks (or, for commit messages,
    `commit-msg` hooks) to check these things, which is great if you're
    working as a solo developer and want the tooling to help you.
    However, using hooks on a developer machine is not effective as a
    policy control because a user can bypass these hooks with
    `--no-verify` without being noticed (among various other ways). Git
    assumes that the user is in control of their local repositories and
    doesn't try to prevent this or tattle on the user.

    In addition, some advanced users find `pre-commit` hooks to be an
    impediment to workflows that use temporary commits to stage work in
    progress or that create fixup commits, so it's better to push these
    kinds of checks to the server anyway.

While the FAQ mentions `pre-commit` hooks, all of this applies to other
hooks as well.  The difference between the `pre-commit` hook and your
proposed `pre-checkout` hook is that the former is generally useful for
users outside of a restricted policy environment (e.g., for local
development only), whereas the `pre-checkout` hook doesn't appear to be.

Of course, others may have different views, and it's possible that
Junio might accept a patch to add such a hook if someone sent one.  I'm
happy to defer to his judgement in this case.

[0] https://git-scm.com/docs/gitfaq#restrict-with-hooks
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--YEwdjvAX6QhYd0wP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5rhXQAKCRB8DEliiIei
gfgmAP90P57Nt06O8Ee3axmIMu2Mi/fMZOS8QBapGzCLPuBquwEA0yH8ew9l1HIG
sabQTgkHUhoMFrX+9Vcl5Ee9Rt8e9AY=
=zARq
-----END PGP SIGNATURE-----

--YEwdjvAX6QhYd0wP--
