From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] bulk checkin does not respect filters
Date: Fri, 24 Feb 2012 04:39:24 -0500
Message-ID: <20120224093924.GA11680@sigill.intra.peff.net>
References: <20120224030244.GA15742@sigill.intra.peff.net>
 <7vvcmw2a3m.fsf@alter.siamese.dyndns.org>
 <20120224082803.GB18688@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 10:39:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S0rcm-0003XO-37
	for gcvg-git-2@plane.gmane.org; Fri, 24 Feb 2012 10:39:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756604Ab2BXJja (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Feb 2012 04:39:30 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:55463
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756441Ab2BXJj2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2012 04:39:28 -0500
Received: (qmail 22325 invoked by uid 107); 24 Feb 2012 09:39:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 24 Feb 2012 04:39:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2012 04:39:24 -0500
Content-Disposition: inline
In-Reply-To: <20120224082803.GB18688@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191419>

On Fri, Feb 24, 2012 at 03:28:03AM -0500, Jeff King wrote:

> I don't like repeating all of the convert_to_git policy logic. Perhaps
> if you pass a NULL buffer to convert_to_git, it should run through its
> usual logic, stopping just short of actually writing anything, and
> return a flag indicating whether it _would_ convert...

So here's a series that does that.

  [1/2]: teach convert_to_git a "dry run" mode
  [2/2]: do not stream large files to pack when filters are in use

-Peff
