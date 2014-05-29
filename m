From: Jeff King <peff@peff.net>
Subject: Re: [BUG REPORT] Git log pretty date
Date: Thu, 29 May 2014 15:49:32 -0400
Message-ID: <20140529194932.GA16665@sigill.intra.peff.net>
References: <CACJZPBtv-Cpb8_WZMz9Hsk9MrC86YGfbvREt6G=QKvMBjrqsEg@mail.gmail.com>
 <CACsJy8BREpVFKq3mW=Lwn+uNm1r40Xe8f4EyXLFN2yybZRT0oA@mail.gmail.com>
 <20140529161628.GB3763@sigill.intra.peff.net>
 <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Rodrigo Fernandes <rtfrodrigo@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 21:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wq6KY-0005tj-QS
	for gcvg-git-2@plane.gmane.org; Thu, 29 May 2014 21:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbaE2Ttf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2014 15:49:35 -0400
Received: from cloud.peff.net ([50.56.180.127]:33663 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751264AbaE2Tte (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2014 15:49:34 -0400
Received: (qmail 17731 invoked by uid 102); 29 May 2014 19:49:34 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 May 2014 14:49:34 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 29 May 2014 15:49:32 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g54begk.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250405>

On Thu, May 29, 2014 at 11:57:15AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ...
> > to at least make --format date output consistent with the rest of git
> > (and to make "%at" consistent with "%ad" and --date=raw). That still
> > doesn't address Rodrigo's concern, though (we would print "0 +0000").
> [...]
> 
> I actually am not very much interested in deciding what to show for
> a broken timestamp.  An empty string is just as good as any random
> cruft.

I was thinking specifically of the first part I quoted above. We are not
consistent between various methods of parsing/printing the date. That
may fall into the "if were doing it from scratch..." category, though;
it's possible that people currently using "--format=%ad" prefer and
expect the empty string to denote a bogus value. I'm OK with leaving it.

> I agree with you that it would be nice to have one escape
> hatch to let the users see what garbage is recorded, if only for
> diagnostic purposes, and DATE_RAW may be one good way to do so (but
> I'd rather recommend "cat-file commit" for real diagnostics).

Yeah, in case I wasn't clear, I don't actually like DATE_RAW as a way to
do that. I'd prefer "--pretty=raw" or "cat-file commit", which already
work.

> I would be more interested to see whatever broken tool that created
> such a commit gets fixed.  Do we know where it came from?

I don't think it has been said yet in the thread. Rodrigo?

-Peff
