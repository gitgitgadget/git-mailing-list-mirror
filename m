From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Fixed crash in fetching remote tags when there is not
	tags.
Date: Wed, 10 Oct 2007 01:10:35 -0400
Message-ID: <20071010051034.GA30834@coredump.intra.peff.net>
References: <1191919868-4963-1-git-send-email-v@pp.inet.fi> <1191919868-4963-2-git-send-email-v@pp.inet.fi> <81553116-3A4F-4526-A772-9A43C53D3E22@pp.inet.fi> <20071009182043.GA2997@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?B?VuRpbvYgSuRydmVs5A==?= <v@pp.inet.fi>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:10:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfTqS-0003wj-Rw
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 07:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751714AbXJJFKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 01:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751681AbXJJFKj
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 01:10:39 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3209 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751674AbXJJFKi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 01:10:38 -0400
Received: (qmail 29528 invoked by uid 111); 10 Oct 2007 05:10:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 10 Oct 2007 01:10:36 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2007 01:10:35 -0400
Content-Disposition: inline
In-Reply-To: <20071009182043.GA2997@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60462>

On Tue, Oct 09, 2007 at 08:20:43PM +0200, Alex Riesen wrote:

> Your test does not crash on my system and your fix is obviously bogus.
> Just take a look at the only call site of the tail_link_ref: ret
> cannot be NULL. alloc_ref will crash in memset, if this were the case.

His work is almost certainly on top of next, which crashes reliably with
the test and has an additional call site for tail_link_ref. Aside from
some trailing whitespace in the patch, I think his fix is reasonable.

-Peff
