From: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
Subject: Re: Grafting mis-aligned trees.
Date: Fri, 28 Nov 2008 17:01:41 -0600
Message-ID: <200811281701.46778.bss03@volumehost.net>
References: <200811171645.12869.bss03@volumehost.net> <492289B0.4010903@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart17058806.uHhGe2TyN9";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 29 00:21:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6CeD-0002Jn-F0
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 00:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752792AbYK1XUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 18:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752737AbYK1XUA
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 18:20:00 -0500
Received: from ispmxmta05-srv.windstream.net ([166.102.165.166]:51317 "EHLO
	ispmxmta05-srv.windstream.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752719AbYK1XT7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Nov 2008 18:19:59 -0500
X-Greylist: delayed 1110 seconds by postgrey-1.27 at vger.kernel.org; Fri, 28 Nov 2008 18:19:59 EST
Received: from ispmxaamta08-gx.windstream.net ([75.88.61.195])
          by ispmxmta09-srv.windstream.net with ESMTP
          id <20081128230129.NFVM4904.ispmxmta09-srv.windstream.net@ispmxaamta08-gx.windstream.net>
          for <git@vger.kernel.org>; Fri, 28 Nov 2008 17:01:29 -0600
Received: from dellbuntu.local ([75.88.61.195])
          by ispmxaamta08-gx.windstream.net with ESMTP
          id <20081128230128.XAZK28131.ispmxaamta08-gx.windstream.net@dellbuntu.local>;
          Fri, 28 Nov 2008 17:01:28 -0600
User-Agent: KMail/1.9.5
In-Reply-To: <492289B0.4010903@drmicha.warpmail.net>
X-Cloudmark-Analysis: v=1.0 c=1 a=rsX2rq0AEOEA:10 a=TqwAxd0Lru9OIGmNjrdj4Q==:17 a=nEQGfrJnAAAA:8 a=BS5PqrctaiS_SiKqIMMA:9 a=MQcxfPdgKszcUyUZaZAA:7 a=mOIU4zlKNjlP-WLO1xvCFiaIak4A:4 a=B7iFY6Z7H_gA:10 a=LY0hPdMaydYA:10 a=kWmb-7g0p9el90t-FqgA:9 a=nIx1w3Re_KRuysL3fE_OTcQQWrUA:4 a=rPt6xJ-oxjAA:10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101891>

--nextPart17058806.uHhGe2TyN9
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 2008 November 18 03:24, Michael J Gruber wrote:
> Boyd Stephen Smith Jr. venit, vidit, dixit 17.11.2008 23:45:
> > I haven't gotten a response from my subscription email, so please CC me
> > on any replies.
> >
> > So, I've been managaing the source I had from a client project in git a=
nd
> > have a non-linear history.  Currently, two tips (production and testing)
> > but there are many feature branches that were git-merge'd in, not
> > rebased.
> >
> > Now, I've gotten the full tree.  Turns out all the source code I was
> > working on was in a subdirectory "project/web".  I'd like to "graft" the
> > *changes* I made onto the full tree.
> >
> > I figured this might be a job for git-filter-branch.  Certainly, that d=
id
> > the job of moving all my changes into the subdirectory.  But, now I want
> > to do something that's a combination or git-rebase and git-filter-branc=
h.
> >  I want to replay the *patches/deltas* (like rebase) on top of the full
> > tree I have, but *maintain the non-liear history* (like filter-branch).
> >
> > Can anyone think of a recipe for me?
> >
> > Trees look something like this right now.
> >
> > <some history> -> FT
> >
> > TI -> <non-linear history> -> A -> <non-linear history> -> C
> >    \                            \                           \
> >     -> PI ------------------------> B ------------------------> D
> >
> > I'd like to have it look something like:
> >
> > <some history> -> FT -> <non-linear history> -> A' -> <non-linear
> > history> -> C' \                            \                          =
 \
> > -> PI' ----------------------> B' -----------------------> D'
> >
> > A', B', C', and D' are different commits, but the diff (and history)
> > between FT and A' is the same as the diff (and history) between TI and =
A.
> >
> > Again, please CC me on any replies.
>
> [CCing is customary here anyways.]
>
> So, your base directory for TI and FT is different, right? I.e.: In the
> TI repo, your project sits at the root, whereas in the FT repo it sits
> in project/web?

Yes.

> Has FT advanced since you took the initial subdir=20
> snapshot for TI?

No.  Well, maybe.  I think the subdir diff is fairly trivial if not empty. =
 TI=20
is an import from the code actually present on the testing server.  FT was=
=20
the a subversion repository obtained later after some hullabaloo with the=20
ex-development house.

Right now this tree is effectively all mine, so I can always graft in commi=
ts=20
to synchronize the common subtree of FT and TI, if that makes things easier.
=2D-=20
Boyd Stephen Smith Jr. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ,=3D ,-_-. =
=3D.=20
bss03@volumehost.net =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0((_/)o o(\_=
))
ICQ: 514984 YM/AIM: DaTwinkDaddy =A0 =A0 =A0 =A0 =A0 `-'(. .)`-'=20
http://iguanasuicide.org/ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\_/ =
=A0 =A0=20

--nextPart17058806.uHhGe2TyN9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJMHhadNbfk+86fC0RAkqwAJ9BieeT07ergoT4iHONx4BvUqRd7wCeMeHT
HgfB/r/x++l9mtUCS3PKUUc=
=slnc
-----END PGP SIGNATURE-----

--nextPart17058806.uHhGe2TyN9--
