From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] stash: Add --clean option to stash and remove all
 untracked files
Date: Tue, 21 Jun 2011 10:18:43 -0400
Message-ID: <20110621141843.GA18700@sigill.intra.peff.net>
References: <1308612986-26593-1-git-send-email-david@porkrind.org>
 <20110621003852.GB2050@sigill.intra.peff.net>
 <4DFFF5AA.4030401@porkrind.org>
 <4E002762.3050803@sohovfx.com>
 <4E003A0F.5080601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Andrew Wong <andrew.w@sohovfx.com>,
	David Caldwell <david@porkrind.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 21 16:18:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QZ1n2-0003ro-6f
	for gcvg-git-2@lo.gmane.org; Tue, 21 Jun 2011 16:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab1FUOSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Jun 2011 10:18:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51672
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753210Ab1FUOSq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2011 10:18:46 -0400
Received: (qmail 2827 invoked by uid 107); 21 Jun 2011 14:18:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Jun 2011 10:18:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2011 10:18:43 -0400
Content-Disposition: inline
In-Reply-To: <4E003A0F.5080601@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176154>

On Tue, Jun 21, 2011 at 08:28:31AM +0200, Johannes Sixt wrote:

> > I personally think "--untracked" (and -u) is more intuitive too, since it
> > tells you what "git stash" is about to do. i.e. "git stash" is about to do
> > the usual stash operation *and* also stash the "untracked" files.
> 
> Really?
> 
>    $ git stash --untracked
> 
> sound like it stashes *only* untracked files. (That by itself may be a
> feature that some people want; so far, I'm not among them.)

I would be happy with something that indicated "untracked files in
addition to the regular stash". I just think it should be about "add
these other files into the stash", not "end up in this directory state".

Something like "--untracked-too" fits that, but is horribly ugly. I also
think it makes sense to have some way of stashing everything, including
excluded files.  That could just be "-x" in conjunction with whatever
this option is (which matches "git clean"), or it could be a separate
option name (like "--all" or "--ignored").

Things like "git stash --all" or "git stash --thorough" indicate that
you are stashing more, but it's hard to remember what the "more" is.

So I don't have any brilliant suggestions. Doing:

  $ git stash --untracked-too --ignored-too

is fairly clear, but somehow strikes me as unnecessarily ugly and
verbose.

-Peff
