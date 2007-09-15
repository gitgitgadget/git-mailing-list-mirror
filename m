From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Data Integrity & un-Commited Branches
Date: Sat, 15 Sep 2007 09:38:45 +0200
Message-ID: <20070915073845.GB3782@efreet.light.src>
References: <2a8a071a0709140028o472bcr8c82bd88e37cc4e9@mail.gmail.com> <2a8a071a0709140036l5db62c0fl5af01f75f35610ba@mail.gmail.com> <7vk5qtd3le.fsf@gitster.siamese.dyndns.org> <2a8a071a0709141740l144b60aevdfec2b6cdab8bb60@mail.gmail.com> <20070915025129.GY3099@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: Brian Scott Dobrovodsky <brian@pontech.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Sep 15 09:38:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWSEz-0006jq-3y
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 09:38:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbXIOHix (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2007 03:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751558AbXIOHix
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 03:38:53 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:40353 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751316AbXIOHiw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 03:38:52 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id D05A35729D;
	Sat, 15 Sep 2007 09:38:50 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id nho5O4Q8fxUZ; Sat, 15 Sep 2007 09:38:48 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id CFB2357274;
	Sat, 15 Sep 2007 09:38:47 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1IWSEn-0003AP-1Y; Sat, 15 Sep 2007 09:38:45 +0200
Content-Disposition: inline
In-Reply-To: <20070915025129.GY3099@spearce.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58228>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 14, 2007 at 22:51:29 -0400, Shawn O. Pearce wrote:
> It isn't unreasonable to want Git to save uncommitted work for the
> current branch and then you switch to another, ending up with a
> clean working directory when you finally get there.  Today we have
> git-stash to help you with this, but I'm thinking maybe we want to
> connect git-checkout with it?

I think it would be reasonable if it just forced you to decide about it. Th=
at
is reading the documentation, checkout only switches branches if the merge =
of
each modified file is trivial and only does 3-way merge if it got -m option.

It might be reasonable to requre that option for all cases, where there are
local changes and the branches don't point to the same commit and without i=
t,
checkout should say something like:

  Cannot switch branches, because the tree is modified. You can apply the
  modifications to the target branch by using -m option, or commit them
  before switching branches (you can undo or amend that commit later if it's
  not finished yet).

The case with branches pointing to the same commit is for checkout -b,
reverting that command if you do it too early/by mistake/wanted branch
instead and for doing it with branch + checkout.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG64wERel1vVwhjGURAqPrAJ9Bu6DI41e6EUrbam9pMpjTBAW9+gCglGiI
BIEsM6Pd/OZyH/lVGghY+Z8=
=rcLT
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
