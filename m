From: Larry D'Anna <larry@elder-gods.org>
Subject: Re: [PATCH v3 2/3] git-push: clean up some of the output from git
 push --porcelain
Date: Wed, 10 Feb 2010 00:55:29 -0500
Message-ID: <20100210055529.GA1566@cthulhu>
References: <214a0317f2e4707a866b2f5d10509296bc1479c1.1265661033.git.larry@elder-gods.org>
 <a1b71c9f6566549e6117f5c98c2f1e60754a7334.1265661033.git.larry@elder-gods.org>
 <7vtytrih7b.fsf@alter.siamese.dyndns.org>
 <7vvde7h1mn.fsf@alter.siamese.dyndns.org>
 <20100208213256.GA470@coredump.intra.peff.net>
 <7viqa7cqs9.fsf@alter.siamese.dyndns.org>
 <20100210053937.GF28526@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 10 06:55:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nf5Y0-0005hN-LR
	for gcvg-git-2@lo.gmane.org; Wed, 10 Feb 2010 06:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775Ab0BJFzb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Feb 2010 00:55:31 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:41727 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417Ab0BJFza (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Feb 2010 00:55:30 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 4A78082200F; Wed, 10 Feb 2010 00:55:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20100210053937.GF28526@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139492>

* Jeff King (peff@peff.net) [100210 00:41]:
> I have not actually been running these patches, just reading them, but
> my impression was the goal _was_ to squelch all of the stderr cruft. But
> if we are not even close, then probably we should just give up and
> callers should "2>/dev/null".

Personally, I don't really care about squelching stderr cruft.  All I really
want is for what goes to stdout be sane and the calling script to be able to
unambiguously figure out what happened, including

* which refs go to which remotes 

* whether or not some mysterious error occurred (beyond those mentioned in the
  ref status lines)

> I had initially endorsed it, but now I am having second thoughts.
> Especially if the "usual" calling convention is to redirect stderr as
> above, then we are probably missing out on any useful error messages
> that accompany a failure return, anyway.  So maybe the sane thing to do
> is to leave the exit code alone, and include a --porcelain output line
> that either says "Everything was OK, see individual ref status" or "We
> couldn't even talk to the other side". Then the status code is
> irrelevant, and stdout contains all of the useful information (and if
> you don't get an error or OK message, you know there was some
> serious error like a broken git installation).

That serves my purposes as well as the exit code would.  Is this the consensus?

     --larry
