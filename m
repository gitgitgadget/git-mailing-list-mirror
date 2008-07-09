From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/2] branch --merged/--not-merged: allow specifying arbitrary  commit
Date: Wed, 09 Jul 2008 09:45:16 +0200
Message-ID: <20080709074516.GA23482@artemis.madism.org>
References: <7v8wwcx446.fsf@gitster.siamese.dyndns.org> <20080708101452.GB19202@artemis.madism.org> <20080708103408.GC19202@artemis.madism.org> <7vvdzfoo1s.fsf@gitster.siamese.dyndns.org> <7vmykronr1.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="a8Wt8u1KmwUX3Y2C";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 09:46:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KGUNX-0006ns-9z
	for gcvg-git-2@gmane.org; Wed, 09 Jul 2008 09:46:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752950AbYGIHpV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2008 03:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752824AbYGIHpU
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Jul 2008 03:45:20 -0400
Received: from pan.madism.org ([88.191.52.104]:34229 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbYGIHpT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2008 03:45:19 -0400
Received: from madism.org (APuteaux-103-1-3-109.w217-128.abo.wanadoo.fr [217.128.49.109])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 37A4D3461F;
	Wed,  9 Jul 2008 09:45:18 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id E98B885E6; Wed,  9 Jul 2008 09:45:16 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Hjemli <hjemli@gmail.com>
Content-Disposition: inline
In-Reply-To: <7vmykronr1.fsf_-_@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87855>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 09, 2008 at 01:22:10AM +0000, Junio C Hamano wrote:
> "git-branch --merged" is a handy way to list all the branches that have
> already been merged to the current branch, but it did not allow checking
> against anything but the current branch.  Having to check out only for
> that purpose made the command practically useless.
>=20
> This updates the option parser so that "git branch --merged next" is
> accepted when you are on 'master' branch.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>=20
>  * This does have an issue.  --no-<option>=3D<value> is often nonsense and
>    parse-options does not accept it (and I do not think we would want to
>    change it).  The use of "--no-merged" was a mistake, but nobody has
>    perfect foresight.
>=20
>    This adds --not-merged <commit> and allows the <commit> to default to
>    HEAD if not given to work it around.  This and the previous one are not
>    for application but primarily meant for discussion on what further
>    flexibility we may want to have in parse-options.

  There's a way: declare --merge as (PARSE_OPT_)NONEG to tell parse-opt
not to generate --no-merge by itself, and declare a --no-merge option as
well.  I think it works, and if not, we should make parse-opt work with
that. This is a quite disgusting hack, and no *new* options should be
written this way, but we have to be flexible enough for backward
compatibility's sake.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkh0bIsACgkQvGr7W6HudhwSQwCdFzYtGfadkepHm8ByIS8wtb9J
reMAniIN1Z7uI8nRUqZyQWPgGHJFSnIN
=9vd1
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
