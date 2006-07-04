From: Keith Packard <keithp@keithp.com>
Subject: Re: git-fetch per-repository speed issues
Date: Mon, 03 Jul 2006 22:29:40 -0700
Message-ID: <1151990980.4723.132.camel@neko.keithp.com>
References: <1151949764.4723.51.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607031603290.12404@g5.osdl.org>
	 <1151973438.4723.70.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607032008590.12404@g5.osdl.org>
	 <1151985747.4723.102.camel@neko.keithp.com>
	 <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1Aa02u9fcaa1LxFL42TJ"
Cc: keithp@keithp.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 04 07:30:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FxdTx-0004p6-PW
	for gcvg-git@gmane.org; Tue, 04 Jul 2006 07:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWGDF3o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Jul 2006 01:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWGDF3o
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Jul 2006 01:29:44 -0400
Received: from home.keithp.com ([63.227.221.253]:29203 "EHLO keithp.com")
	by vger.kernel.org with ESMTP id S1750946AbWGDF3o (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jul 2006 01:29:44 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 9AB8A130020;
	Mon,  3 Jul 2006 22:29:43 -0700 (PDT)
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id SlymKlB8gviL; Mon,  3 Jul 2006 22:29:43 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 068F413001E; Mon,  3 Jul 2006 22:29:42 -0700 (PDT)
Received: from neko.keithp.com (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id E1A4414001;
	Mon,  3 Jul 2006 22:29:42 -0700 (PDT)
Received: by neko.keithp.com (Postfix, from userid 1488)
	id D56616AC24A; Mon,  3 Jul 2006 22:29:40 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607032115340.12404@g5.osdl.org>
X-Mailer: Evolution 2.6.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23250>


--=-1Aa02u9fcaa1LxFL42TJ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2006-07-03 at 21:19 -0700, Linus Torvalds wrote:

> Well, that's still strange. What takes 4.2 seconds then?

$ strace -e trace=3Dexecve -f git-fetch 2>&1 | grep execve | sed -e 's/^.*e=
xecve("//' -e 's/".*$//' | sort | uniq -c | sort -n
      1 /bin/rm
      1 /home/keithp/bin/git
      1 /home/keithp/bin/git-fetch
      1 /home/keithp/bin/git-fetch-pack
      1 /home/keithp/bin/git-ls-remote
      1 /home/keithp/bin/git-peek-remote
      1 /usr/bin/sort
      3 /bin/sed
      4 /home/keithp/bin/git-repo-config
     30 /bin/mkdir
     30 /home/keithp/bin/git-cat-file
     30 /home/keithp/bin/git-check-ref-format
     30 /home/keithp/bin/git-merge-base
     30 /usr/bin/dirname
     64 /home/keithp/bin/git-rev-parse
    361 /usr/bin/expr

someone sure likes 'expr'...

--=20
keith.packard@intel.com

--=-1Aa02u9fcaa1LxFL42TJ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEqfzEQp8BWwlsTdMRAlCXAJ41mhOmzKjo81RjyZNjHHnWrBVcSwCgkAHS
7ZekMGXJINwQtA4DRDOXTXk=
=b9OQ
-----END PGP SIGNATURE-----

--=-1Aa02u9fcaa1LxFL42TJ--
