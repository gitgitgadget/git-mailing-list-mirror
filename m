From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 23:57:22 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908182355070.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de> <1250600335-8642-1-git-send-email-mstormo@gmail.com> <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302> <4A8AEAF5.6070205@gmail.com> <alpine.LNX.2.00.0908181420330.7195@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marius Storm-Olsen <marius@storm-olsen.com>,
	msysgit@googlegroups.com, git@vger.kernel.org, lznuaa@gmail.com,
	bonzini@gnu.org, kusmabite@googlemail.com
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:56:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWfY-0008AI-Hm
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbZHRV4c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZHRV4c
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:56:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:47560 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750717AbZHRV4b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:56:31 -0400
Received: (qmail invoked by alias); 18 Aug 2009 21:56:32 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 18 Aug 2009 23:56:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/Syk03rwzS5puanbI0UEnLCTQrTsKP+0Fui8eQzz
	umdvjdKRVLvZiC
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LNX.2.00.0908181420330.7195@iabervon.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126471>

Hi,

On Tue, 18 Aug 2009, Daniel Barkalow wrote:

> On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
> 
> > Johannes Schindelin said the following on 18.08.2009 16:11:
> > > On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
> > > > So, instead of rely on these vcproj files which *will* go stale, 
> > > > we can simply use the same Makefile system which everyone else is 
> > > > using. :) After all, we're just compiling with a different 
> > > > compiler. The end result will still rely on the *msysGit 
> > > > environment* to function, so we already require it. Thus, GNU Make 
> > > > is present, and we can use it.
> > > 
> > > We can also use sed or perl to generate/modify the .vcproj files, or 
> > > run CMake (once Pau got it to build), and package the stuff using 
> > > zip (once I got that to build).
> > 
> > Really? That would be some script being able to parse the Makefile, 
> > and create something reasonable as a vcproj script :) Keeping all the 
> > options in sync, conditional files/libs, all the various end 
> > executables (a separate .vcproj for each of them, and a solution file 
> > (.sln)to tie them all together into a .. "solution", a complete 
> > product blah blah blah) etc.
> 
> I think it wouldn't be impossible to split the Makefile into an 
> easy-to-parse part and an irrelevant-to-vcproj part.

What?  That is pretty fragile.

It would be _much_ better to just add another Makefile target that outputs 
the files needed for the targets.

We do not need to keep the Makefile as-is!  If the change is not 
intrusive, I am sure our friendly maintainer will not see a problem 
either.

No need for fragile parsing at all.

Ciao,
Dscho
