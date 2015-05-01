From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] checkout-index.c: Unconditionally free memory
Date: Fri, 1 May 2015 18:39:14 -0400
Message-ID: <20150501223913.GA1179@peff.net>
References: <1430508507-14016-1-git-send-email-sbeller@google.com>
 <20150501195017.GA3493@peff.net>
 <CAGZ79kYNR6JNU=vVL_Pp0axFX_cpu1Bi5x226GUbeFdum9wkZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat May 02 00:39:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YoJac-0000r8-5z
	for gcvg-git-2@plane.gmane.org; Sat, 02 May 2015 00:39:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbbEAWjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 May 2015 18:39:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:53076 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbbEAWjQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 May 2015 18:39:16 -0400
Received: (qmail 22638 invoked by uid 102); 1 May 2015 22:39:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 17:39:16 -0500
Received: (qmail 20805 invoked by uid 107); 1 May 2015 22:39:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 01 May 2015 18:39:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 May 2015 18:39:14 -0400
Content-Disposition: inline
In-Reply-To: <CAGZ79kYNR6JNU=vVL_Pp0axFX_cpu1Bi5x226GUbeFdum9wkZg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268183>

On Fri, May 01, 2015 at 03:33:13PM -0700, Stefan Beller wrote:

> > Probably all of the other sites touched by be65e7d could use the same
> > treatment.
> 
> I looked around, just as Eric suggested as well and found those too.
> I don't think I'll track down the history of when this change became possible,
> but I'd rather point to (f5114a40c0d0, 2011-08-04, git-check-attr:
> Normalize paths),
> where the result of prefix_path is freed unconditionally already.

Ah, right. I noticed there were two extras in be65e7d that Eric hadn't
mentioned, but I didn't actually check to see if they were already
fixed. It looks like they are (further evidence that this is a good
thing to be doing :) ).

-Peff
