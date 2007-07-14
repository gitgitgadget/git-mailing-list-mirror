From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-reset: allow --soft in a bare repo
Date: Sat, 14 Jul 2007 01:24:05 -0400
Message-ID: <20070714052405.GA26107@coredump.intra.peff.net>
References: <20070714044916.GA24911@coredump.intra.peff.net> <7vir8nmujo.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 14 07:24:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9a7B-00075Y-4C
	for gcvg-git@gmane.org; Sat, 14 Jul 2007 07:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751725AbXGNFYK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Jul 2007 01:24:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbXGNFYJ
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jul 2007 01:24:09 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3254 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751239AbXGNFYI (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2007 01:24:08 -0400
Received: (qmail 25223 invoked from network); 14 Jul 2007 05:24:33 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 14 Jul 2007 05:24:33 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 14 Jul 2007 01:24:05 -0400
Content-Disposition: inline
In-Reply-To: <7vir8nmujo.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52440>

On Fri, Jul 13, 2007 at 10:19:23PM -0700, Junio C Hamano wrote:

> > Somebody asked about this on irc ("how do I rewind history in a bare
> > repo"). The only other ways right now are to update the ref manually
> > (which involves plumbing), or to "git-push -f" from a non-bare
> > repository. I can't think of any good reason why a soft reset shouldn't
> > be allowed.
> 
> How about "git branch -f this $that"???

Ah, I hadn't thought of that. It seems a bit of a contortion, though,
since git-branch is usually used for _making_ a branch, whereas
git-reset is usually used for _changing_ a branch. But maybe that's just
me.

At any rate, it might still be worth applying the patch. It should be
harmless to loosen the restriction, and even if there are several ways
to accomplish the same thing, why punish people who try git-reset first?
On the other hand, this is the first time I've seen it come up, so maybe
this isn't confusing people.

-Peff
