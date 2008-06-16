From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Teach "git clone" to pack refs
Date: Mon, 16 Jun 2008 05:57:50 -0400
Message-ID: <20080616095750.GA24116@sigill.intra.peff.net>
References: <200806151602.03445.johan@herland.net> <200806151606.16380.johan@herland.net> <20080615175613.GC6127@sigill.intra.peff.net> <200806160003.06300.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Jun 16 11:58:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8BU9-0008HN-5g
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 11:58:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301AbYFPJ5z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 05:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757146AbYFPJ5y
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 05:57:54 -0400
Received: from peff.net ([208.65.91.99]:4559 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756865AbYFPJ5y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 05:57:54 -0400
Received: (qmail 31006 invoked by uid 111); 16 Jun 2008 09:57:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 16 Jun 2008 05:57:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jun 2008 05:57:50 -0400
Content-Disposition: inline
In-Reply-To: <200806160003.06300.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85170>

On Mon, Jun 16, 2008 at 12:03:06AM +0200, Johan Herland wrote:

> Yes, for many repos it does not make much sense to pack branches. But in the 
> case where the repo has many inactive branches (I have repos with 1000 
> branches where at most 5-10 are still active), I'd much rather pack all 
> branches and then later "unpack" the active ones, than write all 
> those "loose" refs as separate files onto the filesystem (e.g. in CygWin 
> *shudder*). In any case, the user normally does not work actively on 
> hundreds of branches, so the overhead of "unpacking" active branches should 
> be fairly negligible in any case.

What I was concerned about was that pack-refs would continue to pack
active branches forever, because by default it repacks branches that are
already packed.

However, it seems that git-gc just passes --all anyway, so it presumably
is not a problem. And at the very least, clone is then consistent with
the auto-gc behavior, which makes sense.

So I withdraw my complaint.

-Peff
