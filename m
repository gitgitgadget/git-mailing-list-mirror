From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: One more shallow tree weirdness - tag not pulled?
Date: Wed, 11 Apr 2007 20:37:59 -0700
Message-ID: <20070412033759.GD18378@curie-int.orbis-terrarum.net>
References: <20070412011616.GB18378@curie-int.orbis-terrarum.net> <7vbqhuml6z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C+ts3FVlLX8+P6JN"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 05:38:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hbq8P-0003F7-EO
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 05:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161559AbXDLDhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Apr 2007 23:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161560AbXDLDhv
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Apr 2007 23:37:51 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:35948 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161559AbXDLDhu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Apr 2007 23:37:50 -0400
Received: (qmail 14990 invoked from network); 12 Apr 2007 03:37:49 -0000
Received: from Unknown (HELO curie.orbis-terrarum.net) (24.81.201.182)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Thu, 12 Apr 2007 03:37:48 +0000
Received: (qmail 10482 invoked by uid 10000); 11 Apr 2007 20:37:59 -0700
Mail-Followup-To: Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vbqhuml6z.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.15 (2007-04-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44315>


--C+ts3FVlLX8+P6JN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2007 at 06:32:36PM -0700, Junio C Hamano wrote:
> The initial clone gets all tags, regardless of reachability.
> Subsequent fetches however only _follows_ tags that point at
> something you have in the repository.  The blob that holds my
> GPG public key is not part of any commit, so you would not have
> that object in your repository, and subsequent "tag following"
> will not see it.
Ah, that explains it. I didn't dig into what the blob contain, just
noticed that it wasn't on the side that I was checking for extending.

> > I created 'git-$N.list' with:
> > find git-$N ! -type d  | sort |egrep -v '\.git/(objects/pack/|index$|lo=
gs/)' \
> >  | tr '\n' '\0' | xargs -0 md5sum | sed 's,git-$N/,,g' >git-$N.list
>=20
> I do not know what you wanted to do, but I suspect you
> reinvented a rather expensive
> 	git ls-remote git-$N
No, the purpose of this command was to check that the checkouts were
functionally equivalent.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Council Member
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--C+ts3FVlLX8+P6JN
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.2 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iD8DBQFGHamXPpIsIjIzwiwRAgcJAKDC17E0q0JFC5xRa1YHLyaSfPA0CwCg4HOa
hRN24HOSDPNsVh5nbzKfYhA=
=ffvR
-----END PGP SIGNATURE-----

--C+ts3FVlLX8+P6JN--
