From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] bash-completion: fix getting strategy list
Date: Thu, 21 Aug 2008 00:39:38 +0200
Message-ID: <20080820223938.GN23800@genesis.frugalware.org>
References: <fcaeb9bf0808190527q60869fd0uccbfd165431a752d@mail.gmail.com> <20080819132803.GA26201@laptop> <48AADDBB.1080203@viscovery.net> <fcaeb9bf0808200958u65ad8fa3oa118b88e16c9c50c@mail.gmail.com> <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="19uQFt6ulqmgNgg1"
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:40:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVwMB-0003Gq-T9
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754011AbYHTWjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753975AbYHTWjl
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:39:41 -0400
Received: from virgo.iok.hu ([193.202.89.103]:40382 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753761AbYHTWjl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:39:41 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 9F5581B24F0;
	Thu, 21 Aug 2008 00:39:39 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id D88E34465E;
	Wed, 20 Aug 2008 23:42:56 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E24851770019; Thu, 21 Aug 2008 00:39:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vfxozpeyh.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93068>


--19uQFt6ulqmgNgg1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 20, 2008 at 02:13:42PM -0700, Junio C Hamano <gitster@pobox.com=
> wrote:
> completion: find out supported merge strategies correctly
>=20
> "git-merge" is a binary executable these days, and looking for assignment
> to $all_strategies variable does not work well.
>=20
> When asked for an unknown strategy, pre-1.6.0 and post-1.6.0 "git merge"
> commands respectively say:
>=20
>     $ $HOME/git-snap-v1.5.6.5/bin/git merge -s help
>     available strategies are: recur recursive octopus resolve stupid ours=
 subtree=20
>     $ $HOME/git-snap-v1.6.0/bin/git merge -s help
>     Could not find merge strategy 'help'.
>     Available strategies are: recursive octopus resolve ours subtree.
>=20
> both on its standard error stream.  We can use this to learn what
> strategies are supported.
>=20
> The sed script is written in such a way that it catches both old and new
> message styles ("Available" vs "available", and the full stop at the end).
> It also allows future versions of "git merge" to line-wrap the list of
> strategies, and add extra comments, like this:
>=20
>     $ $HOME/git-snap-v1.6.1/bin/git merge -s help
>     Could not find merge strategy 'help'.
>     Available strategies are: blame recursive octopus resolve ours
>     subtree.
>     Also you have custom strategies: theirs
>=20
>     Make sure you spell strategy names correctly.

I like this, not adding something to builtin-merge when it's already
there. :)

--19uQFt6ulqmgNgg1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkisnSoACgkQe81tAgORUJbtrgCgptLSVbhCe+uU+qmE1ARE+ZZm
OUUAnRIEvjk+h9aHiXqQboaiaarPeUKd
=o70C
-----END PGP SIGNATURE-----

--19uQFt6ulqmgNgg1--
