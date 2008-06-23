From: Jeff King <peff@peff.net>
Subject: Re: git-rerere observations and feature suggestions
Date: Mon, 23 Jun 2008 11:12:02 -0400
Message-ID: <20080623151201.GB20902@sigill.intra.peff.net>
References: <20080616110113.GA22945@elte.hu> <7vej6xb4lr.fsf@gitster.siamese.dyndns.org> <20080623094906.GA8284@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Chris Mason <chris.mason@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Mon Jun 23 17:13:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAnj9-0000QR-7l
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 17:13:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbYFWPMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 11:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754517AbYFWPMJ
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 11:12:09 -0400
Received: from peff.net ([208.65.91.99]:2804 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753961AbYFWPMI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2008 11:12:08 -0400
Received: (qmail 26721 invoked by uid 111); 23 Jun 2008 15:12:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 23 Jun 2008 11:12:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Jun 2008 11:12:02 -0400
Content-Disposition: inline
In-Reply-To: <20080623094906.GA8284@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85869>

On Mon, Jun 23, 2008 at 11:49:06AM +0200, Ingo Molnar wrote:

> another git-rerere observation: occasionally it happens that i 
> accidentally commit a merge marker into the source code.
> 
> That's obviously stupid, and it normally gets found by testing quickly, 
> but still it would be a really useful avoid-shoot-self-in-foot feature 
> if git-commit could warn about such stupidities of mine.
> 
> ( and if i could configure git-commit to outright reject a commit like 
>   that - i never want to commit lines with <<<<<< or >>>>> markers)

The right place for this is in a pre-commit hook, which can look at what
you are about to commit and decide if it is OK. In fact, the default
pre-commit hook that ships with git performs this exact check. You just
need to turn it on with:

  chmod +x .git/hooks/pre-commit

-Peff
