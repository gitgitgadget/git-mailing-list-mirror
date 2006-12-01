X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Fri, 1 Dec 2006 17:54:19 +0100
Message-ID: <20061201165418.GD18810@admingilde.org>
References: <20061130170625.GH18810@admingilde.org> <200612010902.51264.andyparkins@gmail.com> <20061201110032.GL18810@admingilde.org> <45701B8D.1030508@b-i-t.de> <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org> <45704EA3.40203@b-i-t.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="h4FfhoHh9AMwLYAn"
NNTP-Posting-Date: Fri, 1 Dec 2006 16:54:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45704EA3.40203@b-i-t.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32945>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GqBea-0003wy-JO for gcvg-git@gmane.org; Fri, 01 Dec
 2006 17:54:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031615AbWLAQyV (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 11:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031619AbWLAQyV
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 11:54:21 -0500
Received: from agent.admingilde.org ([213.95.21.5]:6029 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1031615AbWLAQyU
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 11:54:20 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqBeV-0007o6-3c; Fri, 01 Dec 2006 17:54:19 +0100
To: Stephan Feder <sf@b-i-t.de>
Sender: git-owner@vger.kernel.org


--h4FfhoHh9AMwLYAn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Fri, Dec 01, 2006 at 04:47:47PM +0100, Stephan Feder wrote:
> No so different. The way I see it is that "I" (meaning with submodules=20
> implemented as I proposed) could pull regularly from "your" repositories=
=20
> (implemented as you proposed) and work with the result (including=20
> submodules). Could you do the same?

Sorry, but with all that many people proposing things I am a bit lost
now.  Sometimes I thought you want exactly the same thing as I do,
sometimes I think we are talking in totally different directions.

> >For me a submodule is responsible for everything in or below a certain
> >directory.  So by definition when you change something in this
> >directory, you have to change it in the submodule.
>=20
> But you do not consider the case where you cannot change the submodule=20
> because you do not own it.

I do not understand you here.
The submodule is part of the supermodule, and the one who sets up the
repository owns the whole thing, including all submodules, just like all
the files which are part of the project.

If you mean the upstream repository of the submodule, then yes, this is
of course completely separated from the submodule and may be owned by
someone else.  Consequently, this upstream repository of course does not
need to change when someone introduces changes in the supermodule.

> For example, git has the subproject xdiff. If git had been able to work=
=20
> with subprojects as I envision, and if xdiff had been published as a git=
=20
> repository (not necessarily subproject enabled), it could have been=20
> pulled in git's subdirectory xdiff as a subproject.

This could have been done if submodule support would have been available
at the time xdiff was introduced, yes.

> There would not have been a separate branch or even repository for
> xdiff in the git repository.

What separate branch or repository are you talking about?

> All changes to xdiff in git could have been committed to the git=20
> repository only.

Yes, but if it would have been integrated as a submodule it obviously
would have been committed to the xdiff submodule inside the git
repository.
So the changes are really part of the git repository, but you could go
to the "git/xdiff" directory and only see the changes in the submodule,
without the normal supermodule history.

> Independently, they could have been published to upstream and be put
> into the xdiff repository by its author.  But the last part is what
> only the owner of the xdiff repository is able to decide.

Of course, everything still works like normal git repositories.

> >You can't change the submodule contents in the supermodule without also
> >changing the submodule.
> >This is just like you can't commit a change to a file without also
> >changing the file.
>=20
> There is a difference. I would say: If you commit a change to a file in=
=20
> one branch, it need not be changed in all branches.

But you need to change _at_least_ one branch.
Otherwise you cannot commit to a branch.

So if you change something in a submodule, you have to change one branch
in the submodule.
If you call git-checkout in the supermodule this will result in
something like a git-reset in the submodule.

> >No, this is the benefit you get by introducing submodules.
> >Why would you want to introduce a submodule when it is not linked to the
> >supermodule?
>=20
> Because the submodule must be independent of the supermodule.
>=20
> I see where you are coming from. You have one project that is divided=20
> into subprojects but the subprojects themselves are not independent.
>=20
> What I would like to solve is the followng: You have a project X, an=20
> this project is made part of two other projects Y and Z (as a submodule=
=20
> or subproject or whatever you want to call it). The project X need not,=
=20
> must not or cannot care that it was made a subproject. But in projects Y=
=20
> and Z, you must be able to bugfix or extend or modify the code of=20
> projectX, and you must be able to push and pull changes between all=20
> three projects (of course we are only talking about the code part of=20
> project X).

Of course.

So if you wanted to check out everything, you could have something like
~/src/X, ~/src/Y/X, and ~/src/Z/X.
All of these would be GIT repositories, all of them have their
independent branches.

What I am saying is just that if you update Y, and the new Y contains an
updated version of X, then ~/src/Y/X/.git/refs/heads/master will be
changed by the pull, resulting in the new version of X being checked out
in ~/src/Y/X (alongside all the other updates inside ~/src/Y).
This of course is independend from ~/src/X or  ~/src/Z/X.

> Do you see where your solution makes that impossible, and that with more=
=20
> changes to the repository layout?

No ;-)

--=20
Martin Waitz

--h4FfhoHh9AMwLYAn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcF46j/Eaxd/oD7IRAqj/AJwNcBMiH4gJ0fqSTk+W4EaWGJmqZgCfVBS+
pwPUgnL8PgKtb91M5ZwYN6U=
=rpOK
-----END PGP SIGNATURE-----

