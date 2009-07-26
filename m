From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Performance issue of 'git branch'
Date: Sun, 26 Jul 2009 19:16:38 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907261915580.8306@pacific.mpi-cbg.de>
References: <20090723160740.GA5736@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain> <20090723165335.GA15598@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain> <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain> <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain> <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain> <20090724225415.GC6832@mit.edu>
 <20090724225917.GA11191@spearce.org> <4A6C8D3B.101@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Theodore Tso <tytso@mit.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>
X-From: git-owner@vger.kernel.org Sun Jul 26 19:16:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MV7L4-0006I1-4V
	for gcvg-git-2@gmane.org; Sun, 26 Jul 2009 19:16:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753867AbZGZRQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jul 2009 13:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbZGZRQf
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Jul 2009 13:16:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:34419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753839AbZGZRQe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jul 2009 13:16:34 -0400
Received: (qmail invoked by alias); 26 Jul 2009 17:16:33 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 26 Jul 2009 19:16:33 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19JuTBlxI5JiW34MJ+HI695v9Q4i/aKi1xRst7GIM
	pe7N2OU+rJc+KQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4A6C8D3B.101@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124131>

Hi,

On Sun, 26 Jul 2009, Avi Kivity wrote:

> On 07/25/2009 01:59 AM, Shawn O. Pearce wrote:
> > Theodore Tso<tytso@mit.edu>  wrote:
> >    
> > > On Fri, Jul 24, 2009 at 02:21:20PM -0700, Linus Torvalds wrote:
> > >      
> > > > I wonder if there is some way to only load the crazy curl stuff when we
> > > > actually want open a http: connection.
> > > >        
> > > Well, we could use dlopen(), but I'm not sure that qualifies as a
> > > _sane_ solution --- especially given that there are approximately 15
> > > interfaces used by git, that we'd have to resolve using dlsym().
> > >      
> >
> > Yea, that's not sane.
> >
> > Probably the better approach is to have git fetch and git push be a
> > different binary from main git, so we only pay the libcurl loading
> > overheads when we hit transport.
> >    
> 
> Or make the transports shared libraries, and use dlopen() to open the
> transport and dlsym() to resolve the struct transport object exported by the
> library.

... and introduce all kinds of braindamage to the Makefile so we can 
properly compile .dll files on Windows?

Umm, thanks, but no.

Ciao,
Dscho
