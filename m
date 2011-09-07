From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH 2/2] push -s: skeleton
Date: Wed, 7 Sep 2011 23:55:44 +0000
Message-ID: <robbat2-20110907T234637-463765607Z@orbis-terrarum.net>
References: <7vfwk82hrt.fsf@alter.siamese.dyndns.org>
 <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pvezYHf7grwyp3Bc"
Cc: "	Shawn O. Pearce" <spearce@spearce.org>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 08 01:55:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R1RyD-0001Kn-KR
	for gcvg-git-2@lo.gmane.org; Thu, 08 Sep 2011 01:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757520Ab1IGXzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Sep 2011 19:55:48 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:52624 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757517Ab1IGXzs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Sep 2011 19:55:48 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 4A97B1B400D
	for <git@vger.kernel.org>; Wed,  7 Sep 2011 23:55:45 +0000 (UTC)
Received: (qmail 627 invoked by uid 10000); 7 Sep 2011 23:55:44 -0000
Content-Disposition: inline
In-Reply-To: <7vbouw2hqg.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180930>


--pvezYHf7grwyp3Bc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 07, 2011 at 01:57:27PM -0700,  Junio C Hamano wrote:
> If a tag is GPG-signed, and if you trust the cryptographic robustness of
> the SHA-1 and GPG, you can guarantee that all the history leading to the
> signed commit is not tampered with. However, it would be both cumbersome
> and cluttering to sign each and every commit. Especially if you strive to
> keep your history clean by tweaking, rewriting and polishing your commits
> before pushing the resulting history out, many commits you will create
> locally end up not mattering at all, and it is a waste of time to sign
> them.
Thanks to pcloud for including me on the thread. I do find the idea of
these push-certificates very interesting and useful, but I think they
will do best to augment signed commits, not replace them.

There's a couple of related things we've been considering on the Gentoo
side:
- detached signatures of blobs (either the SHA1 of the blob or the blob
  itself)
- The signature covering the message+blob details, but NOT the chain of
  history: this opens up the ability to cherry-pick and rebase iff there
  are no conflicts and the blobs are identical, all while preserving the
  signature.
- concerns about a pre-image attack against Git. tl;dr version:
  1. Attacker prepares decoy file in advance, that hashes to the same as
     the malicious file.
  2. Attacker sends decoy in as an innocuous real commit.
  3. Months later, the attacker breaks into the system and alters the
     packfile to include the new malicious file.
  4. All new clones from that point forward get the malicious version.

Re your comment on always needing to resign commits above, we'd been
considering post-signing commits, not when they are initially made.
After your commit is clean and ready to ship, you can fire the commit
ids into the signature tool, which can generate a detached signature
note for each commit.

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Trustee & Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--pvezYHf7grwyp3Bc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAk5oBIAACgkQPpIsIjIzwiw0BACgzAoCObm+HfozYDsIVBOt3/WQ
BIkAn2x+Atj24uVsjOyOiGC78eOywlxI
=9CQ7
-----END PGP SIGNATURE-----

--pvezYHf7grwyp3Bc--
