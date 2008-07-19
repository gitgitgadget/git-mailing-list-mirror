From: Jeff King <peff@peff.net>
Subject: Re: copy selected history between repostories
Date: Fri, 18 Jul 2008 21:21:07 -0400
Message-ID: <20080719012107.GA14068@sigill.intra.peff.net>
References: <18533605.post@talk.nabble.com> <20080719010122.GA12047@mail.local.tull.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: luisgutz <luis@xmos.com>, git@vger.kernel.org
To: Nick Andrew <nick@nick-andrew.net>
X-From: git-owner@vger.kernel.org Sat Jul 19 03:22:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KK19F-0005co-SG
	for gcvg-git-2@gmane.org; Sat, 19 Jul 2008 03:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYGSBVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 21:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753554AbYGSBVL
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 21:21:11 -0400
Received: from peff.net ([208.65.91.99]:3090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143AbYGSBVK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 21:21:10 -0400
Received: (qmail 28018 invoked by uid 111); 19 Jul 2008 01:21:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 18 Jul 2008 21:21:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Jul 2008 21:21:07 -0400
Content-Disposition: inline
In-Reply-To: <20080719010122.GA12047@mail.local.tull.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89095>

On Sat, Jul 19, 2008 at 11:01:22AM +1000, Nick Andrew wrote:

> I couldn't figure out git-filter-branch, so I did the following,
> which worked for me:
> 
> First, export commits as patches in mbox format:
> 
> 	git log -p --first-parent --reverse --pretty=email $* > mbox
> [...]
> 
> Finally, import into new repo:
> 
> 	git-am mbox2

Note that this will lose any interesting history topology you had, like
branching and merging (and it may have trouble applying all patches in
that case, too). But if your history was a straight line, it should
produce equivalent results.

-Peff
