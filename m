From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: parsecvs losing files
Date: Wed, 28 May 2008 19:03:32 +0200
Message-ID: <20080528170332.GB16996@artemis.madism.org>
References: <b2cdc9f30805280750v3b92d115yf76f382e5c2fa418@mail.gmail.com> <b2cdc9f30805280953l40ce9e37m1fb558e541ef89c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="uZ3hkaAS1mZxFaxD";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: keithp@neko.keithp.com
X-From: git-owner@vger.kernel.org Wed May 28 19:04:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1P4j-0005Vl-Ff
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:04:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbYE1RDm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 13:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751391AbYE1RDm
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 13:03:42 -0400
Received: from pan.madism.org ([88.191.52.104]:52914 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751340AbYE1RDl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 13:03:41 -0400
Received: from madism.org (APuteaux-155-1-52-172.w86-217.abo.wanadoo.fr [86.217.43.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 8A6C139AEF;
	Wed, 28 May 2008 19:03:34 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C6FCD4606; Wed, 28 May 2008 19:03:32 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	keithp@neko.keithp.com, Alex Bennee <kernel-hacker@bennee.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <b2cdc9f30805280953l40ce9e37m1fb558e541ef89c3@mail.gmail.com>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83112>


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

  Sorry for the top posting but the git list isn't really the upstream
for parsecvs. I'm now Cc-ing keithp who is the author :)

On Wed, May 28, 2008 at 04:53:30PM +0000, Alex Bennee wrote:
> On Wed, May 28, 2008 at 3:50 PM, Alex Bennee <kernel-hacker@bennee.com> w=
rote:
> > Hi,
> > <snip>
> > Anyway today I noticed it had failed to import a sub-directory of the
> > project (not a bit I usually build). However looking at the import log
> > from parsecvs I see that the file was read by parsecvs. It looks as
> > though it should have made it into the git repo. The only thing that
> > seems different from the other modules is that the files where
> > imported once and don't seem to have been touched since. This may of
> > caused parsecvs to get confused?
>=20
> Well in answer to myself parsecvs does get confused. In an example
> failed to import file:
>=20
> Load:                          third-party/libxml/runtest.c,v   8207 of 7=
9070
> /export/git/master.cvs/third-party/libxml/runtest.c,v spliced:
> 	 1.1.1.1
> 	 1.1
> Sorted heads for /export/git/master.cvs/third-party/libxml/runtest.c,v
> 	master 1.1
> 	master > BRANCH-3-5-branch 1.1.1.1.0.2
> 	master > BRANCH-3-5-16-branch 1.1.1.1.0.4
> building branches for /export/git/master.cvs/third-party/libxml/runtest.c=
,v
> file sha1: b694d565caf10fedbc7566f2bf15b893c57d5a19
> file sha1: b694d565caf10fedbc7566f2bf15b893c57d5a19
> file has 2 revisions
>=20
> An lo, looking at the branches mentioned these missing files are
> there. Trouble is the files should be in a number of branches, looking
> at the ,v file in question:
>=20
> head	1.1;
> branch	1.1.1;
> access;
> symbols
> 	BRANCH-3-5-26-1:1.1.1.1
> 	BRANCH-3-5-25-1:1.1.1.1
> 	BRANCH-3-5-24-1:1.1.1.1
> 	BRANCH-3-5-22-3:1.1.1.1
> 	BRANCH-3-5-22-1:1.1.1.1
> 	BRANCH-3-5-21-1:1.1.1.1
> 	BRANCH-3-5-20-1:1.1.1.1
> 	BRANCH-3-5-16-7:1.1.1.1
> 	BRANCH-3-5-19-1:1.1.1.1
> 	BRANCH-3-5-16-6:1.1.1.1
> 	BRANCH-3-5-16-5:1.1.1.1
> 	BRANCH-3-5-18-1:1.1.1.1
> 	BRANCH-3-5-16-4:1.1.1.1
> 	BRANCH-3-5-16-branch:1.1.1.1.0.4
> 	BRANCH-3-5-17-1:1.1.1.1
> 	BRANCH-3-5-16-3:1.1.1.1
> 	BRANCH-3-5-16-2:1.1.1.1
> 	BRANCH-3-5-16-1:1.1.1.1
> 	post-merge-of-ajz-post-3-5-branch:1.1.1.1
> 	pre-merge-of-ajz-post-3-5-branch:1.1.1.1
> 	BRANCH-3-5-15-1:1.1.1.1
> 	BRANCH-3-5-14-1:1.1.1.1
> 	BRANCH-3-5-branch:1.1.1.1.0.2
> 	BRANCH-3-5-13-1:1.1.1.1
> 	BRANCH-3-5-12-1:1.1.1.1
> 	BRANCH-3-5-11-1:1.1.1.1
> 	BRANCH-3-5-10-1:1.1.1.1
> 	BRANCH-3-5-9-2:1.1.1.1
> 	BRANCH-3-3-20-red-e1-opt-branch:1.1.1.1
> 	GNOME_LIBXML2_2_6_29:1.1.1.1
> 	GNOME:1.1.1;
> locks; strict;
> comment	@ * @;
>=20
>=20
> 1.1
> date	2007.08.16.15.59.35;	author jbpn;	state Exp;
> branches
> 	1.1.1.1;
> next	;
>=20
> 1.1.1.1
> date	2007.08.16.15.59.35;	author jbpn;	state Exp;
> branches;
> next	;
>=20
>=20
> desc
> @@
>=20
>=20
>=20
> 1.1
> log
> @Initial revision
> <snip rest of file>
>=20
> I'm not sure why parsecvs got this wrong, I'm digging through it but
> I'm a little fuzzy where lex/bison/whatever is involved. I notice
> looking at the log for some of the files that did make it that the CVS
> revisions for all the branches have a .0.[something] suffix which the
> missing branches in this case don't have. However CVS is very sure the
> file exists in these other branches.
>=20
> Could this be something to do with explicit branches and sticky branch
> tags? Or just a straight bug in parsecvs?
>=20
>=20
> --=20
> Alex, homepage: http://www.bennee.com/~alex/
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIPZBkvGr7W6HudhwRAjIVAJ9eh2WjH3mj4KiYl7HoALV55Q3bsgCgi6xn
t5rNk15juPf834CxjxuIPK4=
=SULm
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
