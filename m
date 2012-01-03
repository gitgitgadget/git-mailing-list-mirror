From: Jeff King <peff@peff.net>
Subject: Re: Stashing individual files
Date: Tue, 3 Jan 2012 15:13:23 -0500
Message-ID: <20120103201323.GA4340@sigill.intra.peff.net>
References: <CAJ6vYjduoBNrRcvcvQbX_yY-3-Qm5ZbXOM0WQpWRwC1H1OCqaA@mail.gmail.com>
 <20120103190612.GC20926@sigill.intra.peff.net>
 <7vfwfwtup7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Chris Leong <walkraft@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 03 21:13:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiAji-00050A-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 21:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890Ab2ACUN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 15:13:26 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55561
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754873Ab2ACUNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 15:13:25 -0500
Received: (qmail 9817 invoked by uid 107); 3 Jan 2012 20:20:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Jan 2012 15:20:15 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Jan 2012 15:13:23 -0500
Content-Disposition: inline
In-Reply-To: <7vfwfwtup7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187891>

On Tue, Jan 03, 2012 at 12:08:52PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think that would be OK compromise, though. I'd rather not introduce a
> > whole new "stashfiles" command (or even a new subcommand of stash) if we
> > can avoid it.
> 
> Why wouldn't a simple "git diff -- paths >P.diff" work?

For all the same reasons that "git diff >P.diff" is not as good as a
regular stash.

> What does such a partial stash leave in the working tree, how does the
> user deal with the remaining local changes, what happens after such a
> partial stash is applied/popped?

I would expect it to stash only the changes in the selected files,
restoring them to their state in HEAD, and leave other files untouched.

We already have partial stashing like this via "git stash -p".  This is
just a shorthand for "say yes to all of the changes in foo.c, and no to
everything else". So I don't see it as particularly new or dangerous.

-Peff
