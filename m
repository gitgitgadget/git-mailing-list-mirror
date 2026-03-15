Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B37286A9
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 00:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773535951; cv=none; b=Gi2WmdTOWt4VIGJei/f8mHsJ9Y6DiMz0DBx4ZW7ocira4il4vGSA+RvmfnQTV396eOqZGDXC1Yg6fMHG6eL+ISeR/931r7h9cqqo5X4Ue9QNpcflU8IJVSJGWeWmrFGeADNKrR2fyYtnVz1kMHS0yE1mfJy9lGTVG35mE2VgCFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773535951; c=relaxed/simple;
	bh=LJ+5HMXUgNwXeCX6zfyKQlQI5gCRWadPBnt37iCowSc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y/ySsOvbI5wWq923nxOgtsXVaGsAXHOnZBaiPdvYh8uQaqg5Ri6dPpiZOOLBbxNbO2rqMvEOQ20CyaOOReVDKjCBqqW/K2iM7VFr1VqeZ5bPed1uCDDD4UXIbPArS6hd48uuLrP5G/RLyMWumSUAdp/lYfa5Y6WZrOKurlTLchA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=eYZyjx+C; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="eYZyjx+C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1773535943;
	bh=LJ+5HMXUgNwXeCX6zfyKQlQI5gCRWadPBnt37iCowSc=;
	h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=eYZyjx+C9WcN2gpR+PRSDF1HdGEGtk1vd8NJPcMM3HFHzLzQG5HJuIVNzwrcKY7kv
	 hRQgU+uuUCGCit5W9MP9vPEP61DGsNusXQRm4thGSopIss3wueeVa6+bZkPRYCHxx2
	 R3GdXIHe5RXzvrH4BE0kRT1YxK2JPBGqnQ28jCS+sN8BzpuRwKQ8QMj9ErRCd+L4IS
	 xGeepSYaJxq9KFzqPplkxiJ9+HNcrQxRxqa120bndBA3EA6sjRjBnc6T5QjYah63MK
	 1i071b4W15Vq0ip+pp7Yms+nxBGQSBce3mT+mLP5ygsBd+L7uz5YoQWYC3ZOdDBIwk
	 bTkh2PtmKrzc+RAXHW7bfJ3fG7fkqjK89KKAoCz2/Jcb5CW8GnRSC/DHGNvsKi3Sss
	 5SVqS1G+DfsUJhNuXFXn88HmveT3f/Y3QAV8AqPawsCzLeARnJi62GgJX0WvKwMF4M
	 dX7xS28okRPt0kM9ZQj8rbftzBKzbn00WhFnO2l8zT1zeFMV7it
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:c233:1397:3eba:c74d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8C20920113
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 00:52:23 +0000 (UTC)
Date: Sun, 15 Mar 2026 00:52:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Subject: Unexpected exit code for --help with rev-parse --parseopt
Message-ID: <abYCxrEEPaI21g3H@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mTIpGq0eiexjspv+"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--mTIpGq0eiexjspv+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I use git rev-parse --parseopt to parse command-line options in various
script.  I've noticed that it exits 129 if the options are invalid,
which is fine, but that it also exits 129 if --help or -h are given,
which is not.

The standard philosophy is that if the user explicitly asked for help,
then help output should be printed to standard output (since that's what
the user asked for) and it should exit 0, since the program fulfilled
the user's request successfully.  If the help output is provided because
the user provided an invalid option or argument, then the output should
Go to standard error (since it's an error message) and the program
should exit unsuccessfully (since it did not fulfill the user's request
successfully).

Git gets the location of the output just fine, but currently there's no
way for a program to detect the help output and exit successfully.  Note
that Git subcommands don't have this problem because Git itself
intercepts the help output and sends it to man (or whatever the user has
configured), which then exits successfully.

I'd like to fix this in git rev-parse --parseopt (that is, I am willing
to send a patch), but I'm unsure about the best way to go about this.
Does anyone have ideas about how they'd like this to be fixed?  I could
simply change the exit code in this case or I could add an option to
control this behaviour for backwards compatibility.

Example:

----
#!/bin/sh

OPTS_SPEC=3D"\
foo-cmd [<options>] <args>...

Do stuff.
--
h,help!         show this help

o,output=3D       output to this file
d,dir=3D          specify dependencies relative to this directory
"

main () {
    eval "$(echo "$OPTS_SPEC" | git rev-parse --parseopt -- "$@" || echo ex=
it $?)"

    # Do something with the options here.
}

main "$@"
----

Output:

----
% ./foo-cmd --help >/dev/null; echo $?
129
% ./foo-cmd -h >/dev/null; echo $?
129
% ./foo-cmd --bassoon >/dev/null; echo $?
error: unknown option `bassoon'
usage: foo-cmd [<options>] <args>...

    Do stuff.

    -h, --help            show this help
    -o, --[no-]output ... output to this file
    -d, --[no-]dir ...    specify dependencies relative to this directory

129
----
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--mTIpGq0eiexjspv+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.9 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCabYCxQAKCRB8DEliiIei
gRwJAP4mBYFOxOT1qW7RvMS3nzDqqHj5imRmkIRgp2s8rwlKjAEAm7ZBVYsMZU0a
ktuK8pTtm9KYJ7T19s5exIrrLaeztwY=
=e9AF
-----END PGP SIGNATURE-----

--mTIpGq0eiexjspv+--
