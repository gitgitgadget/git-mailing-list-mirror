From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: are hashes calculated from data
Date: Fri, 2 Apr 2010 09:08:59 +0200
Message-ID: <20100402070859.GD14999@m62s10.vlinux.de>
References: <g2veaacf13c1004011931w70695d1emdceeb977397aee0d@mail.gmail.com> <o2q32541b131004011950u6023ef29ocac1d80f2847ef6f@mail.gmail.com> <buozl1mbi0o.fsf@dhlpc061.dev.necel.com> <y2j32541b131004012148w283911f8pf04a21fc307f68ed@mail.gmail.com> <20100402061015.GC14999@m62s10.vlinux.de> <z2i32541b131004012349na7af3571j67c3a33e3e3ba78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Miles Bader <miles@gnu.org>,
	Raymond Auge <raymond.auge@liferay.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 02 09:09:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nxb08-0002Gv-NB
	for gcvg-git-2@lo.gmane.org; Fri, 02 Apr 2010 09:09:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759247Ab0DBHJE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Apr 2010 03:09:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:43021 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759227Ab0DBHJC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Apr 2010 03:09:02 -0400
Received: (qmail invoked by alias); 02 Apr 2010 07:09:01 -0000
Received: from m62s10.vlinux.de (EHLO m62s10.vlinux.de) [83.151.21.204]
  by mail.gmx.net (mp030) with SMTP; 02 Apr 2010 09:09:01 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX19rJDR7EDVrSCcmFQs1ioYxvqw9zDV7sWcz2HhglZ
	nEH1D5uhoxfZaD
Received: by m62s10.vlinux.de (Postfix, from userid 1000)
	id 5535AD4002; Fri,  2 Apr 2010 09:08:59 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <z2i32541b131004012349na7af3571j67c3a33e3e3ba78@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.56999999999999995
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143782>

On Fri, Apr 02, 2010 at 02:49:25AM -0400, Avery Pennarun wrote:
> On Fri, Apr 2, 2010 at 2:10 AM, Peter Baumann <waste.manager@gmx.de> =
wrote:
> > On Fri, Apr 02, 2010 at 12:48:44AM -0400, Avery Pennarun wrote:
> >> =A0 =A0 =A0 =A0# configure your git-svn so that all its branches a=
re under remotes/svn/*
> >> =A0 =A0 =A0 =A0git fetch origin
> >> =A0 =A0 =A0 =A0git svn fetch --fetch-all
> >> =A0 =A0 =A0 =A0for each branch in remotes/svn/*
> >> =A0 =A0 =A0 =A0 =A0 =A0git checkout remotes/svn/$branch =A0 # deta=
ches HEAD
> >> =A0 =A0 =A0 =A0 =A0 =A0git merge --no-ff origin/$branch
> >> =A0 =A0 =A0 =A0 =A0 =A0git svn dcommit =A0 # replaces merge commit
> >> =A0 =A0 =A0 =A0 =A0 =A0git checkout origin/$branch
> >> =A0 =A0 =A0 =A0 =A0 =A0git merge remotes/svn/$branch
> >> =A0 =A0 =A0 =A0 =A0 =A0git push origin HEAD:$branch
> >> =A0 =A0 =A0 =A0git push origin refs/remotes/svn/*:refs/heads/svn/*
> >
> > If I understand you correctly, this will commit only the the merge =
to svn
> > and won't show all the commits the developer made (because of the -=
-no-ff).
> > From a SVN standpoint isn't it the same as doing the following?
> >
> > =A0 =A0 =A0 =A0git checkout remotes/svn/$branch =A0 =A0 =A0 =A0# to=
 deatch the HEAD
> > =A0 =A0 =A0 =A0git merge --squash =A0origin/$branch
> > =A0 =A0 =A0 =A0git svn dcommit
> >
> > I asked because in my workflow I can't to afford lossing the single=
 commits.
>=20
> No, not quite the same.
>=20
> When git-svn replaces your merge commit with a new commit (as part of
> the 'git svn dcommit' step) the new commit *stays* a merge commit in
> git.  That means it has two parents: the svn parent commit, and the
> commit that you merged from in the first place.
>=20
> So what happens is that svn will see only a single commit, but your
> git history remains intact and git push/pulling will continue working
> as you expect.
>=20

Ah. Ok. So I actually was true, meaning "from a SVN standpoint", I just
expressed myself not clearly.

> If you really need svn to see every individual commit, then you're ou=
t
> of luck.  The only way to do it is to rebase every time you want to
> commit to svn.  git-svn then replaces every single one of your commit=
s
> (essentially another rebase, so it can add the git-svn: tags to the
> commit message) which makes push/pulling between git repos impossible=
=2E
>=20
> So those are your two choices.  Personally, I like my way as a
> transition plan, because the git repo keeps the precise history
> (including forks and merges), while the svn keeps *working* for the
> stragglers who want to keep using it.
>=20

Thx for your explanation,

Peter
