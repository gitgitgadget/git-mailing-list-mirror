From: martin f krafft <madduck@madduck.net>
Subject: Tracking topic branches with rebases vs. merges (was: Branch
 dependencies)
Date: Wed, 3 Aug 2011 12:10:22 +0200
Message-ID: <20110803101022.GC27996@fishbowl.rw.madduck.net>
References: <20110801121946.GA575@fishbowl.rw.madduck.net>
 <CAKPyHN0kAJ-MVsrXam5NjsOYkta4nsSrZUvKoMSi-FeRUSuLEw@mail.gmail.com>
 <20110802190806.GA16674@fishbowl.rw.madduck.net>
 <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
To: Bert Wesarg <bert.wesarg@googlemail.com>,
	git discussion list <git@vger.kernel.org>,
	Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Wed Aug 03 12:10:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoYPZ-0003YK-Jx
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 12:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414Ab1HCKKp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 06:10:45 -0400
Received: from seamus.madduck.net ([213.203.238.82]:50051 "EHLO
	seamus.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752594Ab1HCKKn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 06:10:43 -0400
Received: from fishbowl.rw.madduck.net (129-204.79-83.cust.bluewin.ch [83.79.204.129])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "fishbowl.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by seamus.madduck.net (postfix) with ESMTPS id 15F0D407D3C;
	Wed,  3 Aug 2011 12:10:31 +0200 (CEST)
Received: by fishbowl.rw.madduck.net (Postfix, from userid 1000)
	id 7A7AC1FE4C; Wed,  3 Aug 2011 12:10:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CAKPyHN0EsXMKQ2g7ONaO4yw2ioPbMhg8XCsmB20je=O1DDeE5Q@mail.gmail.com>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux wheezy/sid kernel 3.0.0-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 0.97.2 at seamus
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178555>


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Bert Wesarg <bert.wesarg@googlemail.com> [2011.08.03.0125 +0200=
]:
> I think that having the TopGit philosophy of one feature branch is
> one patch, you can handle an rebased upstream. Thinking of
> a feature branch as a series of patches makes this way harder. But
> I would like to have this philosophy.

Let me just make sure I understand you right: you do not like the
following branch management strategy:

       o--o--o--+--o--o--+--o-.
      /        /        /      \
  o--o--o--o--o--o--o--o--o--o--o--=E2=97=8F

and you would prefer if the topic branch was rebased all along (like
what git.git advocates), and then transferred to mainline with
git-format-patch/git-send-e-mail/git-am (or ff-merged).

I am torn on this issue. On the one hand, I do not find the above to
be so problematic, especially not if the downstream merges happen
only infrequently (undo merges that do not produce conflicts, as
advocated by gitworkflows(7)).

On the other hand, I completely agree with you that rebasing is much
nicer, and it certainly works without publishing the branch. In
git.git, people seem to maintain their own branches and send patch
sets to the mailing list for review.

But how could you and I truly cooperate on a feature branch without
using merges, and without establishing a lock-unlock protocol to
ensure only sequential updates of the refs?

Thanks,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
"alles gackert, aber wer will noch still
 auf dem nest sitzen und eier zu br=C3=BCten?"
                                      -- friedrich wilhelm nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/sig-policy/999bbcc4/current)

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQLvBAEBCgDZBQJOOR6OwBEaaHR0cDovL21hcnRpbi1rcmFmZnQubmV0L2dwZy9z
aWctcG9saWN5LzU1Yzk4ODJkOTk5YmJjYzQvMjAxMTAxMjQxMTI1P3NoYTUxMnN1
bT0xY2FkOTZmZDI3ZDMyMzNmNTNlMjI4NDk1MzM2NDgxMDdlNWVlOGQ1YmU2NTUy
NTFkNzRjOGYxYzVjM2JjNDJmMjMwNGZhNTE1MTUwZjdiZDRkZDA1ZTk4MTk5MjRm
MDQ5NTEzZWU5OTYyY2E3MTcwOWY4MWQ5NDUxNTg1MmJkOAAKCRBVyYgtmZu8xL57
D/4iI1yDrgJAyoaOf6z0i6F4v2hcUeLQIwh6LMqSBMZb0pDd599fFDvX7DWUwMp1
/lYy2dQzZX3lmP3sB6L04iRNp0pTZn8/MYn+IvdAx7HhyXeHDjOepqXm7CzNiloI
tVDU0KERihWzu9eZxZuc75ZkYrkM8K3P0r+xgS/1rg233JondaYw9ZoKUcpGORmQ
eTA4Rp9Mrkd4hv/TQ2Y59SYL1qrta3Xt2LsVCMwIruLFBH6ZVMa2gLlYFNJ+d8s8
tlkCoQT53TJCpVZJlIK8u94/i8QgJzq0mPHHwnR6/Rf4+w6UIOvCeRkvKvYssp3x
2mpCZwlfvZusnzZsjV2j+r94FbasJ7YPZDfk72cdpFV8OhNaTX/ZG824TnJfjYjC
Sg9zPz7T2hpaYAgdISAxqMkNnsqN8AcMJG43DcgpWaL4vRdQ8i32itO8QCdCgG3O
rE1TX9ZC26Xkn/ohiHa5zU7PcSG1IolszWHyURGp3ZnZEkUyn41ZoaFH8tbPphMJ
jlFKSO80Ddw75QpwR5fw6q3S7ecES+k0lUH5bCy3SLET0PzKFezcaNKFshjUAvb7
nKv5RytNkJnR75zM09eNvZCWnt66j9dpbMWhV5oXKRCGLtM1rd3q7Xsl5oCpUmD1
83d94Eo4cIeZo3ZtLvad2Fgz8J0JsrI1X8Lha7SHvBf68Q==
=L6cR
-----END PGP SIGNATURE-----

--YD3LsXFS42OYHhNZ--
