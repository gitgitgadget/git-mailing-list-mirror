From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: git-cvsimport fuzzy commit log matching?
Date: Tue, 23 Dec 2008 12:06:41 +0100
Message-ID: <20081223110641.GA29481@artemis.corp>
References: <20081223110302.GA9376@lst.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="ew6BAiZeqk4r7MaW";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Matthias Urlichs <smurf@smurf.noris.de>, git@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 12:08:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LF57J-0007xW-GN
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 12:08:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750840AbYLWLGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 06:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbYLWLGo
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 06:06:44 -0500
Received: from pan.madism.org ([88.191.52.104]:40716 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750758AbYLWLGn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 06:06:43 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 6651D3E31F;
	Tue, 23 Dec 2008 12:06:42 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 2B25C2AFDF; Tue, 23 Dec 2008 12:06:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081223110302.GA9376@lst.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103809>


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2008 at 11:03:02AM +0000, Christoph Hellwig wrote:
> I'm currently trying to get clean git imports of the XFS userspace
> repositories.  These are funky in the way they were initially kept in
> ptools, and SGI-internal SCM that was built ontop of RCS which changeset
> added ontop.  So we know that commits actually were done in atomic
> changesets.  But ptools has the "nice" feature of allowing both per-file
> and per-changeset commits.   Due to the per-file commits git-cvsimport
> often misdetects a single changeset as multiple individual changes, ala:
>=20
>=20
> commit 0d47d43b5878c6e7d7b516a793a82f0076d22089
> Author: Barry Naujok <bnaujok@sgi.com>
> Date:   Mon Jul 16 15:52:53 2007 +0000
>=20
>     Perform parallel processing based on AG stride/concat unit
>     Merge of master-melb:xfs-cmds:29143a by kenmcd.
>=20
>       Queue up AGs per thread based on ag stride
>=20
> commit 1fa4685db126fd3071e008a6d18f9d51209ab305
> Author: Barry Naujok <bnaujok@sgi.com>
> Date:   Mon Jul 16 15:52:53 2007 +0000
>=20
>     Perform parallel processing based on AG stride/concat unit
>     Merge of master-melb:xfs-cmds:29143a by kenmcd.
>=20
>       Handle ag stride command line option and setup threads as required
>=20
> commit a73288784e77c2411687f6778adb4c0b0f9dcdff
> Author: Barry Naujok <bnaujok@sgi.com>
> Date:   Mon Jul 16 15:52:53 2007 +0000
>=20
>     Perform parallel processing based on AG stride/concat unit
>     Merge of master-melb:xfs-cmds:29143a by kenmcd.
>=20
>       Execute bits changed from x-- to ---
>       Queue up AGs per thread based on ag stride
>=20
> and so on.
>=20
> Any idea how to tell git-cvsimport that if we have exactly the same
> timestamp, and maybe the same author it really is the same changeset and
> we want to merge the commit message?

Why not using a fancy git-filterbranch script to squash them together
instead ? It's probably less work than to try to modify your cvs
importer to work the exact way you want.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--ew6BAiZeqk4r7MaW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklQxkEACgkQvGr7W6Hudhy+aQCfcUPYZctVP3j+lzv0G2Y1YSXR
x4EAn3G1POcZqAwLWHx/liYn35vJxDPI
=McXR
-----END PGP SIGNATURE-----

--ew6BAiZeqk4r7MaW--
