From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-filter-branch: Add an example on how to remove empty commits
Date: Thu, 30 Oct 2008 14:26:23 +0100
Message-ID: <20081030132623.GC24098@artemis.corp>
References: <1225326833-15210-1-git-send-email-pasky@suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ZwgA9U+XZDXt4+m+";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Sverre Rabbelier <srabbelier@gmail.com>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu Oct 30 14:27:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvXYr-0004EH-CM
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 14:27:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694AbYJ3N01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 09:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753892AbYJ3N00
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 09:26:26 -0400
Received: from pan.madism.org ([88.191.52.104]:39177 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753652AbYJ3N00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 09:26:26 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1A3E6221;
	Thu, 30 Oct 2008 14:26:25 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id BDCF75EE23C; Thu, 30 Oct 2008 14:26:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1225326833-15210-1-git-send-email-pasky@suse.cz>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99468>


--ZwgA9U+XZDXt4+m+
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2008 at 12:33:53AM +0000, Petr Baudis wrote:
> From: Sverre Rabbelier <srabbelier@gmail.com>
>=20
> Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---
>  Documentation/git-filter-branch.txt |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
>=20
> diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filt=
er-branch.txt
> index fed6de6..2565244 100644
> --- a/Documentation/git-filter-branch.txt
> +++ b/Documentation/git-filter-branch.txt
> @@ -246,6 +246,21 @@ git filter-branch --commit-filter '
>  	fi' HEAD
>  ------------------------------------------------------------------------=
------
> =20
> +To remove commits that are empty (do not introduce any change):
> +
> +------------------------------------------------------------------------=
------
> +git rev-list HEAD | while read c; do [ -n "$(git diff-tree --root $c)" ]=
 || echo $c; done > revs
> +
> +git filter-branch --commit-filter '
> +  if grep -q "$GIT_COMMIT" '"$(pwd)/"revs';
> +  then
> +    skip_commit "$@";
> +  else
> +    git commit-tree "$@";
> +  fi' HEAD
> +
> +------------------------------------------------------------------------=
------

Why not add an option to filter-branch that removes a commit if it's
empty ? It's quite useful, it helps the user concentrating on just
keeping what matches *his* criteriums, and not caring about the minor
details of cleansing the result.
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkJtf8ACgkQvGr7W6HudhznSACgjXWJwUPAeaLbohxiGy3BVopH
XUQAn2jQwfQgbqFqbA6om2ap7VQpfVl4
=JlSh
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
