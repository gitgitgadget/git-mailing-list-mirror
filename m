From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid using non-portable `echo -n` in tests.
Date: Fri, 31 Oct 2008 14:24:56 -0400
Message-ID: <20081031182456.GC3230@sigill.intra.peff.net>
References: <8A4A84EC-51F7-4038-957C-CCA5C00E5977@silverinsanity.com> <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>,
	Shawn O Pearce <spearce@spearce.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 19:26:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvyhT-0007AE-Vh
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 19:26:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752055AbYJaSZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 14:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752026AbYJaSZJ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 14:25:09 -0400
Received: from peff.net ([208.65.91.99]:4108 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752051AbYJaSZI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 14:25:08 -0400
Received: (qmail 8413 invoked by uid 111); 31 Oct 2008 18:25:06 -0000
Received: from 65-122-15-169.dia.static.qwest.net (HELO sigill.intra.peff.net) (65.122.15.169)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 31 Oct 2008 14:25:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 31 Oct 2008 14:24:56 -0400
Content-Disposition: inline
In-Reply-To: <1225429753-70109-1-git-send-email-benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99616>

On Fri, Oct 31, 2008 at 01:09:13AM -0400, Brian Gernhardt wrote:

> Not all /bin/sh have a builtin echo that recognizes -n.  Using printf
> is far more portable.
> 
> Discovered on OS X 10.5.5 in t4030-diff-textconv.sh and changed in all
> the test scripts.

Hmph. I think this is a good patch, and there is precedent in the past
(20fa04ea, 2aad957, 9754563). But I am surprised this was not caught by
our recent autobuilding project.

However, it seems to work on FreeBSD (which makes it doubly weird that
it is broken on OS X). On Solaris, the /bin/sh is so horribly broken
that I have to use bash anyway. Commit 9754563 claims breakage on AIX,
but it looks like Mike is doing the AIX builds with bash.

So I guess we just need an OS X autobuild. ;)

>  t/t4030-diff-textconv.sh           |    2 +-

And of course this one was me, but I blame JSixt, whose test I just
mindlessly copied. ;)

-Peff
