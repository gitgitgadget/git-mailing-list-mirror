From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 12:43:11 -0400
Message-ID: <20150616164310.GA18667@peff.net>
References: <20150612212526.GA25447@peff.net>
 <20150612212827.GC25757@peff.net>
 <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
 <xmqqvben6214.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Augie Fackler <augie@google.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 16 18:43:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4txJ-0002Fj-6O
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 18:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756412AbbFPQnQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 12:43:16 -0400
Received: from cloud.peff.net ([50.56.180.127]:46851 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754953AbbFPQnN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 12:43:13 -0400
Received: (qmail 12979 invoked by uid 102); 16 Jun 2015 16:43:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 11:43:13 -0500
Received: (qmail 16461 invoked by uid 107); 16 Jun 2015 16:43:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Jun 2015 12:43:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Jun 2015 12:43:11 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvben6214.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271778>

On Tue, Jun 16, 2015 at 09:39:19AM -0700, Junio C Hamano wrote:

> As to the documentation, I have a feeling that, unless the reader
> and/or the user intimately knows that TRACE_PACK is implemented by
> hooking into the same mechanism that TRACE_PACKET needs to, s/he
> would not even wonder if TRACE_PACKET needs to be enabled when
> asking for TRACE_PACK.  Yes, one is a proper substring of the other,
> but the similarity between the two stops there.  While I do not
> think it would hurt very much to mention that they are independent,
> I have a slight suspicion that it might make it more likely to get
> user confused.

Yes, I was just re-reading the documentation based on Augie's comment,
and it seems pretty clear to me. Of course I wrote it, so that is not
saying much. Augie, I'd be happy to hear a proposed wording change if
you have one.

I do kind of hate the name TRACE_PACK for two reasons:

  - it _is_ so close to TRACE_PACKET; maybe TRACE_PACKFILE would be
    better

  - it does not indicate that it is about on-the-wire packs. I.e., it
    has nothing to do with "git repack". But I could not think of a good
    succinct name to indicate that.

-Peff
