From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 04/15] Add new test to ensure git-merge handles
	pull.twohead and pull.octopus
Date: Sat, 5 Jul 2008 02:26:34 +0200
Message-ID: <20080705002634.GF4729@genesis.frugalware.org>
References: <cover.1214581610.git.vmiklos@frugalware.org> <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org> <e2b179460807040934m27e752e7s4f6a786d45d3bc53@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F1UMmCLUB5xxGl5w"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Olivier Marin <dkr@freesurf.fr>
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 02:27:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEvcm-0004Ao-16
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 02:27:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYGEA0i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jul 2008 20:26:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752523AbYGEA0i
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jul 2008 20:26:38 -0400
Received: from virgo.iok.hu ([193.202.89.103]:57803 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752317AbYGEA0h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jul 2008 20:26:37 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 24DBD1B24FE;
	Sat,  5 Jul 2008 02:26:35 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 1CBA44465E;
	Sat,  5 Jul 2008 01:55:47 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7AB7911901F1; Sat,  5 Jul 2008 02:26:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <e2b179460807040934m27e752e7s4f6a786d45d3bc53@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87425>


--F1UMmCLUB5xxGl5w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 04, 2008 at 05:34:05PM +0100, Mike Ralphson <mike.ralphson@gmai=
l.com> wrote:
> > +conflict_count()
> > +{
> > +       eval $1=3D`{
> > +               git diff-files --name-only
> > +               git ls-files --unmerged
> > +       } | wc -l`
> > +}
> > +
>=20
> This here causes the test to fail on AIX (and likely other OS, such as
> apparently OSX) where wc -l outputs whitespace. See
> http://article.gmane.org/gmane.comp.version-control.git/80450
>=20
> Here we want the line count not just a return value, so is the
> following acceptable?
>=20
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index 32585f8..9b6097d 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -73,7 +73,7 @@ conflict_count()
>         eval $1=3D`{
>                 git diff-files --name-only
>                 git ls-files --unmerged
> -       } | wc -l`
> +       } | wc -l | tr -d \ `
>  }

At least it does not break the test for me on Linux. But haven't this
cause you problems in git-merge.sh?  I copied this code chunk from
there.

> Anyway, I thought we preferred $() to backticks?

See above, but sure, we can.

--F1UMmCLUB5xxGl5w
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkhuv7oACgkQe81tAgORUJZULgCeL6n0kMQo8lAh/U0BH8cXuxFQ
h7UAnj4SHBGWdRzDEV3RZXduZ0jJfFgn
=DHA4
-----END PGP SIGNATURE-----

--F1UMmCLUB5xxGl5w--
