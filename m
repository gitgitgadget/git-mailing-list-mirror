From: Jason McMullan <jason.mcmullan@timesys.com>
Subject: Re: [PATCH] ls-tree path restriction semantics fixes
Date: Fri, 27 May 2005 15:26:25 -0400
Message-ID: <1117221986.11542.29.camel@jmcmullan.timesys>
References: <20050527120851.GA11823@port.evillabs.net>
	 <7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-o30h2uJ5lml7mdH93YG2"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 27 21:25:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbkRY-0003qQ-TC
	for gcvg-git@gmane.org; Fri, 27 May 2005 21:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbVE0T0f (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 15:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVE0T0f
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 15:26:35 -0400
Received: from mail.timesys.com ([65.117.135.102]:58180 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S262542AbVE0T0a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 15:26:30 -0400
Received: from jmcmullan by owa.timesys.com; 27 May 2005 15:26:26 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmzqgzg8a.fsf@assigned-by-dhcp.cox.net>
X-Mailer: Evolution 2.0.4-3mdk 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-o30h2uJ5lml7mdH93YG2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-05-27 at 11:16 -0700, Junio C Hamano wrote:
> What you really want is something similar to '-d' flag to
> /bin/ls.  You are interested in the directory itself not its
> contents and I think your gripe is that giving a path that
> matches a tree always descends into it (i.e. there is no way to
> do the equivalent of "/bin/ls -d t").  I agree that it is a
> problem, but changing "/bin/ls t" not to show the directory
> contents of "t" is not a solution.

  git-ls-tree reporting just the tree's hash is valid, because if
you want everything in that tree, you can just do:

git-ls-tree `git-ls-tree HEAD path/dir | (read m t h n; echo $h)`

  I don't see the problem there.


> JM> 	$ git-ls-tree t t
> JM> 	040000 tree 4eeb3990955b8badc4c14712b89d8cd9fff02f15    t
>=20
> I do not know what you wanted to say in this example.  Your
> "Old" and "New" look the same to me.

The problem was that 't' and 't t' produced *vastly* different output
in the old code. 't' would emit everything in the tree, and 't t' would
only emit t's hash.

--=20
Jason McMullan <jason.mcmullan@timesys.com>
TimeSys Corporation


--=-o30h2uJ5lml7mdH93YG2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCl3Rh8/0vJ5szK6kRArWhAJ4mBEAUHDDCaztcFLvAiun999z84wCfal+j
25Xm870+I0W3wMTwUNq3E3M=
=lJQb
-----END PGP SIGNATURE-----

--=-o30h2uJ5lml7mdH93YG2--
