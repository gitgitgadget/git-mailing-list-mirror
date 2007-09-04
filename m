From: martin f krafft <madduck@madduck.net>
Subject: Re: publishing a forked^W cloned directory with ancestry
Date: Tue, 4 Sep 2007 16:17:30 +0200
Message-ID: <20070904141730.GA25759@lapse.madduck.net>
References: <20070830192533.GA18751@piper.oerlikon.madduck.net> <20070830202747.GT10772@jukie.net> <20070830192533.GA18751@piper.oerlikon.madduck.net> <20070830194947.GB10808@fieldses.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
To: git discussion list <git@vger.kernel.org>,
	mdadm development team 
	<pkg-mdadm-devel@lists.alioth.debian.org>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	Bart Trojanowski <bart@jukie.net>
X-From: git-owner@vger.kernel.org Tue Sep 04 17:31:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISaN9-0004JI-Qc
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 17:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754278AbXIDPbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 11:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbXIDPbT
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 11:31:19 -0400
Received: from clegg.madduck.net ([82.197.162.59]:51206 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754105AbXIDPbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 11:31:18 -0400
X-Greylist: delayed 1300 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2007 11:31:18 EDT
Received: from lapse.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTP id 9A0A0BEB9;
	Tue,  4 Sep 2007 17:09:23 +0200 (CEST)
Received: by lapse.madduck.net (Postfix, from userid 1000)
	id 106533FCC5; Tue,  4 Sep 2007 16:17:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070830202747.GT10772@jukie.net> <20070830194947.GB10808@fieldses.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: ClamAV 0.91.2/4152/Tue Sep  4 16:16:36 2007 on clegg.madduck.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57599>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach J. Bruce Fields <bfields@fieldses.org> [2007.08.30.2149 +0200]:
> Maybe the one extra "git remote add ...; git remote fetch" isn't
> such a big deal?

[...]

> Sure, each of those could add a "linus" branch that tracked
> upstream, so I could still get some idea what Linus's tree was
> even if I didn't happen to already have it.  But then I'd end up
> with 4 different slightly-out-of-date pointers to the head of
> linus's repo in each of those trees, which would end up being just
> be a bunch of cruft that I'd have to ignore whenever I looked at
> them.

Thanks to you and everyone else who replied! I spent some time off
computers and still found myself thinking about this as I was hiking
around woods and mountains and in the end, it's perfectly obvious:

I am trying to make it easy for third parties to contribute to my
git-managed project and I (somewhat rightfully) assumed that
I needed to shield my poor contributors from git's complex
tentacles. In doing so, I find myself going backwards and turning
git into something svn-like, thus losing much of its power.

The solution is clear: maintain only my Debian branch on
git.debian.org and expect those cloning it to add the upstream
remote themselves in true distributed manners. A concise file in the
project root with instructions is a nice add-on.



also sprach Bart Trojanowski <bart@jukie.net> [2007.08.30.2227 +0200]:
> Now when you 'git push debian' it will populate the 'upstream' and
> 'master' branches properly.
>=20
> When someone clones your repo, they will get origin/master (your
> branch) and origin/upstream (the official mdadm branch).

This is the solution I had stuck in my head for the longest time
(after you proposed it), but I eventually discard it for one simple
reason: the danger that someone pushes to the upstream branch and
thus diverges it from the real upstream is just too high and would
result in a pretty nasty mess, as far as I can tell.

> Did I understand the problem correctly?

I think you did. And thanks for that. I hope my reasoning above also
makes sense.

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
"the surest way to corrupt a youth is to instruct him to hold in
 higher esteem those who think alike than those who think
 differently."
                                              -- friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3Wj6IgvIgzMMSnURApJ+AJwM7BJIeol1QxlKODlIHdYSuBcxwwCdFST7
ost5zv3nHYAaZmzEJu+nwWA=
=8A1c
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
