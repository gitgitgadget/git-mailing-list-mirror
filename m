From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] rebase with preserve merges should not show merged
	commits
Date: Sat, 22 Mar 2008 16:37:55 +0100
Message-ID: <20080322153755.GA3498@alea.gnuu.de>
References: <1206148785-29466-1-git-send-email-joerg@alea.gnuu.de> <20080322015252.GA7570@atjola.homenet> <20080322140648.GA3189@alea.gnuu.de> <20080322151234.GA19558@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: git@vger.kernel.org
To: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 22 16:57:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jd65y-0007lO-5z
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 16:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905AbYCVP4i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 11:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbYCVP4i
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 11:56:38 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3055 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751709AbYCVP4g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 11:56:36 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 1C514488030; Sat, 22 Mar 2008 16:56:34 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd5nA-0002bY-Qj; Sat, 22 Mar 2008 16:37:56 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jd5nA-0000wF-0E; Sat, 22 Mar 2008 16:37:56 +0100
Content-Disposition: inline
In-Reply-To: <20080322151234.GA19558@atjola.homenet>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77818>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hallo Bj=C3=B6rn,

Bj=C3=B6rn Steinbrink schrieb am Sat 22. Mar, 16:12 (+0100):
> On 2008.03.22 15:06:48 +0100, J=C3=B6rg Sommer wrote:
> > Bj=C3=B6rn Steinbrink schrieb am Sat 22. Mar, 02:52 (+0100):
> > > On 2008.03.22 02:19:42 +0100, J=C3=B6rg Sommer wrote:
> > > > The current version of git-rebase--interactive shows the user the c=
ommits
> > > > coming from a merge.
> > > >=20
> > > > M---A---B
> > > >  \       \
> > > >   o---o---+---o branch
> > > >=20
> > > > Rebasing branch on M with preserve merges gives the commits A and B=
=2E But
> > > > if you mark them for editing or remove them the rebase fails. You m=
ust
> > > > keep them as they are. It's useless to bother the user with these c=
ommits
> > > > and might lead to mistakes.
> > >=20
> > > Uhm, why do you completely remove the possibility to edit A
> >=20
> > Ahh, now I see what you've tried to say. I did add the option
> > --first-parent for rebase interactive *without* preserve merges, too.
> > I'll update my patch.
>=20
> I didn't even look at it closely enough to notice that.
> --preserve-merges preserves the structure of the history. You seem to
> interpret it as to preserve the merges against the original parents,
> except for the first one,

Yes, exactly this is my intent.

> and that's simply not what it's meant to do.

That's a pity. So it's meant to be for such cases:

M---A---B
 \       \
  o---C---+---o branch

M---A---B
|    \
|     `-B'
 \       \
  o---C'--+---o branch

> I can see how that might be useful, but you'd have to add that as an
> additional mode of operation, and not break the normal one.

What's the intention of the patch that adds --first-parent somewhere that
you've mentioned in the IRC?

I would like to send some tests for bugs I've seen. How do I correctly
cleanup after rebase failed? It's necessary to not break following tests.

test_expect_failure '=E2=80=A6' '
	=E2=80=A6
	git rebase -i =E2=80=A6
'

Should I do something like this:

test_expect_failure '=E2=80=A6' '
	=E2=80=A6
	if !git rebase -i =E2=80=A6;
	then
		git rebase --abort;
		false
	fi
'

Bye, J=C3=B6rg.
--=20
Manchmal denke ich, das sicherste Indiz daf=C3=BCr, da=C3=9F anderswo im Un=
iversum
intelligentes Leben existiert, ist, da=C3=9F niemand versucht hat, mit uns
Kontakt aufzunehmen.                           (Calvin und Hobbes)

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH5SfTwe0mZwH1VIARAqLFAJ41w7SIUQCkJrIauL5Ib6CNhPdTJwCgh6dA
nrvzp026bnn46Yx3L8bgvy4=
=MUUG
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
