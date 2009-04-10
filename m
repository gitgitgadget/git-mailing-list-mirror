From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Fri, 10 Apr 2009 13:38:46 -0700
Message-ID: <20090410T203405Z@curie.orbis-terrarum.net>
References: <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home> <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PmA2V3Z32TCmWXqI"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Apr 10 22:40:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsNWm-0003TF-5r
	for gcvg-git-2@gmane.org; Fri, 10 Apr 2009 22:40:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755294AbZDJUiw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Apr 2009 16:38:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753610AbZDJUiw
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Apr 2009 16:38:52 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:56641 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752264AbZDJUiv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Apr 2009 16:38:51 -0400
Received: (qmail 31788 invoked from network); 10 Apr 2009 20:38:48 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Fri, 10 Apr 2009 20:38:48 +0000
Received: (qmail 23298 invoked by uid 10000); 10 Apr 2009 13:38:46 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116280>


--PmA2V3Z32TCmWXqI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2009 at 12:52:54AM -0400, Nicolas Pitre wrote:
> > http://git.overlays.gentoo.org/gitweb/?p=3Dexp/gentoo-x86.git;a=3Dsumma=
ry
> > At least that's what I cloned ;-) I hope it's the right one, but it fits
> > the description...
> OK.  FWIW, I repacked it with --window=3D250 --depth=3D250 and obtained a=
=20
> 725MB pack file.  So that's about half the originally reported size.
The one problem with having the single large packfile is that Git
doesn't have a trivial way to resume downloading it when the git://
protocol is used.

For our developers cursed with bad internet connections (a fair number
of firewalls that don't seem to respect keepalive properly), I suppose
I can probably just maintain a separate repo for their initial clones,
which leaves a large overall download, but more chances to resume.

PS #1: B.Steinbrink's memory improvement patch seems to work nicely too,
but more memory improvements in that realm are still needed.

PS #2: We finally got some newer hardware to run the large repo, I'm
working on the install now, but until the memory issue is better
resolved, I'm still worried we might run short if there are too many
concurrent clones.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--PmA2V3Z32TCmWXqI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknfrlUACgkQPpIsIjIzwixg+ACeNPdynBYrNB7TwZ94+WVsjPU6
/rgAmwYD3k67rI6ZmImqUM1+2mbNzUJD
=SgdS
-----END PGP SIGNATURE-----

--PmA2V3Z32TCmWXqI--
