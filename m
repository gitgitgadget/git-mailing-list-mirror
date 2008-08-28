From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Thu, 28 Aug 2008 19:36:45 -0400
Message-ID: <20080828233645.GF29609@coredump.intra.peff.net>
References: <alpine.LFD.1.10.0808280934160.3300@nehalem.linux-foundation.org> <7BC51BEC-E230-48C5-BD3E-2CECE3C7FC98@cs.indiana.edu> <20080828195211.GA3545@mithlond.arda.local> <4B9831F7-3CB8-49CB-A1DB-111481A271FE@cs.indiana.edu> <20080828212346.GA27867@coredump.intra.peff.net> <1C144B19-DA21-4CB4-B872-C1F154B031CF@cs.indiana.edu> <20080828215907.GE27867@coredump.intra.peff.net> <3DE083DB-ADFF-45E7-B3EB-A76985941271@cs.indiana.edu> <20080828230401.GC29609@coredump.intra.peff.net> <4018E8E1-9C23-4AED-BA78-6E889A32E691@cs.indiana.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Perry Wagle <wagle@cs.indiana.edu>
X-From: git-owner@vger.kernel.org Fri Aug 29 01:38:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYr3u-0005Lb-Pv
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 01:37:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbYH1Xgs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 19:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754910AbYH1Xgs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 19:36:48 -0400
Received: from peff.net ([208.65.91.99]:2905 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119AbYH1Xgs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 19:36:48 -0400
Received: (qmail 9275 invoked by uid 111); 28 Aug 2008 23:36:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Aug 2008 19:36:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Aug 2008 19:36:45 -0400
Content-Disposition: inline
In-Reply-To: <4018E8E1-9C23-4AED-BA78-6E889A32E691@cs.indiana.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94212>

[dropping cc's because I think most people don't care about this bit]

On Thu, Aug 28, 2008 at 04:22:12PM -0700, Perry Wagle wrote:

> What I saw was "git<DASH><SPACE> produces a list of 143 commands.  Long 
> lists are inefficient.  Get rid of it!".  Actually the list is a hash 
> table in any reasonable shell.  So its only aesthetics?

I saw some talk of efficiency, but it was mainly "100,000 files in one
directory makes your filesystem performance suck". But maybe somebody
talked about the shell. I think there is "143 is too many, and scares
new users". And I think there is "systems with hardlink problems ended
up with 100+ copies of the git binary, which is big". For the latter,
you could still keep git-* with a much smaller wrapper, of course.

> Being able to quickly see the list is very useful.  That could be done  
> with git<SPACE><TAB>, except some people want that to be lobotomized to 
> show only a fraction of the total.  My mind boggles at that one.

I think there is a recognition that some of the commands aren't really
that useful to end users, but are kept around as helpers or as scripts.
For example, the interactive mode of "git add" is implemented in perl
(while the rest is implemented in C). So it is purely an implementation
issue that the script git-add--interactive exists. Nobody should be
calling it directly, but rather going through "git add -i", which will
call it as necessary with the right command line options.

> But see my other post.  I'm over it.

Good. :)

-Peff
