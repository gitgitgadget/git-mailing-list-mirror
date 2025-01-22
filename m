Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F8717BB6
	for <git@vger.kernel.org>; Wed, 22 Jan 2025 02:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737511756; cv=none; b=IVIX9YtHt2YJmfX1MGAIVRwc+GJ8u2WJJlDC0ocDLNX5Mlhp/iGiEYgVC8VljNwmWs9JFVNhHQCxEAzdGURn1G7XY64edxndN62adF2B9+wlay3xye6XGNTbrwYLQk+VHCpx4NEyYflIzJnbdY30Q+vx/E64eUpc9kGTH+o92s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737511756; c=relaxed/simple;
	bh=fHRdE0WVO5iU9PkVpoaToOcl8Mujm83s+YxPuK6LwxE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QAK5MPtBLC8nrLiuzlr4/8iy8edhVSgq+TzJtZqmE6xphziQf3kCglg/XyUgUqV2HvgWx1XJ27uqG+PyLBYNMXw13jtkon8c3rnPOmxYNdtsRJz4IfheKGFryqKYrxHLT/kt5qvV/bDn+N2aS0lr/Eh4kskxM4LEf1fy6yVaDQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=CTRK/68P; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="CTRK/68P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737511746;
	bh=fHRdE0WVO5iU9PkVpoaToOcl8Mujm83s+YxPuK6LwxE=;
	h=Date:From:To:Cc:Subject:Content-Type:Content-Disposition:From:
	 Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
	 Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
	b=CTRK/68PCaz4FE7sjy0hGSSD2Ys4Fv2B/nVbdWCyYlLbJqTr6HdoaeJ5wibEATicA
	 GYJBz/L3o1oPtah/cSL55zqbIJgGzFvcZO3YS0LXAOB5kIXNXV+q8oqmE/fkt4CePC
	 TopPJFPtgwsjWC+nQSMwOppgyRE3PZMTANw0HU8C0Fxcqax7cROGLJd31OQ6OVAkEW
	 F7KNWlvaUhAEMhcbYl2mURQjIRW9N4rDZsFSJ2XfF2pgWUL4XF7eH2I5Adxmhd2wuc
	 3rB3uqWlm+H+gv7NP9yTgbfHhX3dgMEN6Ax5SXHT9qGeUIY284E94fICfe0udE7JCx
	 vPBjhZCt1yxirIcutZ5S1W0AgbeEhzxrzAtafoBGr0fIalG4UBQHrDlxnGuFlNvVbp
	 bdwlUXzhcmHbaJcVlw347KGTK2U0grWAfJgtUiA78azYWTrJpejOeQ8zBqJcrI0J9f
	 KEbJKrwpmjp06PUwBs23toaAWbxWp6QrTMJDO7P63Y0ElXd0lXr
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BDD8220033;
	Wed, 22 Jan 2025 02:09:06 +0000 (UTC)
Date: Wed, 22 Jan 2025 02:09:05 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: git refs migrate does not migrate stash entries
Message-ID: <Z5BTQRlsOj1sygun@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="4vKHtMAqxWSMKXr/"
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)


--4vKHtMAqxWSMKXr/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

After the recent fix for reflog migrations posted to the list, I
converted two work repositories. Unfortunately, it doesn't appear as
though the reflog for `refs/stash` was converted, so I think I may have
lost my stashes.  While I would have liked to retain them, fortunately
they were not essential in these repos and I can live without them, but
we probably do want to fix this issue since users in general will want
to maintain them.

Here's a shell script that reproduces the problem on the latest `next`:
----
#!/bin/sh -e

rm -fr test-repo
git version
git init -b dev test-repo
cd test-repo
touch abc.txt
git add abc.txt
git commit -m +
echo abc >abc.txt
git stash
git show stash@{0}
git stash list -p

echo "Converting..."
git refs migrate --ref-format=3Dreftable

echo "Now using reftable."

git stash show
git show stash@{0}
git stash list -p
----

My expectation is that the script exits 0 and prints the stashes a
second time, but it exits early and unsuccessfully and the stashes don't
appear to be preserved.  It does appear to work correctly if you comment
out the `git refs migrate` command.

I would have liked to have done more investigation, but I'm dealing with
some administrivia in my personal life that has taken up more of my
evenings than I would have liked, so I have not done so.

I also apologize for sending a constant barrage of bug reports that
might make it seem like I'm dissatisfied with the work on reftable, when
in fact that's not the case and I do very much appreciate the work being
done.  I did promise Patrick that I'd try it out and be the guinea pig,
and so I'm doing so.  I'm excited to see it end up in its final state.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--4vKHtMAqxWSMKXr/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5BTQQAKCRB8DEliiIei
gWybAP4k1O6gGPCUvmjFGOvlGWWTzVamMTi2p/K9oCrJ7PXuWAD+NK1wig7ZaVSC
FdRlU9s7ALWfwWQ6len3ErCU5oTE2AY=
=bcVx
-----END PGP SIGNATURE-----

--4vKHtMAqxWSMKXr/--
