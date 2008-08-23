From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [RFC/PATCH] Install templates directory using mkdir -p, not
	install -d
Date: Sat, 23 Aug 2008 21:53:18 +0200
Message-ID: <20080823195318.GE23800@genesis.frugalware.org>
References: <1219519746-7438-1-git-send-email-vmiklos@frugalware.org> <7vsksvy0qz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jZNlLGxhPb4urluq"
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 23 21:54:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWzBu-0006Bn-IV
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 21:54:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756393AbYHWTxW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 15:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757155AbYHWTxV
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 15:53:21 -0400
Received: from virgo.iok.hu ([193.202.89.103]:49757 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755390AbYHWTxU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 15:53:20 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id C64F11B2537;
	Sat, 23 Aug 2008 21:53:18 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E1B224465E;
	Sat, 23 Aug 2008 20:55:02 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 2EE00119003C; Sat, 23 Aug 2008 21:53:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vsksvy0qz.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93481>


--jZNlLGxhPb4urluq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Aug 23, 2008 at 12:44:51PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> I think using mkdir in blt/ area is fine, but I have doubts about not
> using $(INSTALL), which is designed to be a standard "marker" in Makefiles
> and meant to be replaceable on deficient platforms, for installing to real
> final destination directories.  IOW, I do not think the last hunk in your
> patch is a good idea.

The other method would be adding some stripped down version of GNU
automake's install-sh, then we use say install-sh -d without caring
about what switches 'install' has on the given platform.

At least that's how HP builds their binary git package:

http://hpux.connect.org.uk/hppd/cgi-bin/wwwtar?/hpux/Development/Tools/git-1.5.6.3/git-1.5.6.3-src-11.11.tar.gz+git-1.5.6.3/HPUX.Install+text

I think the mkdir one would be much simpler.

--jZNlLGxhPb4urluq
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiwaq4ACgkQe81tAgORUJackACgkJPrtAJFUr4yzjIJ2xsHK76n
zwUAnRjxoAquiX8MJ7+353IAT7CY5StA
=o9ud
-----END PGP SIGNATURE-----

--jZNlLGxhPb4urluq--
