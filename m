From: Jeff King <peff@peff.net>
Subject: Re: Gitignore matching "git add" wildcard prevents operation
Date: Fri, 15 Jan 2010 10:48:16 -0500
Message-ID: <20100115154816.GA1579@coredump.intra.peff.net>
References: <4B4F6000.4070005@sofistes.net>
 <20100114195234.GA26684@coredump.intra.peff.net>
 <7vljg0bfox.fsf@alter.siamese.dyndns.org>
 <20100114203928.GA26883@coredump.intra.peff.net>
 <20100115153419.GA12982@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Marko Poutiainen <regs@sofistes.net>, git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Fri Jan 15 16:49:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVoPT-0002R6-9W
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 16:48:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287Ab0AOPsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2010 10:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467Ab0AOPsV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 10:48:21 -0500
Received: from peff.net ([208.65.91.99]:45748 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751319Ab0AOPsU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2010 10:48:20 -0500
Received: (qmail 27175 invoked by uid 107); 15 Jan 2010 15:53:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 15 Jan 2010 10:53:11 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Jan 2010 10:48:16 -0500
Content-Disposition: inline
In-Reply-To: <20100115153419.GA12982@vidovic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137078>

On Fri, Jan 15, 2010 at 04:34:19PM +0100, Nicolas Sebrecht wrote:

> >   1. Most programs don't take their own globs. Without knowing that git
> >      can do so, there is no reason to discover it in this instance. I
> >      can see searching the manpage for options, but not for a discussion
> >      of globbing behavior.
> > 
> >   2. They would have to know that using a git-glob will magically change
> >      the error-checking behavior.
> 
> Not sure. This isn't a Git-particular issue.
> 
> Users may hit this with a lot of other unix tools (sed, grep, find,
> etc). So, we can expect either
>   they already know the issue;
> or
>   they are discovering it using Git.

I don't understand what you mean. How does "sed" do its own globbing of
the command line?

> Most of the tools I talk about do have a manual section about globbing.
> Users could learn globs with Git too and expect the same behaviour
> somewhere else.

Sure. git-add(1) talks about globbing, too, and it even has a sentence
that explains exactly what is happening in Marko's case:

   The git add command will not add ignored files by default. If any
   ignored files were explicitly specified on the command line, git add
   will fail with a list of ignored files. Ignored files reached by
   directory recursion or filename globbing performed by Git (quote your
   globs before the shell) will be silently ignored.

My complaint was more that as a user, I am not likely to see this
problem and think "I'll bet git-specific globbing can solve it." And
when I look in the manual, I am more likely to look for a command-line
option that helps me rather than to read all of the text (though the
fact that we specifically mention "ignore" in the same paragraph means
that at least a user searching for "ignore" in the man page will come up
with this paragraph).

-Peff
