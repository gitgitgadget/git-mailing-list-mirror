From: Jeff King <peff@peff.net>
Subject: Re: move detection doesnt take filename into account
Date: Wed, 9 Jul 2014 23:53:28 -0400
Message-ID: <20140710035328.GB28401@sigill.intra.peff.net>
References: <53B105DA.30004@gmail.com>
 <287177519.16421.1404206204124.JavaMail.zimbra@dewire.com>
 <xmqqtx71xh27.fsf@gitster.dls.corp.google.com>
 <53B2CE4A.9060509@gmail.com>
 <xmqq61jhxb0g.fsf@gitster.dls.corp.google.com>
 <20140709064521.GA14682@sigill.intra.peff.net>
 <xmqqegxu7cpg.fsf@gitster.dls.corp.google.com>
 <20140709220337.GF25854@sigill.intra.peff.net>
 <xmqqa98i9nwc.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elliot Wolk <elliot.wolk@gmail.com>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 10 05:55:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X55Rq-0006H0-Mp
	for gcvg-git-2@plane.gmane.org; Thu, 10 Jul 2014 05:55:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755386AbaGJDxb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Jul 2014 23:53:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:59153 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751861AbaGJDxa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 23:53:30 -0400
Received: (qmail 28478 invoked by uid 102); 10 Jul 2014 03:53:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 09 Jul 2014 22:53:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Jul 2014 23:53:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqqa98i9nwc.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253170>

On Wed, Jul 09, 2014 at 03:18:43PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I think the hash here does not collide in that way. It really is just
> > the last sixteen characters shoved into a uint32_t.
> 
> All bytes overlap with their adjacent byte because they are shifted
> by only 2 bits, not 8 bits, when a new byte is brought in.  We can
> say that the topmost two bits of the result must have come from the
> last character, but other than these, there are more than one input
> byte for each bit position to be set/unset by, so two names that human
> would not consider "similar" would be given the same hash, no?

Yeah, you're right. I didn't look at the algorithm closely enough.

-Peff
