From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] Add --verbose|-v to test-chmtime
Date: Thu, 30 Oct 2008 18:58:51 -0400
Message-ID: <20081030225850.GA3688@sigill.intra.peff.net>
References: <81b0412b0810300426u2ccbe51at1bf5f989b6333ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 31 00:00:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KvgVS-0007R2-5g
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 00:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbYJ3W64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 18:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754000AbYJ3W6z
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 18:58:55 -0400
Received: from peff.net ([208.65.91.99]:1783 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753388AbYJ3W6y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 18:58:54 -0400
Received: (qmail 12190 invoked by uid 111); 30 Oct 2008 22:58:53 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (12.233.202.2)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 30 Oct 2008 18:58:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Oct 2008 18:58:51 -0400
Content-Disposition: inline
In-Reply-To: <81b0412b0810300426u2ccbe51at1bf5f989b6333ed1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99531>

On Thu, Oct 30, 2008 at 12:26:24PM +0100, Alex Riesen wrote:

> This allows us replace perl when getting the mtime of a file because
> of time zone conversions, though at the moment only one platform which
> does this has been identified: Cygwin when used with ActiveState Perl
> (as usual).
> [...]
>     test-chmtime -v +0 filename1 | cut -f 1

Personally, I would have:

  - split the argument refactoring and the addition of the "-v" argument
    into two patches to make reviewers lives easier

  - just used a special timespec that means "don't change anything, but
    show show"

but I think those are mostly nitpicks, so I am OK with the series as-is.

-Peff
