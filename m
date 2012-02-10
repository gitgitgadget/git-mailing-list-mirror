From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/8] gitweb: Highlight interesting parts of diff
Date: Fri, 10 Feb 2012 15:24:50 -0500
Message-ID: <20120210202450.GC5504@sigill.intra.peff.net>
References: <1328865494-24415-1-git-send-email-michal.kiedrowicz@gmail.com>
 <m339aivn4z.fsf@localhost.localdomain>
 <20120210151528.56145e0c@gmail.com>
 <201202101555.20163.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 21:24:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvx1d-0001It-EE
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 21:24:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388Ab2BJUYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 15:24:52 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33529
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932337Ab2BJUYw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 15:24:52 -0500
Received: (qmail 7461 invoked by uid 107); 10 Feb 2012 20:32:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Feb 2012 15:32:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Feb 2012 15:24:50 -0500
Content-Disposition: inline
In-Reply-To: <201202101555.20163.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190450>

On Fri, Feb 10, 2012 at 03:55:19PM +0100, Jakub Narebski wrote:

> > I think highlighting inline and side-by-side diff outputs is
> > something different from "git diff --word-diff". I find it useful for
> > people who are used to these diff formats (i.e. me :).
> 
> I was thinking about *using* "git diff --word-diff" for diff refinement
> highlighting of inline (unified) and side-by-side diff... 

Yeah, you might be able to get better results out of a real diff engine
(i.e., having "git diff" do the color by doing a real LCS-match) than
out of diff-highlight (which is really just a couple of simple
heuristics). OTOH, the heuristics sometimes make the result "less noisy"
because they don't find little bits of commonality, and instead
highlight only a single chunk per line.

So if somebody wanted to work on that, I'd be really curious to see if
they could get better results. It's not high enough priority for me
personally, as I find diff-highlight is "good enough".

-Peff
