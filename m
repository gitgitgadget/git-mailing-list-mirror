From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: Question about git-svn import
Date: Tue, 18 Dec 2007 16:31:59 +0100
Message-ID: <20071218153159.GA12549@alea.gnuu.de>
References: <4766AF65.5060706@obry.net> <20071218034836.GA27080@dervierte> <4767724A.9040207@obry.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 23:06:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4kZK-0004xs-Gb
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 23:05:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756320AbXLRWFS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2007 17:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756220AbXLRWFR
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Dec 2007 17:05:17 -0500
Received: from banki.eumelnet.de ([83.246.114.63]:1293 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756159AbXLRWFO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2007 17:05:14 -0500
X-Greylist: delayed 1391 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Dec 2007 17:05:14 EST
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 499AE48807A; Tue, 18 Dec 2007 22:42:00 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J4kAk-0000gI-Vm
	for git@vger.kernel.org; Tue, 18 Dec 2007 22:40:23 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.68)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1J4eQK-0003po-8K
	for git@vger.kernel.org; Tue, 18 Dec 2007 16:32:00 +0100
Content-Disposition: inline
In-Reply-To: <4767724A.9040207@obry.net>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68828>


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Pascal,

Pascal Obry schrieb am Tue 18. Dec, 08:10 (+0100):
> Steven Walter a =E9crit :
> > Not sure if this is the best way, but I would recommend cloning into two
> > repositories, then combining them. =20
>=20
> I feared that :)

It's not as complicated as you might think.

> > So you already have the newer
> > changes with the standard layout.  You would now:
> >=20
> >     $ git svn init <repo>
> >=20
> > And only fetch the revisions before the layout change.  You could then
> > combine the two repositories using .git/info/grafts and
> > git-rewrite-branch.
>=20
> Hum, looks like something not easy to do (at least for a Git beginner
> like me) ! Any documentation on this ? Would you mind showing this on
> the example script I sent ?

I had the same problem. We changed the structure of our SVN repository
=66rom /trunk/pkg to /pkg/trunk and git-svn couldn't deal with this.

I used the script posted in
http://lists.alioth.debian.org/pipermail/pkg-jed-devel/2007-December/001719=
=2Ehtml
to do the switch.

Some suggestions:
1. Import both parts into one git repo into their own branches. (use
   --prefix)

2. Use gitk to insprect the history to find bad commits, e.g. empty
   commits or things git-svn imported wrong.

3. Use git-filter-branch with the --parent-filter to join the branches.

HTH, J=F6rg.
--=20
Die am Lautesten reden, haben stets am wenigsten zu sagen.

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHZ+fvwe0mZwH1VIARAiu7AJwJJy538Wp5bGVJ6J4aCp4SnOU/JACfZ4x4
wvS5G6TZuOlX+PCq1mjJP+M=
=lUvu
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
