From: Jeff King <peff@peff.net>
Subject: Re: Bug report: Duplicate CRLF rewrite warnings on commit
Date: Fri, 13 May 2016 14:12:55 -0400
Message-ID: <20160513181255.GA30700@sigill.intra.peff.net>
References: <20160513134953.GE2345@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Adam Dinwoodie <adam@dinwoodie.org>
X-From: git-owner@vger.kernel.org Fri May 13 20:13:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b1HaD-000800-Ep
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 20:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752407AbcEMSM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 14:12:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:39233 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751312AbcEMSM7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 14:12:59 -0400
Received: (qmail 9453 invoked by uid 102); 13 May 2016 18:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 14:12:58 -0400
Received: (qmail 20313 invoked by uid 107); 13 May 2016 18:12:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 13 May 2016 14:12:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 May 2016 14:12:55 -0400
Content-Disposition: inline
In-Reply-To: <20160513134953.GE2345@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294552>

On Fri, May 13, 2016 at 02:49:53PM +0100, Adam Dinwoodie wrote:

> (Tangentially: what's the accepted practice for submitting failing test
> scripts?  I've written a short test case to add to t0020 that shows this
> bugged behaviour, but I've got the vague impression from past emails
> that leading with the patch email adding the failing test case is not
> the expected way to do things on this list...)

We don't want commits that fail the test suite, since it makes bisection
more difficult. But you can mark known bugs like:

   test_expect_failure 'git-foo should output bar' '
	...
   '

I think it's OK to submit a patch like that. Hopefully somebody picks
that up and combines it with their fix patch, but if not, then it at
least documents the failure for later generations.

-Peff
