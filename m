From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Fri, 23 Nov 2007 14:31:18 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711231428350.27959@racer.site>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
 <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 23 15:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvZZI-0008Mz-VB
	for gcvg-git-2@gmane.org; Fri, 23 Nov 2007 15:31:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbXKWOb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2007 09:31:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753179AbXKWOb1
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Nov 2007 09:31:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:45316 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752824AbXKWOb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2007 09:31:26 -0500
Received: (qmail invoked by alias); 23 Nov 2007 14:31:23 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 23 Nov 2007 15:31:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+NRLI1ltmNDLwE6mtTefGza6PTZNTCEPKJAmq8mI
	UQpbW+obAu3rj0
X-X-Sender: gene099@racer.site
In-Reply-To: <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65900>

Hi,

On Fri, 23 Nov 2007, Nguyen Thai Ngoc Duy wrote:

> On Nov 21, 2007 10:40 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > [WIP: this does not handle tags yet, and it lacks a test script
> >  as well as documentation.]
> >
> > This program dumps (parts of) a git repository in the format that
> > fast-import understands.
> >
> > For clarity's sake, it does not use the 'inline' method of specifying
> > blobs in the commits, but builds the blobs before building the commits.B
> >
> > ---
> >         I am way too tired now to continue, but maybe someone else wants
> >         to pick up the ball.
> 
> Well, I would better be back on setup_git_directory() than picking up
> the ball.

Concur.

> I have a suggestion though. git-fast-export and git-fast-import should 
> support bundle.

I think this is not what fast-export and fast-import are about.  They use 
an easy to generate, and easy to edit, format.

Bundles are optimised transport mechanisms for sneaker net.  They are not 
to be meant to be easy to edit, but as small as possible.

> Bundle is very handy for transferring a bunch of commits, but it does 
> not (cannot?) hold tags and branches.

But they can!  Nothing prevents you from calling

	git bundle create a1.bundle refs/tags/v1.0.0 refs/heads/next

(At least this is the idea, haven't tested yet).

Ciao,
Dscho
