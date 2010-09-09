From: Jeff King <peff@peff.net>
Subject: Re: git log over restricts output when using --follow?
Date: Thu, 9 Sep 2010 15:51:59 -0400
Message-ID: <20100909195159.GC1146@sigill.intra.peff.net>
References: <4C86D5AE.6030302@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Gregg Leichtman <gslaccts@verizon.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:52:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtnAJ-0008VI-LY
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab0IITvs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:51:48 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47449 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753133Ab0IITvr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:51:47 -0400
Received: (qmail 21330 invoked by uid 111); 9 Sep 2010 19:51:46 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:51:46 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:51:59 -0400
Content-Disposition: inline
In-Reply-To: <4C86D5AE.6030302@verizon.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155898>

On Tue, Sep 07, 2010 at 08:15:42PM -0400, Gregg Leichtman wrote:

> (3)
> 
> |gsl@aragorn:~/gitTest> gitnp log -2 --follow --pretty=oneline junk.txt
> 500e8791578c5baf7a139d4997841769a995ac6b mod of junk and junk3
> |
> 
> (4)
> 
> |gsl@aragorn:~/gitTest> gitnp log -2 --pretty=oneline junk.txt
> 500e8791578c5baf7a139d4997841769a995ac6b mod of junk and junk3
> 594ceed7a0fb35a860a6e2cb913d5398f09a861f 1st mod junk.txt
> |
> 
> Why don't I see 2 output lines for item (3) above?

Without looking closer into the problem, I would guess that it is
because of the hack-ish way that --follow is implemented. That is,
most history pruning and simplification happens outside of the actual
--follow traversal. So yes, it looks like a defect, but fixing it may
involve rewriting --follow entirely.

But don't let that discourage you from looking further. :)

-Peff
