From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Dangling blob after git gc
Date: Thu, 27 Nov 2008 14:30:27 +0100
Message-ID: <20081127133027.GW4746@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YvpO9wCO44Ze8QQC"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 27 14:33:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5h04-0008SH-0P
	for gcvg-git-2@gmane.org; Thu, 27 Nov 2008 14:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbYK0Nab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Nov 2008 08:30:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751862AbYK0Nab
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Nov 2008 08:30:31 -0500
Received: from virgo.iok.hu ([212.40.97.103]:59170 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751272AbYK0Naa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Nov 2008 08:30:30 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E8039580B2
	for <git@vger.kernel.org>; Thu, 27 Nov 2008 14:30:27 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E609F4465E
	for <git@vger.kernel.org>; Thu, 27 Nov 2008 14:30:27 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id BE09F11901A1; Thu, 27 Nov 2008 14:30:27 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101808>


--YvpO9wCO44Ze8QQC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

$ git version
git version 1.6.0.4

$ git fsck
dangling blob 070011dddba40fe0066cbebfe51ea6d160f95af8
dangling blob 3ec00c535bbac37f738971a5ad14bb11892c5863
dangling commit c180face4d2451f9e77f41d4f9d4f3ad7cbd51c0
(...)

So I have multiple dangling blobs/trees/commits, let's do a gc.

$ git gc
Counting objects: 96978, done.
Compressing objects: 100% (25044/25044), done.
Writing objects: 100% (96978/96978), done.
Total 96978 (delta 70392), reused 96978 (delta 70392)

$ git fsck
dangling commit 2302e3fd37e808d3240ffa887ea1c22cac9cb770
dangling commit 0a2bc7013d49e0695242ffc2d57360d0396c22ea
dangling blob c330f89bcc20b1c9ca689e66062d086562e0633d
dangling commit ac319ab8d187e818f2dd05774175a2a7feb9696e
dangling commit a5f5b7956f7d63bab13d3f2c45c7315cfbea28b8

The commits are probably due to reflogs, that's OK. But why do I have a
dangling blob after git gc? The interesting part is that as you can see
most of them is removed, but not all.

Any ideas? :)

Thanks.

--YvpO9wCO44Ze8QQC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkkuoPMACgkQe81tAgORUJaf2wCfVa5I69EsoEXGfq3YdJqe/9PX
BhsAoJ+lqZupF3Nvxl4hlN6VS97EVh4k
=hDv3
-----END PGP SIGNATURE-----

--YvpO9wCO44Ze8QQC--
