From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 66/67] use strbuf_complete to conditionally append slash
Date: Wed, 16 Sep 2015 18:57:01 -0400
Message-ID: <20150916225700.GA26015@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915161619.GN29753@sigill.intra.peff.net>
 <xmqq8u86m2i4.fsf@gitster.mtv.corp.google.com>
 <20150916223901.GA24945@sigill.intra.peff.net>
 <xmqqpp1ikm9x.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 00:57:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcLdd-00022R-EO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 00:57:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752498AbbIPW5K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 18:57:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:60476 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752328AbbIPW5J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 18:57:09 -0400
Received: (qmail 1654 invoked by uid 102); 16 Sep 2015 22:57:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 17:57:09 -0500
Received: (qmail 25219 invoked by uid 107); 16 Sep 2015 22:57:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 18:57:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 18:57:01 -0400
Content-Disposition: inline
In-Reply-To: <xmqqpp1ikm9x.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278085>

On Wed, Sep 16, 2015 at 03:54:50PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> Is this conversion correct?  This seems to me that the caller wants
> >> to create an IMAP folder name immediately under the root hierarchy
> >> and wants to have the leading slash in the result.
> >
> > Ugh, you're right. This is the "other" style Eric mentioned earlier.
> >
> > This looks like the only one in the patch (there are many that did not
> > check buf.len at all, but if we assume they were not invoking undefined
> > behavior before, then they are fine under the new code).
> 
> Yes, I should have said that earlier to save one roundtrip.
> 
> Thanks for working on this.

For my re-roll, I've just omitted changing that caller. I think we can
leave it as-is; it is not worth trying to introduce a new helper for the
one site.

-Peff
