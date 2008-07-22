From: Pierre Habouzit <madcoder@debian.org>
Subject: [SCNR] Re: [FYI PATCH] git wrapper: DWIM mistyped commands
Date: Tue, 22 Jul 2008 22:16:48 +0200
Message-ID: <20080722201648.GB11831@artemis.madism.org>
References: <alpine.DEB.1.00.0807222100150.8986@racer>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="St7VIuEGZ6dlpu13";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 22:17:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLOIx-0001fO-JF
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 22:17:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768AbYGVUQv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 16:16:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYGVUQv
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 16:16:51 -0400
Received: from pan.madism.org ([88.191.52.104]:55191 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751690AbYGVUQv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 16:16:51 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 7BD4035B80;
	Tue, 22 Jul 2008 22:16:49 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 30656D4D0; Tue, 22 Jul 2008 22:16:48 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222100150.8986@racer>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89520>


--St7VIuEGZ6dlpu13
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 22, 2008 at 08:01:29PM +0000, Johannes Schindelin wrote:
>=20
> This patch introduces a modified Damerau-Levenshtein algorithm into
> Git's code base, and uses it with the following penalties to show some
> similar commands when an unknown command was encountered:
>=20
> 	swap =3D 0, insertion =3D 1, substitution =3D 2, deletion =3D 4
>=20
> A typical output would now look like this:
>=20
> 	$ git sm
> 	git: 'sm' is not a git-command. See 'git --help'.
>=20
> 	Did you mean one of these?
> 		am
> 		rm
>=20
> The cut-off is at similarity rating 6, which was empirically determined
> to give sensible results.
>=20
> As a convenience, if there is only one candidate, Git continues under
> the assumption that the user mistyped it.  Example:
>=20
> 	$ git reabse
> 	WARNING: You called a Git program named 'reabse', which does
> 	not exist.
> 	Continuing under the assumption that you meant 'rebase'
> 	[...]

<SCNR>
    Or use a decent shell:

    When typing e.g.: git tsa<tab>, it yields:
    $ git status
    ---- corrections (errors 1)
    status        -- show working-tree's status
    tag           -- create tag object signed with GPG
    tar-tree      -- create tar archive of the files in the named tree
    ---- original
    tsa

    and it even works for non git commands ;)
</SCNR>

Despite that, I really like your idea. **hint hint** One could even hook th=
at
for long options into parse-options.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--St7VIuEGZ6dlpu13
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkiGQDAACgkQvGr7W6HudhzGcwCfYkb0u+ytFUEw5KDSAuBK0SC9
ykgAoKN+oPw6xlf1cUMeaIfaPWpeG3ps
=6WoM
-----END PGP SIGNATURE-----

--St7VIuEGZ6dlpu13--
