From: Jeff King <peff@peff.net>
Subject: Re: Interpreting git merge failures
Date: Tue, 12 Jul 2011 02:33:00 -0400
Message-ID: <20110712063300.GB12491@sigill.intra.peff.net>
References: <CAKmUPx5Qt2K+7F+BsW3WTmRjodBSrteuyG8p9oRHZuhApTu4+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Scott Bronson <bronson@rinspin.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 08:33:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgWWr-000357-GS
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 08:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753928Ab1GLGdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 02:33:04 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43212
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753539Ab1GLGdD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 02:33:03 -0400
Received: (qmail 9684 invoked by uid 107); 12 Jul 2011 06:33:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 02:33:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 02:33:00 -0400
Content-Disposition: inline
In-Reply-To: <CAKmUPx5Qt2K+7F+BsW3WTmRjodBSrteuyG8p9oRHZuhApTu4+g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176929>

On Thu, Jul 07, 2011 at 11:45:57AM -0700, Scott Bronson wrote:

> What is the best way to determine why a git merge failed?
> I'm writing a script that needs to do different things depending
> on what went wrong.
> 
> Right now I'm parsing error messages.  It's obviously a bad
> idea and prone to breakage but it does work.   Example:

Sorry, that's the best you can do with "git merge" currently.

The usual advice would be to check the repo status yourself with
plumbing tools, but:

  1. That's a lot of work on the part of a script writer.

  2. It's not atomic. You want to know why a merge failed, but
     circumstances might have changed since the original failure.

It would be nice if "git merge" gave different exit codes for various
situations. I don't think it would be all that big a change, and you
might be a good person to suggest which conditions need their own exit
code, as you are also writing the consuming end of the codes.

Want to write a patch?

-Peff
