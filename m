From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Unhelpful "branch.master.remote = <nickname>" advice?
Date: Thu, 12 Nov 2009 15:56:35 +0100
Message-ID: <20091112145635.GA6721@atjola.homenet>
References: <1257945756.26362.79.camel@heerbeest>
 <48B54636-1825-48B3-BECD-4150A55B013F@dbservice.com>
 <1257965806.26362.132.camel@heerbeest>
 <D6B0AE61-6CA3-4F79-BB50-B8795415BAB7@dbservice.com>
 <1257968052.26362.155.camel@heerbeest>
 <AC99BA30-A36D-4798-8E7D-9D69EFE99D55@dbservice.com>
 <1258035449.26362.273.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Tomas Carnecky <tom@dbservice.com>, git list <git@vger.kernel.org>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Thu Nov 12 15:56:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8b6N-0004Nl-LY
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 15:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753031AbZKLO4g convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Nov 2009 09:56:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752882AbZKLO4g
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Nov 2009 09:56:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:55820 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752861AbZKLO4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Nov 2009 09:56:35 -0500
Received: (qmail invoked by alias); 12 Nov 2009 14:56:39 -0000
Received: from i59F574F9.versanet.de (EHLO atjola.homenet) [89.245.116.249]
  by mail.gmx.net (mp055) with SMTP; 12 Nov 2009 15:56:39 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19n/cEOcvFnAf42GwJtgcxKh22I40jxanc3ylMUOB
	v2ZFDi72JmieT+
Content-Disposition: inline
In-Reply-To: <1258035449.26362.273.camel@heerbeest>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132769>

On 2009.11.12 15:17:29 +0100, Jan Nieuwenhuizen wrote:
> Op woensdag 11-11-2009 om 21:32 uur [tijdzone +0100], schreef Tomas
> Carnecky:
>=20
> Hi Tomas,
>=20
> > It didn't tell you to copy'n'paste the whole lines to a git-config(=
1) =20
> > commandline. But I do see that the output can be confusing for some=
one =20
> > not familiar with the git configuration files/git-config.
>=20
> Once I get this to work, I'll send a patch for it.
>=20
> > I don't know the relationship between you and eddy, but usually you=
 =20
> > shouldn't rebase (=3Drewrite) eddies commits. That also means you'd=
 have =20
> > to live with the merge commits.
>=20
> Hmm, okay.
>=20
> > I see your mistake. Both the origin and eddy remote write to the sa=
me =20
> > namespace (refs/remotes/origin/*), and that's also why you get (for=
ce =20
> > update) below
>=20
> Ah, that makes sense.
>=20
> > . Change the fetch line of remote.eddy.fetch to +refs/heads/*:refs/=
=20
> > remotes/eddy/*. After that both command (pull -r / pull -r eddy) =20
> > should work (I hope).
>=20
> Okay, so now I have
>=20
>     [branch "master"]
> 	    remote =3D origin
> 	    merge =3D refs/heads/master
>     [remote "origin"]
> 	    url =3D git@github.com:janneke/gub.git
> 	    fetch =3D +refs/heads/*:refs/remotes/origin/*
>     # advise from git pull, using <nickname> =3D eddy
>     #        branch.master.remote =3D <nickname>
>     #        branch.master.merge =3D <remote-ref>
>     #        remote.<nickname>.url =3D <url>
>     #        remote.<nickname>.fetch =3D <refspec>
>     #[branch "master"]
>     #	remote =3D eddy
>     #	merge =3D refs/heads/master
>     [remote "eddy"]
> 	    url =3D http://github.com/epronk/gub.git
>     #use remote.eddy.fetch to +refs/heads/*:refs/remotes/eddy/*.
> 	    fetch =3D +refs/heads/*:refs/remotes/eddy/*
>=20
> It looked promising, but still get
>=20
>     15:00:20 janneke@peder:~/vc/gub
>     $ git pull -r --verbose
>     From git@github.com:janneke/gub
>      =3D [up to date]      lilypond-release-branch -> origin/lilypond=
-release-branch
>      =3D [up to date]      master     -> origin/master
>     Current branch master is up to date.

That used the configured defaults.

>     15:00:26 janneke@peder:~/vc/gub
>     $ git pull -r --verbose eddy
>     From http://github.com/epronk/gub
>      =3D [up to date]      lilypond-release-branch -> eddy/lilypond-r=
elease-branch
>      =3D [up to date]      master     -> eddy/master

This one got arguments, so it didn't use defaults.

If you want "git pull" to use the "eddy" remote, then set
branch.<name>.remote to eddy, not to origin.


And as a sidenote:
Using "git pull --rebase" with more than one upstream is most of the
time a very bad idea.

Let's say we have:

A---B---C---D (master)
     \   \
      \   E---F---G (origin's master)
       \
        H---I---J (eddy's master)

Now you do "git pull --rebase origin master", which results in:

                      D' (master)
                     /
A---B---C---E---F---G (origin's master)
     \
      H---I---J (eddy's master)

And then you do "git pull eddy master", which will now rebase history
that is not yours:

A---B---C---E---F---G (origin's master)
     \
      H---I---J (eddy's master)
               \
                C'--E'--F'--G'--D' (master)

IOW, you get one hell of a mess.

Bj=F6rn
