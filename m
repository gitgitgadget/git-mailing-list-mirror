From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 5/9] add generic terminal prompt function
Date: Thu, 15 Dec 2011 16:59:03 -0500
Message-ID: <20111215215903.GA1917@padd.com>
References: <20111210103943.GA16478@sigill.intra.peff.net>
 <20111210104101.GE16648@sigill.intra.peff.net>
 <20111215124851.GA6907@padd.com>
 <20111215133939.GA2241@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 15 22:59:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbJKo-0007dQ-K8
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 22:59:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759516Ab1LOV7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 16:59:22 -0500
Received: from honk.padd.com ([74.3.171.149]:41504 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751890Ab1LOV7W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 16:59:22 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 6ECAA278;
	Thu, 15 Dec 2011 13:59:20 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 12EDF31466; Thu, 15 Dec 2011 16:59:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111215133939.GA2241@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187245>

peff@peff.net wrote on Thu, 15 Dec 2011 08:39 -0500:
> I agree it might be a little more obvious to put it there (I think what
> happened is my initial revision did not look at "echo" ever again, and
> then that conditional was added later when I realized that the "!echo"
> case needed us to print the newline manually).
> 
> > And why no sigchain_pop() for the signal handler?
> 
> Because I used sigchain_push_common, which has no pop_common analog. But
> it's OK, because calling restore_term sets term_fd to -1, making further
> calls a no-op. So leaving the handler in place is fine.
> 
> Another option would be to add sigchain_pop_common, which pops the
> same signals from push_common.

Thanks for the detailed explanation.  It was indeed the lack of
symmetry that set me off.  I missed the term_fd check for both.

		-- Pete
