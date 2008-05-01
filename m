From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] commit: Show the committer ident when is different
	from the parent
Date: Thu, 1 May 2008 18:28:01 -0400
Message-ID: <20080501222801.GA21731@sigill.intra.peff.net>
References: <1209545236-4266-1-git-send-email-sbejar@gmail.com> <1209545236-4266-4-git-send-email-sbejar@gmail.com> <20080430145017.GA922@sigill.intra.peff.net> <20080430163701.GA6544@sigill.intra.peff.net> <8aa486160804301223w574fe425n5d0678020ff1e7b4@mail.gmail.com> <20080430192639.GC30344@sigill.intra.peff.net> <8aa486160805010134l4746f9afhec546a9d49fd7a6d@mail.gmail.com> <20080501135109.GA10135@sigill.intra.peff.net> <7vd4o5zw2s.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Santi =?utf-8?B?QsOpamFy?= <sbejar@gmail.com>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 02 00:28:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JrhGn-0000Gl-TH
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 00:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762251AbYEAW2G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 18:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762079AbYEAW2E
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 18:28:04 -0400
Received: from peff.net ([208.65.91.99]:3333 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761567AbYEAW2D (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 18:28:03 -0400
Received: (qmail 8569 invoked by uid 111); 1 May 2008 22:28:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 18:28:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 18:28:01 -0400
Content-Disposition: inline
In-Reply-To: <7vd4o5zw2s.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80943>

On Thu, May 01, 2008 at 12:02:51PM -0700, Junio C Hamano wrote:

> Once you have a good algorithm to see when to trigger the warning that the
> user might be using an unintended committer identity, I do not think you
> should refrain from issuing the warning when you see the offending
> committer ident and whose commit you are building on top of should not
> affect it.  Otherwise, the user will get the warning once (or not even get

I think I must not be writing very clearly, because that is basically
the same point I have been trying to make in this thread.  Santi's
original algorithm for warning about the wrong committer ident was to
check whether it matched the parent commit. But my point was that is a
bad algorithm, because it has way too many false positives (i.e., you
will end up showing the committer _all the time_ in many workflows).
So the followup was "check this other thing, and also look at whether it
matches the parent" to which my response was "why bother checking the
parent match then?"

I also think you could argue that we should just show the committer all
the time. But I don't think anyone has made that argument.

> I think the other patch about showing the author when you are committing
> other's changes is a good move, by the way.

I agree; it has a very straightforward and sensible algorithm for when
to show.

-Peff
