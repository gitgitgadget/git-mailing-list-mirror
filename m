From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug-ish: CRLF endings and conflict markers
Date: Thu, 11 Jan 2007 11:26:12 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701111123280.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701110941.22024.andyparkins@gmail.com> <20070111095046.GA28309@spearce.org>
 <Pine.LNX.4.63.0701111057110.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070111101653.GC28309@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 11:26:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4x8T-0003WP-C1
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 11:26:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbXAKK0O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 05:26:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030237AbXAKK0O
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 05:26:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:55139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030247AbXAKK0N (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 05:26:13 -0500
Received: (qmail invoked by alias); 11 Jan 2007 10:26:12 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 11 Jan 2007 11:26:12 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Shawn O. Pearce" <spearce@spearce.org>
In-Reply-To: <20070111101653.GC28309@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36576>

Hi,

On Thu, 11 Jan 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Thu, 11 Jan 2007, Shawn O. Pearce wrote:
> > 
> > > That said I don't really care about this problem that much. The problem 
> > > that I care about is its far too easy to convert the lineendings in a 
> > > file (e.g. CRLF->LF, LF->CRLF).  This causes the entire file to differ, 
> > > making merges very difficult.  I really should just fix it (in the one 
> > > place where it matters to me) by modifying the pre-commit hook to look 
> > > for such a case and abort.
> > 
> > Why not just introduce a config variable, and do the conversion in-flight?
> 
> That's a lot of work and goes very much against the Git mindset that
> we never alter content, just store it as-is.

While that is correct, we also _use_ the content, and very much alter it 
all the time. A diff, for example, is nothing but altered content.

> All I want is to make the user realize what they have done.  "Hey dummy, 
> you just changed the entire file and the only difference I see for most 
> lines is simply the addition/removal of a CR.  You shouldn't do that!".  
> The pre-commit hook is the perfect place for that.

This sounds sensible. I mistook your task to be integrator for people you 
can't smack.

> > Or, alternatively, do the merge ignoring white space? (Of course, this 
> > is somewhat pointless when merging whitespace fixes...)
> 
> Lets not go down that road.  That's just asking for trouble. And it 
> sounds like a lot of work from what you pointed out in another message.

But to the contrary, ignoring white space in xdl_merge() is just a 
question of passing XDF_IGNORE_WHITESPACE_CHANGE as part of the xpparam's.

Ciao,
Dscho
