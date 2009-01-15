From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: cygwin git diff crash
Date: Thu, 15 Jan 2009 16:34:18 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901151631280.3586@pacific.mpi-cbg.de>
References: <b9fd99020901141409w1e0c926fkc762f8709bd1c13f@mail.gmail.com>  <alpine.DEB.1.00.0901142333200.3586@pacific.mpi-cbg.de> <b9fd99020901150642i2e61bb78yf2dab2b8713592df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeremy Ramer <jdramer@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 16:34:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNUF9-0005Rj-Iq
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 16:34:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814AbZAOPd1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 10:33:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753451AbZAOPd0
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 10:33:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:59888 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753277AbZAOPd0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 10:33:26 -0500
Received: (qmail invoked by alias); 15 Jan 2009 15:33:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 15 Jan 2009 16:33:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18GN3g588oG885mGcRmaOe0tYNVCLPRzy0y2Pu55h
	SLFn2/kKhltFAl
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <b9fd99020901150642i2e61bb78yf2dab2b8713592df@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105835>

Hi,

On Thu, 15 Jan 2009, Jeremy Ramer wrote:

> On Wed, Jan 14, 2009 at 3:33 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Wed, 14 Jan 2009, Jeremy Ramer wrote:
> >
> >> Ok this is a weird issue and it's probably cygwin's fault, but I
> >> haven't found any way to fix it so I' thought I would throw it out
> >> here for comment.
> >>
> >> I am using git 1.6.0.4 on cygwin. I have a repo where if any file has
> >> changes and git detects as mode 100644 I get this error:
> >> $git diff
> >>       3 [main] git 2744 C:\cygwin\bin\git.exe: *** fatal error - could
> >> not load user32, Win32 error
> >>
> >> If I change the mode to 100755 git diff will work fine.
> >> $chmod a+x test.cpp
> >> $git diff
> >> diff --git a/test.cpp b/test.cpp
> >> old mode 100644
> >> new mode 100755
> >> index 7c0dfcd..20987a7
> >> --- a/test.cpp
> >> +++ b/test.cpp
> >> @@ -6,9 +6,11 @@ int main()
> >>
> >>  void func()
> >>  {
> >> +       int a;^M
> >>  }
> >>
> >>  void func2()
> >>  {
> >> +       int b;^M
> >>  }
> >>
> >> Anybody have a clue as to why this might occur?  I have seen this in
> >> many of the repo's I use, but it is not repeatable.  I tried making a
> >> test repo but could not reproduce.
> >
> > Wow, that _is_ weird.  Does your test suite pass?
> >
> > Ciao,
> > Dscho
> >
> 
> Forgive my ignorance, but I am not sure how to run the test suite.  I
> did a quick google search but didn't find anything.  I am using
> cygwin's packaged version of git and am not building it from source,
> so maybe the suite is not available.  If I get a chance I will try
> building from source.

It is really easy: just make sure that make, gcc, libiconv-dev, 
openssl-dev and libcurl-dev are installed (that's it AFAIR), then download 
a tarball, e.g.

	http://repo.or.cz/w/git.git?a=snapshot;h=next;sf=tgz

unpack it, cd to it and run "make".  (I would _not_ run configure...)

Hth,
Dscho
