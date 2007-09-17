From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 0/3] the return of the strbuf
Date: Mon, 17 Sep 2007 15:35:22 +0200
Message-ID: <20070917133522.GD18176@artemis.corp>
References: <20070917125211.GA18176@artemis.corp>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/e2eDi0V/xtL+Mc8";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 15:35:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXGlF-00044c-UX
	for gcvg-git-2@gmane.org; Mon, 17 Sep 2007 15:35:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928AbXIQNf2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 09:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754891AbXIQNf2
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 09:35:28 -0400
Received: from pan.madism.org ([88.191.52.104]:33699 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754850AbXIQNf0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 09:35:26 -0400
Received: from madism.org (beacon-free2.intersec.com [82.236.12.71])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 125C92021F;
	Mon, 17 Sep 2007 15:35:22 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 5D131344A80; Mon, 17 Sep 2007 15:35:22 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20070917125211.GA18176@artemis.corp>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58440>


--/e2eDi0V/xtL+Mc8
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On lun, sep 17, 2007 at 12:52:11 +0000, Pierre Habouzit wrote:
>   While getting rid of ->eof in strbuf (as it was somehow tasteless). It
> made me aware of the fact that fast-import.c was using a custom buffer
> implementation (I think that was the fourth if not the fifth). So here
> is the series that eradicates it.
>=20
>   Trying to understand fast-import.c code, I happened to remark that it
> was possible to avoid many reallocations, just by reusing old buffers
> rather than dropping them (this was not possible in a readable way
> before, but it is now, and uses the same mechanisms that was garbage
> collecting buffers, to swap them instead).
>=20
>   I've not enough stuff to do real-life tests of the old fast-import and
> the new one, but I wouldn't be surprised that it gives a quite nice
> speed improvements for tools that use long fast-import batches. If not,
> well, the code is shorter and more readable, hence it's still a gain.

Shawn: Johannes makes me remark that you are git-fast-import author,
hence may want to be Cc-ed of that series, so here is a mail so that you
don't miss the thread.


The list: it's often hard to know who you should Cc on a given change,
I use format.headers to force Junio and git@, but sometimes you want a
different set of persons. I wonder if this could not be wired in the
repository, as a .gitattribute extension ?


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/e2eDi0V/xtL+Mc8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBG7oKavGr7W6HudhwRAuJ5AJ42hDOlmx8KVqCZiWc/uTahrINWdwCdE2GA
+FEkY2IdGsCpiwzIe0p7I6U=
=BraK
-----END PGP SIGNATURE-----

--/e2eDi0V/xtL+Mc8--
