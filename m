From: Jeff King <peff@peff.net>
Subject: Re: git log filtering
Date: Fri, 9 Feb 2007 08:22:39 -0500
Message-ID: <20070209132239.GA727@coredump.intra.peff.net>
References: <7v64ad7l12.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071257490.8424@woody.linux-foundation.org> <7vps8l65fh.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702071334060.8424@woody.linux-foundation.org> <20070208061654.GA8813@coredump.intra.peff.net> <Pine.LNX.4.63.0702081905570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070208223336.GA9422@coredump.intra.peff.net> <Pine.LNX.4.63.0702090115180.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070209015925.GD10574@coredump.intra.peff.net> <Pine.LNX.4.63.0702091410230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 09 14:22:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFViA-0001Yz-SZ
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 14:22:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946445AbXBINWl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Feb 2007 08:22:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946447AbXBINWl
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Feb 2007 08:22:41 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3200 "HELO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1946445AbXBINWl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Feb 2007 08:22:41 -0500
Received: (qmail 25938 invoked from network); 9 Feb 2007 08:22:43 -0500
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 9 Feb 2007 08:22:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Feb 2007 08:22:39 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0702091410230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39179>

On Fri, Feb 09, 2007 at 02:13:18PM +0100, Johannes Schindelin wrote:

> The difference, of course, is that with the "other things", we either have 
> no alternative (if you do not have curl, you cannot use HTTP transport), 
> or we have workalikes (if you don't use openssl, the (possibly slower) 
> SHA1 replacements take effect).

I'm not a pcre expert, but I thought most of the additions to posix
extended regular expressions were expressed through constructs that
would otherwise be invalid patterns. For example, '(?i)' doesn't make
any sense as a pattern. Thus you would only see different behavior when
inputting nonsense. Of course, we're not currently using extended
regexps, but that could be made the default without additional
dependencies.

> We _used_ to rely on external "diff" and "merge", but have them as inbuilt 
> components, exactly to avoid "if you have a slightly differing setup, 
> git behaves differently".

But you're OK with "if you didn't built against curl, http transport
just doesn't work." So what if there is a '--pcre' option and a
corresponding config option? Thus you get the same results always,
unless you use --pcre and it's not built, in which case git dies. That
seems to be the moral equivalent of the curl situation.


At any rate, you didn't address my original point, which is _all_ of
those options have drawbacks. I think the drawbacks of re-writing or
re-packaging a regular expression library outweigh those of adding the
dependency (or even having slightly irregular behavior).

-Peff
