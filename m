From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: valgrind patches, was Re: What's cooking in git.git (Jan 2009,
 #04; Mon, 19)
Date: Wed, 21 Jan 2009 01:10:22 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210105470.19014@racer>
References: <7vbpu3r745.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191407470.3586@pacific.mpi-cbg.de> <20090120044447.GF30714@sigill.intra.peff.net> <alpine.DEB.1.00.0901201447290.5159@intel-tinevez-2-302> <20090120141932.GB10688@sigill.intra.peff.net>
 <alpine.DEB.1.00.0901201545570.5159@intel-tinevez-2-302> <20090120232439.GA17746@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQgx-00051u-IK
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:11:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470AbZAUAKN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:10:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757135AbZAUAKL
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:10:11 -0500
Received: from mail.gmx.net ([213.165.64.20]:34448 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756875AbZAUAKK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:10:10 -0500
Received: (qmail invoked by alias); 21 Jan 2009 00:10:08 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp069) with SMTP; 21 Jan 2009 01:10:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19kpA4lPxlkROrRCLlhGIJpq9dzpAFT05tq1YMjDY
	/vXLYR+Yt7EBAi
X-X-Sender: gene099@racer
In-Reply-To: <20090120232439.GA17746@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106544>

Hi,

On Tue, 20 Jan 2009, Jeff King wrote:

> On Tue, Jan 20, 2009 at 03:50:28PM +0100, Johannes Schindelin wrote:
> 
> > > How will you deal with race conditions between two simultaneously 
> > > running scripts? I.e., where are you going to put it?
> > 
> > There are no race conditions, as for every git executable, a symbolic 
> > link is created, pointing to the valgrind.sh script [*1*].
> 
> Hmm. I suppose that would work, since every test run is trying to create 
> the same state.

Yep, that's what I meant with "no race".

> > Besides, what with valgrind being a memory hog, you'd be nuts to call 
> > valgrinded scripts simultaneously.
> 
> I have to disagree there. I think there are two obvious usage patterns:
> 
>   - run script $X specifically under valgrind to track down a bug
> 
>   - run the whole test suite under valgrind occasionally to find
>     latent bugs that wouldn't otherwise show up
> 
> In the latter, you want a pretty beefy box.  When I did the original
> patches, I ran through the whole test suite under valgrind. It took
> several hours on a 6GB quad-core box, using "-j4". I would hate for it
> to have taken an entire day. :)

Heh.  Okay.  I was convinced that your valgrind patch predated my -j<n> 
patch...

In any case, I already found a bug in the nth_last series, thanks to your 
work, which I'll send in a minute.

Ciao,
Dscho
