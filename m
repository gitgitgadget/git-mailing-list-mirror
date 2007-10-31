From: Johan Herland <johan@herland.net>
Subject: Re: Recording merges after repo conversion
Date: Wed, 31 Oct 2007 18:08:49 +0100
Message-ID: <200710311808.55630.johan@herland.net>
References: <Pine.LNX.4.64.0710090807060.26773@ds9.cixit.se> <Pine.LNX.4.64.0710311553510.4362@racer.site> <alpine.LFD.0.999.0710310928490.3340@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2845113.UWpDZrYJQ9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Peter Karlsson <peter@softwolves.pp.se>,
	Lars Hjemli <hjemli@gmail.com>,
	Benoit SIGOURE <tsuna@lrde.epita.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 31 18:10:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InH55-00079X-IN
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 18:10:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756683AbXJaRJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 13:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756600AbXJaRJ4
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 13:09:56 -0400
Received: from sam.opera.com ([213.236.208.81]:36806 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756645AbXJaRJz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 13:09:55 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l9VH8ttN009265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 31 Oct 2007 17:08:56 GMT
User-Agent: KMail/1.9.7
In-Reply-To: <alpine.LFD.0.999.0710310928490.3340@woody.linux-foundation.org>
X-Virus-Scanned: ClamAV 0.91.1/4650/Wed Oct 31 15:43:03 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62850>

--nextPart2845113.UWpDZrYJQ9
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Wednesday 31 October 2007, Linus Torvalds wrote:
> On Wed, 31 Oct 2007, Johannes Schindelin wrote:
> > Seriously, your proposal does not make any sense.  If you have to set u=
p a=20
> > hook to get the _sane_ behaviour, something is really wrong.  So I do n=
ot=20
> > really understand why you brought up this idea here and now.
>=20
> Well, I think this does kind of have some commonality with another issue=
=20
> that has come up before: git clone only clones the really core repository=
=20
> data.
>=20
> That's generally a big feature, and I think it's absolutely the correct=20
> thing to do.
>=20
> But I can also see that sometimes, you might want to clone more than the=
=20
> actual repository, and get things like SVN metadata, branch reflogs,=20
> various hooks and all the config options too.
>=20
> Of course, in practice, at least right now, the right thing to do for tha=
t=20
> is to just do a recursive filesystem copy and then a "git status", but I=
=20
> think the background here is that some people simply do end up wanting to=
=20
> transfer more infrastructure than just the actual repository data.
>=20
> One thing to note: one reason for *not* allowing that is that incremental=
=20
> upgrades of non-repo data is obviously not possible. You might be able to=
=20
> *clone* a repo with config info and other metadata (if nothing else, then=
=20
> by just doing that raw filesystem copy), but you will never ever be able=
=20
> to _fetch_ the updates, because they aren't part of the core repository,=
=20
> and aren't versioned.
>=20
> So I think I can understand why some people would want to do things like=
=20
> this, but I do think it's broken. Yes, you can make the grafts file (or=20
> the config file) be part of the repo, and even just add a symlink to your=
=20
> .git/ directory, but it's simply not a very good model.
>=20
> So I think it always does end up breaking (other people might rebase, and=
=20
> break your grafts, or just not want them in the first place, or they don'=
t=20
> care about the same things, and mess up "your" configuration etc etc). So=
=20
> the git repo layout is designed to have the minimally required shared=20
> state, and not anything else.

I agree that sharing the "metainfo" (i.e. config, grafts, hooks, reflogs,=20
rerere magic, etc.) of the repo is not something git should do in the gener=
al=20
case.

But in some specific workflows (e.g. in-house, centralized workflows), I th=
ink=20
it makes sense to coordinate/share some of this info between repos. But in=
=20
that case, I guess such coordination/sharing can be done by special-purpose=
=20
tools built on top of git (e.g. in-house admin scripts).


=2E..Johan

=2D-=20
Johan Herland, <johan@herland.net>
www.herland.net

--nextPart2845113.UWpDZrYJQ9
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7-ecc0.1.6 (GNU/Linux)

iD8DBQBHKLaiBHj4kl4fT1wRAhaFAJ9QbY4BtbFCZi3JEolCJoLY/KXAgwCeKODP
8+4WR6PXeZh8kwFhLXAT4FU=
=BIap
-----END PGP SIGNATURE-----

--nextPart2845113.UWpDZrYJQ9--
