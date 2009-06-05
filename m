From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Best way to merge two repos with same content, different
	history
Date: Fri, 5 Jun 2009 11:46:16 -0700
Message-ID: <robbat2-20090605T183716-227340397Z@orbis-terrarum.net>
References: <63BEA5E623E09F4D92233FB12A9F794303117DBF@emailmn.mqsoftware.com> <286817520906050953n1afed29cn6c85f219a0c9b8b5@mail.gmail.com> <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 05 20:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCeSY-00053w-48
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 20:48:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157AbZFESq4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Jun 2009 14:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZFESq4
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 14:46:56 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:37672 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752692AbZFESqz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 14:46:55 -0400
Received: (qmail 5963 invoked from network); 5 Jun 2009 18:46:53 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 05 Jun 2009 18:46:53 +0000
Received: (qmail 5588 invoked by uid 10000); 5 Jun 2009 11:46:16 -0700
Content-Disposition: inline
In-Reply-To: <63BEA5E623E09F4D92233FB12A9F794303117DC1@emailmn.mqsoftware.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120818>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 05, 2009 at 12:10:30PM -0500, Kelly F. Hickel wrote:
> Bost,=20
> 	Thanks, but I'm already working with a local copy of the CVS repo.
> 	I've corresponded with Michael Haggerty about the time this takes,
> 	and there just doesn't seem to be any way to improve the speed,
> 	without making some fairly drastic changes to cvs2git.
I've been working with mhagger lately as it also pertains to the Gentoo
conversion. We've made some very good progress.

A couple of comments in that regard:
- Make really sure your box is not short of RAM. Throw some measurement
  tools onto there to see it. A couple of GiB is worthwhile. After we
  found this early on, and switched boxes, we dropped from our initial
  multiple days to 20 hours.
- His latest ExternalBlobGenerator code (_NOT_ available in SVN yet)
  reduced our pass1 time from 36204 seconds to 1598 seconds, with
  a potential to be much faster now, as parallelization of part of that
  is now trivial.
- pass9 is still the remaining large time-eater for us. I've started to
  look at it, but I haven't made any actual developments yet.

Would you mind posting your cvs2svn stats like these?
http://archives.gentoo.org/gentoo-scm/msg_b69b2f6ecee0ec7bb402d31b372b945b.=
xml

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAkopZ/gACgkQPpIsIjIzwiy9agCglTiczixDXKaOU+jX0kSoYbcx
MbMAoL2cKxv+4vGwFeYY3QDIzN6X4fGI
=j/n6
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
