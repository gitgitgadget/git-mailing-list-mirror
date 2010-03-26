From: "R. Tyler Ballance" <tyler@monkeypox.org>
Subject: Re: Rebasing with merges and conflict resolutions
Date: Fri, 26 Mar 2010 10:16:04 -0700
Message-ID: <20100326171603.GA12592@kiwi.sharlinx.com>
References: <20100326031111.GB27737@kiwi.sharlinx.com>
 <4BAC5C14.4060903@viscovery.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Mar 26 18:16:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvD8u-00073Q-An
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 18:16:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971Ab0CZRQO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 13:16:14 -0400
Received: from mail.geekisp.com ([216.168.135.169]:38237 "EHLO
	starfish.geekisp.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751531Ab0CZRQN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 13:16:13 -0400
Received: (qmail 15138 invoked by uid 1003); 26 Mar 2010 17:16:11 -0000
Received: from localhost (HELO kiwi.sharlinx.com) (tyler@monkeypox.org@127.0.0.1)
  by mail.geekisp.com with SMTP; 26 Mar 2010 17:16:10 -0000
Mail-Followup-To: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <4BAC5C14.4060903@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143260>


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Fri, 26 Mar 2010, Johannes Sixt wrote:

> Please don't set Mail-Followup-To on this list.
>=20
> Am 3/26/2010 4:11, schrieb R. Tyler Ballance:
> > Two contributors worked in tandem on a particular project, constantly m=
erging
> > back and forth between each other creating a history of 118 commits tot=
al with
> > 37 of them being merge commits, 7 of those merge commits having conflict
> > resolutions involved.
> >=20
> > I would /like/ to rebase those into a more linear revision history, but=
 I
> > can't seem to find any set of commands that doesn't have me:
> >    a) Manually re-doing every conflict resolution and merge (git rebase=
 -p master)
> >    b) Drastically diverging from the original topic branch and entering=
 some
> >       sort of mergeless hell (git rebase master)
>=20
> I'm afraid you can't avoid the merge conflict resolutions. But you can let
> you help by git-rerere. Look into the script rerere-train.sh that lets you
> prime your rerere database.
>=20
> http://repo.or.cz/w/alt-git.git/blob_plain/master:/contrib/rerere-train.sh
>=20
> > Is it even possible to straighten this out without a massive rework of =
these
> > commits?
>=20
> I would sort the commits into topics and then repeatedly rebase -i the
> history involved onto the same commit, each time removing those commits
> that do not belong to the topic. That is, you get a forest of topics
> sprouting from the same commit. Finally, merge the topics back together.

The problem I'm having with this is that with a `git rebase -p -i master` I
can't even squash two related changes that are right next to each other
together because the rebase bails out earlier on conflicts while trying to
replay.

Perhaps I'm chosing the incorrect upstream?

> IOW, I wouldn't aim at a completely linear history, at least not at the
> first try.
>=20
> > In the future, is there a better way for two developers to work in the =
same
> > back-and-forth fashion (code ping pong!) without leading to *heavily* m=
erged
> > histories that are unpossible to untangle?
>=20
> Discipline. Keep developers focused on their topic. Merge only after a
> topic is completed. Do not give in to "oh, *your* feature is cool, *I*
> want to have it now, so I merge it".

I think that's easier said than done, with backend work I'm able to clearly
define topics, whereas the front-end developers (as it is in this case)
typically overlap ever so slightly in their work

Cheers,
-R. Tyler Ballance
--------------------------------------
 Jabber: rtyler@jabber.org
 GitHub: http://github.com/rtyler
Twitter: http://twitter.com/agentdero
   Blog: http://unethicalblogger.com


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.12 (GNU/Linux)

iEYEARECAAYFAkus69MACgkQFCbH3D9R4W9E9wCfRc0+9T+08irSq4+DWmwQv5/I
qX8AoIc7ufaP/xlSTr3UKdW0vbCP2hab
=tDsy
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
