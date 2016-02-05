From: Jeff King <peff@peff.net>
Subject: Re: Clarification on the git+ssh and ssh+git schemes
Date: Fri, 5 Feb 2016 14:30:27 -0500
Message-ID: <20160205193027.GC7245@sigill.intra.peff.net>
References: <62DF0D5B-83DF-465D-9786-A4E7DA97F2BA@dwim.me>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@dwim.me>
X-From: git-owner@vger.kernel.org Fri Feb 05 20:30:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRm5S-0007GA-Dp
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 20:30:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbcBETaa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 14:30:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:38317 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753082AbcBETa3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 14:30:29 -0500
Received: (qmail 29310 invoked by uid 102); 5 Feb 2016 19:30:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 14:30:29 -0500
Received: (qmail 17496 invoked by uid 107); 5 Feb 2016 19:30:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 05 Feb 2016 14:30:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2016 14:30:27 -0500
Content-Disposition: inline
In-Reply-To: <62DF0D5B-83DF-465D-9786-A4E7DA97F2BA@dwim.me>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285598>

On Fri, Feb 05, 2016 at 09:33:06AM -0800, Carlos Mart=C3=ADn Nieto wrot=
e:

> git supports using git+ssh:// and ssh+git:// instead of ssh:// or the
> rsync-style format. The first two are however not documented in the
> git-clone manage as acceptable protocols (which is what I think of as
> the canonical source for what you can use). There are tests to make
> sure these are supported, but even the commit that allows for this
> (c05186cc; Support git+ssh:// and ssh+git:// URL) makes it pretty
> clear it=E2=80=99s not something that=E2=80=99s considered sensible.

Hrm. I tried to find more discussion on the list, but I couldn't find
any mention of git+ssh, nor of that patch. I wonder if there is a hole
in my archive, or if they were done off-list for some reason.

Anyway...

> But in either case, if we=E2=80=99re going to support it, it should b=
e
> documented. If we don=E2=80=99t want to support it, then we should de=
lete the
> references to these formats along with the tests for this.

Whether they are stupid or not (and I agree that they are), we cannot
just rip them out now without warning. And given that they are probably
not costing us a lot in maintenance burden to keep, I'd guess it is les=
s
effort to simply leave them in place.

I suspect they were not really documented because nobody wanted to
encourage their use. I don't think it would be wrong to document that
they exist and are deprecated, though.

> I=E2=80=99m happy to write a patch going in either direction, but I=E2=
=80=99d like
> some input from the community as to what we want to do.

I imagine your ulterior motive is also figuring out whether libgit2
needs to support them?

-Peff
