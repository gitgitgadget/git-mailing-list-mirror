From: Sylvain Rabot <sylvain@abstraction.fr>
Subject: Re: Gitweb: Scan dir for repos & show these other specified repos
Date: Mon, 01 Mar 2010 23:22:52 +0100
Message-ID: <1267482172.4400.22.camel@kheops>
References: <4B8C1267.2050301@gmail.com>
	 <m33a0jn7ft.fsf@localhost.localdomain> <1267478419.4400.2.camel@kheops>
	 <201003012318.29548.jnareb@gmail.com>
Reply-To: sylvain@abstraction.fr
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+58Zm5z/b67Lhby1xzjp"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 01 23:23:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmE1C-0005vJ-Rn
	for gcvg-git-2@lo.gmane.org; Mon, 01 Mar 2010 23:23:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632Ab0CAWXJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Mar 2010 17:23:09 -0500
Received: from lo.gmane.org ([80.91.229.12]:44367 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751057Ab0CAWXI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Mar 2010 17:23:08 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1NmE13-0005pm-9p
	for git@vger.kernel.org; Mon, 01 Mar 2010 23:23:05 +0100
Received: from smj33-1-82-233-66-33.fbx.proxad.net ([82.233.66.33])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 23:23:05 +0100
Received: from sylvain by smj33-1-82-233-66-33.fbx.proxad.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 01 Mar 2010 23:23:05 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: smj33-1-82-233-66-33.fbx.proxad.net
In-Reply-To: <201003012318.29548.jnareb@gmail.com>
X-Mailer: Evolution 2.28.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141364>


--=-+58Zm5z/b67Lhby1xzjp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-03-01 at 23:18 +0100, Jakub Narebski wrote:
> On Mon, 1 Mar 2010, Sylvain Rabot wrote:
> > On Mon, 2010-03-01 at 11:55 -0800, Jakub Narebski wrote:
> > > "Mike.lifeguard" <mike.lifeguard@gmail.com> writes:
> > >=20
> > > > Is it possible to have gitweb show all repositories in /path/to/whe=
rever
> > > > and also show some other repositories at particular locations like
> > > > /home/user/git/repo1 and /home/user2/git/repo2 ? Or better yet, sca=
n
> > > > multiple dirs? Currently I can only see how to do one or the other
> > > > within a single gitweb installation. I suppose I could run two of t=
hem...
>=20
> > > P.S. It probably be a good idea to have something like mod_userdir,
> > > but gitweb currently doesn't support something like that.
> >=20
> > I had the same problematic some times ago. I wanted to have several
> > project's roots folder for gitweb (one for each unix user of the
> > server).
> >=20
> > You can find the discussion here :
> >=20
> > http://thread.gmane.org/gmane.comp.version-control.git/132926/
> > http://marc.info/?t=3D125827961600002&r=3D1&w=3D2
> >=20
> > Here the configuration I used :
> >=20
> > /etc/gitweb.conf :
> >=20
> > $projectroot =3D $ENV{'GITWEB_PROJECTROOT'} || "/var/gitweb";
> >=20
> > /etc/apache2/sites-available/yourvirtualhost :
> >=20
> > RewriteEngine on
> > RewriteRule ^/$ /cgi-bin/gitweb.cgi [QSA,L,PT]
> > RewriteRule ^/\~([^\/]+)/?$ /cgi-bin/gitweb.cgi
> > [QSA,E=3DGITWEB_PROJECTROOT:/home/$1/gitweb/,L,PT]
> >=20
> > I.E. :
> >=20
> > http://yourvirtualhost/ will have /var/gitweb as proeject root
> > http://yourvirtualhost/~<user>/ will have /home/<users>/gitweb as
> > proeject root
> >=20
> > You can modify the rewrite rule to match what you want to do.
>=20
> Would you mind writing it up and adding it as an example in gitweb/README=
?
> If you don't have time, I can try to do this myself in my free time.

Not at all. I will try to make it the more understandable possible and I
will send you the patch.


--=20
Sylvain Rabot <sylvain@abstraction.fr>

--=-+58Zm5z/b67Lhby1xzjp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkuMPjsACgkQ+TklUoyVcydsrwCfZizmJtLciJKEEXsIJtIEQ3mr
edQAoINKv1kKHyotHnd92IlzYsY0IYWY
=FZav
-----END PGP SIGNATURE-----

--=-+58Zm5z/b67Lhby1xzjp--
