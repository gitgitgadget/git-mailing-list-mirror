From: Jeff King <peff@peff.net>
Subject: Re: diff settings
Date: Sat, 24 Jan 2009 14:22:23 -0500
Message-ID: <20090124192222.GA18010@coredump.intra.peff.net>
References: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Keith Cascio <keith@CS.UCLA.EDU>
X-From: git-owner@vger.kernel.org Sat Jan 24 20:24:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LQo6k-0007N3-7A
	for gcvg-git-2@gmane.org; Sat, 24 Jan 2009 20:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769AbZAXTWZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Jan 2009 14:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbZAXTWZ
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jan 2009 14:22:25 -0500
Received: from peff.net ([208.65.91.99]:34252 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753363AbZAXTWZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jan 2009 14:22:25 -0500
Received: (qmail 19150 invoked by uid 107); 24 Jan 2009 19:22:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 24 Jan 2009 14:22:31 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 24 Jan 2009 14:22:23 -0500
Content-Disposition: inline
In-Reply-To: <alpine.GSO.2.00.0901240936080.23073@kiwi.cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106993>

On Sat, Jan 24, 2009 at 09:38:18AM -0800, Keith Cascio wrote:

> How do I configure my local git so that diff always obeys a particular
> option, e.g. "-w", without needing to type it on the command line each
> time?

AFAIK, there is not a way to do it in the general case (though there are
specific config options for things like rename support). When I
refactored the gitattributes diff=$foo code a few months back, I tried
to keep in mind the possibility of a "diff options" field. But I never
actually implemented anything, as I don't personally ever use diff
options in such a way.

If you're interested, it would probably not be too hard to implement
(see userdiff.[ch], and the external and textconv code in diff.c for a
start).

-Peff
