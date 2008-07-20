From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: What's cooking in git.git (topics)
Date: Sun, 20 Jul 2008 15:04:07 +0200
Message-ID: <20080720130407.GF10347@genesis.frugalware.org>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <7v63r38r4r.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness> <7vabge30dh.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="F5PMopVgTaFKhUu5"
Cc: Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 20 15:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKYbF-00089B-2H
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 15:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756927AbYGTNEP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 09:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756928AbYGTNEP
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 09:04:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:47941 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754166AbYGTNEO (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 09:04:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id A58F21B251F;
	Sun, 20 Jul 2008 15:04:12 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 684464465E;
	Sun, 20 Jul 2008 14:24:32 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id E5A0A177001C; Sun, 20 Jul 2008 15:04:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807191311220.3305@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89198>


--F5PMopVgTaFKhUu5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 19, 2008 at 01:19:46PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> So I still feel that "-s subtree=3D<blabla>,recursive=3Dtheirs" would be =
a=20
> viable way to go.  And more intuitive than "-X".
>=20
> I'll just ask Miklos what he thinks of the idea, and to write the patch i=
f=20
> he likes it, once he's back from the saddle. :-)

I think there are three steps here.

First, currently you can specify multiple strategies in the config
(pull.twohead, pull.octopus) using a space separated list. If we want to
change it to a coma-separated list, should we care about backwards
compatibility? There are tests for this, but it's undocumented (and my
patch to document it was rejected, saying we should not encourage people
to use it).

Second, we could allow custom strategies, as we started to discuss here:

http://thread.gmane.org/gmane.comp.version-control.git/86584/focus=3D87684

Third, it would be nice to allow passing extra parameter(s) to the
backends, but I do not know what concept is the best here. The
strategy1=3Dfoo,stategy2=3Dbar limits the input to a single string. Is that
enough? Given that recursive=3Dtheirs was considered harmful, we don't
have too much examples; for subtree the only parameter I could think of
is the path, so a string there is enough.

However, further strategies, like blame, could take more parameters,
like git blame -C<num> -M<othernum>. Or do I just overcomplicate it? ;-)

--F5PMopVgTaFKhUu5
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiDN8cACgkQe81tAgORUJYwFwCfY37uZSLmBmgzxrvjso5qkYOo
WtUAn39+h1Wn9d9tby/emufemV7yHb6Y
=+PVY
-----END PGP SIGNATURE-----

--F5PMopVgTaFKhUu5--
