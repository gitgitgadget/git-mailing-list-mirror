From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: Deleted file is back - how to investigate?
Date: Sun, 26 Jun 2011 22:25:32 +0200
Message-ID: <20110626202532.GS30255@genesis.frugalware.org>
References: <20110626103218.GQ30255@genesis.frugalware.org>
 <1309097423.11860.76.camel@oxylap>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="c1qHkdEbEbCG94PZ"
Cc: git@vger.kernel.org
To: Christof =?iso-8859-1?Q?Kr=FCger?= <git@christof-krueger.de>
X-From: git-owner@vger.kernel.org Sun Jun 26 22:33:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qaw1N-0003HI-Cq
	for gcvg-git-2@lo.gmane.org; Sun, 26 Jun 2011 22:33:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab1FZU0x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jun 2011 16:26:53 -0400
Received: from virgo.iok.hu ([212.40.97.103]:47006 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754260Ab1FZUZe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2011 16:25:34 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2AF0358095;
	Sun, 26 Jun 2011 22:25:32 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 0A22344965;
	Sun, 26 Jun 2011 22:25:31 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 536D7BAC006; Sun, 26 Jun 2011 22:25:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1309097423.11860.76.camel@oxylap>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176331>


--c1qHkdEbEbCG94PZ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 26, 2011 at 04:10:23PM +0200, Christof Kr=FCger <git@christof-k=
rueger.de> wrote:
> In this particular case, it seems that the offending commit is indeed a
> merge commit (a5f45ee4). But it rather looks like user error and not a
> git bug to me.  When I checkout its first parent (a5e830ee) and merge
> its second parent (93b01c6c) myself, I get some conflicts, but the
> ogle-gui file stays deleted.
>=20
> As to how to detect what pulled the file back in:
> I added --graph to your command line which implies parent rewriting.
> This includes merges and should give you some information about the
> "topology" of the history graph, leaving out irrelevant commits
> in-between.  I wouldn't call myself a history simplification exptert, so
> there might still be cases where this does not help, but in this case it
> indeed shows the offending merge commit.

Hi Chris,

Great, --graph indeed lists two merge commits, and if I check the tree
objects manually, I can see which one introduced the file. But I still
don't really understand --name-status why don't show the addition of
those files, given that I hoped this counts as an "evil merge".

Thanks.

--c1qHkdEbEbCG94PZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEUEARECAAYFAk4HlbwACgkQe81tAgORUJaHAgCgn3VS3VwJbcgIcbxwiRBROVRs
cyEAl1u8APwHabavJy6sFRzYC4NLW7s=
=2SDv
-----END PGP SIGNATURE-----

--c1qHkdEbEbCG94PZ--
