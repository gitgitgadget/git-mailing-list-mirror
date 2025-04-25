Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA2721FF2A
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 20:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745611861; cv=none; b=GjE/VxgYv1KnN9LCD7udvDh4vZFy9AgYoE3oUSeMj9yhycPMFqeur+jWujrzni9bcufDAUd+YfGGPufIEDOXWFQ5jg5NN6mRXcvdYJAQKuiTptysdtVWcp7WYb+ohM745muPiM00jLFntC4QYMqbK+jjzcdQmllOYxzL1cqWx1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745611861; c=relaxed/simple;
	bh=yU3IBaTOjWV/mmtmLDlgsqatK1BTPxtkyWdtQvVcFxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmMOidb44CBeuNnR9OMN+Shfo+2O9Jm1tgCujey4Ie9q2WowsSfFnzUkVclag7t7QJU+lcCHk4JaTFTNVBlie1KQfiiFOn/XZunny0oubyq6okLhRsBx0KkNqnlwimsaTpGtjsS1fcPduhziZrH0GjBtIRHt5aWfuQ8kjwEzO4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XqwdVuI2; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XqwdVuI2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1745611856;
	bh=yU3IBaTOjWV/mmtmLDlgsqatK1BTPxtkyWdtQvVcFxQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XqwdVuI24ZIcWN7n4DDVwvXgivW//Yz6GyEE2Me3JxtWmbJx7ImtEZqwCcvrScaxc
	 RZ0G7Pd+0QtRt6TTFFwDJt5SEBfG3q5RYv/vc4ar+M40EdwdPUH/zco4CbZVCZM7pO
	 BKsfP8wl+dCZj+UeWViziJKn+Zd5aKZHIluUgyGzRwSY/olZPzsxc8nOLX5gjTOB1+
	 Je/hRgV+dM6p8NagnUqzrmdMRBXv7SY4NbqH2o5bgzSch9Fi8XTHrDVnu77YIEFG1E
	 h2waThugmmfucGi9+2CMOHxgfvHrtU8sWdWrWAuVOeVg5toChT5BqOF/AdPp9EdUCS
	 kCJ5mjvcVXSkC1N9jgBqRHktnN2sv17sNf2WLUukDtHhkKNjCA2XRG/edHFH7cxmlt
	 BKrloAMDg6UUwypbaG9doUbT43p6f/1UGPlU3oXp7BCXzp/WMtfXL5XI08sWkLHBoq
	 H/c1pd64dU89pIVJmimx/+LP+QZTq7pK81Dogr3uLy+GdeqCnvC
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:d5c6:e1bb:f3a5:7a20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E1BAC2011E;
	Fri, 25 Apr 2025 20:10:56 +0000 (UTC)
Date: Fri, 25 Apr 2025 20:10:55 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v3 2/2] meson: prefer shell at "/bin/sh"
Message-ID: <aAvsT1o6wIGGCEui@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Eli Schwartz <eschwartz@gentoo.org>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	git@vger.kernel.org, Peter Seiderer <ps.report@gmx.net>,
	Justin Tobler <jltobler@gmail.com>
References: <20250425-pks-meson-posix-shell-v3-0-01607a2e9334@pks.im>
 <20250425-pks-meson-posix-shell-v3-2-01607a2e9334@pks.im>
 <xmqqy0votbns.fsf@gitster.g>
 <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="2k412GcU5wLiIvC3"
Content-Disposition: inline
In-Reply-To: <06e57780-9f59-4166-81d3-9cd0c1c66b7e@gentoo.org>
User-Agent: Mutt/2.2.13 (2024-03-09)


--2k412GcU5wLiIvC3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-04-25 at 18:07:18, Eli Schwartz wrote:
> On 4/25/25 1:04 PM, Junio C Hamano wrote:
> > Now I am showing my ignorance, but does this support folks whose
> > shell are not spelled "sh" (like "/usr/local/bin/dash"), and more
> > importantly, if it does not, shouldn't we be using a mechanism that
> > does?  I think -Dsane_tool_path=3D/usr/local/bin would help with the
> > leading directory path, but I suspect that find_program() does not
> > help specifying "dash" to be used as our target_shell (or host
> > shell), or "perl5" as our perl.
> >=20
> > Of course, this "my sh is called dash" can be left totally outside
> > of the topic of these two patches.
>=20
>=20
> POSIX does not require a specific absolute file path for "sh", but it
> does mandate that you have a shell and its name is "sh", whichever
> directory it may be found in.
>=20
> There is (most of the time) not actually a program called "sh". Various
> different programs may provide a symlink "sh", pointing to their own shel=
l:
>=20
> - GNU Bash (bash)
> - Korn Shell (ksh93)
> - Policy-compliant Ordinary Shell (Debian `posh`)
> - Almquist Shell (ash)
> - Debian Almquist Shell (dash)
> - busybox
> - MirBSD Korn Shell (mksh)

All of what you said here is true, but I will point out that AT&T ksh
(ksh93 and also ksh88) doesn't support `local`.  All of the others do,
as do other pdksh derivatives (like OpenBSD's sh and ksh[0]).

I believe on NonStop that `sh` is AT&T ksh, so there is no program or
symlink named `sh` on the system which meets our needs.  The customary
option there is to use bash instead.

Additionally, Debian allows zsh as `/bin/sh`, since it meets their
requirements, but older versions do not run all elements of a pipeline
in a subshell, which, while allowed by POSIX as an extension,
practically breaks our code (and lots of other code as well).  (New
versions contain a patch I sent that fixes this behaviour when in `sh`
mode.)  As a result, a user compiling their own Git might need to
specify something that is not `sh` on such a system.

And Junio points out correctly that some systems have Perl as `perl5`,
not `perl`.  (Mostly in environments that once had or still have Perl
4.)

So all that to say that we do need to be able to specify an arbitrary
path to a binary in order for things to work on some systems.

[0] Which are the same thing.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--2k412GcU5wLiIvC3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmgL7E8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ4AQ3vkcJWtF/ahCpNA28U3ywJQUUNQjKw7ZGgVlPqMO
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAIGBAQDs/8QS3AIo5p6xV1groyF8XcBU
2ysk9K1cejKgIO1RfwEAuYr58veCUdPRN8VfqZB/jYo6V7RxkS5YK0bEwmOjeAw=
=NE++
-----END PGP SIGNATURE-----

--2k412GcU5wLiIvC3--
