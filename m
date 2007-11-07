From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: git svn dcommit with a dirty index
Date: Wed, 7 Nov 2007 20:06:49 +0100
Message-ID: <DBC1E504-9007-4C89-9728-2DDBAFF2053B@lrde.epita.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-73--740638906"
Content-Transfer-Encoding: 7bit
Cc: Eric Wong <normalperson@yhbt.net>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Nov 07 20:07:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpqF7-0002Ps-OU
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 20:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752336AbXKGTG5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 14:06:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXKGTG5
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 14:06:57 -0500
Received: from 2.139.39-62.rev.gaoland.net ([62.39.139.2]:45535 "EHLO
	kualalumpur.lrde.epita.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbXKGTG4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 14:06:56 -0500
Received: from tsunaxbook.lrde.epita.fr ([192.168.101.162])
	by kualalumpur.lrde.epita.fr with esmtpsa (TLS-1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.63)
	(envelope-from <tsuna@lrde.epita.fr>)
	id 1IpqEo-00065O-FG; Wed, 07 Nov 2007 20:06:54 +0100
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63845>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-73--740638906
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

Hello list,
 From what I understand, when using dcommit, git-svn uses rebase to  
"sync" the history with what has just been committed.  If the index  
is in a dirty state, this will cause trouble.  I thought about using  
git-stash and then git stash apply --index but I'm afraid this could  
be confusing if dcommit actually brings more revision in that the  
ones it has just committed.  I'm not sure this is possible and even  
if it is, it might not be troublesome since if the commits are  
accepted in the SVN repo, they surely don't overlap with commits that  
have been sent in the mean time.  But it's risky, so I don't know  
what to do.  If we use the stash approach, we might want to tell the  
user that we bailed out because of a problem that needs to be fixed  
and that he can recover his changes with git stash apply --index.

Or we should simply check that the index isn't dirty beforehand and  
refuse to dcommit if it is.

Any suggestion?

PS OT: Eric, have you made any progress on the svn:externals<- 
 >submodules mapping?  I badly need this feature, but I don't want to  
start to work on it if you're currently working on it (or about to  
deal with it) to avoid unecessary effort duplication.

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-73--740638906
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHMgzJwwE67wC8PUkRAthWAJ91aQYpTj5+oFA4oqdNPnVJ7cPnRwCeNc7q
FGAoiu12OEUddi1B3P0EYzQ=
=Uhvd
-----END PGP SIGNATURE-----

--Apple-Mail-73--740638906--
