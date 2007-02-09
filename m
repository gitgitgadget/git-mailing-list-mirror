From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git log filtering
Date: Fri, 9 Feb 2007 16:02:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702091557420.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v64ad7l12.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org>
 <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org>
 <20070208061654.GA8813@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070208223336.GA9422@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070209015925.GD10574@coredump.intra.peff.net>
 <Pine.LNX.4.63.0702091410230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070209132239.GA727@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 16:02:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFXGf-0001I6-CO
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 16:02:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946483AbXBIPC0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 10:02:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946487AbXBIPC0
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 10:02:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:43852 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946483AbXBIPCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 10:02:25 -0500
Received: (qmail invoked by alias); 09 Feb 2007 15:02:24 -0000
X-Provags-ID: V01U2FsdGVkX18vTe4Q39gvEb77XLOtAHBZUM7S+dJz8DVT9bvSY8
	r7XQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070209132239.GA727@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39181>

Hi,

On Fri, 9 Feb 2007, Jeff King wrote:

> On Fri, Feb 09, 2007 at 02:13:18PM +0100, Johannes Schindelin wrote:
> 
> > The difference, of course, is that with the "other things", we either have 
> > no alternative (if you do not have curl, you cannot use HTTP transport), 
> > or we have workalikes (if you don't use openssl, the (possibly slower) 
> > SHA1 replacements take effect).
> 
> I'm not a pcre expert, but I thought most of the additions to posix
> extended regular expressions were expressed through constructs that
> would otherwise be invalid patterns.

So, once pcre is used, you can use these constructs. Even in scripts. 
Which just so happen to break on platforms where git is not compiled with 
pcre support.

Or do you suggest checking (in git!) if the pattern is a pcre special or 
not? That would be insane.

> > We _used_ to rely on external "diff" and "merge", but have them as 
> > inbuilt components, exactly to avoid "if you have a slightly differing 
> > setup, git behaves differently".
> 
> But you're OK with "if you didn't built against curl, http transport 
> just doesn't work."

Yes, I am. Since HTTP is itself only a second-class citizen.

> So what if there is a '--pcre' option and a corresponding config option? 
> Thus you get the same results always, unless you use --pcre and it's not 
> built, in which case git dies. That seems to be the moral equivalent of 
> the curl situation.

I might be wrong, but most of git does not depend on HTTP.

> At any rate, you didn't address my original point, which is _all_ of 
> those options have drawbacks. I think the drawbacks of re-writing or 
> re-packaging a regular expression library outweigh those of adding the 
> dependency (or even having slightly irregular behavior).

This is only because you do not really have problems with dependencies. 
You just install, or compile, the dependent thing, which happens to be no 
hassle, since you use Linux. And you can compile & install things.

Once everybody runs Linux, and is allowed to compile & install things, I 
will no longer complain about trillions of dependencies.

Ciao,
Dscho
