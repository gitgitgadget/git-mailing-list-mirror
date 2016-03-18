From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] pretty-print: add --pretty=noexpand
Date: Fri, 18 Mar 2016 01:55:00 -0400
Message-ID: <20160318055500.GA27875@sigill.intra.peff.net>
References: <CA+55aFxV5PWdSn9Gj=zV464TtJo=QvciZrhc5Pwe+Qfyqt8sXw@mail.gmail.com>
 <xmqqwpp243sb.fsf@gitster.mtv.corp.google.com>
 <xmqqoaae4340.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwbNXJnwEYrKE5dDRk_6eZeGT6Z11uSQS8RmCSq43PkdA@mail.gmail.com>
 <xmqqk2l23xzc.fsf@gitster.mtv.corp.google.com>
 <CA+55aFwbev52kTV1wNMTsxR3kWvhXxTkjVy-KQOEO_2jX3RrAQ@mail.gmail.com>
 <xmqq37rozoic.fsf_-_@gitster.mtv.corp.google.com>
 <xmqqoaacy9tm.fsf_-_@gitster.mtv.corp.google.com>
 <20160318050807.GC22327@sigill.intra.peff.net>
 <CA+55aFw=obdDSTS98GQi6ER3RgAxD61xDmXYVeEX=a3GKM6SOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 18 07:07:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agnZ9-0003m2-Jx
	for gcvg-git-2@plane.gmane.org; Fri, 18 Mar 2016 07:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754014AbcCRFzF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2016 01:55:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:33905 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755329AbcCRFzD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 01:55:03 -0400
Received: (qmail 17129 invoked by uid 102); 18 Mar 2016 05:55:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:55:03 -0400
Received: (qmail 9012 invoked by uid 107); 18 Mar 2016 05:55:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 18 Mar 2016 01:55:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 Mar 2016 01:55:00 -0400
Content-Disposition: inline
In-Reply-To: <CA+55aFw=obdDSTS98GQi6ER3RgAxD61xDmXYVeEX=a3GKM6SOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289200>

On Thu, Mar 17, 2016 at 10:36:16PM -0700, Linus Torvalds wrote:

> On Thu, Mar 17, 2016 at 10:08 PM, Jeff King <peff@peff.net> wrote:
> >
> > Hmm. Isn't "expand tabs" orthogonal to the rest of the pretty format?
> > That is, couldn't one want "--pretty=fuller, but with tabs expanded"?
> 
> Yeah, you are right, one easily could. And in fact I end up doing
> "fuller" myself occasionally, because I check peoples commit
> timestamps (some people have a nasty habit of rebasing when they
> shouldn't).
> 
> So it's not just the medium format that would want detab by default,
> it's "full" and "fuller" too (but probably not "raw": that indents the
> message too, but the only real reason to use "raw" is for scripting).
> 
> So it would probably be better to make it a separate flag, and not tie
> it to a particular log format (and just make the log format set the
> default).

Yeah, I agree with all of that. I didn't want to force anybody to have
to think too hard about corner cases they don't care about (again, as
long as we don't paint ourselves into a corner) but I tend to think that
it makes sense to apply it consistently to all of the stock
human-readable formats (short, medium, full, fuller), but not to "raw"
or "email", and probably not to user-formats.

-Peff
