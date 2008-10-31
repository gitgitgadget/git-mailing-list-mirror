From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] filter-branch: add git_commit_non_empty_tree and  --prune-empty.
Date: Fri, 31 Oct 2008 23:42:41 +0100
Message-ID: <20081031224241.GD21799@artemis.corp>
References: <20081030132623.GC24098@artemis.corp> <1225445204-28000-1-git-send-email-madcoder@debian.org> <alpine.DEB.1.00.0810312334480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="UfEAyuTBtIjiZzX6";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, pasky@suse.cz, srabbelier@gmail.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Oct 31 23:44:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw2iu-00041T-No
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 23:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752542AbYJaWmp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 18:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751921AbYJaWmp
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 18:42:45 -0400
Received: from pan.madism.org ([88.191.52.104]:48685 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751893AbYJaWmo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 18:42:44 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 1F6AC3B728;
	Fri, 31 Oct 2008 23:42:42 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 643D55EE243; Fri, 31 Oct 2008 23:42:41 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0810312334480.22125@pacific.mpi-cbg.de.mpi-cbg.de>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99665>


--UfEAyuTBtIjiZzX6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 10:36:58PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Fri, 31 Oct 2008, Pierre Habouzit wrote:
>=20
> > git_commit_non_empty_tree is added to the functions that can be run fro=
m=20
> > commit filters. Its effect is to commit only commits actually touching=
=20
> > the tree and that are not merge points either.
> >=20
> > The option --prune-empty is added. It defaults the commit-filter to
> > 'git_commit_non_empty_tree "$@"', and can be used with any other
> > combination of filters, except --commit-hook that must used
> > 'git_commit_non_empty_tree "$@"' where one puts 'git commit-tree "$@"'
> > usually to achieve the same result.
>=20
> I think that the example Sverre posted is better.  It might be a bit more=
=20
> to write out, but at least people can adapt it to their needs (as opposed=
=20
> to only skip "empty" commits).
>=20
> However, I would _love_ to see your tests being merged with Sverre's patc=
h=20
> (of course, the tests should use the described procedure, then).

Well Sverre's example is probably the most efficient way to do the task,
though the thing is right now, what one wants is rarely to "just" skip
empty commits, but to do some modifications that does not leave empty
commits.

IOW not doing a modification _then_ a new one, but both at the same
time. Given how slow filter-branch can be, it's better to do one
transformation instead of two.


Note that I don't think we should apply only my patch and not Sverre's,
his proposal just made me think that this was an itch I wanted to
scratch for a long time, and both probably are complementary.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--UfEAyuTBtIjiZzX6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLieEACgkQvGr7W6HudhwONACffKBNeLZrHvBff2q260yQ73g/
L/kAn1sHC+d51eiYQ2Buz4k6YeI81orO
=28UL
-----END PGP SIGNATURE-----

--UfEAyuTBtIjiZzX6--
