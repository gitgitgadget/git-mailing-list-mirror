From: Jeff King <peff@peff.net>
Subject: Re: "malloc failed"
Date: Thu, 29 Jan 2009 00:20:41 -0500
Message-ID: <20090129052041.GB31507@coredump.intra.peff.net>
References: <878wow7pth.fsf@mcbain.luannocracy.com> <20090128050225.GA18546@coredump.intra.peff.net> <c26bbb3fe074f6f6e0634a4ae8611239@206.71.190.141> <87skn3rn5n.fsf@mcbain.luannocracy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Abrahams <dave@boostpro.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 06:22:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSPLt-00066I-JM
	for gcvg-git-2@gmane.org; Thu, 29 Jan 2009 06:22:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbZA2FUp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jan 2009 00:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbZA2FUn
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jan 2009 00:20:43 -0500
Received: from peff.net ([208.65.91.99]:51192 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751176AbZA2FUn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jan 2009 00:20:43 -0500
Received: (qmail 28988 invoked by uid 107); 29 Jan 2009 05:20:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 29 Jan 2009 00:20:52 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 29 Jan 2009 00:20:41 -0500
Content-Disposition: inline
In-Reply-To: <87skn3rn5n.fsf@mcbain.luannocracy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107634>

On Wed, Jan 28, 2009 at 07:06:28PM -0500, David Abrahams wrote:

> Well, moving the 2.6G .dar backup binary out of the fileset seems to
> have helped a little, not surprisingly :-P

Ok, that _is_ big. ;) I wouldn't be surprised if there is some corner of
the code that barfs on a single object that doesn't fit in a signed
32-bit integer; I don't think we have any test coverage for stuff that
big.

But it may also just be that we are going to try malloc'ing 2.6G, and
that's making some system limit unhappy.

> I don't know whether anyone on this list should care about that failure
> given the level of abuse I'm inflicting on Git, but keep in mind that
> the system *does* have 8G of memory.  Conclude what you will from that,
> I suppose!

Well, I think you said before that you were never getting close to using
up all your memory. Which implies it's some system limit.

-Peff
