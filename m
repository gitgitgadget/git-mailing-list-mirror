From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH/Test] Build in merge is broken
Date: Sun, 13 Jul 2008 19:46:59 +0200
Message-ID: <20080713174659.GE10347@genesis.frugalware.org>
References: <loom.20080713T073129-112@post.gmane.org> <20080713124100.GB10347@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hn090KliNom6wizA"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Hvammen Johansen <hvammen+git@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 19:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KI5g8-0004EY-F3
	for gcvg-git-2@gmane.org; Sun, 13 Jul 2008 19:48:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752972AbYGMRrE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2008 13:47:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753522AbYGMRrD
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Jul 2008 13:47:03 -0400
Received: from virgo.iok.hu ([193.202.89.103]:56500 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752919AbYGMRrB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2008 13:47:01 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E578E1B24FB;
	Sun, 13 Jul 2008 19:46:59 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 675004465E;
	Sun, 13 Jul 2008 19:11:15 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 5D0CA11901B3; Sun, 13 Jul 2008 19:46:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080713124100.GB10347@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88316>


--hn090KliNom6wizA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 13, 2008 at 02:41:00PM +0200, Miklos Vajna <vmiklos@frugalware.=
org> wrote:
> > The test case when run will record the parents that were asked for whic=
h is
> > fine.  However, only c2 is recorded as a parent in the commit object.  =
Both
> > c1 and c2 should have been recorded.  The merge is otherwise working
> > correctly.
>=20
> Thanks for the testcase, I'm on it. ;-)

So far what I see is that the input for the reduce_heads() function is
(c1, c0, c2, c0, c1). The expected output would be (c1, c2), but the
actual output is c2. So I suspect the bug is not in builtin-merge.c
itself but in reduce_heads().

Hmm..

Adding Junio to Cc, who is the original author of reduce_heads().

--hn090KliNom6wizA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkh6P5MACgkQe81tAgORUJbjTACfY3cnr3zsy1uLZMi1MEcY1nGQ
vV4An1DjW5WOMaP+UV9EsgAxMEv31wyw
=Efja
-----END PGP SIGNATURE-----

--hn090KliNom6wizA--
