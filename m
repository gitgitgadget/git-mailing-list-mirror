From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] git-gc: skip stashes when expiring reflogs
Date: Wed, 11 Jun 2008 19:03:44 -0400
Message-ID: <20080611230344.GD19474@sigill.intra.peff.net>
References: <OLvkESB0JjBNs9kF8Q2M5UFNBJqq4FjbgGeQVyWstGwcXqCOq16_oomM0y-utOBbV7BnndyrICE@cipher.nrlssc.navy.mil> <5vuJsx6Kidj7e8EABk_d63dLAYuWF-S880RrJKu83cJo_ejU3VN-VA@cipher.nrlssc.navy.mil> <20080611213648.GA13362@glandium.org> <alpine.DEB.1.00.0806112242370.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Hommey <mh@glandium.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 12 01:04:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6ZMu-00083h-4F
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 01:04:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425AbYFKXDq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jun 2008 19:03:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753333AbYFKXDq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jun 2008 19:03:46 -0400
Received: from peff.net ([208.65.91.99]:4610 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbYFKXDq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jun 2008 19:03:46 -0400
Received: (qmail 14815 invoked by uid 111); 11 Jun 2008 23:03:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 11 Jun 2008 19:03:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jun 2008 19:03:44 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806112242370.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84679>

On Wed, Jun 11, 2008 at 10:44:17PM +0100, Johannes Schindelin wrote:

> FWIW I thought it was one of the clever designs of git-stash that it 
> automatically expires together with the other reflogs.  A stash is only a 
> temporary thing, that is not even meant to leave the local repository, 
> after all.

I agree. If you are concerned about valuable stashes getting deleted, my
guess is one of:

  - you would like reflog expiration to be longer

  - you are using stash as a long-term storage, which it was never
    intended for. Use a branch.

The latter, of course, is based on my use and my impression of others
use (I almost always apply a stash within 30 seconds of having stashed
it). So maybe everyone is keeping stashes around for months, and this is
a useful change.

-Peff
