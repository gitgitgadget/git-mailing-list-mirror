From: Jeff King <peff@peff.net>
Subject: Re: imap-send badly handles commit bodies beginning with "From <"
Date: Tue, 1 Nov 2011 09:14:12 -0700
Message-ID: <20111101161412.GA7796@sigill.intra.peff.net>
References: <20111028180044.GA3966@foghorn.codeweavers.com>
 <20111028203256.GA15082@sigill.intra.peff.net>
 <20111030090111.GA1624@jpl.local>
 <20111101153803.GB5552@sigill.intra.peff.net>
 <4EB01918.8080604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Magnus =?utf-8?B?QsOkY2s=?= <magnus.back@sonyericsson.com>,
	git@vger.kernel.org, Andrew Eikum <aeikum@codeweavers.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Nov 01 17:14:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RLGyj-0004kN-QR
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 17:14:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753650Ab1KAQOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Nov 2011 12:14:16 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:59358
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603Ab1KAQOO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Nov 2011 12:14:14 -0400
Received: (qmail 5133 invoked by uid 107); 1 Nov 2011 16:20:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Nov 2011 12:20:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Nov 2011 09:14:12 -0700
Content-Disposition: inline
In-Reply-To: <4EB01918.8080604@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184574>

On Tue, Nov 01, 2011 at 05:06:48PM +0100, Michael Haggerty wrote:

> On 11/01/2011 04:38 PM, Jeff King wrote:
> > Right. If you properly quote and unquote "From " lines, then mbox can be
> > unambiguous.
> 
> That is not quite true.  The RFC says only that lines matching "^From "
> should be quoted, not lines matching "^>From " (or, generally, "^>*From
> ").  So the quoting is lossy; it is *not* possible to tell whether a
> line starting with ">From " should be unquoted (it could have been
> ">From " in the original).

That was what I meant by "properly". Note that the second link Magnus
mentioned (and which is referred to in the RFC in the paragraph
immediately following the discussion of "from" quoting) discusses this
explicitly.

The real issue with mbox is not that it can't be done well, but that you
have no clue which variant the writing end used. In practice, it works
OK because it's simple and those corner cases just don't come up much
(at least for a reasonably defensive reader).

-Peff
