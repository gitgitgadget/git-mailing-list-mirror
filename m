From: Jeff King <peff@peff.net>
Subject: Re: cherry-pick is slow
Date: Tue, 15 May 2012 09:24:51 -0400
Message-ID: <20120515132451.GA25378@sigill.intra.peff.net>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
 <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
 <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
 <20120514145412.GA1159@sigill.intra.peff.net>
 <CAPZ_ugbD=mOPBs6GyapWtv6NWuJ-=r2+bqBN9n+gdTPwGj3F0Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry Risenberg <dmitry.risenberg@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 15 15:25:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SUHkT-0007Fn-Bp
	for gcvg-git-2@plane.gmane.org; Tue, 15 May 2012 15:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758863Ab2EONZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 May 2012 09:25:00 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43846
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758859Ab2EONY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2012 09:24:58 -0400
Received: (qmail 31163 invoked by uid 107); 15 May 2012 13:25:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 15 May 2012 09:25:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 May 2012 09:24:51 -0400
Content-Disposition: inline
In-Reply-To: <CAPZ_ugbD=mOPBs6GyapWtv6NWuJ-=r2+bqBN9n+gdTPwGj3F0Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197831>

[let's keep this on-list so others can benefit from the discussion]

On Tue, May 15, 2012 at 12:38:59PM +0400, Dmitry Risenberg wrote:

> > It's probably detecting renames as part of the merge, which can be
> > expensive if the thing you are cherry-picking is far away from HEAD. You
> > can try setting the merge.renamelimit config variable to something small
> > (like 1; setting it to 0 means "no limit").
> 
> I set it to 1, but it didn't help at all - cherry-pick time is still
> about the same.

OK, then my guess was probably wrong. You'll have to try profiling (if
you are on Linux, "perf record git cherry-pick ..."; perf report" is the
simplest way). Or if the repository is publicly available, I can do a
quick profile run.

-Peff
