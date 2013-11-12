From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/86] replace prefixcmp() with has_prefix()
Date: Tue, 12 Nov 2013 15:14:05 -0500
Message-ID: <20131112201405.GA23418@sigill.intra.peff.net>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
 <5281012D.4060708@op5.se>
 <20131112083240.GA1684@sigill.intra.peff.net>
 <xmqqy54timsm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andreas Ericsson <ae@op5.se>,
	Christian Couder <chriscool@tuxfamily.org>,
	git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 12 21:14:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgKLm-00009E-8k
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 21:14:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756602Ab3KLUOK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 15:14:10 -0500
Received: from cloud.peff.net ([50.56.180.127]:37966 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753484Ab3KLUOH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 15:14:07 -0500
Received: (qmail 17480 invoked by uid 102); 12 Nov 2013 20:14:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Nov 2013 14:14:07 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Nov 2013 15:14:05 -0500
Content-Disposition: inline
In-Reply-To: <xmqqy54timsm.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237731>

On Tue, Nov 12, 2013 at 08:53:45AM -0800, Junio C Hamano wrote:

> Even though we already added has_suffix() for tail matches, it is
> not too late to rethink, as it is not in 'master' yet.
> 
> One thing I noticed is that it is probably misnamed, or at least in
> a way that invites confusion.  Can people tell which one of these is
> correct without looking at existing callsites?
> 
> 	has_suffix(filename, "txt");
> 	has_suffix(filename, ".txt");

To me, it is obviously the latter. My name for "thing at the end of a
file after the dot" is "extension", not "suffix".

I thought that was universal, but if there are people who find it
confusing, it is worth changing. After all, the point is to make the
code more readable.

> The semantics of the function we have is the latter and is better
> called endswith(), I suspect.  And the corresponding function to
> check for head matches should probably be called beginswith().

Those are OK to me. "has_suffix" would be my first choice, but if it is
confusing to others, your suggestions are fine.

-Peff
