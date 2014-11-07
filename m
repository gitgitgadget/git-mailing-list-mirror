From: Jeff King <peff@peff.net>
Subject: Re: [RFC] git checkout $tree -- $path always rewrites files
Date: Fri, 7 Nov 2014 14:17:45 -0500
Message-ID: <20141107191745.GB5695@peff.net>
References: <20141107081324.GA19845@peff.net>
 <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 07 20:18:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmp2l-0007pm-P9
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 20:18:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753114AbaKGTRs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Nov 2014 14:17:48 -0500
Received: from cloud.peff.net ([50.56.180.127]:37687 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753025AbaKGTRr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 14:17:47 -0500
Received: (qmail 29443 invoked by uid 102); 7 Nov 2014 19:17:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 13:17:47 -0600
Received: (qmail 24847 invoked by uid 107); 7 Nov 2014 19:17:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 07 Nov 2014 14:17:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Nov 2014 14:17:45 -0500
Content-Disposition: inline
In-Reply-To: <xmqqegtfgcfx.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 07, 2014 at 09:14:42AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Is there a reason that we don't use this diff technique for checkout?
> 
> I suspect that the reasons are probably mixture of these:
> 
>  (1) the code path may descend from checkout-index and predates the
>      in-core diff machinery;
> 
>  (2) in the context of checkout-index, it was more desirable to be
>      able to say "I want the contents on the filesystem, even if you
>      think I already have it there, as you as a new software are
>      likely to be wrong and I know better"; or
> 
>  (3) it was easier to code that way ;-)
> 
> I do not see there is any reason not to do what you suggest.

OK. It's not very much code (and can mostly be lifted from git-reset),
so I may take a stab at it.

-Peff
