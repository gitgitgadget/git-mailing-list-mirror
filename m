From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [BUG?] Working tree getting out of date "spontaneously"
Date: Fri, 5 Jun 2009 15:23:31 +0200
Message-ID: <20090605132331.GC11035@atjola.homenet>
References: <20090605122444.GA11035@atjola.homenet> <200906051514.15876.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Fri Jun 05 15:24:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCZPe-0000zq-L2
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 15:24:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755383AbZFENXd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Jun 2009 09:23:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755349AbZFENXd
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jun 2009 09:23:33 -0400
Received: from mail.gmx.net ([213.165.64.20]:39166 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755351AbZFENXc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jun 2009 09:23:32 -0400
Received: (qmail invoked by alias); 05 Jun 2009 13:23:33 -0000
Received: from i59F5600C.versanet.de (EHLO atjola.local) [89.245.96.12]
  by mail.gmx.net (mp018) with SMTP; 05 Jun 2009 15:23:33 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX19kNBYO+JtknIzkYYJunQho3emCIuDIXdBSUKdZkM
	Ta3+oFtborTEtb
Content-Disposition: inline
In-Reply-To: <200906051514.15876.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120772>

On 2009.06.05 15:14:15 +0200, Robin Rosenberg wrote:
> fredag 05 juni 2009 14:24:44 skrev Bj=F6rn Steinbrink:
> > Hi,
> >=20
> > can't make any sense out of this at all:
> >=20
> > doener@atjola:git (master) $ git reset --hard HEAD@{1}
> > HEAD is now at b11cf09 Merge branch 'da/pretty-tempname'
> > doener@atjola:git (master) $ git update-ref refs/remotes/origin/mas=
ter HEAD
> >=20
> > doener@atjola:git (master) $ git pull
> > From git://git.kernel.org/pub/scm/git/git
> >    b11cf09..6096d75  master     -> origin/master
> > Updating b11cf09..6096d75
> > Fast forward
> >  Documentation/RelNotes-1.6.3.2.txt     |   12 +++++-------
> >  Documentation/git.txt                  |    7 ++++++-
> >  contrib/completion/git-completion.bash |   12 ++++++++++--
> >  grep.c                                 |    6 +++++-
> >  4 files changed, 26 insertions(+), 11 deletions(-)
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > doener@atjola:git (master) $ git diff-index --name-only --cached HE=
AD
> >=20
> > *wait a minute, doing nothing*
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > Documentation/RelNotes-1.6.3.2.txt
> > Documentation/git.txt
> > contrib/completion/git-completion.bash
> > grep.c
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only --cached HE=
AD
> >=20
> > doener@atjola:git (master) $ git diff-index --stat HEAD
> >  0 files changed, 0 insertions(+), 0 deletions(-)
> >=20
> > doener@atjola:git (master) $ git diff-index --name-only HEAD
> > Documentation/RelNotes-1.6.3.2.txt
> > Documentation/git.txt
> > contrib/completion/git-completion.bash
> > grep.c
> >=20
> >=20
> > Running "git status" seems to fix things.
> >=20
> > Bj=F6rn, confused
>=20
> What file system and OS?

Linux 2.6.30-rc8, ext4. ctime gets updated for no apparent reason, see
the other mail I just sent.

Thanks,
Bj=F6rn
