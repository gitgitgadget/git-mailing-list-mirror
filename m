From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: fix archive generation for empty trees
Date: Thu, 8 Mar 2012 02:15:59 -0500
Message-ID: <20120308071559.GF7643@sigill.intra.peff.net>
References: <1331165362-78065-1-git-send-email-brodie@sf.io>
 <20120308055520.GB7643@sigill.intra.peff.net>
 <7vpqcnfvhs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brodie Rao <brodie@sf.io>,
	=?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 08 08:16:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5Xa5-0000by-GX
	for gcvg-git-2@plane.gmane.org; Thu, 08 Mar 2012 08:16:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751917Ab2CHHQF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Mar 2012 02:16:05 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44363
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750993Ab2CHHQC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Mar 2012 02:16:02 -0500
Received: (qmail 919 invoked by uid 107); 8 Mar 2012 07:16:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Mar 2012 02:16:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Mar 2012 02:15:59 -0500
Content-Disposition: inline
In-Reply-To: <7vpqcnfvhs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192531>

On Wed, Mar 07, 2012 at 10:38:07PM -0800, Junio C Hamano wrote:

> > ... However, prefix_pathspec does a lot of magic parsing;
> > it's unclear to me whether this is all in support of properly
> > adding the prefix, or if its side effects are important.
> 
> These "magic" are for things like :(root)/path that will explicitly
> refuse the prefix when run from a subdirectory.

Yeah, that was my impression. In that case, I would think we could get
rid of the get_pathspec call entirely, as it is purely about fixing-up
prefixes, and we know that we have none.

-Peff
