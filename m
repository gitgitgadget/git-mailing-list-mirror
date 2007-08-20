From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax
	mean.
Date: Mon, 20 Aug 2007 20:08:09 +0200
Message-ID: <20070820180809.GA8542@efreet.light.src>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <7v4piuafqy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Cc: Steven Grimm <koreth@midwinter.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 20 20:08:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INBft-00032u-QI
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 20:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481AbXHTSIW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 14:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbXHTSIW
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 14:08:22 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:42685 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751247AbXHTSIV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 14:08:21 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 5E955572AE;
	Mon, 20 Aug 2007 20:08:20 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id wNX4cMvuBk2E; Mon, 20 Aug 2007 20:08:17 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id C174C57282;
	Mon, 20 Aug 2007 20:08:11 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1INBfd-0006Z0-T6; Mon, 20 Aug 2007 20:08:09 +0200
Content-Disposition: inline
In-Reply-To: <7v4piuafqy.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56232>


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 19, 2007 at 23:20:53 -0700, Junio C Hamano wrote:
> Steven Grimm <koreth@midwinter.com> writes:
>=20
> > Junio C Hamano wrote:
> >> People should learn this command.  Really.
> >>
> >>       $ git cat-file -p :$n:path
> >>
> >> where $n =3D=3D 2 is ours, $n =3D=3D 1 is common ancestor, and $n =3D=
=3D 3
> >> is theirs.
> >
> > The git-rev-parse manpage talks about the :$n:path notation (buried dee=
p in
> > a list of other syntax) but it just says $n is a "stage number" -- some=
one
> > who is not familiar with the internals of git's merge implementation is
> > never going to be able to figure out that "1", "2", and "3" mean what J=
unio
> > said.
>=20
> The patch makes sense.  Thanks.
>=20
> Just to give historical background to new readers, this is
> primarily because the really core level of the plumbing started
> as not caring between stages 2 and 3 (iow, as far as the merge
> is concerned, both heads are equal), and the description in the
> manual was written back then.
>=20
> These days, all the merge strategies and other non-merge
> programs such as "git am" that can record conflicts as
> multi-stage index entries consistently use stage #2 as our
> version, and stages #2 and #3 are not equals anymore.

Pardon me? In what are they not equal?

In merge, the parents *are* equall. They are just recorded in the resulting
commit in particular order and the stages are in that order.

Besides if I prepare a merge locally to push out to a shared repo, I will
probably switch to the mainline and merge my branch in, so it will actually
be my changes in stage #3. That is to say 'ours' and 'theirs' don't really
express what is going on IMHO.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGydiJRel1vVwhjGURAtfKAKCI14oZw0VrIgz51i/wT02jgj+tKQCaAtrc
Wq5tHBNNh+9dmEV69NDjfSk=
=wcDi
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
