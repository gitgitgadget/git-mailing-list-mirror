From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: GSoC 2010
Date: Fri, 12 Feb 2010 10:02:27 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1002121000290.20986@pacific.mpi-cbg.de>
References: <fabb9a1e1002101223o6a00f7eavb84567c1119c8ebc@mail.gmail.com> <20100212080620.GA31719@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jeff King <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git List <git@vger.kernel.org>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Feb 12 09:56:07 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfrJj-00045E-A1
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 09:56:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294Ab0BLIz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 03:55:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:34642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750907Ab0BLIz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 03:55:57 -0500
Received: (qmail invoked by alias); 12 Feb 2010 08:55:56 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp001) with SMTP; 12 Feb 2010 09:55:56 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19QOU9LK2lQhWfUzLrnh6wDTTE+j/SBxRTfWrWX4I
	nDXP6EmLPxubo9
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20100212080620.GA31719@dcvr.yhbt.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.58999999999999997
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139664>

Hi,

On Fri, 12 Feb 2010, Eric Wong wrote:

> Sverre Rabbelier <srabbelier@gmail.com> wrote:
> > Heya,
> > 
> > Dscho created a GSoC 2010 idea's page [0] a few weeks ago, but it's a
> > bit sad at the moment (only two idea's). Part of the reason Git was
> > listed as 'example application' before was our awesome idea list, we
> > should live up to that again this year :). If you feel like mentoring
> > a summer of code student, or if you have a great idea, please add it
> > to the list so that our would-be students have some variety in
> > choosing their projects. I just added "A remote helper for svn" [1]
> > myself, since I would love to see native svn support in git. Would
> > either Daniel or Eric (or someone else of course) be interested in
> > being a co- or backup-mentor for this project?
> 
> Hi Sverre,
> 
> I can't commit to anything, but they're welcome to email me/the list for
> guidance.  I've left some notes further down in this email as well...
> 
>   It's been a long time since I've had time (or need, since most projects
>   I care about have moved to git) to hack on git-svn.
> 
>   The git-vcs-* stuff is interesting and a good reason to refactor/redo
>   parts of git-svn to work with it.  It's been overdue for a
>   refactoring/cleanup for _years_ now.
> 
> 
> I can't say SVN (nor the Perl support libraries) are pleasant to work
> with.  Things to keep in mind:
> 
> * avoid memory leaks by using explicit pools
> 
> * avoid memory errors (which are much harder to track down
>   wrapped around layers of SWIG/XS/SVN library abstractions).
>   We sometimes copy SVN native data types into normal Perl ones
>   ASAP to avoid errors/leaks
> 
> * inconsistent between different repo types:
>   - escaping may be rules are stricter/laxer for some paths
>   - error codes aren't consistent
> 
> * inability to safely maintain multiple connections to a repo
>   in one process
> 
> I'm sure I'm missing some things here that my mind just blocked
> out entirely...
> 
> All of them should be well-documented in the git-svn commit history
> and/or comments.

Would it not make sense to implement git-remote-svn as a C program? That 
should help matters especially on Windows, where git-svn is very slow due 
to its using MSys (which is a stripped-down Cygwin, as you know, jumping 
through hoops to bring some POSIX-iness to Windows).

Ciao,
Dscho
