From: Miklos Vajna <vmiklos@frugalware.org>
Subject: git-fast-export and tags without a tagger
Date: Thu, 18 Dec 2008 17:46:14 +0100
Message-ID: <20081218164614.GS5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Gf9uwQCH04IP1HVU"
Cc: git@vger.kernel.org, scott@canonical.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Dec 18 17:47:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDM2I-0005Ow-90
	for gcvg-git-2@gmane.org; Thu, 18 Dec 2008 17:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbYLRQqQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 11:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751838AbYLRQqQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 11:46:16 -0500
Received: from virgo.iok.hu ([212.40.97.103]:34489 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801AbYLRQqP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 11:46:15 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 2030458095;
	Thu, 18 Dec 2008 17:46:14 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 03C174465E;
	Thu, 18 Dec 2008 17:46:13 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 3DF3311B862F; Thu, 18 Dec 2008 17:46:14 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103470>


--Gf9uwQCH04IP1HVU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Tags created with ancient versions of git have no tagger. The udev repo
has such tags, for example:

$ git cat-file tag 4ea98ca6db3b84f5bc16eac8574e5c209ec823ce
object face198a5f21027fefe796dc01e19e349a2d36ce
type commit
tag 062

fast-export will fail on these repos. From IRC:

20:05 < Keybuk> vmiklos: exactly the same error with 1.6.0.5
20:07 < Keybuk> $ git fast-export --signed-tag=strip --all
20:07 < Keybuk> fatal: No tagger for tag 4ea98ca6db3b84f5bc16eac8574e5c209ec823ce

I think it would be nice to handle the situation better than just die().

What about a --force option that would fake the tagger in case the tag
points to a commmit and use the commiter from there?

I'm willing to work on this, but I thought it's better to discuss the
right solution for the problem first.

Thanks.

--Gf9uwQCH04IP1HVU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklKflYACgkQe81tAgORUJbDigCgliEplcZLoNYnQaJCthjKltm2
bU4AoJBPHfXgQK07g/7i9BsV3P3AyS5A
=3PrH
-----END PGP SIGNATURE-----

--Gf9uwQCH04IP1HVU--
