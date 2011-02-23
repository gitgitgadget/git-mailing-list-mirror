From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] merge: improve inexact rename limit warning
Date: Wed, 23 Feb 2011 03:02:33 -0500
Message-ID: <20110223080232.GA2724@sigill.intra.peff.net>
References: <20110219101936.GB20577@sigill.intra.peff.net>
 <20110219102051.GA22508@sigill.intra.peff.net>
 <7vzkppgdz9.fsf@alter.siamese.dyndns.org>
 <20110222153909.GB27178@sigill.intra.peff.net>
 <7vsjvfdhzy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 23 09:02:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps9gI-0006Y8-El
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 09:02:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab1BWICg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Feb 2011 03:02:36 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35990 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752624Ab1BWICf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Feb 2011 03:02:35 -0500
Received: (qmail 10008 invoked by uid 111); 23 Feb 2011 08:02:34 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 23 Feb 2011 08:02:34 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Feb 2011 03:02:33 -0500
Content-Disposition: inline
In-Reply-To: <7vsjvfdhzy.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167675>

On Tue, Feb 22, 2011 at 10:46:57AM -0800, Junio C Hamano wrote:

> >> This conflicts with 2840824 (diffcore-rename: fall back to -C when -C -C
> >> busts the rename limit, 2011-01-06) on 'pu', unfortunately.
> >
> > Do you want to do the merge, or do you want me to rebase on top of
> > 2840824?
> 
> Please check the resolution queued on 'pu'; I suspect that your series
> should graduate before the fall-back-to-c-from-c-c topic, so I'd rather
> not to see you rebase this.

It looks sane to me. I was going to say we should also have
merge-recursive check for the fallback-to-c flag and tell the user what
happened, but I don't think merge-recursive ever has FIND_COPIES_HARDER
enabled.

Which I think means in 2840824 itself, the warning about fallback can
never be triggered (because merge-recursive is the only caller who
turned on warn_on_too_large_rename).

-Peff
