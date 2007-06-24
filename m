From: Keith Packard <keithp@keithp.com>
Subject: Re: parsecvs fails even on simple input
Date: Sun, 24 Jun 2007 22:31:07 +0100
Message-ID: <1182720667.13289.41.camel@neko.keithp.com>
References: <20070622113625.GD12473@rkagan.sw.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1p6PIuyvTJheN4P/h8td"
Cc: keithp@keithp.com, Al Viro <viro@zeniv.linux.org.uk>,
	git@vger.kernel.org
To: Roman Kagan <rkagan@sw.ru>
X-From: git-owner@vger.kernel.org Mon Jun 25 06:47:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2gUH-00069a-02
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 06:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752928AbXFYErk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 00:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753281AbXFYErj
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 00:47:39 -0400
Received: from home.keithp.com ([63.227.221.253]:1298 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752928AbXFYErj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 00:47:39 -0400
X-Greylist: delayed 1369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 25 Jun 2007 00:47:38 EDT
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id EC6BE114313;
	Sun, 24 Jun 2007 21:24:45 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 1rtXYnVUH8Dt; Sun, 24 Jun 2007 21:24:42 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id D2E96114315; Sun, 24 Jun 2007 21:24:42 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id A8133114309;
	Sun, 24 Jun 2007 21:24:42 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id AA9AD6AC00D; Sun, 24 Jun 2007 21:24:41 -0700 (PDT)
In-Reply-To: <20070622113625.GD12473@rkagan.sw.ru>
X-Mailer: Evolution 2.10.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50857>


--=-1p6PIuyvTJheN4P/h8td
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2007-06-22 at 15:36 +0400, Roman Kagan wrote:

> The problem is the following: after that commit parsecvs tries to add
> objects to the git tree on its own via calls to libgit; however, in
> between it runs git-pack-objects.  Thus objects move to pack files
> without libgit being aware of it; this results in 'ivalid object'
> errors.

Sticking a call to reprepare_packed_git() after the pack creation fixes
this nicely.

>  Wouldn't it be better to teach parsecvs
> to speak git-fast-import language instead?

Avoiding fork/exec is rather important for parsecvs perforamance.

--=20
keith.packard@intel.com

--=-1p6PIuyvTJheN4P/h8td
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGfuKbQp8BWwlsTdMRAijeAJ49JGFiwxsiNFNlt/DHGUwt9Y9u3QCfRsjb
31MMuhjVqQ7h54jII8wLO4I=
=BIZI
-----END PGP SIGNATURE-----

--=-1p6PIuyvTJheN4P/h8td--
