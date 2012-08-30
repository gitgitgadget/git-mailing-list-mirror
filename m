From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] name-rev: --weight option (WIP)
Date: Wed, 29 Aug 2012 23:55:52 -0400
Message-ID: <20120830035552.GC32268@sigill.intra.peff.net>
References: <7vharmxkzl.fsf@alter.siamese.dyndns.org>
 <1346275044-10171-1-git-send-email-gitster@pobox.com>
 <1346275044-10171-4-git-send-email-gitster@pobox.com>
 <7vligxuv6l.fsf@alter.siamese.dyndns.org>
 <20120830033611.GA32268@sigill.intra.peff.net>
 <7vharlujaq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 05:56:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T6vrR-0004v7-0b
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 05:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751481Ab2H3Dz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Aug 2012 23:55:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:47677 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750990Ab2H3Dz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2012 23:55:58 -0400
Received: (qmail 5351 invoked by uid 107); 30 Aug 2012 03:56:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 29 Aug 2012 23:56:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2012 23:55:52 -0400
Content-Disposition: inline
In-Reply-To: <7vharlujaq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204518>

On Wed, Aug 29, 2012 at 08:53:49PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I wonder if you can
> > define the weight as a recursive function of the parents.
> 
> I do not think we can.  A merge Z between X (that has N commits
> behind it) and Y (that has M commits behind it) has at most N+M+1
> commits behind it (counting itself), but we cannot tell how many
> among these N and M are shared.
> 
> > That would double-count "A" and "B" in this example. But maybe there is
> > a clever way to define it that avoids that.
> 
> We've dealt with this issue long time ago when we optimized the
> bisection count, which involves exactly the same issue.

OK. I didn't think too hard about it, so I'll trust you that it is not
easy. I wonder if using the generation number would be another way of
defining "oldest" that would be easier to calculate.

-Peff
