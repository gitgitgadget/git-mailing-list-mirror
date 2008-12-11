From: Jeff King <peff@peff.net>
Subject: Re: fatal output from git-show really wants a terminal
Date: Thu, 11 Dec 2008 17:59:43 -0500
Message-ID: <20081211225943.GA29311@coredump.intra.peff.net>
References: <ghop5d$qud$1@ger.gmane.org> <200812111051.20322.bss03@volumehost.net> <20081211215554.GA11565@sigill.intra.peff.net> <200812111645.10067.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Fri Dec 12 00:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAuWu-0007pT-Sd
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 00:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759234AbYLKW7r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759229AbYLKW7r
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:59:47 -0500
Received: from peff.net ([208.65.91.99]:2846 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759171AbYLKW7q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:59:46 -0500
Received: (qmail 29917 invoked by uid 111); 11 Dec 2008 22:59:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 11 Dec 2008 17:59:44 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Dec 2008 17:59:43 -0500
Content-Disposition: inline
In-Reply-To: <200812111645.10067.bss03@volumehost.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102837>

On Thu, Dec 11, 2008 at 04:45:05PM -0600, Boyd Stephen Smith Jr. wrote:

> I did see a commit message mentioning some unusual settings for PAGER, but in 
> general, pagers are interactive.  I'd think the default behavior would 
> be "interactive <-> pager", with a config option to turn the pager always off 
> or always on.  From there, I would reason the test for interactivity should 
> be the POSIX test.

Right, but then that leads to the case I mentioned before. I think you
want to say "this is interactive _and_ our stdout is going to the
interactive spot". Which by your definition would be isatty() on stdin,
stderr, and stdout.

And maybe that is a better test, but I think it would be helpful to
provide a concrete example where that behavior works and the current
behavior doesn't.

> It looks like this test have have been attempting to follow the behavior 
> of --color=auto to GNU less and GNU grep (and possibly others).  This 
> certainly makes some sense as well, and may be less surprising.

Yes. You'll see we use a similar test for git's "auto" color.

> >And FWIW, I don't recall this ever being discussed before, but then I
> >have not been involved with git since the very beginning.
> 
> Google should be able to find it.  And worst-case, I can tell wget to spider 
> the archives and then run some sort of find/html2txt/grep on them.

I have the complete archive, and I couldn't find anything useful. ;)

Let me know if you want a copy (or you can pull it straight from gmane,
but it is somewhat slow IIRC).

-Peff
