From: Jeff King <peff@peff.net>
Subject: Re: Splitting up a repository
Date: Sat, 4 Dec 2010 00:33:04 -0500
Message-ID: <20101204053304.GA7311@sigill.intra.peff.net>
References: <4CF9D15D.7090001@cs.wisc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Sat Dec 04 06:33:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POkkK-0005qI-Hi
	for gcvg-git-2@lo.gmane.org; Sat, 04 Dec 2010 06:33:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751836Ab0LDFdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Dec 2010 00:33:10 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:59647 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750703Ab0LDFdJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Dec 2010 00:33:09 -0500
Received: (qmail 28560 invoked by uid 111); 4 Dec 2010 05:33:08 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Sat, 04 Dec 2010 05:33:08 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 04 Dec 2010 00:33:04 -0500
Content-Disposition: inline
In-Reply-To: <4CF9D15D.7090001@cs.wisc.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162884>

On Fri, Dec 03, 2010 at 11:27:57PM -0600, Evan Driscoll wrote:

> Say I have a repo where there are directories repo/foo, repo/bar,
> repo/baz. 'foo', 'bar', and 'baz' are loosely related -- closely enough
> that I put them together initially, but loosely enough that I now wish I
> could check out just 'repo/foo'. Since Git doesn't support partial
> checkouts (a bit annoying!), I now have to split this repository into
> separate ones. I'd of course like to keep history.
> 
> Is there a better way than making several (recursive) copies of the
> repository, deleting all but one directory in each copy, then moving the
> contents of that directory up a level? (And perhaps setting up a Git
> superproject at the original location. I do know about that.)

Rewrite the history of each directory with git-filter-branch. It even
has a "--subdirectory-filter" option that will do exactly what you want.

-Peff
