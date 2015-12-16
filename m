From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] push: add '-d' as shorthand for '--delete'
Date: Wed, 16 Dec 2015 16:52:52 -0500
Message-ID: <20151216215252.GA11615@sigill.intra.peff.net>
References: <1450106584-22313-1-git-send-email-ps@pks.im>
 <1450106584-22313-2-git-send-email-ps@pks.im>
 <20151214211856.GF14788@sigill.intra.peff.net>
 <xmqqr3imcf2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 22:53:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9K0a-0007Gi-L1
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 22:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966706AbbLPVw4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 16:52:56 -0500
Received: from cloud.peff.net ([50.56.180.127]:43225 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S966654AbbLPVwz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 16:52:55 -0500
Received: (qmail 25800 invoked by uid 102); 16 Dec 2015 21:52:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Dec 2015 15:52:55 -0600
Received: (qmail 874 invoked by uid 107); 16 Dec 2015 21:53:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Dec 2015 16:53:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Dec 2015 16:52:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr3imcf2l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282595>

On Wed, Dec 16, 2015 at 12:29:38PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > At this point, it seems that "--delete" is useful, and nothing else has
> > been proposed for "-d" in the intervening years. It seems like a
> > reasonable use of the flag to me.
> 
> I think there were two (and a half) reasons why we didn't let
> "--delete" use a short-and-sweet "-d", and I agree that "something
> else that is more useful did not come" removes one of them.
> 
> The other reason was to avoid the chance of fat-fingering, because
> deleting is destructive, and it is even harder to recover from if
> the damage is done remotely (and the remaining one-half is that
> deleting is a rare event).
> 
> Even though I do not think the need for the "safety" has been
> reduced over time to warrant this change, a similarity with "branch"
> that has "-d/--delete" would be a good enough argument to support
> this change.

Thanks for the input, I hadn't considered "safety" at all. We do have
safety measures on "git branch -d" that we don't have here. I guess we
could implement something similar (e.g., see if the to-be-deleted branch
is merged elsewhere; of course we might not have the objects locally at
all). On the other hand, you can already screw yourself pretty badly
with "push -f".

So I think it's probably OK to add "-d".

-Peff
