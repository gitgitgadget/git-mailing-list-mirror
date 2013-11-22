From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Nov 2013, #05; Thu, 21)
Date: Fri, 22 Nov 2013 17:32:22 -0500
Message-ID: <20131122223222.GA7538@sigill.intra.peff.net>
References: <xmqqtxf51e5c.fsf@gitster.dls.corp.google.com>
 <20131122102345.GC12042@sigill.intra.peff.net>
 <xmqq61rk1b52.fsf@gitster.dls.corp.google.com>
 <CAFFjANQy72zLuxtpA+-nMhYEt=qfOu_FSszR8X7QNPTKBEi6tA@mail.gmail.com>
 <xmqqr4a8yzga.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Vicent =?utf-8?B?TWFydMOt?= <tanoku@gmail.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Nov 22 23:32:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjzH3-0006eZ-7l
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 23:32:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756124Ab3KVWcZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 17:32:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:44031 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755486Ab3KVWcY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 17:32:24 -0500
Received: (qmail 17332 invoked by uid 102); 22 Nov 2013 22:32:24 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Nov 2013 16:32:24 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Nov 2013 17:32:22 -0500
Content-Disposition: inline
In-Reply-To: <xmqqr4a8yzga.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238218>

On Fri, Nov 22, 2013 at 12:05:25PM -0800, Junio C Hamano wrote:

> > If this could make it to `next` some time next week, that would work
> > out great for us, because we may start considering using `next` as a
> > partial or full deployment on our production machines
> 
> I do not think potentially incompatible stuff that are slated for
> 2.0 that have been cooking in 'next' affects the server side, so
> that may be a good and safe move.

I do not think we will literally run `next` in this case, but probably
v1.8.5 + selected topics (like this one :) ).

We do not need to base ourselves on a release, of course, and we may
start using a rolling version of master, but choose quiescent points in
the cycle (like starting with a release, and then rolling forward around
-rc time). I started trying that with this cycle, which is how I found
the --literal-pathspec regression in mid-cycle, and then found out the
fix hadn't graduated during -rc. :)

If that proves stable, then I will consider bumping up our frequency of
following `master`, and then eventually following `next` (possibly with
some lag). As a large site, we get to expose the code to a lot of new
people; but we also need to be mindful that we are exposing a lot of
people to new bugs.

-Peff
