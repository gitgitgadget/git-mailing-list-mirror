From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH] git-send-email.perl: fix In-Reply-To for second and
 subsequent patches
Date: Fri, 15 Oct 2010 09:56:51 +0200
Message-ID: <20101015095651.b75c4b54.ospite@studenti.unina.it>
References: <1287049138-13940-1-git-send-email-ospite@studenti.unina.it>
	<20101014182250.GA18341@burratino>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__15_Oct_2010_09_56_51_+0200_RDL8KPbCI9potgo9"
Cc: git@vger.kernel.org, Stephen Boyd <bebarino@gmail.com>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 09:57:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6fA7-0006oU-1w
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 09:57:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604Ab0JOH5E (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Oct 2010 03:57:04 -0400
Received: from smtp209.alice.it ([82.57.200.105]:35334 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751058Ab0JOH5D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 03:57:03 -0400
Received: from jcn (87.3.144.99) by smtp209.alice.it (8.5.124.08) (authenticated as fospite@alice.it)
        id 4C1A275907B8DF9E; Fri, 15 Oct 2010 09:56:58 +0200
In-Reply-To: <20101014182250.GA18341@burratino>
X-Mailer: Sylpheed 3.0.2 (GTK+ 2.20.1; x86_64-pc-linux-gnu)
X-Face: z*RaLf`X<@C75u6Ig9}{oW$H;1_\2t5)({*|jhM<pyWR#k60!#=#>/Vb;]yA5<GWI5`6u&+
 ;6b'@y|8w"wB;4/e!7wYYrcqdJFY,~%Gk_4]cq$Ei/7<j&N3ah(m`ku?pX.&+~:_/wC~dwn^)MizBG !pE^+iDQQ1yC6^,)YDKkxDd!T>\I~93>J<_`<4)A{':UrE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159102>

--Signature=_Fri__15_Oct_2010_09_56_51_+0200_RDL8KPbCI9potgo9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 14 Oct 2010 13:22:50 -0500
Jonathan Nieder <jrnieder@gmail.com> wrote:

> (+cc: some send-email people)
>

For the new recipients, the original mail is here btw:
http://permalink.gmane.org/gmane.comp.version-control.git/159039

More comments below.

> Hi,
>=20
> Antonio Ospite wrote:
>=20
> > Make second and subsequent patches appear as replies to the first patch,
> > even when an initial In-Reply-To is supplied
> [...]
> > Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
>=20
> Thanks.
>

Thanks for commenting Jonathan.

> >   - When $initial_reply_to is asked to the user, it is asked as the
> >     "Message-ID to be used as In-Reply-To for the _first_ email", this
> >     makes me think that the second and subsequent patches are not using
> >     it
>=20
> This kind of justification belongs in the commit message, no?
> That way, we can save future readers the trouble of figuring out
> the rationale all over again when considering future changes to this
> code.
>

Ok, I can add this in the commit message, I am waiting some days for
v2, in case someone else has more to say.

> > --- a/git-send-email.perl
> > +++ b/git-send-email.perl
> > @@ -1313,7 +1313,7 @@ foreach my $t (@files) {
> > =20
> >  	# set up for the next message
> >  	if ($thread && $message_was_sent &&
> > -		(chain_reply_to() || !defined $reply_to || length($reply_to) =3D=3D =
0)) {
> > +		($message_num =3D=3D 1 || chain_reply_to() || !defined $reply_to || =
length($reply_to) =3D=3D 0)) {
> >  		$reply_to =3D $message_id;
>=20
> Would it be possible to break this long line?
>

I like the OR chain on the same line, but I can split it anyways if
that's the preference.

> If you're feeling particularly adventurous, it would be nice to add a
> test for the changed functionality to t/t9001-send-email.sh, so we
> don't break it with other changes in the future.
>

No promises, but I might give that a try.

> I haven't looked too deeply or even tried running applying the patch,
> but generally it looks good to me.
>=20
> Ciao,
> Jonathan
>=20

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__15_Oct_2010_09_56_51_+0200_RDL8KPbCI9potgo9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAky4CUMACgkQ5xr2akVTsAEDtACeK0myaNkykBJhcLMMQUb4KPLA
jc8AoJKxH/zmhw+6jC3BsGLZhRrFI/2N
=lOVj
-----END PGP SIGNATURE-----

--Signature=_Fri__15_Oct_2010_09_56_51_+0200_RDL8KPbCI9potgo9--
