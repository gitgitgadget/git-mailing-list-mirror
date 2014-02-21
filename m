From: John Keeping <john@keeping.me.uk>
Subject: Re: Fwd: Git Directory Diff for submodule
Date: Fri, 21 Feb 2014 09:27:25 +0000
Message-ID: <20140221092725.GE1048@serenity.lan>
References: <CAN-m_UmNudmxJnA95h1nYqi7GGxtzKqqpgFHmJZ+MTnxRoEd6g@mail.gmail.com>
 <CAN-m_UnQ7Yzuq7n6mxmsd3XcfLSVxMdnLiGFDiN1Ph3ZiFqwew@mail.gmail.com>
 <CAN-m_U=eYSEXfVBcD1Rfx-YvGx5Wu+hB2uAc=6xX_HO7bS0FUg@mail.gmail.com>
 <52F54441.6090209@web.de>
 <CAN-m_UnSqTnLydyVF2TLxOia9vzmQr9e4+xWh8aVNBosfCq5nA@mail.gmail.com>
 <53066D8A.6070909@web.de>
 <CAJDDKr5czZezBZC1HtS9EjKvpPn-sxQTJOWLABRBVw2ei2BFVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	=?iso-8859-1?Q?G=E1bor_Lipt=E1k?= <gabor.liptak@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Feb 21 10:28:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WGmOk-0004ns-MX
	for gcvg-git-2@plane.gmane.org; Fri, 21 Feb 2014 10:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754601AbaBUJ1o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 Feb 2014 04:27:44 -0500
Received: from jackal.aluminati.org ([72.9.247.210]:33751 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754351AbaBUJ1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Feb 2014 04:27:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 7FDB0CDA59A;
	Fri, 21 Feb 2014 09:27:35 +0000 (GMT)
X-Quarantine-ID: <qOzyNdkqaBvL>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qOzyNdkqaBvL; Fri, 21 Feb 2014 09:27:34 +0000 (GMT)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 84515CDA5D9;
	Fri, 21 Feb 2014 09:27:27 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <CAJDDKr5czZezBZC1HtS9EjKvpPn-sxQTJOWLABRBVw2ei2BFVg@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242459>

On Thu, Feb 20, 2014 at 02:41:23PM -0800, David Aguilar wrote:
> On Thu, Feb 20, 2014 at 1:03 PM, Jens Lehmann <Jens.Lehmann@web.de> w=
rote:
> > Sorry for the late reply, but here we go ...
> >
> > Am 10.02.2014 07:33, schrieb G=E1bor Lipt=E1k:
> >> Hi Jens,
> >>
> >> So "git status" says:
> >>
> >> liptak@liptak-kubuntu:~/Projects/MAIN_MODULE/platform/SUBMODULE
> >> [master]$ git status
> >> # On branch master
> >> # Your branch is up-to-date with 'origin/master'.
> >> #
> >> # Changes not staged for commit:
> >> #   (use "git add <file>..." to update what will be committed)
> >> #   (use "git checkout -- <file>..." to discard changes in working
> >> directory)
> >> #
> >> #       modified:   xxxxxx.java
> >> #       modified:   xxxxxxx.java
> >> # ...
> >> # ...
> >> # ...
> >> # ...
> >> # ...
> >> #
> >> no changes added to commit (use "git add" and/or "git commit -a")
> >>
> >> git config core.worktree gives back: "../../../../platform/SUBMODU=
LE"
> >
> > Which looks a bit strange but is perfectly ok for a repository
> > that uses a gitfile, as the core.worktree setting is relative
> > to the git directory the gitfile references and not the directory
> > the gitfile lives in. A quick glance at the find_worktree
> > subroutine in git-difftool.perl makes me think that difftool is
> > not aware of that fact. David, does that make sense?
>=20
> That does make sense. It sounds like that may need to be adjusted.
>=20
> What does `git rev-parse --show-toplevel` print? It seems like the
> find_worktree() logic needs to be extended to handle .git files.

Having tried it with a submodule here, it looks like rev-parse gets thi=
s
right.

> >> The submodule was inited simply with "git submodule init" +
> >> "git.submodule update"
>=20
> Or possibly, as you mention below, it could be that "git submodule
> init" ended up writing the wrong core.worktree value. I'm not very
> familiar with how they are initialized, but the paths do seem sane, s=
o
> I doesn't seem like that's the issue.
>=20
> If it's a problem in difftool we can probably find a way to do the
> right thing. It looks like the core.worktree is relative to the
> .git/modules/XXX directory rather than the submodule (and
> super-project)'s worktree.
>=20
> Here's our current logic:
>=20
> sub find_worktree
> {
>     my ($repo) =3D @_;
>=20
>     # Git->repository->wc_path() does not honor changes to the workin=
g
>     # tree location made by $ENV{GIT_WORK_TREE} or the 'core.worktree=
'
>     # config variable.
>     my $worktree;
>     my $env_worktree =3D $ENV{GIT_WORK_TREE};
>     my $core_worktree =3D Git::config('core.worktree');
>=20
>     if (defined($env_worktree) and (length($env_worktree) > 0)) {
>         $worktree =3D $env_worktree;
>     } elsif (defined($core_worktree) and (length($core_worktree) > 0)=
) {
>         $worktree =3D $core_worktree;
>     } else {
>         $worktree =3D $repo->wc_path();
>     }
>     return $worktree;
> }
>=20
> John, any thoughts?

I don't really like reimplementing logic from core Git here, so I think
it might be best to just call "git rev-parse --show-toplevel" here; it
would also be sufficient to make sure we resolve $core_worktree against
$GIT_DIR - should we be doing that for $env_worktree as well?  It looks
like git-rev-parse treats a relative GIT_WORK_TREE as relative to the
current working directory, so we're OK there.

Does anyone know why repository->wc_path() does not obey the config
variable or $GIT_WORK_TREE?  It seems like the most correct fix is to
fix it there.
