From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Fri, 13 Jun 2008 09:11:09 -0400
Message-ID: <20080613131108.GA15876@sigill.intra.peff.net>
References: <20080611230344.GD19474@sigill.intra.peff.net> <alpine.LFD.1.10.0806111918300.23110@xanadu.home> <loom.20080612T042942-698@post.gmane.org> <6413041E-A64A-4BF4-9ECF-F7BFA5C1EAEF@wincent.com> <4851F6F4.8000503@op5.se> <20080613055800.GA26768@sigill.intra.peff.net> <48521EDA.5040802@op5.se> <20080613074257.GA513@sigill.intra.peff.net> <7vtzfxwtt0.fsf@gitster.siamese.dyndns.org> <19C06D62-966A-4626-A620-2281A7CAA2B6@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	Eric Raible <raible@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@cam.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Jun 13 15:13:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K794a-0008Dr-K5
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 15:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbYFMNLN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 09:11:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755866AbYFMNLN
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 09:11:13 -0400
Received: from peff.net ([208.65.91.99]:2740 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755735AbYFMNLN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 09:11:13 -0400
Received: (qmail 24291 invoked by uid 111); 13 Jun 2008 13:11:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 09:11:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 09:11:09 -0400
Content-Disposition: inline
In-Reply-To: <19C06D62-966A-4626-A620-2281A7CAA2B6@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84872>

On Fri, Jun 13, 2008 at 02:40:50PM +0200, Wincent Colaiuta wrote:

> Sounds a little bit over-engineered to me.
>
> So, "stash" is intended for short-term storage, but by adding a "keep"  
> option you're officially blessing it for long-term storage as well. And 
> the interface that you propose, explicitly marking stuff as "for keeps" 
> and being able to move stuff from "temp" to "keep" sounds quite  
> complicated.

I agree. I like the expiration of stashes, but if it is a choice between
"just don't expire them" and "here is a complex set of rules and
obligations for preventing them from expiring" I think we are better off
just leaving them.

-Peff
