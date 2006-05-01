From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Transitively read alternatives
Date: Tue, 2 May 2006 00:53:35 +0200
Message-ID: <20060501225335.GI20847@admingilde.org>
References: <20060501203631.GH20847@admingilde.org> <7v1wvdsbuj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WlEyl6ow+jlIgNUh"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 02 00:53:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FahGy-0004ZU-Vr
	for gcvg-git@gmane.org; Tue, 02 May 2006 00:53:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWEAWxh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 1 May 2006 18:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWEAWxh
	(ORCPT <rfc822;git-outgoing>); Mon, 1 May 2006 18:53:37 -0400
Received: from admingilde.org ([213.95.32.146]:8934 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932306AbWEAWxg (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 May 2006 18:53:36 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1FahGp-0002wx-I0; Tue, 02 May 2006 00:53:35 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wvdsbuj.fsf@assigned-by-dhcp.cox.net>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19392>


--WlEyl6ow+jlIgNUh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, May 01, 2006 at 01:56:36PM -0700, Junio C Hamano wrote:
> If you have a local copy of Linus, Jeff and David trees, you
> could arrange Jeff tree to borrow from Linus and David, and
> David tree to borrow from Linus and Jeff.  I wonder what the new
> code does when you add a new repository that borrows from Jeff
> and David.  Does it borrow from Linus twice?  Four times?  Does
> it stop without falling into endless recursion?  I did not do
> this myself because I was lazy and did not want to address these
> issues.

I haven't tested these corner cases extensively yet, but from reading
the code it should behave like this:

If you have loops or multiple references to the same repository then
only the first occurance is used.  When reading a reference to an alternate
object store for the second time it is simply ignored.

But of course you should be careful when you set up alternate files.
Having two repositories reference each other and then simultanously
running git-prune in both is obviously not a good idea ;-).

=2E.. more testing ...

Well of course practice and reality always differ... I'll send an
updated patch shortly ;-)

--=20
Martin Waitz

--WlEyl6ow+jlIgNUh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEVpFuj/Eaxd/oD7IRAqGnAJoCqCVCofui6DgF8QKtjqnlbubWagCfW9q/
tPTpi8JmjsbTtQUNPplelVk=
=+V4R
-----END PGP SIGNATURE-----

--WlEyl6ow+jlIgNUh--
