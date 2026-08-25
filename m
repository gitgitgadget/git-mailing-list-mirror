Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24193E5A1F
	for <git@vger.kernel.org>; Tue, 25 Aug 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787693082; cv=none; b=grIC5VJcq1X0fZ9dVITX6INX96Td38e6j32UHf3U5+bMcFi+O3bQP0/SgS4o1BVzEq0YkoRdQqTuHVOlh3AIFmHYvZNjOLIYcRMs8AFEDp9e1XM+CxKu7F1sgpx4Mvj5NracLf+lvP3QQU8dZNIfHwouhHSyO0VRBXgGyDN/KZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787693082; c=relaxed/simple;
	bh=f1EoCmN3q1voZehglMsJIdTz2XGprzWrHLlEPAO6wDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NA94+Ut8LNvtbEiVnn0DVchtHh/I0PUS762JpeSKS7fkS2+bEDzXgK2THF3Cd9uMTOi7ORYnrPEGujdLq1+BlG+1v3luGEIbdUaybyiOZziTd74/PjABtduViJ1lxPRW6u3J8RalHMTMjtp+MItjQyguxKvmmKk7RjoIfGpUqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ZL1rb3E5; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ZL1rb3E5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787693072;
	bh=f1EoCmN3q1voZehglMsJIdTz2XGprzWrHLlEPAO6wDM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ZL1rb3E5u/qYwgHH5M+4CjZBgF0WUxtxSgltwNnyQFcSp0IR/0m1y8zAPPXI7KK45
	 HcdWTR0zEVGeQwtWsC61FICLDXuEJuFOrAuLaP/KWaIkKCBbvZ3qQrN0iePdpGx0WV
	 EvOJigF2MIYK0sq3Efa/ILfUcDrz7D8mstDHtCwEuPaSEmpW10TAeLIWZLcJwUSIRB
	 WKgncMoIyJYq4wR0CC35T1VT/nyOGUYcXI2lrIP+spbajJ8OCMpEWWd58LXSq6wLLA
	 N0cgEVlMwiFg9Il6Vqk4mWdSByQL6qApM5cCrgS4CrtLizJRUscYtT+oLN99guQD6R
	 yCM36fjuKWeLct8FtlpDUhzt10Y+PijoGOc6ND2TmI7XhUTIq2fhnNTXk7o2blgE4F
	 ZXTU9GN88/PLK0oKHkMgQBjOZnrXluhrExtdNrPpnrEBze8NB5CizchIY2NTxIDYMg
	 mX0j+OfD6zAhkBKh3TAfMfTDGsyhGEEKoWr1O2vXb/4K7MUYDIJ
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:23b3:441d:199e:9561])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 0798F20101;
	Tue, 25 Aug 2026 21:24:32 +0000 (UTC)
Date: Tue, 25 Aug 2026 21:24:30 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Andrew Pleeter <andrewpleeter@gmail.com>
Subject: Re: [PATCH] builtin/whoami: add new 'whoami' command
Message-ID: <ao4IDZMbgvTTYksS@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrew Pleeter via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Andrew Pleeter <andrewpleeter@gmail.com>
References: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R3eA2LyeTV5wwr+G"
Content-Disposition: inline
In-Reply-To: <pull.2388.git.git.1787690802942.gitgitgadget@gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--R3eA2LyeTV5wwr+G
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-25 at 20:46:42, Andrew Pleeter via GitGitGadget wrote:
> From: anpl1623 <andrewpleeter@gmail.com>

You will probably want this to match your real name since you're using
it in the email.  We prefer that people use their real names, but don't
require it, but I assume that it's not a problem since you just CC'd
yourself using it (and it's also in your email address).

> Add a builtin 'whoami' command to inspect and display the resolved
> author and committer identity along with the commit signing
> configuration (GPG/SSH key ID and commit.gpgsign status) used when
> creating Git commits.
>=20
> Support optional flags (--author, --committer, --name, --email,
> --signing-key, and --verbose) for targeted querying and scripting.

I suspect users will want a way to get _all_ of the output in a
machine-readable way, so you'd probably want to provide some method of
doing that.  Note that because your existing endpoints provide
translated strings, they are not suitable for this.  That doesn't mean
that they should not be translated (because they should) but we'd
probably want a format like the following:

user.author.name=3DA U Thor
user.author.email=3Dauthor@example.com

Other formats are possible, though.

Possibly a `-z` option for NUL-terminated instead of LF-terminated
output might be warranted as well unless we're certain that our output
will never contain a newline (hint: config options can).

> Include documentation in Documentation/git-whoami.adoc and regression
> tests in t/t0015-whoami.sh.
>=20
> Signed-off-by: anpl1623 <andrewpleeter@gmail.com>

Again, you'll want to sign this off with your real name.

>     MOTIVATION
>    =20
>     Users often work across multiple environments, profiles, or repositor=
ies
>     with different global/local configs and signing keys. Currently,
>     verifying what identity and signing key will be attached to a new com=
mit
>     requires checking several individual git config and git var settings.
>     git whoami provides a simple, direct porcelain command to verify this=
 in
>     one step.

I think this should go in the commit message.  I thought to myself,
"Well, there are already ways to get this information, so why add a new
one?"  Telling us why your patch is compelling and solves an important
purpose is appropriate for the commit message.

I might also like to see an explanation as to why this wouldn't work
better in `git var` or elsewhere instead, since much of the information
is already there.  Since that's an alternative you've rejected, tell us
why and sell us on your vision.

> +	repo_config(the_repository, git_default_config, NULL);

Let's not add more uses of `the_repository`.  Use the `repo` argument to
the main function above, taking care to handle the NULL case.

> +	repo_config_get_bool(the_repository, "commit.gpgsign", &gpgsign);
> +	repo_config_get_string(the_repository, "user.signingkey", &signing_key);
> +	repo_config_get_string(the_repository, "gpg.format", &gpg_format);
> +	repo_config_get_string(the_repository, "gpg.ssh.defaultkeycommand", &ss=
h_default_key_cmd);
> +
> +	is_ssh =3D gpg_format && !strcmp(gpg_format, "ssh");
> +
> +	if (signing_key && *signing_key) {
> +		resolved_key =3D xstrdup(signing_key);
> +	} else if (is_ssh) {
> +		if (ssh_default_key_cmd && *ssh_default_key_cmd)
> +			resolved_key =3D get_signing_key_id();
> +	} else if (gpgsign) {
> +		resolved_key =3D get_signing_key_id();
> +	}

Should this also do something useful for X.509 keys?

Overall, I don't have a strong need for this and I'm fine using the
existing functionality.  However, I see how it could be useful and if it
were merged and available in the versions of Git I use, then I might
make use of it.

Perhaps others think this is compelling, though, so I'm interested to
hear other opinions about the utility of the command.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--R3eA2LyeTV5wwr+G
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqOCA4JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ3XCjYHZ1SEbmb2/m8X5+Nri2t6jEjS/K6hRXPdcJYd+
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAOQ4AQDxEJkewuU7FSOzcmdgU56q9jPu
4LSkSNZLTDZWI55FugEAggjJ7muDIeNcfhhIIKJnXvPfaXmRmHMy/vw7Y0f8ngE=
=IVpI
-----END PGP SIGNATURE-----

--R3eA2LyeTV5wwr+G--
