From: Jeff King <peff@peff.net>
Subject: Re: Add comment lines to patch format
Date: Fri, 18 May 2012 20:14:10 -0400
Message-ID: <20120519001410.GC765@sigill.intra.peff.net>
References: <20120518132228.GA27970@do>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:14:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVXJj-0002kh-KU
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968237Ab2ESAOR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:14:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48880
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968235Ab2ESAOO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:14:14 -0400
Received: (qmail 9864 invoked by uid 107); 19 May 2012 00:14:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 20:14:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 20:14:10 -0400
Content-Disposition: inline
In-Reply-To: <20120518132228.GA27970@do>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197998>

On Fri, May 18, 2012 at 08:22:28PM +0700, Nguyen Thai Ngoc Duy wrote:

> One thing is trailing space, like demonstrated in the patch below,
> because trailing spaces may be intentional sometimes. But I'd like to
> incorporate some word-diff goodness in patch format using this comment
> line to spot few/single character addition/removal.
> [...]
> If anyone knows a tool with similar feature, I'd greatly appreciate it
> (as the Internet taught me, everything I think of is already thought
> of/implemented by someone)

Have you looked at contrib/diff-highlight?

I think your approach is interesting because it can annotate much more
than just "this part is interesting". Sometimes when I send a patch, I'd
like to be able to comment in-line, like:

  +       if (bar > 3)
  +               foo(bar);
  = Yeah, this magic "3" is ugly, and we should handle it
  = through $whatever in the re-roll.
  +       else
  +               something_else();

I usually just write something in the cover letter, or reply to myself
with comments inline. I don't know how much I would use it in practice,
but it might be a neat thing for "git apply" to simply ignore comment
lines in the middle of a hunk.

Of course, this feature might not be worth breaking compatibility with
every existing version of "git apply" and "patch" out there.

-Peff
