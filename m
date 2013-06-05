From: Jeff King <peff@peff.net>
Subject: Re: git archive --worktree-attributes doesn't exclude .gitattributes
 anymore
Date: Tue, 4 Jun 2013 23:13:49 -0400
Message-ID: <20130605031349.GA6727@sigill.intra.peff.net>
References: <1370384339.31882.YahooMailNeo@web172702.mail.ir2.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Gianfranco Costamagna <costamagnagianfranco@yahoo.it>
X-From: git-owner@vger.kernel.org Wed Jun 05 05:14:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uk4Ag-0003Fp-Md
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 05:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120Ab3FEDNy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Jun 2013 23:13:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:46621 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750791Ab3FEDNx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Jun 2013 23:13:53 -0400
Received: (qmail 26001 invoked by uid 102); 5 Jun 2013 03:14:39 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Jun 2013 22:14:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Jun 2013 23:13:49 -0400
Content-Disposition: inline
In-Reply-To: <1370384339.31882.YahooMailNeo@web172702.mail.ir2.yahoo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226426>

On Tue, Jun 04, 2013 at 11:18:59PM +0100, Gianfranco Costamagna wrote:

> git version 1.8.1.2
> [...]
> I tried to put .gitattributes or .git/info/attributes, the file is the following
> http://pastebin.com/irngA1L8
> [...]
> The archive gets created, but every file is inside, no exclusions at all.
> 
> I suspect a regression between git 1.7 and 1.8

Yes, there was a regression with matching directory names in
gitattributes in v1.8.1.1. The regression is fixed in v1.8.1.6 and
above.

If upgrading is too hard, I think you can work around it by putting
"win_build/" instead of "win_build" in your .gitattributes (after
v1.8.1.6, both should work for your case).

-Peff
