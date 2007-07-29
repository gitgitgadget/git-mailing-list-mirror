From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Documentation/git-diff: remove -r from --name-status
 example
Date: Sun, 29 Jul 2007 13:24:20 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707291323150.14781@racer.site>
References: <20070729002427.GA1566@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707281905050.3442@woody.linux-foundation.org>
 <20070729041159.GA5544@coredump.intra.peff.net>
 <alpine.LFD.0.999.0707282119010.3442@woody.linux-foundation.org>
 <7vbqdvolww.fsf@assigned-by-dhcp.cox.net> <7vwswjmu08.fsf@assigned-by-dhcp.cox.net>
 <20070729094955.GA14915@coredump.intra.peff.net> <Pine.LNX.4.64.0707291214060.14781@racer.site>
 <20070729113850.GA17796@coredump.intra.peff.net> <Pine.LNX.4.64.0707291258410.14781@racer.site>
 <20070729121948.GA21983@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 14:24:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7pC-0005gz-Ty
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 14:24:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761841AbXG2MYk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 08:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761948AbXG2MYk
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 08:24:40 -0400
Received: from mail.gmx.net ([213.165.64.20]:59582 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761737AbXG2MYj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 08:24:39 -0400
Received: (qmail invoked by alias); 29 Jul 2007 12:24:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 29 Jul 2007 14:24:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+c9q5+/tCcvncljTO8K+3uqjmB3J7VAaOI2+0iQj
	Bpp2+Vw7G+/s7J
X-X-Sender: gene099@racer.site
In-Reply-To: <20070729121948.GA21983@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54113>

Hi,

On Sun, 29 Jul 2007, Jeff King wrote:

> On Sun, Jul 29, 2007 at 01:04:13PM +0100, Johannes Schindelin wrote:
> 
> > The idea is this: when "--quiet" was given, we do not output anything, and 
> > therefore do not have to recurse into the directories, because we already 
> > know that there are differences when a _tree_ is different.  I do not 
> > remember all details of the "--quiet" implementation, but I think that it
> > 
> > - exits early (as you said)
> > 
> > - does not turn on "recursive" to avoid unnecessary work.
> 
> OK, looking through the code, this works _sometimes_. If I say "git-diff
> --quiet" then it will not recurse. If I say "git-diff -p --quiet" then
> it will (even though we never show the -p output).

That is expected behaviour.  If you ask for it, it should be done (however 
silly it might be).

> Since --quiet supersedes all output formats, I think it probably should 
> just clear the recursive option entirely. In which case rather than 
> special-casing quiet to avoid recursion in git-diff, we can simply turn 
> on recursion before parsing options (and it will get turned off 
> correctly by any diff options that need to do so).

No.  Just think about "git diff -p -w --quiet".  In some cases it _has_ to 
recurse.

Ciao,
Dscho
