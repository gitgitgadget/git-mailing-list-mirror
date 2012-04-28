From: Jeff King <peff@peff.net>
Subject: Re: ref-format checking regression
Date: Sat, 28 Apr 2012 05:24:50 -0400
Message-ID: <20120428092450.GA2850@sigill.intra.peff.net>
References: <20120427115000.GA8126@sigill.intra.peff.net>
 <xmqqr4v99pu5.fsf@junio.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Apr 28 11:25:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SO3tt-0002wT-4l
	for gcvg-git-2@plane.gmane.org; Sat, 28 Apr 2012 11:25:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897Ab2D1JZD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Apr 2012 05:25:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:49875
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750885Ab2D1JY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Apr 2012 05:24:59 -0400
Received: (qmail 4783 invoked by uid 107); 28 Apr 2012 09:25:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 28 Apr 2012 05:25:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 28 Apr 2012 05:24:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqr4v99pu5.fsf@junio.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196493>

On Fri, Apr 27, 2012 at 08:06:26AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I upgraded git on a machine recently, and it created problems for a repo
> > with a bogus character in a ref name.  Older versions of git never
> > complained about it. Newer ones, containing your dce4bab ("add_ref():
> > verify that the refname is formatted correctly") do. That's fine; it's
> > bogus and git _should_ complain about it.
> > 
> > However, recovering from the situation is unnecessarily hard, ...
> > ...
> > I seem to recall discussing this format-tightening and trying to be sure
> > that users were left with a way forward for fixing their repos. But I
> > can't find the discussion, and I don't recall any conclusion we came to.
> 
> I haven't dug the archive but I do recall pointing many issues out
> around the theme "be liberal in what you accept and strict in what you
> produce" on this topic, and loosening one or two showstoppers during the
> review cycle, but obviously we did not catch all of them.

I should point out that this was due to GitHub recently upgrading the
version of git on our backend servers. And out of the bazillion repos we
host, I have so far seen only one actual bug report. So while it might
be nice to be more friendly, it may simply not be all that common an
issue (and in this case, we were able to resolve it manually). If it's
easy to fix, I think we should, but if the fix ends up being very
complex, it might not be worth the trouble.

-Peff
