From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: An alternate model for preparing partial commits
Date: Fri, 27 Jun 2008 19:27:01 +0200
Message-ID: <20080627172701.GB15359@atjola.homenet>
References: <9af502e50806262350t6e794a92g7751147f1882965@mail.gmail.com> <20080627071014.GA12344@atjola.homenet> <9af502e50806270954q613087efub0eb05c25f2eefb9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Robert Anderson <rwa000@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:28:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCHjv-00041d-Oo
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 19:28:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754116AbYF0R1I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Jun 2008 13:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754085AbYF0R1H
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 13:27:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49447 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752017AbYF0R1E (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 13:27:04 -0400
Received: (qmail invoked by alias); 27 Jun 2008 17:27:02 -0000
Received: from i577B854A.versanet.de (EHLO atjola.local) [87.123.133.74]
  by mail.gmx.net (mp007) with SMTP; 27 Jun 2008 19:27:02 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX190hmd5fbx0JksrBqvpjNkSd/xjE2zVX5nU0dGFfJ
	UuLb9OPsXPUVzX
Content-Disposition: inline
In-Reply-To: <9af502e50806270954q613087efub0eb05c25f2eefb9@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86606>

On 2008.06.27 09:54:43 -0700, Robert Anderson wrote:
> On Fri, Jun 27, 2008 at 12:10 AM, Bj=F6rn Steinbrink <B.Steinbrink@gm=
x.de> wrote:
> > Hm, I use "stash" for that purpose, which leads to kind of the reve=
rse
> > of your approach. So I do sth. like this:
> >  - hack hack hack
> >  - Notice that I want to make two commits out of what I have in my
> >   working tree
> >  - git add -p -- stage what I want in the first commit
> >  - git commit -m tmp -- temporary commit
>=20
> This is a guess at the first commit?  I don't like it, but I'm still
> listening.

It's rather a work-around to stash away only the changes that are not i=
n
the index. See the other reply to my mail for a patch that adds an
option to stash to do that without the commit/reset hack.

> >  - git stash -- stash away what doesn't belong in the first commit
> >  - git reset HEAD^ -- drop the temporary commit, with the changes k=
ept
> >   in the working tree
>=20
> Now I have my guess at the first commit as my tree state, correct?
> What happens when I decide I need a couple of hunks from another file
> which I missed in my first guess, and is now in the stashed state?
> How do I get those out of the stash and into the working tree?  If
> there is no convenient way to do that, then this method is not
> sufficient to cover the use case I am talking about.

git stash pop
eventually fix conflicts if you changed the working tree in the meantim=
e
go back to the "git add -p" step

Bj=F6rn
