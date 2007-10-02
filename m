From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-svn merge helper
Date: Tue, 2 Oct 2007 23:14:00 +0200
Message-ID: <20071002211400.GA992@atjola.homenet>
References: <20070930110550.GA4557@atjola.homenet> <1EF130A4-3CC7-4A42-9166-3539D9A38828@lrde.epita.fr> <20071001025059.GA29323@atjola.homenet> <0D8A7A3C-8F51-482D-9229-29ADC9585760@lrde.epita.fr> <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Benoit SIGOURE <tsuna@lrde.epita.fr>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 23:14:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icp46-00012x-Fx
	for gcvg-git-2@gmane.org; Tue, 02 Oct 2007 23:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755281AbXJBVNl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Oct 2007 17:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755266AbXJBVNl
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Oct 2007 17:13:41 -0400
Received: from mail.gmx.net ([213.165.64.20]:39019 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755157AbXJBVNk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2007 17:13:40 -0400
Received: (qmail invoked by alias); 02 Oct 2007 21:13:38 -0000
Received: from i577B85BB.versanet.de (EHLO localhost) [87.123.133.187]
  by mail.gmx.net (mp029) with SMTP; 02 Oct 2007 23:13:38 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/3SytbyT/3+76KwqKIPU/t31o+ORKjbGxdQ6H+Vl
	4LO73jROLGMGa7
Content-Disposition: inline
In-Reply-To: <8c5c35580710010113v7d4ad14bt129b7cb12d8f4fb8@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59741>

On 2007.10.01 10:13:45 +0200, Lars Hjemli wrote:
> On 10/1/07, Benoit SIGOURE <tsuna@lrde.epita.fr> wrote:
> > On Oct 1, 2007, at 4:50 AM, Bj=F6rn Steinbrink wrote:
> > > Then how does that work? The manpage explicitly says that I shoul=
d not
> > > use git-{pull,merge} on branches I want to dcommit from. And a tr=
ivial
> > > test immediately got the expected effect of git-svn trying to
> > > commit to
> > > trunk instead of the branch.
> >
> > Ah, yes, you're right.  Well, this will work the day we can pass an
> > option to git-svn dcommit to tell it where the commit must be sent.
> >
>=20
> This is fixed in the latest version of git-svn (yet to be released).
> There is no need for an extra option, git-svn dcommit now handles
> merges between subversion branches correctly.

Thanks, but there's still a case that fails.

One common pattern in SVN is to have the feature branch following the
trunk. In git terms, that would mean that the feature branch is
continually rebased onto the HEAD of the HEAD AFAICT (although SVN of
course cannot represent that). The problem with that is, that git
doesn't create a merge commit in that case and git-svn gets confused
again.

git checkout mybranch
git merge master # Creates a merge commit
git checkout master
git merge mybranch # Does just fast forward

Is there anyway to force a merge commit or some other work around?

Thanks,
Bj=F6rn
