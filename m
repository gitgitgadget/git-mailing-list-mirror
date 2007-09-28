From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Add a --dateformat= option to git-for-each-ref
Date: Fri, 28 Sep 2007 14:47:10 -0400
Message-ID: <20070928184710.GA5560@coredump.intra.peff.net>
References: <200709261009.18777.andyparkins@gmail.com> <20070926125811.GC13739@coredump.intra.peff.net> <200709281516.05438.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 28 20:47:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbKrx-0001gB-VR
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 20:47:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbXI1SrO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 14:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752477AbXI1SrN
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 14:47:13 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2385 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751397AbXI1SrN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 14:47:13 -0400
Received: (qmail 16665 invoked by uid 111); 28 Sep 2007 18:47:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 28 Sep 2007 14:47:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Sep 2007 14:47:10 -0400
Content-Disposition: inline
In-Reply-To: <200709281516.05438.andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59416>

On Fri, Sep 28, 2007 at 03:15:58PM +0100, Andy Parkins wrote:

> > like a sane way to implement these sorts of things (e.g.,
> > "%(objectsize:human)", "%(parent:1)", etc).
> 
> I'd thought about doing it like that, but imagined that there would
> objections that it was overcomplicating git-for-each-ref.  As you
> think that's acceptable, I'll do it.

Well, I'm not sure my opinion counts for much, but at least there are
now two of us. :)

> A patch series that implements both your requested changes to follow.

Patches 1/2 look fine to me (but I agree with the squash suggestion).

3/4 are not exactly what I had in mind, but I think are reasonable in
this case. Rather than treating it was ":format", I had imagined more of
a ":attribute1:attribute2" style, where some attributes may be
understood by all substitutions (e.g., the moral equivalent of shell's
":-" and ":+"), and some only by some substitutions (such as date
formats). And on top of that, these sorts of substitutions should be
unified with the --pretty=format machinery.

Of course, that is a much larger task and you probably just want to do
your date formatting and get your other work done. So I think your
implementation is reasonable, in that it accomplishes what you want in a
reasonable amount of code, and its syntax doesn't prevent moving towards
what I described above (since %(foo:bar:baz) is currently nonsensical,
we would be free to adapt its meaning later).

So in a very verbose way,

Acked-by: Jeff King <peff@peff.net>

-Peff
