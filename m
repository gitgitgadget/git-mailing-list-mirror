From: Greg Troxel <gdt@ir.bbn.com>
Subject: Re: RFD: Handling case-colliding filenames on case-insensitive filesystems
Date: Wed, 23 Feb 2011 18:09:06 -0500
Message-ID: <rmi39newdpp.fsf@fnord.ir.bbn.com>
References: <201102231811.45948.johan@herland.net>
	<AANLkTi=MyqXYi=zNZ+MFcUW2p-_icwg0m_aMQpVioT8J@mail.gmail.com>
	<4D658FAD.2010505@xiplink.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 00:19:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PsNzP-00016S-63
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 00:19:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752466Ab1BWXTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 18:19:18 -0500
Received: from fnord.ir.bbn.com ([192.1.100.210]:57851 "EHLO fnord.ir.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab1BWXTS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 18:19:18 -0500
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Feb 2011 18:19:17 EST
Received: by fnord.ir.bbn.com (Postfix, from userid 10853)
	id 1DF1952C6; Wed, 23 Feb 2011 18:09:13 -0500 (EST)
X-Hashcash: 1:20:110223:jaysoffian@gmail.com::aFnfh8HZE9uVMPqY:000000000000000000000000000000000000000000Rrf
X-Hashcash: 1:20:110223:marcnarc@xiplink.com::cJ/TMQQ8p/n809a6:000000000000000000000000000000000000000001oTk
X-Hashcash: 1:20:110223:git@vger.kernel.org::aFnfh8HZE9uVMPqY:0000000000000000000000000000000000000000001SvV
X-Hashcash: 1:20:110223:johan@herland.net::UyWqTwvZzWFfJpH3:000000000000000000000000000000000000000000007fa2
In-Reply-To: <4D658FAD.2010505@xiplink.com> (Marc Branchaud's message of "Wed,
	23 Feb 2011 17:52:29 -0500")
User-Agent: Gnus/5.110012 (No Gnus v0.12) Emacs/23.2 (berkeley-unix)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167738>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Marc Branchaud <marcnarc@xiplink.com> writes:

> On 11-02-23 02:07 PM, Jay Soffian wrote:
>
>> And on a case-insensitive file-system, git has remapped foo.[ch] to
>> foo~2.[ch] for the purposes of avoiding collisions on checkout.
>>=20
>> The checkout can't be compiled correctly, so what's the point of even
>> allowing it?
>
> In our case it would be useful to still have that checkout because the
> people working on the case-insensitive systems are dealing with a
> different part of the tree and don't care about the part with the
> collision.

Agreed; I've had this problem too.  In particular, a repository with
multiple packages imported, one of which was a Linux flavor that has
conflicting names in case-preserving filesystems.  The result was an
apparently modified checkout, but the offending files were not
interesting to the project.  So some sort of remapping, and the
subsequent prohibition on modifications (perhaps to either) seems like a
good plan.

Perhaps by default the checkout should just error out, but then it would
be good to have a variable to instead translate the duplicated names.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iEYEARECAAYFAk1lk5IACgkQ+vesoDJhHiUKAQCgqOl0AofI1qxhK2kaEN6VE6Dn
T0UAoJhetT+8Ey8rI+ok1S+AMwKV0UBs
=b6Lg
-----END PGP SIGNATURE-----
--=-=-=--
