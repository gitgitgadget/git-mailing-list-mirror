From: Jeff King <peff@peff.net>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Fri, 8 Feb 2013 04:22:04 -0500
Message-ID: <20130208092204.GA15490@sigill.intra.peff.net>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <20130208044836.GC4157@sigill.intra.peff.net>
 <7vliaz49sf.fsf@alter.siamese.dyndns.org>
 <7vd2wb483w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 10:22:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3kAF-0000lh-Ln
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 10:22:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946191Ab3BHJWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 04:22:09 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42102 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946169Ab3BHJWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 04:22:06 -0500
Received: (qmail 27750 invoked by uid 107); 8 Feb 2013 09:23:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 08 Feb 2013 04:23:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2013 04:22:04 -0500
Content-Disposition: inline
In-Reply-To: <7vd2wb483w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215769>

On Thu, Feb 07, 2013 at 10:45:07PM -0800, Junio C Hamano wrote:

> To support a triangular arrangement well, there may need some
> thinking on what $branch@{upstream} means.  The original intent of
> the upstream mode specified for "push.default" is push the result
> back to what you based your work on, but in a triangular arrangement
> that is no longer true.

I don't think that "upstream" or "simple" push settings really make
sense in such a triangular arrangement. And IMHO, that's OK. They
reflect a much simpler view of the world than git is capable of
supporting. So "simple" works OK as a default, and people can move to
"matching" (or "current", or even a custom refspec) once they have are
ready to take advantage of a more advanced topology/workflow.

We have the problem now that new users do not necessarily understand the
matching strategy, or why it is useful, and get confused. When we move
to "simple", we may be switching to a world where the early part of the
learning curve is more gentle for those users, but they eventually run
across the steeper part when they want to adjust their workflow (i.e.,
they will eventually learn about non-symmetric repo topologies because
those are part of many useful workflows).

But I think it's a good thing to push that part of the learning curve
out, because:

  1. Some people may stay in the centralized view their whole lives and
     never care.

  2. It will make more sense to them, because they'll understand how it
     fits into what they're trying to do, rather than viewing it as an
     arcane and senseless default.

There may be some confusion as people hit that learning point. I won't
be surprised if we end up adding more advice.* messages in certain cases
to guide people to adjusting their push.default. But I'm just as happy
to wait until people start hitting the confusion point in practice, and
we can see more clearly when that advice should trigger, and what it
should say.

Unless you have ideas now, of course, in which case I'm happy to hear
them. :)

-Peff
