From: martin f krafft <madduck@debian.org>
Subject: linearising TopGit forests into patch series (was: [ANNOUNCE]
	TopGit - A different patch queue manager)
Date: Thu, 7 Aug 2008 14:56:24 -0300
Organization: The Debian project
Message-ID: <20080807175623.GA16833@lapse.rw.madduck.net>
References: <20080803031424.GV32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4461563666892176285=="
Cc: vcs distro packaging discussion list
	<vcs-pkg-discuss@lists.alioth.debian.org>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org Thu Aug 07 19:56:38 2008
Return-path: <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>
Envelope-to: gcpv-vcs-pkg-discuss@m.gmane.org
Received: from alioth.debian.org ([217.196.43.134])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KR9j4-0001gm-0u
	for gcpv-vcs-pkg-discuss@m.gmane.org; Thu, 07 Aug 2008 19:56:38 +0200
Received: from localhost
	([127.0.0.1] helo=alioth.debian.org ident=list)
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org>)
	id 1KR9i8-00017f-MA
	for gcpv-vcs-pkg-discuss@m.gmane.org; Thu, 07 Aug 2008 17:55:40 +0000
Received: from clegg.madduck.net ([193.242.105.96])
	by alioth.debian.org with esmtp (Exim 4.63)
	(envelope-from <madduck@lapse.rw.madduck.net>) id 1KR9i0-00015Z-1o
	for vcs-pkg-discuss@lists.alioth.debian.org;
	Thu, 07 Aug 2008 17:55:38 +0000
Received: from lapse.rw.madduck.net (unknown [209.13.181.29])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net",
	Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id 649F71D40A7;
	Thu,  7 Aug 2008 19:55:21 +0200 (CEST)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id 5383C80B3; Thu,  7 Aug 2008 14:56:24 -0300 (ART)
In-Reply-To: <20080803031424.GV32184@machine.or.cz>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel
	2.6.24-etchnhalf.1+scoflowctrl.1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Virus-Scanned: ClamAV 0.93.1/7972/Thu Aug 7 14:22:20 2008 on
	clegg.madduck.net
X-Virus-Status: Clean
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on alioth.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=AWL,BAYES_00,URIBL_RED
	autolearn=ham version=3.2.3
X-BeenThere: vcs-pkg-discuss@lists.alioth.debian.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Discussions on using VCS for distro packaging
	<vcs-pkg-discuss.lists.alioth.debian.org>
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/vcs-pkg-discuss>
List-Post: <mailto:vcs-pkg-discuss@lists.alioth.debian.org>
List-Help: <mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/vcs-pkg-discuss>,
	<mailto:vcs-pkg-discuss-request@lists.alioth.debian.org?subject=subscribe>
Mime-version: 1.0
Sender: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
Errors-To: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: vcs-pkg-discuss-bounces+gcpv-vcs-pkg-discuss=m.gmane.org@lists.alioth.debian.org
X-SA-Exim-Scanned: No (on alioth.debian.org); SAEximRunCond expanded to false
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91593>


--===============4461563666892176285==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Petr and everyone else,

as some of you may know, I am working on http://vcs-pkg.org, and
Pierre kindly alerted me to your announcement, which looks very
interesting for what we are trying to do.

Assuming a number of interdependent topic branches, does TopGit
provide a way for me to linearise/flatten/serialise these branches
in a one-patch-per-branch fashion, so that I could turn any TopGit
repository into a quilt series? I am only interested in a one-way
conversion from TopGit to quilt for now.

The reason for this is quite simply that while it's fabulous to use
e.g. Git for managing the source repository from which to build
distro packages, the resulting packages will have all
distro-specific changes applied or collated into a single diff. This
makes it hard for other distributions to grab patches, for upstream
to keep on top of what is being distributed, and for bug fixers to
separate patches and test only specific ones.

If we could turn a TopGit-managed forest into a quilt series, we
could distribute the series with the package and allow those who
inspect the source package to use quilt to navigate the patches.

If anyone has any input on the matter, I'd love to hear it.

Thank you,

--=20
 .''`.   martin f. krafft <madduck@debian.org>
: :'  :  proud Debian developer, author, administrator, and user
`. `'`   http://people.debian.org/~madduck - http://debiansystem.info
  `-  Debian - when you have better things to do than fixing systems
=20
infinite loop: see 'loop, infinite'.
loop, infinite: see 'infinite loop'.

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkibNz8ACgkQIgvIgzMMSnU5iACgla6EGfnOsIwVBT036xoAfBZ7
qRkAn1FVE+isGqT9+uRnd8DEHvW29BYv
=G7ER
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


--===============4461563666892176285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
