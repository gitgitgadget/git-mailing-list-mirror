From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Strange untracked file behaviour
Date: Wed, 17 Dec 2008 00:24:52 +0100
Message-ID: <20081216232452.GV5691@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="rmjRBBEgaenXGypG"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 17 00:26:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCjIv-0004IO-BG
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 00:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbYLPXY6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 18:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755592AbYLPXY5
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 18:24:57 -0500
Received: from virgo.iok.hu ([212.40.97.103]:35025 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757805AbYLPXYz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 18:24:55 -0500
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 5C508580B8
	for <git@vger.kernel.org>; Wed, 17 Dec 2008 00:24:52 +0100 (CET)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 3164B4465E
	for <git@vger.kernel.org>; Wed, 17 Dec 2008 00:24:52 +0100 (CET)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 4FF0411B862F; Wed, 17 Dec 2008 00:24:52 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103296>


--rmjRBBEgaenXGypG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Here is a copy of the udev repo I cloned some time ago:

http://frugalware.org/~vmiklos/files/udev.tar.bz2

I did not modify it, so I thought a simple 'git pull' can update it.

$ git pull
Updating 661a0be..b6626d0
error: Untracked working tree file 'test/sys/class/misc/rtc/dev' would
be removed by merge.

Ok, let's clean the untracked files:

$ git clean -x -d -f

But it does not remove any file.

$ git ls-files|grep test/sys/class/misc/rtc/dev
test/sys/class/misc/rtc/dev

So it seems git-clean is right.

$ git pull -s resolve
Updating 661a0be..b6626d0
error: Untracked working tree file 'test/sys/class/misc/rtc/dev' would
be removed by merge.

So it does not seem to be merge-recursive-related.

Does somebody have an idea what's going on? :)

$ git version
git version 1.6.1.rc1.35.gae26e.dirty

('dirty' is due to non-code changes in my working directory.)

Let me know if you need more details.

Thanks.

--rmjRBBEgaenXGypG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAklIOMQACgkQe81tAgORUJaTtACgq4KueyIIu/TT7eCr1k/RWTw2
inoAnjWMak78VvhzCMiTgMZK50kKsVdl
=nr1r
-----END PGP SIGNATURE-----

--rmjRBBEgaenXGypG--
