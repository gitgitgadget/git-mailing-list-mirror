From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] format-patch: set default stat_width to 72
Date: Fri, 4 Apr 2008 06:50:56 -0400
Message-ID: <20080404105056.GB29672@sigill.intra.peff.net>
References: <20080403102214.GA23121@coredump.intra.peff.net> <7vr6dmywqg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jan Engelhardt <jengelh@computergmbh.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 04 12:51:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhjWK-0004VN-5P
	for gcvg-git-2@gmane.org; Fri, 04 Apr 2008 12:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754228AbYDDKvA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Apr 2008 06:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754562AbYDDKvA
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Apr 2008 06:51:00 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2886 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754228AbYDDKu7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Apr 2008 06:50:59 -0400
Received: (qmail 9436 invoked by uid 111); 4 Apr 2008 10:50:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 04 Apr 2008 06:50:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Apr 2008 06:50:56 -0400
Content-Disposition: inline
In-Reply-To: <7vr6dmywqg.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78799>

On Thu, Apr 03, 2008 at 11:12:23PM -0700, Junio C Hamano wrote:

> >> format-patch already defaults to "--stat --summary -p" if you give it
> >> no format options. The default stat is 80, I believe; for format-patch
> >> it should probably be bumped to 72 anyway.
> [...]
> But it loses information, and I am not sure if it is worth it.  Why do you
> even worry about "a few layers of quoting"?  Isn't it a much worse offense
> from responder/commenter's part to quote and NOT trimming diffstat part?

I don't think a blanket rule to say "it is wrong for a responder to
quote the diffstat part" makes sense. I have several times seen people
specifically responding to the diffstat.

At any rate, I don't think the current setting is a big problem; my
thought was that we are generating an email, and that certain line
length conventions tend to apply there (though it could just as easily
be 76, or 78, or whatever convention). Losing a few characters off the
end of the diffstat doesn't really seem like information loss to me
(the +++-- part is gets chomped, and it is already being chomped for the
80-character limit; we just normalize it to a slightly smaller number of
characters).

But I don't really care that much, so please drop the patch if you are
concerned about that.

-Peff
