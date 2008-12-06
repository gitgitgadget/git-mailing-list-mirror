From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: Git Books
Date: Sat, 6 Dec 2008 20:45:15 +0100
Message-ID: <20081206194515.GA4721@atjola.homenet>
References: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Scott Chacon <schacon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 20:46:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L936s-0003YI-Rx
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 20:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363AbYLFTpW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2008 14:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752362AbYLFTpV
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 14:45:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:38631 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752220AbYLFTpU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 14:45:20 -0500
Received: (qmail invoked by alias); 06 Dec 2008 19:45:16 -0000
Received: from i577B8F30.versanet.de (EHLO atjola.local) [87.123.143.48]
  by mail.gmx.net (mp057) with SMTP; 06 Dec 2008 20:45:16 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX18Z/gdim3sZRlX6JOdE9islkhduoTgOPi7VeqyM7T
	8FusA9JMEyb8R2
Content-Disposition: inline
In-Reply-To: <d411cc4a0812060358ub640ea3kd04072c5640eef68@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102472>

On 2008.12.06 03:58:28 -0800, Scott Chacon wrote:
> So, since I'm near the beginning of this process, I was wondering if
> the group had any feedback as to what might be super helpful to
> include.  I mean, I have a pretty good layout and all, but if you
> wanted to point me to some threads that tend to crop up in the mailin=
g
> list and IRC channel from relative newcomers that I might be able to
> nip in the bud, I would like to.  I'm addressing the stuff that _I_
> hear a lot, and I'm scanning the IRC logs and list for topics, but I
> figured many of you must answer the same questions all the time, too.

Just some random thoughts:

Please explain HEAD early on, and what it actually means. I've seen
quite a number of people understanding HEAD as, for example, a magic
keyword, a branch property, or a _direct_ reference to the latest commi=
t
on the branch they have checked out. Especially the last one has really
confused the hell out of some people when they came across the concept
of a detached HEAD.

Explaining remote tracking branches early on, say after the first
"clone" is also important I guess. A number of readers will probably
just "dive in" when they learned a few commands and clone some random
repo to start playing. Unless Murphy lets us down, they'll clone a repo
that has multiple branches and will sit there, wondering how to get one
of the branches that only exist as remote tracking branches in their
repo.

And for commands, it's IMHO best to always start with the "full blown"
form, and only then, after introducing the command and what it does,
start to talk about short forms and how you can leave out some argument=
s
and fall back to defaults.

=46or example:

rebase:
Start with "rebase --onto <onto> <upstream> <branch>" and how that take=
s
the commits from <upstream>..<branch> and "replays" them on top of
<onto>. In my experience, starting with that version and showing how it
affects the commit DAG helps people to actually understand what happens=
,
while a plain "git rebase master" seems like pure magic to some, becaus=
e
you can't even use the arguments to explain why and where things are
placed, or you start telling how those are all defaults, and then have
to explain everything all over again, when you use the explicit form fo=
r
more complicated things and people seem to get confused by that.

fetch:
Include refspecs in the first examples and show how a missing rhs cause=
s
the fetched stuff to be stored in FETCH_HEAD. And only then go on to
tell that remotes usually have a default refspec in their config, and
that you can thus omit the refspecs when you fetch from a remote.

push:
refspecs again. Maybe start with pushing a single branch/tag/whatever,
explicitly, eg. "git push origin refs/heads/master:refs/heads/master",
and only then introduce the DWIM stuff like "git push origin master".
Same thing for the default ":" refspec, please mention what that refspe=
c
means and that it is the default when no refspec is given (either on th=
e
command line or in the config). A lot of people don't seem to know abou=
t
refspecs at all, and the "matching branch names" refspec is IMHO worth
being mentioned, as I've seen a bunch of questions lately that could be
answered by explaining that. For example, updating matching branches an=
d
pushing a new tag at once, or having a push config that pushes one or
more branches to differently named branches on the remote, but using th=
e
name matching for all other. And personally, I also like "git push
origin : v1.2.3" better than pushing twice or naming my branches
explicitly :-)

Bj=F6rn
