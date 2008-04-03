From: Miklos Vajna <vmiklos@frugalware.org>
Subject: tests for pre-auto-gc hook (WAS: Re: [PATCH 3/3] contrib/hooks:
	add an example pre-auto-gc hook)
Date: Thu, 3 Apr 2008 23:26:56 +0200
Message-ID: <20080403212656.GJ11574@genesis.frugalware.org>
References: <cover.1207049697.git.vmiklos@frugalware.org> <7vhceldv12.fsf@gitster.siamese.dyndns.org> <20080402011447.GO3264@genesis.frugalware.org> <7vwsngaoqg.fsf@gitster.siamese.dyndns.org> <20080402190240.GV3264@genesis.frugalware.org> <7vtzik848t.fsf@gitster.siamese.dyndns.org> <cover.1207164676.git.vmiklos@frugalware.org> <96017502f7bca67a14f9a09d19c8ea42bde78949.1207167342.git.vmiklos@frugalware.org> <7vfxu4808c.fsf@gitster.siamese.dyndns.org> <20080402204524.GZ3264@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cf0hFtnykp6aONGL"
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Bj?rn Steinbrink <B.Steinbrink@gmx.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 03 23:27:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhWyH-0003uH-Lr
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 23:27:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756647AbYDCV1B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 17:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756323AbYDCV1B
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 17:27:01 -0400
Received: from virgo.iok.hu ([193.202.89.103]:30471 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756235AbYDCV1A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 17:27:00 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id 786FC1B2518;
	Thu,  3 Apr 2008 23:26:57 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 7B60D446AC;
	Thu,  3 Apr 2008 23:23:44 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 6ECF81190543; Thu,  3 Apr 2008 23:26:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080402204524.GZ3264@genesis.frugalware.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78782>


--cf0hFtnykp6aONGL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I wanted to create a test like t7503-pre-commit-hook.sh for pre-auto-gc
but actually I'm not sure how to trigger git gc --auto to do something.

Here is what I managed to do so far:

----
git init
git config gc.auto 1
for i in `seq 1 500`; do echo $i >file; git add file; done
git commit -m init
----

After this, 'git gc --auto' seem to print the 'Auto packing your
repository for optimum performance.' message, but the return code is
still 0, just like if it did not do anything.

So all what I found is that the .git/objects/pack/ directory is empty in
a new repo, and if git gc --auto did something, it won't be empty but:

1) this isn't the proper way I'm sure.

2) if I want to do it from a test, then I would need to create the repo
=66rom scratch again and again, which is quite dirty.

Does anyone have better ideas?

Thanks

--cf0hFtnykp6aONGL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkf1S6AACgkQe81tAgORUJaAmgCgg5s58M7JqU/I67woccPzuJvN
GKoAn1UbBV9yY70zAqqlRSCVw0T1wMwt
=zLco
-----END PGP SIGNATURE-----

--cf0hFtnykp6aONGL--
