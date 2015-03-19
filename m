From: Jeff King <peff@peff.net>
Subject: Re: Bug in fetch-pack.c, please confirm
Date: Thu, 19 Mar 2015 16:31:26 -0400
Message-ID: <20150319203126.GA31663@peff.net>
References: <0758b2029b41448a77a4e4df1c4e406@74d39fa044aa309eaea14b9f57fe79c>
 <20150316011343.GA928@peff.net>
 <xmqqfv90khpd.fsf@gitster.dls.corp.google.com>
 <20150319185517.GB8788@peff.net>
 <xmqqtwxgizg9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Kyle J. McKay" <mackyle@gmail.com>,
	Git mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 19 21:31:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYh6Y-0001W9-P6
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 21:31:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbbCSUbd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 16:31:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:35407 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751267AbbCSUb3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 16:31:29 -0400
Received: (qmail 3316 invoked by uid 102); 19 Mar 2015 20:31:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 15:31:29 -0500
Received: (qmail 17096 invoked by uid 107); 19 Mar 2015 20:31:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 16:31:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 16:31:26 -0400
Content-Disposition: inline
In-Reply-To: <xmqqtwxgizg9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265824>

On Thu, Mar 19, 2015 at 12:01:26PM -0700, Junio C Hamano wrote:

> > I'm working up a few patches in that area, which I'll send out in a few
> > minutes. Once that is done, then I think the explanation you give above
> > would be correct.
> 
> If a follow-up is coming then I'd just drop this one.  Thanks.

OK, here it is. Took me a bit longer than I expected, as I wanted to
figure out whether the second patch was actually fixing a bug (and if
so, to add test coverage). Turns out that it is a real bug.

The final patch is what you sent, rebased on top (though there are not
any code changes; the underlying commits make the _explanation_ true,
but no code change was required). I fixed up the nits I mentioned in my
earlier email.

  [1/4]: filter_ref: avoid overwriting ref->old_sha1 with garbage
  [2/4]: filter_ref: make a copy of extra "sought" entries
  [3/4]: fetch_refs_via_pack: free extra copy of refs
  [4/4]: fetch-pack: remove dead assignment to ref->new_sha1

-Peff
