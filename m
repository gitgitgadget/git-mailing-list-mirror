From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] avoid shifting signed integers 31 bits
Date: Mon, 4 Jan 2016 18:32:30 -0500
Message-ID: <20160104233230.GA28274@sigill.intra.peff.net>
References: <20151229063449.GA28755@sigill.intra.peff.net>
 <20151229063545.GA30340@sigill.intra.peff.net>
 <CACsJy8CAAqZFQCfadUov7DFhSgh=dtGfE-onbXZQXO-0Y2652g@mail.gmail.com>
 <20151231052029.GA10238@sigill.intra.peff.net>
 <xmqqh9itp705.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 00:32:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGEc9-0000SH-H6
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 00:32:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753622AbcADXce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jan 2016 18:32:34 -0500
Received: from cloud.peff.net ([50.56.180.127]:48555 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753561AbcADXcd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jan 2016 18:32:33 -0500
Received: (qmail 7952 invoked by uid 102); 4 Jan 2016 23:32:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 18:32:33 -0500
Received: (qmail 6732 invoked by uid 107); 4 Jan 2016 23:32:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 04 Jan 2016 18:32:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 04 Jan 2016 18:32:30 -0500
Content-Disposition: inline
In-Reply-To: <xmqqh9itp705.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283332>

On Mon, Jan 04, 2016 at 09:52:10AM -0800, Junio C Hamano wrote:

> >> We have this in cache.h, should it be fixed as well?
> >> 
> >> /* CE_EXTENDED2 is for future extension */
> >> #define CE_EXTENDED2         (1 << 31)
> >
> > Sort of. We don't actually use it, and since it's a macro, that means it
> > never even hits the compiler proper itself. So it's not a bug, but it's
> > a bug waiting to happen. :)
> >
> 
> Let's squash an obvious change for that in to 1/2, then, before I
> merge the series to 'next'.

Thanks, I agree it is worth fixing while we're visiting the topic.

-Peff
