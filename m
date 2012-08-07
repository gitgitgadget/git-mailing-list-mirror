From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] prune.c: only print informational message in
 show_only or verbose mode
Date: Tue, 7 Aug 2012 17:59:46 -0400
Message-ID: <20120807215946.GB22974@sigill.intra.peff.net>
References: <CA+sFfMdXc+usFRnCNVoke91_X2qWZARTvPHO=B7Ukxr-j7JB2g@mail.gmail.com>
 <1344315709-15897-1-git-send-email-drafnel@gmail.com>
 <1344315709-15897-2-git-send-email-drafnel@gmail.com>
 <7vtxwfw9rp.fsf@alter.siamese.dyndns.org>
 <7vpq73w9i8.fsf@alter.siamese.dyndns.org>
 <CA+sFfMdVhTwAFLUgrO-mLBh8apG-5X1OJKCN9xgq3-N+1RBrvg@mail.gmail.com>
 <20120807060311.GB13222@sigill.intra.peff.net>
 <7vlihqv0ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 00:00:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Syroi-0006yn-HX
	for gcvg-git-2@plane.gmane.org; Tue, 07 Aug 2012 23:59:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab2HGV7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Aug 2012 17:59:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:54999 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340Ab2HGV7v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2012 17:59:51 -0400
Received: (qmail 502 invoked by uid 107); 7 Aug 2012 21:59:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 07 Aug 2012 17:59:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Aug 2012 17:59:46 -0400
Content-Disposition: inline
In-Reply-To: <7vlihqv0ks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203052>

On Tue, Aug 07, 2012 at 02:44:51PM -0700, Junio C Hamano wrote:

> Ok, so I'll queue it as a separate topic with a different
> justification.
> 
> -- >8 --
> From: Brandon Casey <drafnel@gmail.com>
> Date: Mon, 6 Aug 2012 22:01:49 -0700
> Subject: [PATCH] prune.c: only print informational message in show_only or verbose mode
> 
> "git prune" reports removal of loose object files that are no longer
> necessary only under the "-v" option, but unconditionally reports
> removal of temporary files that are no longer needed.
> 
> The original thinking was that presence of a leftover temporary file

s/presence/the &/

> should be an unusual occurrence that may indicate an earlier failure
> of some sort, and the user may want to be reminded of it.  Removing
> an unnecessary loose object file, on the other hand, is just part of
> the normal operation.  That is why the former is always printed out
> and the latter only when -v is used.
> 
> But neither report is particularly useful.  Hide both of these
> behind the "-v" option for consistency.
> 
> Signed-off-by: Brandon Casey <drafnel@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---

Looks fine to me.  I think tmpfile removal is also not that interesting
in general. A stale file can happen any time the user aborts an
operation via ^C. But I think your justification is sufficient as-is
(and this topic is not worth spending too much more time on).

-Peff
