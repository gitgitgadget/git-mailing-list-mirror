Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB29283C82
	for <git@vger.kernel.org>; Sat, 13 Jun 2026 21:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387624; cv=none; b=FSS6NYMCgKual+mgwdygUv6D+Nj9YL0RA+vogj4aC9PSoos76J1Cuc2D/racyGRlUYyeaPJGb9hiOwa58JSEDmO046R/I6Qn+LlGMSInFuugONTLXlJZrLNy7iGxZnEhNXeIfBdqItMXZxVIMyodGbQmekyWy8WFGG3Pp1YFgIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387624; c=relaxed/simple;
	bh=XoxtJw2QNa9220adrKUWneyhVLvFewlOI4K8q5y/Xf0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFww1Ib+sX4MyIm5d1pz8dGI6NbHArmF1s06FpKh4F3nhhsm6sXhbBi/m5LS9I3hTaMbC4Bc3nRsu3LWF01ODjBR880sc6/VEFZrgnY1DCh/z14QRpNkjsD3WN2noxxiCnYtQ6n/YkecLkSwzdc8aBx4bHevlxdzn0g3mqG8RkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=u7yONSWR; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="u7yONSWR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1781387615;
	bh=XoxtJw2QNa9220adrKUWneyhVLvFewlOI4K8q5y/Xf0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=u7yONSWR7ejraEtWF29BVQNSqC8JtI1NvVMsbOR7hmTWVbNrh6ALQZfqvc5wTYEVV
	 7aNFv5KNlCHNlvtau8sOn+L+0NzAbHljvfJ/cCwLA2sgw54PAjXBbDCE9xLremdRJG
	 P4JRzfyVdHC6FIVdovsNzfhmbW0zwsDHVJ2cWkyK2OO/6FTzucj8/UT7XkXL7nWbtA
	 1v6kkMfy/imk53fAMiOFvhrmoWx32n2pKuGKmH8Y/JTrPoPPZzxwpnHXFUMlGo0lY7
	 2A+Qs/eK+XS9CWGIsYLfsQQPBTISFelAp4juS5FDHwAKNyKTIUfAV09iAXV7kLkkl4
	 9GXt2JK7+wFLWKnflIFVxp5TuPyJ0wLCLNajVsxoP+D1lAeua73Hq5ltp8whH51q0A
	 youf2re61ulNWjtfTYlxf2p2R2gj7fRPP6oZ2wU8lTKh6C15ruEc7IqpVwF1UfDU5a
	 hSyWQ5oBze/ducETuCZhmD3Juig0zCpzUgFeW2ONgj74mu0QbNA
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:3c09:7eb3:49a1:129f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 2D8272018E;
	Sat, 13 Jun 2026 21:53:35 +0000 (UTC)
Date: Sat, 13 Jun 2026 21:53:33 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jamison Phillips <JamisonCPhillips@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [RFC/PATCH] Suggestion: Safe Hook Verification for
 Unzipped/Local Repositories
Message-ID: <ai3RXeTeTNmFfUuL@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jamison Phillips <JamisonCPhillips@gmail.com>, git@vger.kernel.org
References: <CA+pATbgyg3Wqg7NnScPx3hUmo8nG23EFx2QUXuVAd3nJ6Z_CPw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oDXAv4YmWMtiCJLl"
Content-Disposition: inline
In-Reply-To: <CA+pATbgyg3Wqg7NnScPx3hUmo8nG23EFx2QUXuVAd3nJ6Z_CPw@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)


--oDXAv4YmWMtiCJLl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-06-13 at 21:20:43, Jamison Phillips wrote:
> Hello Git Community,

Hey,

> THE PROBLEM:
> When a user clones a repository, Git safely excludes the '.git/hooks'
> directory. However, if a developer downloads a project as a ZIP
> archive from an untrusted third party and extracts it, the archive can
> contain a fully formed '.git/hooks' directory populated with
> malicious, executable scripts.
>=20
> The moment the developer runs a standard command like 'git checkout'
> or 'git status' inside this unzipped folder, the hooks execute
> immediately without user consent or awareness. This is an active
> vector for supply-chain malware insertion on developer workstations.

Git's security model does not allow working with untrusted working
trees, period.  The only things we guarantee are safe to do with an
untrusted repository are clone and fetch from it.

I'll also note that there are a variety of other methods that one can
use to execute arbitrary code with an untrusted working tree due to
unsafe configuration options.  For example, one can set
`filter.<driver>.clean` and `filter.<driver>.smudge` and execute
arbitrary code with a crafted repository.  This is why we don't let
people include config (or hooks) as part of the repository.

My concern is that we'd be misleading people that this was a safe way to
work by adopting your proposal when that is not true.  We would then be
deluged by a whole host of invalid security reports.

Would you like to maybe share a little bit about why you (or others) are
distributing repositories as ZIP files instead of using the standard
protocol methods?  Perhaps we can offer some thoughtful comments about
how to achieve the intended goals with a better security posture.

> PROPOSED FEATURE:
> I suggest implementing a "Safe Hook Verification" mechanism with the
> following logic:
>=20
> 1. First-Time Intercept: If Git detects executable scripts inside
> '.git/hooks' on a repository that does not have an explicit local
> clearance, it should halt execution and prompt the user: "Warning:
> This repository contains local hooks that have not been approved. Run
> them? (y/N)".

How would this work in a non-interactive situation?  If I install Git
LFS, it installs hooks when its filter process is installed for the
first time.  So if I then clone a repository using Git LFS in a CI job
or a container build process, the hooks won't work and my repository may
end up broken.

Note that the Unix philosophy does not have tools prompt users by
default.  If I say `rm -fr ~`, then my home directory gets blown away
because that is what I asked for, even if that may have been improvident
and imprudent; no prompt is expected.

> 2. Out-of-Directory Verification State: If the user approves ('y'),
> Git should log this approval by saving a unique cryptographic hash of
> the approved hooks to a global state directory outside of the
> repository's working tree (e.g., inside
> ~/.config/git/approved_hooks/).

This is almost certainly going to grow indefinitely.  I've been copying
my entire home directory from machine to machine as I get a new one for
19 years and I fully imagine that this would have grown quite a bit in
that time.

Another thing I think is worth noting is that just because I think a
hook is safe in one context does not mean I think it's safe in another.
A post-checkout hook that runs a particular command (say, `bin/setup`)
=66rom the repository might be safe on my dotfiles (which I exclusively
control and maintain), but an identical hook on a repository from Bob's
Malware Emporium would probably not be a good idea.  Reusing safe code
to do unsafe things has long been a favourite approach of attackers.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--oDXAv4YmWMtiCJLl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmot0V0JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZymB7+7kp9+dJCzl0YJ/QgdZ9/XkY27RBfQeubgPkwb4
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAPA8AP9I5lzqFK8iHlaiBaiDmZf66GY1
TH+K0OPC6ZCqGo3oTAD7B1r+DOEWMoT3+Wumeir9rR8J5DAqVL4QR/HWOPC/hgc=
=3zMU
-----END PGP SIGNATURE-----

--oDXAv4YmWMtiCJLl--
