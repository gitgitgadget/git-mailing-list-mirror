From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 0/3] symref rename/delete fixes
Date: Mon, 27 Oct 2008 09:50:55 +0100
Message-ID: <20081027085055.GL2273@genesis.frugalware.org>
References: <7v8wsca5ne.fsf@gitster.siamese.dyndns.org> <cover.1224987944.git.vmiklos@frugalware.org> <7vhc6yioyq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="udcq9yAoWb9A4FsZ"
Cc: Jeff King <peff@peff.net>, Brandon Casey <casey@nrlssc.navy.mil>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 27 09:52:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuNpd-0002yP-MJ
	for gcvg-git-2@gmane.org; Mon, 27 Oct 2008 09:52:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbYJ0IvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Oct 2008 04:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750965AbYJ0IvA
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Oct 2008 04:51:00 -0400
Received: from virgo.iok.hu ([193.202.89.103]:52281 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbYJ0Iu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Oct 2008 04:50:59 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 6B641580B7;
	Mon, 27 Oct 2008 09:50:58 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id EE34F4465E;
	Mon, 27 Oct 2008 09:50:55 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 7400611901A1; Mon, 27 Oct 2008 09:50:55 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vhc6yioyq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99217>


--udcq9yAoWb9A4FsZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 26, 2008 at 10:31:09PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> > Of course you can say that this should be handled by git-remote itself,
> > without using rename_ref() but that not seem to be a good solution to
> > me. (Workaround in the wrong layer, instead of a solution in a good
> > one.)
>=20
> I do not think it is a workaround at all.
>=20
> I would even say that the renaming of symref that "git remote rename"
> needs to do is fundamentally different from what rename_ref() is about,
> and trying to cram it into rename_ref() is a grave mistake.
>=20
> If you "git remote rename origin upstream" when origin/HEAD points at
> refs/remotes/origin/master, you need to make the renamed one point at
> refs/remotes/upstream/master, as you will be renaming origin/master to
> upstream/master.
>=20
> Normal "rename_ref()" would just rename the ref without touching its
> contents, and if you used it to implement "git remote rename", your
> upstream/HEAD would point at the old name "origin/master" that will
> disappear when rename is finished, wouldn't it?  I do not think it is
> useful.

Ah, I missed that. You convienced me, I'll post updated patches later
today. :)

--udcq9yAoWb9A4FsZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkFgO8ACgkQe81tAgORUJZdFACgkb5AXsyKMD17donrK8x2DOyP
A/cAn1iw8TkZ4qTXuL2K220uxG0RQ8Us
=hHFx
-----END PGP SIGNATURE-----

--udcq9yAoWb9A4FsZ--
