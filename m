From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: [PATCH] git-send-email: skip RFC2047 quoting for ASCII subjects
Date: Thu, 25 Oct 2012 13:12:17 +0200
Message-ID: <20121025111217.GA3688@shrek.podlesie.net>
References: <1351065815-22416-1-git-send-email-krzysiek@podlesie.net>
 <20121024084636.GA23500@sigill.intra.peff.net>
 <20121024171036.GA18880@shrek.podlesie.net>
 <20121024192530.GA26477@sigill.intra.peff.net>
 <20121024210826.GA23562@shrek.podlesie.net>
 <20121025090149.GC8390@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 25 13:13:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRLMy-0006lr-Op
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 13:13:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933164Ab2JYLMs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 07:12:48 -0400
Received: from shrek-modem2.podlesie.net ([83.13.132.46]:45512 "EHLO
	shrek.podlesie.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758617Ab2JYLMr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 07:12:47 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id 65DDA399; Thu, 25 Oct 2012 13:12:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20121025090149.GC8390@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208391>

On Thu, Oct 25, 2012 at 05:01:49AM -0400, Jeff King wrote:
> 
> Hmm. What is this patch on top of? It looks like it is on top of your
> original patch, but when I tried it on top of that, it does not apply
> either, and the index lines in the patch do not mention a sha1 that I do
> not have.

Sorry, it's against km/send-email-compose-encoding (or current next)
+ "git-send-email: use compose-encoding for Subject".

> 
> Do you mind re-rolling a final 2-patch series with:
> 
>   1. Your original patch and this one squashed together, with an
>      appropriate commit message.

I think that it's better to do refactoring and fix for ASCII in separate
patches. Maybe we should reverse order of first two patches. This first
will do refactoring and the second will just replace quote_rfc2047()
with quote_subject() in "broken" encoding case and add test
for this problem.

> 
>   2. The second "quote when we see '=?'" patch.
> 
> Thanks.
> 
> -Peff

ok, I will resend the final series.

I need also to fix "git-send-email: use compose-encoding for Subject"
patch. Now it's depends both on this series and
km/send-email-compose-encoding branch.

Krzysiek
