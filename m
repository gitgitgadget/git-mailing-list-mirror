From: Kai Blin <kai@samba.org>
Subject: Re: Directory renames without breaking git log.
Date: Thu, 4 Sep 2008 22:52:34 +0200
Message-ID: <200809042252.37329.kai@samba.org>
References: <200809032338.35359.kai@samba.org> <200809042145.09573.kai@samba.org> <7vtzcv1yk8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2728509.jmnxuI4eQ1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 22:53:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KbLpq-0004Xt-DN
	for gcvg-git-2@gmane.org; Thu, 04 Sep 2008 22:53:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754353AbYIDUwj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2008 16:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754157AbYIDUwi
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Sep 2008 16:52:38 -0400
Received: from mail.samba.org ([66.70.73.150]:60390 "EHLO lists.samba.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752026AbYIDUwi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2008 16:52:38 -0400
Received: from ip6-localhost (localhost [127.0.0.1])
	by lists.samba.org (Postfix) with ESMTP id E169316394D;
	Thu,  4 Sep 2008 20:52:33 +0000 (GMT)
User-Agent: KMail/1.9.9
In-Reply-To: <7vtzcv1yk8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94957>

--nextPart2728509.jmnxuI4eQ1
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 04 September 2008 21:49:27 Junio C Hamano wrote:

> > git blame still works, and git log --sparse path/to/file works, of
> > course. --sparse makes giving a path a bit pointless, of course, but we
> > probably can live with that for time being. I'm still open for
> > suggestions, of course. :)
>
> Give both directories, like:
>
> 	"git log -- newdir olddir"
>
> perhaps?

Better, but really ugly, as we'll have to keep doing this for the rest of t=
he=20
project's life to get the full history. And while it's all nice and fun for=
=20
git log -- source3/configure.in source/configure.in, it's less fun for deep=
er=20
paths.

We'll probably end up just doing a git-filter-branch renaming the samba3=20
source dir source3 from the beginning and the samba4 source dir source4 fro=
m=20
the beginning, and then do the octopus merge. Without any paths changing,=20
that should probably work. It's a bit annoying to break all external=20
branches, but we only need to do this once, and people will only need to=20
git-format-patch and git-am once, and we can provide a step-by-step guide f=
or=20
this as well.

Thanks for the feedback, though. :)

Cheers,
Kai

=2D-=20
Kai Blin
WorldForge developer  http://www.worldforge.org/
Wine developer        http://wiki.winehq.org/KaiBlin
Samba team member     http://www.samba.org/samba/team/
=2D-
Will code for cotton.

--nextPart2728509.jmnxuI4eQ1
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBIwEqVEKXX/bF2FpQRApbqAJ9VKpLZUZ1gLzj8y/zUbvxb+XVfBgCdFKaC
M3ELpumFhHm8TOkCvzaLK5Q=
=Deav
-----END PGP SIGNATURE-----

--nextPart2728509.jmnxuI4eQ1--
