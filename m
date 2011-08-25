From: Jeff King <peff@peff.net>
Subject: Re: [PATCH RFC] gitk: Allow commit editing
Date: Wed, 24 Aug 2011 23:07:55 -0400
Message-ID: <20110825030755.GA3465@sigill.intra.peff.net>
References: <1313610971-1741-1-git-send-email-sojka@os.inf.tu-dresden.de>
 <20110818223346.GA8481@sigill.intra.peff.net>
 <87obzlwpx0.fsf@steelpick.2x.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, paulus@samba.org
To: Michal Sojka <sojka@os.inf.tu-dresden.de>
X-From: git-owner@vger.kernel.org Thu Aug 25 05:08:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwQIW-0006d0-2H
	for gcvg-git-2@lo.gmane.org; Thu, 25 Aug 2011 05:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306Ab1HYDH6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 23:07:58 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41784
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750827Ab1HYDH5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 23:07:57 -0400
Received: (qmail 10510 invoked by uid 107); 25 Aug 2011 03:08:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Aug 2011 23:08:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2011 23:07:55 -0400
Content-Disposition: inline
In-Reply-To: <87obzlwpx0.fsf@steelpick.2x.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180058>

On Fri, Aug 19, 2011 at 02:23:39PM +0200, Michal Sojka wrote:

> > Invoking rebase behind the scenes makes me very nervous. In particular:
> > 
> >   1. There is nothing to indicate to the user that they are rewriting a
> >      string of commits, which is going to wreak havoc if any of the
> >      commits have been published elsewhere (either pushed somewhere, or
> >      even present in another local branch). I.e., rebasing generally
> >      needs to be a conscious decision of the user.
> 
> I added a warning if the edited commit is contained in a remote branch.
> Would you consider this sufficient?

It's likely problematic if the commit appears in the history of any
other ref, unless they are also planning on rebasing that ref, too
(which you can't really know, but it is probably better to warn).

-Peff
