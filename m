From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 22:40:48 +0400
Message-ID: <20090420184048.GF25059@dpotapov.dyndns.org>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org> <49EC7E3B.9050909@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 20:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvyTG-0006iW-8Q
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 20:43:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754598AbZDTSlZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 14:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754754AbZDTSlY
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 14:41:24 -0400
Received: from ti-out-0910.google.com ([209.85.142.191]:61821 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753583AbZDTSlX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 14:41:23 -0400
Received: by ti-out-0910.google.com with SMTP id 11so1399252tim.23
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 11:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=BoEcDuHxhyhzVL5Lw7MvEbyIHXgIfhH7iHGFKswEvbw=;
        b=a63Hl1CSFggNNguG4E199UbOmhagoXH9CyWBiZbUD6dFCZTO7PQmXAWKQ2P4j05M4T
         kfIXYEULORX+f0QlKyxF7dC5fkDfVl+3/V45YYjHnBLpl4dqEjqA+O9JOOM1UTFjckWK
         dIvN8/aqvEqp88ACRRMjZz/fwSeBsoZNEHyZ0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cwK3uPV2P2GvTqE4e1/a8ShMfYWDZZkc43d4giA/yiGNG/vjLYSffQ2HfhzYDSGjCT
         WHc5WXn/ksOsbaE7dUXjD+NxmzcXcTRQig9sbZdqbv/F+aWIgGEyP2TbP8CnZVwQ7gwn
         lerpBdzVFrayCXsPaTIdwdoiKLC4NRxwe0l2E=
Received: by 10.110.26.8 with SMTP id 8mr290370tiz.12.1240252881097;
        Mon, 20 Apr 2009 11:41:21 -0700 (PDT)
Received: from localhost (ppp91-78-50-115.pppoe.mtu-net.ru [91.78.50.115])
        by mx.google.com with ESMTPS id i6sm2036649tid.0.2009.04.20.11.41.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 20 Apr 2009 11:41:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <49EC7E3B.9050909@drmicha.warpmail.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117020>

On Mon, Apr 20, 2009 at 03:52:59PM +0200, Michael J Gruber wrote:
> Dmitry Potapov venit, vidit, dixit 20.04.2009 15:24:
> > On Mon, Apr 20, 2009 at 02:07:50PM +0200, Michael J Gruber wrote:
> >> Dmitry Potapov venit, vidit, dixit 20.04.2009 13:32:
> >>> On Sun, Apr 19, 2009 at 05:17:52PM +0200, Johannes Schindelin wro=
te:
> >>>>
> >>>> But it is important to keep in mind that our concept of branches=
 is not=20
> >>>> intuitive:
> >>>>
> >>>> http://longair.net/blog/2009/04/16/git-fetch-and-merge/
> >>>
> >>> I don't see how our concept of branches is any different from wha=
t other
> >>> version control systems have; but I see why it is so confusing fo=
r many
> >>
> >> It is very different, and for a good reason, indeed.
> >>
> >> git's branches really are moving tags. As such, there is no single
> >> branch that a commit would be tied to. A commit does not belong to=
 a
> >> specific branch; you commit on a branch (usually), and it may be
> >> contained in 1 or more branches, of course.
> >=20
> > When you create a new commit, it is always belong to _one_ branch a=
nd
> > never to two or more branches. After that you can create a child br=
anch
> > that will also contain this commit, but it is so in any other VCS.
>=20
> There is nothing in a git commit that ties it to a specific branch; i=
n
> that sense, it does not "belong" to any.

Let's take a look at definition of "branch" in different sources:

"Branching, in revision control and software configuration management,
is the duplication of an object under revision control (such as a sourc=
e
code file, or a directory tree) so that modifications can happen in
parallel along both branches."
Source: http://en.wikipedia.org/wiki/Branching_(software)

"This is the basic concept of a branch=E2=80=94namely, a line of develo=
pment
that exists independently of another line, yet still shares a common
history if you look far enough back in time. A branch always begins lif=
e
as a copy of something, and moves on from there, generating its own
history."
Source: http://svnbook.red-bean.com/en/1.1/ch04.html#svn-ch-4-sect-1

"When we need to be precise, we will use the word "branch" to mean a
line of development, and "branch head" (or just "head") to mean a
reference to the most recent commit on a branch."
Source: http://www.kernel.org/pub/software/scm/git/docs/v1.6.2.3/user-m=
anual.html#what-is-a-branch

It is not that Git commit is not belong to any, but it may appear as
being to many branches in shared history. Yet, I don't see anything
in definition of branch that would preclude this.

>=20
> A git branch is a pointer to a commit. That commit and its predecesso=
rs
> are contained in the branch. A commit may be contained in multiple
> branches, on equal footing: there is no "prime branch".

This is not accurate description. The aforementioned pointer is called
"branch head". Branch (in strictly sense) is a line of development,
which is defined by its head. A usual commit has one parent; a merge
commit can have more than one parent, the first parent defines the
branch line while other parents point to branches merged to it.

>=20
> In other VCS, a commit always belongs to exactly one branch: the one =
you
> committed it to, which is stored in the commit. It may be contained i=
n
> multiple branches, but belongs to the one only.

I am not sure that it is the case, but actually it depends how you
define terms "belong", "contained", "branch", etc... Anyway, no commonl=
y
used definition of "branch" implies any idea of exclusiveness ownership
of some commit.

> >>
> >> This is fundamentally different from what is named "branch" in hg,=
 e.g.
> >> There, a commit stores the branch name, which is why you can't del=
ete
> >> branches easily. [For me, this is also why hg branches are useless=
, but
> >> I don't want to start flames here - for me they are useless, for o=
thers
> >> they may still be perfect.]
> >=20
> > I don't see it as fundamentally different. Basically, Hg has some
> > restriction that does not let you to remove branches that outlived =
their
> > usefulness (and thus polluting name space), but the underlying stru=
cture
> > is the same...
>=20
> The underlying structure is the directed graph, with predecessorship
> being the incidence relation. But what's being discussed here is the
> various VCS concepts going by the name "branch" (the concept overlayi=
ng
> the graph structure), and those are inherently different. Not being a=
ble
> to delete a branch (without taking all its commits down) is one
> consequence of a specific concept.

I think you confuse two different things branch and its name. It is not
exactly same things in most VCSes, though you usually use branch name t=
o
refer to any branch. In Git (as in CVS and SVN), you can delete branch
name without deleting commits.

>=20
> So, that ID is exactly equivalent to hg's branch name: stored in the
> commit; just like svn's branches/paths if you follow a standard layou=
t.

No, ID is just ID. You have commit ID in Git too, and you cannot remove
it without removing commits, and if you have commit ID of the branch
head, you can follow the whole branch line even if it does not have any
name.

>=20
> > Incidentally, you can always follow Git branch
> > in similar way by using --first-parent option...
> >=20
> >>
> >> Hg is introducing "bookmarks" now, corresponding to git branches. =
I
> >> think this name describes the nature of git branches very well.
> >=20
> > Honestly, the first thing that comes to my mind when I hear bookmar=
ks
> > in relation to VCS is unannotated tags... The idea of self advancin=
g
> > bookmarks is really weird...
>=20
> ... but exactly what git's branches are, and what makes them so usefu=
l ;)

No, Git branches are branches, anyway "bookmarks" is clearly a wrong
term. If you do not like "branch", there are many other terms that can
be used instead, for example: streams, codelines.

> That's because you're thinking of browser bookmarks instead of a real
> bookmark.  A bookmark in a book would be rather pointless if I couldn=
't
> advance it as I read pages.  :-D

You can advance them or move backward, but bookmarks do not move on its
own. They always point to the place where you put them. That's why this
term remembers me more unannotated tags.


Dmitry
