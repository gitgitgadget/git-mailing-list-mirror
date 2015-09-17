From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 33/67] read_branches_file: replace strcpy with xstrdup
Date: Thu, 17 Sep 2015 12:24:48 -0400
Message-ID: <20150917162447.GA25837@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915154950.GG29753@sigill.intra.peff.net>
 <xmqqlhc6p2f9.fsf@gitster.mtv.corp.google.com>
 <20150916204226.GE3915@sigill.intra.peff.net>
 <xmqq7fnpkqdj.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 17 18:24:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcbzS-0002Q6-TE
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 18:24:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752121AbbIQQYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 12:24:51 -0400
Received: from cloud.peff.net ([50.56.180.127]:60880 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752072AbbIQQYu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 12:24:50 -0400
Received: (qmail 9187 invoked by uid 102); 17 Sep 2015 16:24:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 11:24:50 -0500
Received: (qmail 31646 invoked by uid 107); 17 Sep 2015 16:24:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 17 Sep 2015 12:24:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 17 Sep 2015 12:24:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7fnpkqdj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278130>

On Thu, Sep 17, 2015 at 08:38:32AM -0700, Junio C Hamano wrote:

> > In some of the cases, as you've seen, I dug further in cleaning things
> > up. But in others I did the minimal fix (especially in this case, the
> > limitations are only about the deprecated "branches" and "remotes"
> > file), mostly to try to keep the scope of work sane.
> 
> That is sensible.  As long as the result of conversion is easier to
> audit (which is the primary focus of this series), I'd agree that we
> should stop there, instead of making further changes.
> 
> The last thing we would want to do is to change the behaviour,
> especially to unintentionally start rejecting what we have always
> accepted, while doing a "code clean-up".  Letting these sleeping
> dogs lie is the safest.  That various distros lag behind our release
> schedule means that we may not hear about regression until a year
> after we break it for a feature used by minority of users.

Yeah, that was my thinking. Since I _did_ end up doing the cleanup and
posted it earlier, please feel free to review and express an opinion on
the original versus the cleanup.

I'm on the fence.  I do think the cleaned-up version is much nicer, but
I always worry about the risk of touching little-used code.

-Peff
