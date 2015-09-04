From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pack-protocol: document newline behavior in push commands
Date: Fri, 4 Sep 2015 05:00:44 -0400
Message-ID: <20150904090044.GB32751@sigill.intra.peff.net>
References: <20150903080205.GA20182@sigill.intra.peff.net>
 <xmqq4mjbi1w1.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 04 11:00:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXmre-0003ko-Uy
	for gcvg-git-2@plane.gmane.org; Fri, 04 Sep 2015 11:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758546AbbIDJAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Sep 2015 05:00:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:54858 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758522AbbIDJAq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Sep 2015 05:00:46 -0400
Received: (qmail 26799 invoked by uid 102); 4 Sep 2015 09:00:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 04:00:47 -0500
Received: (qmail 18118 invoked by uid 107); 4 Sep 2015 09:00:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 04 Sep 2015 05:00:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Sep 2015 05:00:44 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4mjbi1w1.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277295>

On Thu, Sep 03, 2015 at 03:17:18PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Frankly, this feels a bit like a step backwards to me. I am tempted to
> > suggest instead that git start sending the newlines, but I'm not sure
> > it's worth any potential fallout.
> 
> I actually think we should do both in the longer term.
> 
> If we say sender "SHOULD" and we know no existing receiver violates
> the "MUST NOT reject", our sender should follow that "SHOULD".

Right, it was the second "we know..." that made me worry. It is really
"we assume". :) Whether it is right according to the spec or not, the
real world is sometimes more complicated. And given that there is no
real advantage to changing the sending behavior now, I didn't think it
worth doing.

> This documentation update is good in that it makes the examples
> easier to read (by the way, the first pre-context line ends with
> '\n', which we would eventually also address) by making the reader
> understand that the convention used in this S:/C: exchange
> illustration the optional LF is not shown.

In the second patch I left them all intact, but I agree that we could
drop the "\n" entirely from the example conversations, as it is implied
(and GIT_PACKET_TRACE, for example, does not even show it).

-Peff
