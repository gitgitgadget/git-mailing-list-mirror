From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [RFC/PATCH] Make git-{pull,rebase} no-tracking message
 friendlier
Date: Wed, 29 Feb 2012 18:34:03 +0100
Message-ID: <1330536843.22763.19.camel@beez.lab.cmartin.tk>
References: <1330013115-26355-1-git-send-email-cmn@elego.de>
	 <vpq399wc4ns.fsf@bauges.imag.fr>
	 <1330487854.691.24.camel@centaur.lab.cmartin.tk>
	 <vpqbooit61u.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-rLYu/6akRs3BWrW+TpXd"
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Feb 29 18:35:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2nR1-0002LU-Nn
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 18:35:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031241Ab2B2RfW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 12:35:22 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:40664 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030904Ab2B2RfW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 12:35:22 -0500
Received: from [10.10.10.234] (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 1634546057;
	Wed, 29 Feb 2012 18:35:15 +0100 (CET)
In-Reply-To: <vpqbooit61u.fsf@bauges.imag.fr>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191836>


--=-rLYu/6akRs3BWrW+TpXd
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2012-02-29 at 09:09 +0100, Matthieu Moy wrote:
> Carlos Mart=C3=ADn Nieto <cmn@elego.de> writes:
>=20
> > $example is a caller-given string which already contains the whole
> > command (i.e. it's already 'git rebase <upstream branch>' or 'git pull
> > <repository> <branch>').
>=20
> OK, I didn't remember the exact message.
>=20
> > In this patch I've moved that command to its own paragraph so the
> > usage part of the output gets more visibility.
>=20
> I prefer this, yes.
>=20
> Perhaps we could go further and try to guess a remote and a branch name
> to give in the example. "git push" already does that to some extend:
>=20
>   $ git -c push.default=3Dtracking push
>   fatal: The current branch my-branch has no upstream branch.
>   To push the current branch and set the remote as upstream, use
>  =20
>       git push --set-upstream origin my-branch
>=20
> i.e. if there's a remote configured, then using it in the example makes
> sense. I'm not sure if using the current branch name in the example
> would also be a good thing (it usually is for "push" because most users
> would push to a branch with the same name on the remote end).

We do show the branch name in the 'remote add' text at the end, so we
should probably try to use it here as well. What I'm assuming is the
most usual case of one remote called 'origin' shouldn't be a problem. I
think I'll suppress the last part of the output when there are remotes
configured, as we can probably assume that the user is aware of them.

I'm tempted to throw out the second block and say to use either 'git
pull $remote $branch' or 'git branch --set-upstream $branch
$remote/$branch' and refer to the documentation for more. After all,
this is an error message, not a man page.

>=20
> It may also make sense not to suggest "git remote add" if there's
> already a remote configured. Otherwise, the case, which is probably the
> most common, of:
>=20
>   git clone http://example.com/repo
>   cd repo
>   git checkout -b new-branch
>   git pull
>=20
> is made far more complex than it should for the newcommer.

Indeed. Removing the last part is probably better for everyone.

   cmn


--=-rLYu/6akRs3BWrW+TpXd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPTmGLAAoJEHKRP1jG7ZzTYo4H/RhpDxZJeiRBsvqQDD8ElblS
0oucBDUaoZgm9KP2c1xpbk+ZNV6JlqpOqn8jkn/B8WSzSKl68dA1n8qFtVCtRc/F
duXEJ9M4vnAbxX3rcTiPNO613d3w50/kRU/R8w2vokzmIOT3Xhfr4kVTuySKK+G9
P7dIXBA3mZXEAV6J62gDjVTPRduBxNPg7hUW4NygVKqnw6HMHoedrTSVC3QDUz5V
SI1KEBI+wHjGJJWF9EZM+CpBcqpb9SvSGCjrF5cgZq8ZhxnrPh/GBDC2br5idyp5
7MTgHIrU0ir1pnMUMH5quvLIDdq5jFZslLF08ELnBmd9zq4qY1FB4ugy9F7xoRY=
=eLYs
-----END PGP SIGNATURE-----

--=-rLYu/6akRs3BWrW+TpXd--
