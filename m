From: Jeff King <peff@peff.net>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 11:30:21 -0500
Message-ID: <20100115163021.GA1947@coredump.intra.peff.net>
References: <4B4F6000.4070005@sofistes.net>
 <20100114195234.GA26684@coredump.intra.peff.net>
 <7vljg0bfox.fsf@alter.siamese.dyndns.org>
 <20100114203928.GA26883@coredump.intra.peff.net>
 <20100115153419.GA12982@vidovic>
 <20100115154816.GA1579@coredump.intra.peff.net>
 <20100115161107.GC12982@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jan 15 17:30:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVp4W-0000jC-RF
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 17:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757580Ab0AOQa3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 11:30:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757593Ab0AOQa3
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 11:30:29 -0500
Received: from peff.net ([208.65.91.99]:43942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757492Ab0AOQa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 11:30:27 -0500
Received: (qmail 27328 invoked by uid 107); 15 Jan 2010 16:35:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 11:35:16 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 11:30:21 -0500
Content-Disposition: inline
In-Reply-To: <20100115161107.GC12982@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137080>

On Fri, Jan 15, 2010 at 05:11:07PM +0100, Nicolas Sebrecht wrote:

> > I don't understand what you mean. How does "sed" do its own globbing of
> > the command line?
> 
> Well, we are in the same dilemma as the other tools. The internal
> globbing rules are explained in the related man page.

Maybe I wasn't clear: to my knowledge, "sed" does not do any globbing
itself.  How is this the same situation?

Of course other commands like sed will be fed the expansion of a shell
glob, and there may be times when you want to feed a subset of an
expansion. But that is not my complaint; my complaint was mainly that
git's solution to this is not easily discoverable by an uninformed user.
Most other commands don't even have a solution (you would have to solve
it in the shell to pass the desired expansion to the program).

> > when I look in the manual, I am more likely to look for a command-line
> > option that helps me rather than to read all of the text
> 
> True. All I can see is to improve the man page with a dedicated section
> "Globbing" instead of loosing it in a "random" place.

I don't think that would help. The problem is that the user knows they
have an issue with ignored files. The solution is custom globbing, but
they don't know that. So making globbing more prominent doesn't help,
since they will be looking for ignores. You would need to have an
"ignore" section that mentions globbing.

To be clear: I do not have an actual solution, and my initial message
was mostly just grumbling. We _do_ mention globbing and ignores in the
same paragraph, as I quoted earlier. So that is probably enough for a
diligent user to come up with the solution, or at least enough that
trying to improve on it will have diminishing returns.

You could even argue that I was not being such a diligent user in my
initial response. :)

-Peff
