From: "Dmitry V. Levin" <ldv@altlinux.org>
Subject: Re: git rev-parse --since=1970-01-01 does not work reliably
Date: Tue, 1 Nov 2011 16:44:34 +0400
Message-ID: <20111101124434.GB22229@altlinux.org>
References: <20111031161708.GA29924@altlinux.org> <20111031231320.GA3857@do>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 01 13:44:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLDht-0001vU-4L
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 13:44:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546Ab1KAMog (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 08:44:36 -0400
Received: from vint.altlinux.org ([194.107.17.35]:55336 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754284Ab1KAMof (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 08:44:35 -0400
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id BF9E13F8023A;
	Tue,  1 Nov 2011 12:44:34 +0000 (UTC)
Received: by wo.int.altlinux.org (Postfix, from userid 508)
	id ABD513F485E2; Tue,  1 Nov 2011 16:44:34 +0400 (MSK)
Content-Disposition: inline
In-Reply-To: <20111031231320.GA3857@do>
X-fingerprint: FE4C 93AB E19A 2E4C CB5D  3E4E 7CAB E6AC 9E35 361E
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184566>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 01, 2011 at 06:13:20AM +0700, Nguyen Thai Ngoc Duy wrote:
> On Mon, Oct 31, 2011 at 08:17:09PM +0400, Dmitry V. Levin wrote:
> >=20
> > git rev-parse --since=3D1970-01-01 (and other git commands that take
> > date string arguments like --since) may fail when --since=3D1970-01-01 =
is
> > given.  Whether it fails or not depends on current time and timezone da=
ta.
> > For example, "TZ=3DEurope/Paris git rev-parse --since=3D1970-01-01" fai=
ls two
> > hours a day (between 00:00 and 02:00 CET), and those who use more easte=
rn
> > timezones are even less lucky.  In artificial timezones like UTC-24 it
> > always fails:
> >=20
> > $ TZ=3DUTC-24 git rev-parse --since=3D1970-01-01
> > --max-age=3D18446744073709523490
>=20
> Out of curiosity, why do you need to work with a time so close to that
> date?

There is an utility that used to invoke "git log --since=3D'1970-01-01 UTC'"
by default, and I was unlucky enough to use it during these hours of
failure.  The utility is now fixed (it no longer calls git log with
--since option unless explicitly instructed to do so), and I hope git
is going to be fixed as well.

BTW, the timezone specifier (UTC) in "git rev-parse --since=3D'1970-01-01 U=
TC'"
seems to be completely ignored by date string parser.


--=20
ldv

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk6v6bIACgkQfKvmrJ41Nh4m4gCgjo8jOAxqP2jNYOCHDJku2HEA
lQkAoKC3Dqb1P7kWaWTJQgh2bja/Wk6Z
=db9q
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
