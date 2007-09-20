From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/5] strbuf API additions and enhancements.
Date: Thu, 20 Sep 2007 12:10:07 -0400
Message-ID: <20070920161007.GA22876@sigill.intra.peff.net>
References: <20070918223947.GB4535@artemis.corp> <20070918224119.17650344AB3@madism.org> <20070919144604.7deca4f7.froese@gmx.de> <46F21097.5030901@eudaptics.com> <87lkb1iz0i.fsf@Astalo.kon.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Kalle Olavi Niemitalo <kon@iki.fi>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:10:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYObm-0004Hm-7A
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 18:10:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756572AbXITQJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 12:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756575AbXITQJ6
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 12:09:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2481 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755004AbXITQJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 12:09:58 -0400
Received: (qmail 14234 invoked by uid 111); 20 Sep 2007 16:09:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 20 Sep 2007 12:09:56 -0400
Received: (qmail 24397 invoked by uid 1000); 20 Sep 2007 16:10:07 -0000
Content-Disposition: inline
In-Reply-To: <87lkb1iz0i.fsf@Astalo.kon.iki.fi>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58785>

On Thu, Sep 20, 2007 at 10:20:29AM +0300, Kalle Olavi Niemitalo wrote:

> Normative text in 7.15p3 confirms this: "The object ap may be
> passed as an argument to another function; if that function
> invokes the va_arg macro with parameter ap, the value of ap in
> the calling function is indeterminate and shall be passed to the
> va_end macro prior to any further reference to ap."
> 
> Therefore va_copy is needed here, at least in principle.

Not just in principle; a few months ago, I ran afoul of the same issue
using gcc + glibc6, so it is a real problem for our target platforms
(sorry, I don't have a test case anymore, but I recall getting
undefined-ish behavior from my print statements).

-Peff
