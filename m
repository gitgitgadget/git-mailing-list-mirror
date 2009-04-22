From: Jeff King <peff@peff.net>
Subject: Re: dangling commits and blobs: is this normal?
Date: Wed, 22 Apr 2009 16:05:02 -0400
Message-ID: <20090422200502.GA14304@coredump.intra.peff.net>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE0502@EXCHANGE.trad.tradestation.com> <20090422152719.GA12881@coredump.intra.peff.net> <W0cjdA0pSHr_AbT2c-k5hDf7LyNvwkc38qIIhTtJJRwFnGBxaBsEiw@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221331450.6741@xanadu.home> <FcecxnoVg4H8G3MKjZgl2T6zCGDer4yYyScIgaweFTNgDCKG65Xiig@cipher.nrlssc.navy.mil> <alpine.LFD.2.00.0904221548310.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	John Dlugosz <JDlugosz@TradeStation.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Apr 22 22:06:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwiiU-0005eH-B0
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 22:06:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753462AbZDVUFK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2009 16:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753393AbZDVUFJ
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 16:05:09 -0400
Received: from peff.net ([208.65.91.99]:60938 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753097AbZDVUFI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Apr 2009 16:05:08 -0400
Received: (qmail 17946 invoked by uid 107); 22 Apr 2009 20:05:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 22 Apr 2009 16:05:15 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Apr 2009 16:05:02 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904221548310.6741@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117248>

On Wed, Apr 22, 2009 at 04:00:06PM -0400, Nicolas Pitre wrote:

> And what would be the point of manually running 'git gc' then, given 
> that 'git gc --auto' is already invoked automatically after most commit 
> creating commands?
> 
> I mean, if you consider explicit 'git gc' too long, then simply wait 
> until you can spare the time, if at all.  This is not like a non gc'd 
> repository suddently becomes non functional.

The other tradeoff, mentioned by Matthieu, is not about speed, but about
rollover of files on disk. I think he would be in favor of a less
optimal pack setup if it meant rewriting the largest packfile less
frequently.

However, it may be reasonable to suggest that he just not manually "gc"
then. If he is not generating enough commits to warrant an auto-gc, then
he is probably not losing much by having loose objects. And if he is,
then auto-gc is already taking care of it.

-Peff
