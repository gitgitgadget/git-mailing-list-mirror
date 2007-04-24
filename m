From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Re: [BUG] git gui and =?iso-8859-1?Q?my_?=
	=?iso-8859-1?Q?=F6?=
Date: Tue, 24 Apr 2007 10:57:15 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070424085715.GA9334@informatik.uni-freiburg.de>
References: <20070423113225.GA5427@lala> <20070424053935.GO17480@spearce.org> <20070424061652.GP17480@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 24 10:57:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgGpw-0007Fm-Ic
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 10:57:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbXDXI5V convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 24 Apr 2007 04:57:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751049AbXDXI5V
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 04:57:21 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63446 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750930AbXDXI5U (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Apr 2007 04:57:20 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HgGpq-00054f-Ts; Tue, 24 Apr 2007 10:57:19 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l3O8vGYm009594;
	Tue, 24 Apr 2007 10:57:16 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l3O8vF4S009593;
	Tue, 24 Apr 2007 10:57:15 +0200 (MEST)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070424061652.GP17480@spearce.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45432>

Hello Shawn,

Shawn O. Pearce wrote:
> "Shawn O. Pearce" <spearce@spearce.org> wrote:
> > Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> > > 	commit-tree failed:
> > > 	Warning: commit message does not conform to UTF-8.
>=20
> This was starting to bug me, so I went off and found it.  OK, well
> the encoding error anyway.  git-gui incorrectly claimed commit-tree
> failed when it didn't.  But besides the point, this is the bad line:
>=20
> >    1294     fconfigure $msg_wt -encoding $enc -translation binary
>=20
> I have had trouble in the past with trying to use that magic
> -encoding flag on fconfigure to get Tcl's file channels to perform
> encoding work for me.  Seems it doesn't work right or something...
> so other parts of git-gui (e.g. the filename handling parts)
> perform the convertfrom/convertto logic on their own... but the
> commit message handling parts didn't.
>=20
> They do now (git gui 0.6.5-11-gf20db5f).
>=20
> Can you please test my current master branch and see if that fixes
> things for you?  repo.or.cz, git-gui.git...
Works fine.  I pulled in your changes[1] and it worked with one test
case.  (I amended the merge and added a sign-off. ;-)

Best regards and thanks
Uwe

[1] Thanks to gitster in #git to explain how to do it.  It's as easy as=
:

	git pull -s subtree git://.../git-gui.git master

--=20
Uwe Kleine-K=F6nig

http://www.google.com/search?q=3Dgravity+on+earth%3D
