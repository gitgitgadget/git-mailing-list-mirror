From: garyc618 <gary.carter@eigen.com>
Subject: Re: merging bare repository
Date: Mon, 30 May 2011 19:01:32 -0700 (PDT)
Message-ID: <1306807292356-6421097.post@n2.nabble.com>
References: <533718318.20110513145132@gmail.com> <20110513135348.GB10857@jpl.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 04:03:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QREIi-00010Z-7r
	for gcvg-git-2@lo.gmane.org; Tue, 31 May 2011 04:03:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688Ab1EaCBd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 May 2011 22:01:33 -0400
Received: from sam.nabble.com ([216.139.236.26]:57222 "EHLO sam.nabble.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751695Ab1EaCBd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 May 2011 22:01:33 -0400
Received: from jim.nabble.com ([192.168.236.80])
	by sam.nabble.com with esmtp (Exim 4.72)
	(envelope-from <gary.carter@eigen.com>)
	id 1QREGy-0001pJ-Bx
	for git@vger.kernel.org; Mon, 30 May 2011 19:01:32 -0700
In-Reply-To: <20110513135348.GB10857@jpl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174789>


Magnus B=C3=A4ck-2 wrote:
>=20
>=20
> Don't do the merge in the server-side bare git, do it somewhere you'v=
e
> made a non-bare clone that has a worktree. A workstation would be the
> best choice, but you could make such a clone on the server too (but I=
'd
> avoid introducing a process in an organization that required people t=
o
> be able to logon to the Git server). Once you've actually done the me=
rge
> you can push the merge commit to the master branch of
> ssh://git@server/git/project.git.
>=20
> To deal with upstreams like this I recommend you place the upstream
> branch(es) in a separate namespace prefixed by <upstreamname>/, e.g.
> github/master if your upstream is the master branch from the official
> Github repo of the project. Example:
>=20
>    git fetch ssh://git@some.org/git/project.git
>    git push ssh://git@server/git/project.git FETCH_HEAD:github/master
>=20
> If you mirror the upstream branches like this on your server merges
> from upstream becomes trivial[*],
>=20
>    git merge origin/github/master
>    git push ssh://git@server/git/project.git HEAD:master
>=20
> and can be done on any workstation plus it's easy for your users to
> e.g. see what they've been up to compared to the upstream:
>=20
>    git log origin/github/master..origin/master
> [...]
>=20

Could you explain more about how this works - where do I find the chara=
cter
string to use instead of "github".  It can't be arbitrary, I got an err=
or
message.
When I did the fetch it said
*branch HEAD -> FETCH_HEAD
could you explain what this means in more detail?

We enthusiasts-who-don't-have-time-to-become-git-masters really need so=
me
well explained examples if we're going to be able to convince managemen=
t
that git is not some super complicated tool that takes weeks to learn. =
 The
particular use case described in this thread is the last sticking point=
 I
have to make work before I can show git doing everything we need it to =
do to
my management.


--
View this message in context: http://git.661346.n2.nabble.com/merging-b=
are-repository-tp6358945p6421097.html
Sent from the git mailing list archive at Nabble.com.
