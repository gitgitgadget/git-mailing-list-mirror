From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fix "git log -i --grep"
Date: Mon, 25 Aug 2008 02:18:33 -0400
Message-ID: <20080825061833.GB9313@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <20080825013837.GA17201@coredump.intra.peff.net> <7vmyj1isot.fsf@gitster.siamese.dyndns.org> <20080825061504.GA9313@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 08:19:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXVQS-0000d6-G6
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 08:19:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751621AbYHYGSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 02:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751561AbYHYGSg
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 02:18:36 -0400
Received: from peff.net ([208.65.91.99]:1507 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750734AbYHYGSg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 02:18:36 -0400
Received: (qmail 17976 invoked by uid 111); 25 Aug 2008 06:18:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 25 Aug 2008 02:18:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 25 Aug 2008 02:18:33 -0400
Content-Disposition: inline
In-Reply-To: <20080825061504.GA9313@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93602>

On Mon, Aug 25, 2008 at 02:15:05AM -0400, Jeff King wrote:

> > As you suggested, making the grep option structure embedded in rev_info
> > may not be a bad idea.  We used to keep track of the sub-options
> > separately while we encounter, and updated grep_filter at the end of the
> > loop, but the conversion to use parse-options broke it.
> 
> I worked up this patch, and it is below. However, I think it may not be
> a good idea, because...

Actually, let me amend that. While writing the email, I came to the
conclusion that the "complain if -i but not --grep" is probably not a
good idea. So in that case, I think this patch (allocating grep_filter
inside the struct) _is_ a good idea.

But I don't feel too strongly either way.  If you disagree, we can go
with the first one, and I can resend it (with the cleanup I mentioned)
and I can do the trivial complaining patch on top of it.

-Peff
