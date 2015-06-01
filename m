From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] format-patch: dereference tags with
 --ignore-if-in-upstream
Date: Mon, 1 Jun 2015 22:34:09 +0000
Message-ID: <20150601223409.GB140991@vauxhall.crustytoothpaste.net>
References: <CAP8UFD1phg8E0JCgkz88CMUo9H-W=s5JDuKeCMOkf1=UYBJt+g@mail.gmail.com>
 <1433120593-186980-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqr3pv8okj.fsf@gitster.dls.corp.google.com>
 <xmqq6177728a.fsf@gitster.dls.corp.google.com>
 <20150601174712.GA18364@peff.net>
 <xmqq4mmr5fqy.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 00:34:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzYHj-000635-Ox
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 00:34:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753105AbbFAWeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 18:34:16 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:58364 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752245AbbFAWeO (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 18:34:14 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:fd0c:c3b:29e1:d998])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 2EACC2808F;
	Mon,  1 Jun 2015 22:34:13 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
	Bruce Korb <bruce.korb@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqq4mmr5fqy.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270475>


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 01, 2015 at 01:35:17PM -0700, Junio C Hamano wrote:
> -- >8 --
> From: Junio C Hamano <gitster@pobox.com>
> Date: Mon, 1 Jun 2015 10:44:21 -0700
> Subject: [PATCH] format-patch: do not feed tags to clear_commit_marks()
>=20
> "git format-patch --ignore-if-in-upstream A..B", when either A or B
> is a tag, failed miserably.
>=20
> This is because the code passes the tips it used for traversal to
> clear_commit_marks(), after running a temporary revision traversal
> to enumerate the commits on both branches to find if they have
> commits that make equivalent changes.  The revision traversal
> machinery knows how to enumerate commits reachable starting from a
> tag, but clear_commit_marks() wants to take nothing but a commit.
>=20
> In the longer term, it might be a more correct fix to teach
> clear_commit_marks() to do the same "committish to commit"
> dereferncing that is done in the revision traversal machinery, but

"dereferencing".  Otherwise, looks exactly like what I would have
written in my reroll had you not gotten to it before me.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCgAGBQJVbN3hAAoJEL9TXYEfUvaLSaoP/A1xo6V8e6Oe5arSJqVA9YiA
iRKWuWLyEfJgCMR8jG7ALD69I1ReoVPfhIAHy1J0USBNNCVyBhLVJXMlfudih5lV
QLv4vMzTYH5PDa9LuGoH5MLvO6hKrQstgB88yskcj+hkq+JT1WAi3hiiorZB1jLI
o/2dRQvIY+R6buo0HjF8m75hkRXmkXWMD1hYXAWoHguWshxdLqttEy5uqfO+SfWl
NrPueyq41rpP0kBuR/htGdLfZ33daz9hOte5t6+YMv9QIc4g+A6RTl2mvf9erxbJ
HDpXZPihKUwFFKEGBDAuH2Yy/eh8z9RFcJABjrHF6tTHZ3uunNNG6svHw5td3ACP
T0Eh498W5CcJzJNq//AHi+CbiKYePi0PAvL3z6Cc8xAgA4dqR3mrqHpxilCZrWnG
J60+RaFpp/qfQTae8b1vejB/pcFzg9IEC2VE35sYWCnwgkOXm9UQWOrvM4qKdTEX
ej+FggIXfUkNkVrkty+Z/Ib9nHfsrwvZrpoxkXfOSKulfDbX0MPIw8vso2y1DE5a
su+kx/TW9IJ/6aSiymz22vP9spp8pW6OSqcgZJZmqYtoXKYlSu6wO2MK9FrQRVMM
CEOKFodOuBgP8dGNVEUUTMJV1iMabGMl9ILmkhABiAWXmzn39mphxS71u/OJXhB7
vigyT/v7K2HjTKUvxnww
=mmCJ
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
