From: Jeff King <peff@peff.net>
Subject: Re: Why Git is so fast (was: Re: Eric Sink's blog - notes on git,
	dscms and a "whole product" approach)
Date: Fri, 1 May 2009 15:08:54 -0400
Message-ID: <20090501190854.GA13770@coredump.intra.peff.net>
References: <46a038f90904270155i6c802fceoffc73eb5ab57130e@mail.gmail.com> <m3ocugod96.fsf@localhost.localdomain> <m3fxfqnxn5.fsf_-_@localhost.localdomain> <20090430142244.GA23550@coredump.intra.peff.net> <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 01 21:09:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lzy6x-0003bL-9o
	for gcvg-git-2@gmane.org; Fri, 01 May 2009 21:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbZEATI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2009 15:08:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754635AbZEATI6
	(ORCPT <rfc822;git-outgoing>); Fri, 1 May 2009 15:08:58 -0400
Received: from peff.net ([208.65.91.99]:45232 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753645AbZEATI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2009 15:08:57 -0400
Received: (qmail 26408 invoked by uid 107); 1 May 2009 19:09:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 01 May 2009 15:09:10 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2009 15:08:54 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0905011431460.5379@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118088>

On Fri, May 01, 2009 at 02:43:49PM -0400, Linus Torvalds wrote:

> > Like all generalizations, this is only mostly true. Fast network servers
> > with big caches can outperform disks for some loads.
> [...]
> In contrast, a workstation with local filesystems and enough memory to 
> cache it well will just be a lot nicer.
> [...]
> > I have never used perforce, but I get the impression that it is more 
> > optimized for such a situation.
> 
> I doubt it. I suspect git will outperform pretty much anything else in 
> that kind of situation too.

Thanks for the analysis; what you said makes sense to me. However, there
is at least one case of somebody complaining that git doesn't scale as
well as perforce for their load:

  http://gandolf.homelinux.org/blog/index.php?id=50

Part of his issue is with git-p4 sucking, which it probably does. But
part of it sounds like he has a gigantic workload (the description of
which sounds silly to me, but I respect the fact that he is probably
describing standard practice among some companies), and that workload is
just a little too gigantic for the workstations to handle. I.e., by
throwing resources at the central server they can avoid throwing as many
at each workstation.

But there are so few details it's hard to say whether he's doing
something else wrong or suboptimally. He does mention Windows, which
IIRC has horrific stat performance.

-Peff
