From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-merge: give a proper error message for invalid
	strategies in config
Date: Tue, 22 Jul 2008 09:39:12 +0200
Message-ID: <20080722073912.GN32057@genesis.frugalware.org>
References: <1216656647-16897-1-git-send-email-vmiklos@frugalware.org> <7vr69mpl5v.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OX2aLCKeO1apYW07"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:40:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCTm-0002mx-4w
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751405AbYGVHjP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751223AbYGVHjP
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:39:15 -0400
Received: from virgo.iok.hu ([193.202.89.103]:55413 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751218AbYGVHjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:39:14 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 08BB31B2513;
	Tue, 22 Jul 2008 09:39:13 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id BE3CA4465E;
	Tue, 22 Jul 2008 08:58:36 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 67769177001D; Tue, 22 Jul 2008 09:39:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vr69mpl5v.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89461>


--OX2aLCKeO1apYW07
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jul 21, 2008 at 10:01:16PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Doesn't this make "git merge -s 'recursive resolve'" to misbehave?

Depends on what do we expect it to do. ;-)

My patch unified the handling of pull.twohead / -s option, so it
(actually unintentionally) made -s accepting multiple strategies as a
space separated list. Given that we already accept multiple strategies
as a space separated list in pull.twohead (and we do _not_ use multiple
pull.twohead entries) I think my patch is more logical.

Though, there was already a thread about how should we specify multiple
strategies on the commandline; and you suggested in

        http://article.gmane.org/gmane.comp.version-control.git/89208

to use -s strategy1 -s strategy2.

In that case, I think your patch is better, and once it hits git.git, I
would like to send a patch that changes the config parsing as well, so
that pull.twohead "foo bar" would be invalid, and the user would have to
have two pull.twohead entries: one for foo and one for bar.

Does this sound reasonable?

Thanks.

--OX2aLCKeO1apYW07
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiFjqAACgkQe81tAgORUJYs5ACgmpyv0bzKEr/WJgb5Iujj1Tq6
SxwAnAttucHey28IewO6dAzn5PVQlFwJ
=D991
-----END PGP SIGNATURE-----

--OX2aLCKeO1apYW07--
