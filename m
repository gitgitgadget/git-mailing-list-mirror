From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH 0/4] deny push to current branch of non-bare repo
Date: Thu, 13 Nov 2008 00:37:35 -0500
Message-ID: <20081113053735.GA5343@coredump.intra.peff.net>
References: <20081107220730.GA15942@coredump.intra.peff.net> <7v3ai3f7oa.fsf@gitster.siamese.dyndns.org> <20081108142756.GC17100@coredump.intra.peff.net> <7vwsfeaqpa.fsf@gitster.siamese.dyndns.org> <20081109014926.GA31276@coredump.intra.peff.net> <f73f7ab80811111644y14f0e0ccweed44440356a6508@mail.gmail.com> <20081112084412.GA3860@coredump.intra.peff.net> <f73f7ab80811122122i4ae3ba6dn2ceb314b86660a70@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Thu Nov 13 06:40:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L0Uw8-0004in-28
	for gcvg-git-2@gmane.org; Thu, 13 Nov 2008 06:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbYKMFhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2008 00:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750957AbYKMFhi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Nov 2008 00:37:38 -0500
Received: from peff.net ([208.65.91.99]:2961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbYKMFhi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2008 00:37:38 -0500
Received: (qmail 24859 invoked by uid 111); 13 Nov 2008 05:37:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 13 Nov 2008 00:37:36 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Nov 2008 00:37:35 -0500
Content-Disposition: inline
In-Reply-To: <f73f7ab80811122122i4ae3ba6dn2ceb314b86660a70@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100853>

On Thu, Nov 13, 2008 at 12:22:20AM -0500, Kyle Moffett wrote:

> somebody to push something for me to test, they push directly to that
> repo, and when I'm done playing with a previous run I just do:
> 
> $ git checkout new/branch/to/test
> $ make clean
> $ ./configure
> $ make
> $ make check

OK, I see how using a detached HEAD makes sense. But I think just going
straight to a detached HEAD might make even more sense. With your
proposed behavior, you need to be prepared to unexpectedly and
asynchronously move to a detached HEAD at any time, so why not just
start there in the first place?

And then the "push to current branch" problem is neatly solved: you have
no current branch.

So:

  $ git checkout new/branch/to/test^0
  $ make, configure, etc

-Peff
