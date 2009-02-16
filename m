From: Jeff King <peff@peff.net>
Subject: Re: disallowing push to currently checked-out branch
Date: Sun, 15 Feb 2009 23:37:09 -0500
Message-ID: <20090216043708.GB12986@coredump.intra.peff.net>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <20090216035027.GA12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152057500.14911@asgard.lang.hm> <20090216040529.GC12689@coredump.intra.peff.net> <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Heikki Orsila <shdl@zakalwe.fi>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Mon Feb 16 05:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYvGf-0002Wa-Dt
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 05:39:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756107AbZBPEhN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 23:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756010AbZBPEhN
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 23:37:13 -0500
Received: from peff.net ([208.65.91.99]:58065 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755948AbZBPEhM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 23:37:12 -0500
Received: (qmail 13264 invoked by uid 107); 16 Feb 2009 04:37:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 15 Feb 2009 23:37:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Feb 2009 23:37:09 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.10.0902152113380.14911@asgard.lang.hm>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110136>

On Sun, Feb 15, 2009 at 09:18:47PM -0800, david@lang.hm wrote:

>> So people doing major version upgrades of their OS don't need to read
>> release notes or re-test behavior?
>
> when was the last time you read the release notes for an entire distro?

Since you ask, I track Debian unstable and I read the release notes
(NEWS.Debian) for every package that I upgrade, and skim the changelogs
for perhaps half.

But yes, I realize that is not common; I don't expect that every user
reads every release note.

My point is that things _are_ going to change in a major version OS
upgrade. It is up to the user to make the tradeoff of how much time they
want to spend researching those changes versus the likelihood and
severity of breakage. If I have a mission critical system running git,
I'm going to read git's release notes. If I don't, then I will probably
accept that something could break, and fix it if it does.

> and it's not a matter of reading the release notes. it's a matter of them  
> running a version that gives them a warning before you feed them a version 
> that will cause their existing stuff to fail.

The warning is not a panacea:

  1. It might actually cause breakage. Less likely than a straight
     change in behavior, but still possible.

  2. Users don't necessarily see the warning. By definition, it is not
     changing the behavior. So unless they are examining the output
     (which might not be the case for an unattended system), it can go
     unnoticed.

So all of the problems you are talking about are still possible even
with an extremely long change cycle.

> I recognise that not all software is concerned about backwards  
> compatibility, but if git wasn't concerned with backwards compatibility  
> and a graceful upgrade process, this thread wouldn't exist.

I think git is much better about backwards compatibility than most
packages I have seen. But there is a cost to maintaining it completely
and forever, in that you are either hampered in what you can do (i.e.,
there are enhancements you would like to make but can't) or you pay an
awful burden in development cost maintaining two diverging codebases.

Based on the numbers in your last email, you seem to be advocating a
9-15 year lag on making any behavior changes in git. I'm sorry, but I
have no interest in waiting that long to see enhancements I work on in
git make it into a released version.

I think Junio is doing a fine job at dealing with backwards
compatibility and keeping things moving at a reasonable pace. If you
think it should go slower, you are certainly welcome to fork and release
an "ultra-stable" version of git that reverts any backwards incompatible
changes while keeping up with other new features.

-Peff
