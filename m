From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log: respect log.shownotes variable
Date: Thu, 8 Apr 2010 03:05:26 -0400
Message-ID: <20100408070526.GH30473@coredump.intra.peff.net>
References: <20100407204536.GA32382@coredump.intra.peff.net>
 <7vljczapzt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 08 09:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzloI-000667-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 08 Apr 2010 09:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758420Ab0DHHFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Apr 2010 03:05:47 -0400
Received: from peff.net ([208.65.91.99]:46599 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758395Ab0DHHFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Apr 2010 03:05:46 -0400
Received: (qmail 17064 invoked by uid 107); 8 Apr 2010 07:05:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 08 Apr 2010 03:05:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Apr 2010 03:05:26 -0400
Content-Disposition: inline
In-Reply-To: <7vljczapzt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144336>

On Wed, Apr 07, 2010 at 02:53:42PM -0700, Junio C Hamano wrote:

> My gut feeling is that people who do have notes in the default namespace
> (or the ones in notes.displayRef) do want to see them _all the time_.
> Otherwise they'd put such notes in namespaces that are not shown by
> default, and view them on demand, no?

I dunno. I don't have any notes I've written, so I just stuck Thomas' in
refs/notes/commit. In retrospect, that was probably dumb, because it
conflicts with any notes I would write.

> But then there is a bigger question: what kind of notes would you want to
> always see as part of "git log" output?  My answer to that question for my
> personal workflow (both dayjob and here) so far has been "none", and that
> is exactly the reason why my "applied from this message" notes live in
> notes/am namespace and I have nothing in the default notes namespace.

Yeah, thinking on it more, that is much better. I now have:

  [remote "trast"]
	  url = git://repo.or.cz/git/trast.git
	  fetch = +refs/heads/notes/*:refs/notes/am/*

which makes more sense (and I was happy to see he has kept updating
them. My copy was quite stale).

So let's ignore log.shownotes for now, and encourage people to manage
their notes better. When we see more how people are using notes, we may
want it, but let's wait until then.

-Peff
