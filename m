From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git rev-list --boundary from..to
Date: Mon, 23 Apr 2007 16:53:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0704231650280.8822@racer.site>
References: <8aa486160704230634m130d1877k9e965847a2029751@mail.gmail.com> 
 <Pine.LNX.4.64.0704231624400.8822@racer.site>
 <8aa486160704230738t75c90777k3787032fa4e348fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-287112035-1177339994=:8822"
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Santi_B=E9jar?= <sbejar@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 23 16:53:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfzvK-0004CY-MQ
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 16:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751653AbXDWOxr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 10:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXDWOxr
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 10:53:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:58595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751653AbXDWOxq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 10:53:46 -0400
Received: (qmail invoked by alias); 23 Apr 2007 14:53:45 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 23 Apr 2007 16:53:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/7ls1LbMH7iimBY00kUVmbCVKBiyHhTS8mE9pzxO
	lbDnPVJZosVeMs
X-X-Sender: gene099@racer.site
In-Reply-To: <8aa486160704230738t75c90777k3787032fa4e348fb@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45327>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-287112035-1177339994=:8822
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 23 Apr 2007, Santi Béjar wrote:

> On 4/23/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Mon, 23 Apr 2007, Santi Béjar wrote:
> >
> > >  git rev-list ${order} --boundary ${commitlimit}
> > >
> > >  is what is used in gitk. In v1.5.0.3:
> > >
> > >  $ gitk from..to
> > >
> > > shows the boundary commits next to the child, but it is no longer the
> > > case since v1.5.0.3-290-g86ab490.
> > >
> > >  Now all the boundary commits are at the bottom.
> > >
> > > While at it, when used with --max-count they are at the bottom too,
> > > and I understand why, but is there a way to tell "show me the boundary
> > > commits next to the child even if it means it takes more time"?
> >
> > I'd say "--parents", and infer the relevant information.
> 
> Sorry, I think I did not expressed it quite well. The "next to the 
> child" was about the order git-rev-list outputs the commits, not about 
> the parent information (moreover gitk uses --parents).

I meant that you can use "--parents" to reorder the revs, so that the 
boundary commits come directly after their children.

> > While I agree that it was nicer to scripts earlier, IMHO it was 
> > incorrect, too.
> 
> Sorry but I do not understand what is incorrect. Are you talking about 
> the regression or about the --max-count question?

AFAICT the calculation of what makes a boundary commit was wrong before, 
and as a consequence of the fixed method, you see the boundary commits at 
the end.

To "fix" the order back to what you are used to, rev-list would have to do 
a specialized topological sort on top of what it does right now. Since not 
all users of rev-list--boundary need that, it should not be changed IMHO, 
at least by default.

Ciao,
Dscho

--8323584-287112035-1177339994=:8822--
