From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [JGIT PATCH 8/6] Fix zero context insert and delete hunk
	headers to match CGit
Date: Wed, 6 May 2009 00:19:46 +0200
Message-ID: <20090505221946.GA20002@neumann>
References: <20090503000540.GN23604@spearce.org>
	<200905031025.53084.robin.rosenberg.lists@dewire.com>
	<49FD5662.9070004@pelagic.nl>
	<200905031124.08113.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	Miles Bader <miles@gnu.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Wed May 06 00:20:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1Szd-0007oL-59
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 00:20:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754125AbZEEWTv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 May 2009 18:19:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754124AbZEEWTv
	(ORCPT <rfc822;git-outgoing>); Tue, 5 May 2009 18:19:51 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:57916 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbZEEWTu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2009 18:19:50 -0400
Received: from [127.0.1.1] (p5B133919.dip0.t-ipconnect.de [91.19.57.25])
	by mrelayeu.kundenserver.de (node=mrelayeu5) with ESMTP (Nemesis)
	id 0ML25U-1M1SzL2IvX-0001df; Wed, 06 May 2009 00:19:49 +0200
Content-Disposition: inline
In-Reply-To: <200905031124.08113.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Provags-ID: V01U2FsdGVkX1/zi8n6k8eZLGJTUnStpUqE1LtS3GzioF65EJl
 DuvUn5R9jbOzyevqcza77rESi6dVKPaO2OC0pCarjS2rh1GXy6
 TljpdPUATl3xrEC9i93gw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118317>

Hi,


On Sun, May 03, 2009 at 11:24:07AM +0200, Robin Rosenberg wrote:
> s=F6ndag 03 maj 2009 10:31:30 skrev "Ferry Huberts (Pelagic)" <ferry.=
huberts@pelagic.nl>:
> > > 3) We should have a convention like C Git for marking known break=
ages.
> > > One option is FIXME, another it so go JUnit 4 and abuse the expec=
ted exception=20
> > > annotation (using it for declaring OK exceptions is pretty bad us=
e anyway I think,
> > > so we might use it for something better), or perhaps the @Ignore =
annotation which
> > > is meant specifically for this and other cases. A FIXME can be im=
plemented right
> > > away.
> >=20
> > standard pratice for junit would be to write a test case on what yo=
u would=20
> > expect to be _correct_ behaviour. obviously that test would then fa=
il.
> > it would be a know failure in the test suite. do not go ignoring it=
=2E it's=20
> > better to keep being reminded that stuff doesn't work :-)
>=20
> What I've see so far is that people start ignoring almost any failure=
, including new ones, when the test suites contains fails with "known" =
failues. The assumption is that the failed tests were the same as befor=
e.
>=20
> Worse, automated tests have a hard time telling the difference. Curre=
ntly I ran
> the jgit tests as part of the Eclipse plugin build and I want it to s=
top if there is a problem that we don't know of.=20
>=20
> "Annotation" of different kinds can be "grepped" for so we can find t=
he broken
> cases separately and even refuse completion of release builds if we d=
ecide
> on that.=20
>=20
> Our primary UI right now is the Eclipse JUnit tests runner and I don'=
t want
> to be remined of Shawn's or whoever's bugs when trying to make sure I=
 don't
> break anything. Red =3D *I* broke something or found something new.=20
>=20
> TestNG has a nice way of classifying tests so, we could mark failures=
 as "known failures" and specifically exclude/include them when invokin=
g the
> JUnit tests.

you could use test suites to easily circumvent this in JUnit, even in
JUnit 3.x.

Just set up two test suites: one for the tests that should pass and
one for the tests with known breakages.  That way you can run either
only the "good" tests or only the broken ones.  Or even both, and you
can easily discern failures caused by known breakages from your new
breakages by looking at the tree of tests in eclipse's JUnit view.


Regards,
G=E1bor
