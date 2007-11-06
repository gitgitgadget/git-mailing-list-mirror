From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in  git, help users out.
Date: Tue, 06 Nov 2007 01:08:39 +0100
Message-ID: <20071106000839.GR8939@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org> <CD2E6759-9E7E-41E6-8B58-AB6CA9604111@midwinter.com> <7vlk9cmiyq.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711052325090.4362@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Mjqg7Yu+0hL22rav";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpBzz-0000Qr-Ev
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 01:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbXKFAIm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 19:08:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754453AbXKFAIm
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 19:08:42 -0500
Received: from pan.madism.org ([88.191.52.104]:50764 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753999AbXKFAIl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 19:08:41 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EAF8E28A1E;
	Tue,  6 Nov 2007 01:08:39 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 233DD7D21; Tue,  6 Nov 2007 01:08:39 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0711052325090.4362@racer.site>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63597>


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 11:40:46PM +0000, Johannes Schindelin wrote:
> Hi,
>=20
> On Mon, 5 Nov 2007, Junio C Hamano wrote:
>=20
> > Steven Grimm <koreth@midwinter.com> writes:
> >=20
> > > But that suggested command is not going to convince anyone they were
> > > wrong about git being hard to learn. I wonder if instead of saying, "I
> > > know what you meant, but I'm going to make you type a different
> > > command," we should make git revert just do what the user meant.
> > >
> > > There is already precedent for that kind of mixed-mode UI:
> > >
> > > git checkout my-branch
> > > vs.
> > > git checkout my/source/file.c
> >=20
> > That's an example of mixed-mode UI, but what you are suggesting is quit=
e=20
> > different, isn't it?
> >=20
> > There is no other officially supported single-command-way to
> > checkout paths out of the index.
>=20
> Okay, let's step back a bit.
>=20
> We taught "git show" to show other objects than commits, by doing the=20
> obvious things.  So there _is_ a precendent to changing a commands=20
> behaviour to accept more than just commits.  And there was already anothe=
r=20
> command for the same purpose, cat-file, which was never meant as=20
> porcelain however.
>=20
> Now, what does "revert" _mean_?  At the moment, it wants a commit, and=20
> will undo the changes that commit introduced, _and commits it_ (asking=20
> for a message).
>=20
> What would I expect "git revert -- file" to do?  It would undo the change=
s=20
> to that file -- and since no commit was specified, I would expect it to=
=20
> look at the changes against the index.  (IOW exactly what Steven=20
> proposed.)
>=20
> To continue the analogy, it would have to commit the undoing of the=20
> change.  But since that change never was committed, I think it is more=20
> natural to _not_ commit it.
>=20
> In the same way, I would expect "git revert <commit> -- file" to undo the=
=20
> changes in that commit to _that_ file (something like "git merge-file=20
> file <commit>:file <commit>^:file"), but this time commit it, since it=20
> was committed at one stage.

  I agree that this is something that really makes sense to me, and does
not looks like a perversion of the UI, and quite a nice extension in
fact. And it would _finally_ solve the issue that for _ANYTHING_ on the
planet that I've used for more than 10 seconds, $SCM revert path/to/file
reverts local changes :)

  When you look at how git-revert is implemented, you'll see that it
uses the very same code as git cherry-pick does, and in fact, I've
wanted a git cherry-pick <commit> -- path1 path2 path3 for a _very_ long
time, and your proposal would just gracefully give it as a bonus I
believe (of course uncommited changes have no sense for a cherry-pick).

  I like it a lot.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL7CHvGr7W6HudhwRAilGAJ9h4pGheRgprcjqkvd9Xczjq44ubgCdEJ/m
cflrvHb+rpb5eyrekdG6gy0=
=kqOj
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
