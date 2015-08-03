From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 5/6] clone: fix hostname parsing when guessing dir
Date: Mon, 3 Aug 2015 12:37:28 -0400
Message-ID: <20150803163727.GA2602@sigill.intra.peff.net>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
 <1438185076-28870-1-git-send-email-ps@pks.im>
 <1438185076-28870-6-git-send-email-ps@pks.im>
 <xmqq7fpiamiq.fsf@gitster.dls.corp.google.com>
 <20150730121811.GA24635@pks-pc.localdomain>
 <xmqqk2th7gmq.fsf@gitster.dls.corp.google.com>
 <xmqqfv457fkc.fsf@gitster.dls.corp.google.com>
 <20150803083414.GA23997@pks-xps.Speedport_W_723V_1_37_000>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	pclouds@gmail.com
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Aug 03 18:37:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMIk5-00025Z-4J
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 18:37:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719AbbHCQhc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 12:37:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:40184 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753255AbbHCQhc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 12:37:32 -0400
Received: (qmail 29964 invoked by uid 102); 3 Aug 2015 16:37:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Aug 2015 11:37:31 -0500
Received: (qmail 14009 invoked by uid 107); 3 Aug 2015 16:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Aug 2015 12:37:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Aug 2015 12:37:28 -0400
Content-Disposition: inline
In-Reply-To: <20150803083414.GA23997@pks-xps.Speedport_W_723V_1_37_000>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275172>

On Mon, Aug 03, 2015 at 10:34:14AM +0200, Patrick Steinhardt wrote:

> One more question for backwards compatibility remains then.
> Currently when we clone something like 'http://example.com:2222/'
> we'd create a git repository '2222' as we'd split on the first
> occurrence of ':'. Should we remain backwards compatible here, as
> well, or change the behavior to use 'example.com' as repository
> name?

I don't think naming the repo "2222" makes much sense; I'd consider it a
bug. The only sensible names are "example.com" or "example.com:2222"
(the latter is more specific if you are going to clone the root off of
several different ports, but that seems rather unlikely; the former is
probably what I'd expect).

-Peff
