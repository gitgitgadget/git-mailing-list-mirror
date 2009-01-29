From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Valgrind updates
Date: Thu, 29 Jan 2009 15:54:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901291547510.3586@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0901210105470.19014@racer> <20090121001551.GB18169@coredump.intra.peff.net> <alpine.DEB.1.00.0901210119510.19014@racer> <20090121003739.GA18373@coredump.intra.peff.net> <alpine.DEB.1.00.0901210216440.19014@racer>
 <20090121190757.GB21686@coredump.intra.peff.net> <alpine.DEB.1.00.0901212259420.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901270327200.26199@intel-tinevez-2-302> <alpine.LFD.2.00.0901261934450.3123@localhost.localdomain> <alpine.DEB.1.00.0901270512171.14855@racer>
 <20090127131404.GA11870@sirena.org.uk> <alpine.DEB.1.00.0901271742430.3586@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901271006060.3123@localhost.localdomain> <69A01114-27BB-4239-8FD8-C35D1306CE25@alumni.caltech.edu> <alpine.DEB.1.00.0901290024290.3586@pacific.mpi-cbg.de>
 <4D595705-7935-4AC2-91F4-1DAB3C6C7D27@alumni.caltech.edu> <alpine.DEB.1.00.0901291510520.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Jean-loup Gailly <jloup@gzip.org>,
	Mark Brown <broonie@sirena.org.uk>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Adler <madler@alumni.caltech.edu>
X-From: git-owner@vger.kernel.org Thu Jan 29 15:55:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSYIa-0005kq-0W
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 15:55:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754238AbZA2Oxx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 09:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753844AbZA2Oxx
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 09:53:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:57578 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753360AbZA2Oxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 09:53:52 -0500
Received: (qmail invoked by alias); 29 Jan 2009 14:53:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp063) with SMTP; 29 Jan 2009 15:53:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1997H0lwNB9oJKvsTUKsjx9X5Stj6wy0wpCczRDZS
	GRrA7u/FoSglc2
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.1.00.0901291510520.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107690>

Hi,

On Thu, 29 Jan 2009, Johannes Schindelin wrote:

> On Wed, 28 Jan 2009, Mark Adler wrote:
> 
> > On Jan 28, 2009, at 3:27 PM, Johannes Schindelin wrote:
> > >On Wed, 28 Jan 2009, Mark Adler wrote:
> > > >2.  Can someone send me the input and the 58 bytes of output from this
> > > >  case?
> > >
> > >I did better than that already...
> > >http://article.gmane.org/gmane.comp.version-control.git/107391
> > 
> > Johannes,
> > 
> > Thanks for the input and code.  When I run it, the byte in question at 
> > offset 51 is 0x2c.  The output decompresses fine and the result matches 
> > the input. If I change the 0x2c to anything else, decompression fails.  
> > The 58 bytes are below.
> > 
> > Can you also send me the 58 bytes of output that you get when you run it?
> 
> I get exactly the same 58 bytes.  Together with the fact that the 52nd 
> byte is actually required to be 0x2c, I think that maybe valgrind is 
> having problems to track that this byte was correctly initialized.
> 
> BTW did you have any chance to test the code with valgrind on your 
> machine?  It might be related to this here platform (x86_64).

Now, things get interesting.

Of course, I made sure that I had the newest zlib installed before 
mentioning publically that I found a strange valgrind issue.

But I did not build it from source myself; I installed what Ubuntu Gutsy 
Gibbon had to offer me.

Now that I tried to investigate further by compiling zlib from source, 
instrumenting it with various valgrind-specific code to find out what is 
actually happening, I cannot reproduce anymore!

So I searched for the sources that Ubuntu provides, and I _still_ cannot 
reproduce.

So I'll just go for the easy solution, install plain straightforward 
zlib-1.2.3 (as opposed to zlib_1.2.3.3.dfsg-12ubuntu1), and apologise to 
y'all for all the bruhaha.

Ciao,
Dscho

P.S.: Note that there is still something fishy going on, as Ubuntu's zlib 
generates the deflated stream correctly.  But that will have to be 
investigated by someone with substantially more time on her hands than me.
