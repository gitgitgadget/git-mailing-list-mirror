From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: Warning: cvsexportcommit considered dangerous
Date: Mon, 5 Nov 2007 00:05:28 +0100
Message-ID: <200711050005.28561.robin.rosenberg.lists@dewire.com>
References: <Pine.LNX.4.64.0711041638270.4362@racer.site> <623F4AFA-FE43-4046-9D3F-435396BBE17D@zib.de> <Pine.LNX.4.64.0711042133330.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Steffen Prohaska <prohaska@zib.de>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Bennee <kernel-hacker@bennee.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:03:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IooVO-00050n-MC
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753214AbXKDXDd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 18:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbXKDXDd
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:03:33 -0500
Received: from [83.140.172.130] ([83.140.172.130]:26096 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752807AbXKDXDc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:03:32 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id BE0908026EB;
	Sun,  4 Nov 2007 23:54:34 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07604-01; Sun,  4 Nov 2007 23:54:34 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id 459C88026D1;
	Sun,  4 Nov 2007 23:54:34 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <Pine.LNX.4.64.0711042133330.4362@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63453>

s=F6ndag 04 november 2007 skrev Johannes Schindelin:
> Hi,
>=20
> On Sun, 4 Nov 2007, Steffen Prohaska wrote:
>=20
> > On Nov 4, 2007, at 5:41 PM, Johannes Schindelin wrote:
> >=20
> > > ever since the up-to-date check was changed to use just one call =
to=20
> > > "cvs status", a bug was present.  Now cvsexportcommit expects "cv=
s=20
> > > status" to return the results in the same order as the file names=
 were=20
> > > passed.
> > >=20
> > > This is not true, as I had to realise with one of my projects on=20
> > > sourceforge.
> > >=20
> > > Since time is so scarce on my side, I will not have time to fix t=
his=20
> > > bug, but will instead return to my old "commit by hand" procedure=
=2E
> >=20
> > I introduced this 'optimization', which turned out to be a bug. So,=
 I=20
> > feel responsible. Sorry for the trouble.
> >=20
> > In August this was already recognized and a patch submitted:
> >=20
> > http://marc.info/?t=3D118718458000004&r=3D1&w=3D2
> >=20
> > I do not know why it wasn't applied. I forgot re-checking after my=20
> > vacation.
>=20
> It slipped by me, because of holiday, too.  (I was on my well needed=20
> holiday then.)
>=20
> But that patch really seems like a step back to me.  The line "File: =
=2E..=20
> Status: ..." should be parsable enough to fix the bug properly, inste=
ad of=20
> undoing the optimisation.
Unfortunately it's not that easy to parse. It *can* be done by looking =
at the
repository path, and the CVS/Root etc, but it's not nice.=20

>=20
> AFAICS Robin replied with a "let's see if a proper fix materialises",=
 and=20
> I kind of hope that it will materialise soon.

Still hoping :). BTW, wouldn't this err on the right side anyway, i.e. =
if an
existing file was not up to date and was wrongly thought to not exist o=
r a new=20
file was thought to be up-to-date, I would get an error and would not b=
e able
to commit. I've never seen it though and I always have a clean CVS chec=
kout
so the potential bug seems unlikely to me.

The command I always use is.

	git cvsexportcommit -u -c -w /my/cvs/checkout

Never bitten me yet (touch wood).

My real worry is on the other side, with bad conversion from CVS to git=
=2E

-- robin
