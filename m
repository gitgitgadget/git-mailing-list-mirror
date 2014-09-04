From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/6] fsck: check tag objects' headers
Date: Wed, 3 Sep 2014 22:04:54 -0400
Message-ID: <20140904020454.GB32310@peff.net>
References: <alpine.DEB.1.00.1408171840040.990@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1408281646530.990@s15462909.onlinehome-server.info>
 <xmqqlhq88fyb.fsf@gitster.dls.corp.google.com>
 <xmqqegw08fft.fsf@gitster.dls.corp.google.com>
 <20140829234641.GG24834@peff.net>
 <xmqqwq9o2s6l.fsf@gitster.dls.corp.google.com>
 <20140903222937.GA30560@peff.net>
 <xmqq7g1kwb39.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 04 04:05:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPMQ1-00087q-EI
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 04:05:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756372AbaIDCE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2014 22:04:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:43926 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750908AbaIDCE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2014 22:04:56 -0400
Received: (qmail 15614 invoked by uid 102); 4 Sep 2014 02:04:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Sep 2014 21:04:56 -0500
Received: (qmail 26885 invoked by uid 107); 4 Sep 2014 02:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Sep 2014 22:05:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Sep 2014 22:04:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g1kwb39.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256433>

On Wed, Sep 03, 2014 at 04:14:34PM -0700, Junio C Hamano wrote:

> > The main advantage of the "tag" field is that it is machine-readable,
> > and that your verification process can check that "git verify-tag
> > v2.1.0" actually returns a tag that says "tag v2.1.0". But I do not
> > think we do that verification at all. I wonder if that is something we
> > should add support for.
> 
> Yes.  That essentially boils down to "refs/tags/$tag" must have "tag $tag"
> line (the reverse may not have to be true if the hierarchy is
> outside refs/tags/, though).

Exactly. But to just bring it back to the original series, I do not
think this is a thing that fsck should care about. It is something that
verify-tag should care about (but again, not unconditionally, and
probably not by default).

-Peff
