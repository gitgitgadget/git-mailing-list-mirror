From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Teach 'git grep' about
 --open-files-in-pager=[<pager>]
Date: Fri, 26 Mar 2010 17:18:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003261714550.7596@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de> <36ca99e91003260439x3d60b851g15b8652d50f61c06@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-31776320-1269620125=:7596"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Mar 26 17:18:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvCEf-0000Ms-Kc
	for gcvg-git-2@lo.gmane.org; Fri, 26 Mar 2010 17:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752645Ab0CZQSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Mar 2010 12:18:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:55782 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751807Ab0CZQSH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Mar 2010 12:18:07 -0400
Received: (qmail invoked by alias); 26 Mar 2010 16:18:05 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 26 Mar 2010 17:18:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX187N/BHABU7HzZHJMBfw8JMB0Oax9vvxDk4p+dkYo
	MahanBaYSietw3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <36ca99e91003260439x3d60b851g15b8652d50f61c06@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.1003261715290.7596@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55000000000000004
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143257>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-31776320-1269620125=:7596
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.1003261715291.7596@pacific.mpi-cbg.de>

Hi,

On Fri, 26 Mar 2010, Bert Wesarg wrote:

> On Fri, Mar 26, 2010 at 11:48, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > This supports opening the results of a 'git grep' directly in a pager
> > (where the pager can be 'vi', too).
> >
> > This series is purely about convenience, everything the option does can
> > be done with a regular script or command line.
> >
> > But I saw so many people doing their own scripts for that, and in many
> > cases, they are subtly broken (e.g.
> >
> >        git grep -z <expr> | xargs -0r vi +/<expr>
> >
> > would work as long as you do not have to check the exit status of git
> > grep from another script) that I finally decided to go for it and send
> > this patch pair.
> >
> > My most common use case for this is to do something like
> >
> >        git grep -Ovi SomeJustRenamedFile
> >
> > to edit all files I might have forgotten to change after a git mv.
> >
> > (Actually, to be honest, my use case involves -Pvi, but I will have to
> > retrain my hands.)
> >
> > Johannes Schindelin (2):
> >  grep: Add the option '--open-files-in-pager'
> >  grep -P: allow optional argument specifying the pager (or editor)
> 
> Your re-training failed miserable ;-)

It would have if I said that it is finished.

> I like the idea. But could it make sense to get the line number of the 
> first match to the filename. In the same syntax as on the console (i.e. 
> <file>:<line>:)?

See Peff's mail, and my answer to it for an explanation why it would 
actively _not_ help me that way.

> I have also the feeling that -O potion does not like pager with
> arguments, be it from GIT_PAGER, PAGER, or from the command line.

You are correct. That's why I said "-O[<pager>]" and not 
"-O[<pager-with-arguments-that-cause-whitespace-problems-especially-with-spaces-in-directory-names-so-you-need-to-make-a-script-wrapper-anyway>]" 

Of course, if you would find that useful, nobody stops you from making a 
patch on top of my patch pair.

Ciao,
Dscho

--8323328-31776320-1269620125=:7596--
