From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] ls-remote: introduce symref argument
Date: Sun, 17 Jan 2016 10:16:23 -0500
Message-ID: <20160117151622.GD15519@sigill.intra.peff.net>
References: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: bturner@atlassian.com, gitster@pobox.com, pedrorijo91@gmail.com,
	git@vger.kernel.org
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 17 16:16:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aKp49-0005wp-Bc
	for gcvg-git-2@plane.gmane.org; Sun, 17 Jan 2016 16:16:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752762AbcAQPQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Jan 2016 10:16:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:55103 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752499AbcAQPQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jan 2016 10:16:25 -0500
Received: (qmail 7068 invoked by uid 102); 17 Jan 2016 15:16:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jan 2016 10:16:25 -0500
Received: (qmail 2016 invoked by uid 107); 17 Jan 2016 15:16:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 17 Jan 2016 10:16:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jan 2016 10:16:23 -0500
Content-Disposition: inline
In-Reply-To: <1453028643-13978-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284259>

On Sun, Jan 17, 2016 at 12:03:58PM +0100, Thomas Gummerer wrote:

> > I thought it might be nice for any porcelain which tries to wrap
> > `ls-remote`, make some decision based on the capabilities, and then
> > invoke another plumbing command. But I guess that is probably slightly
> > crazy, and nobody is doing it.
> > 
> > Something like `ls-remote --symrefs` probably would be a better place to
> > start.
> 
> Turns out adding this is pretty simple.
> 
> The first two patches are documentation, which I noticed when reading
> up about the command.  Patch three is a cleanup patch, which makes
> ls-remote use the parse-options api instead of the hand-rolled option
> parser.  Patch four is actually adding the option.
> 
> Thomas Gummerer (4):
>   ls-remote: document --quiet option
>   ls-remote: fix synopsis
>   ls-remote: use parse-options api
>   ls-remote: add support for showing symrefs
> 
>  Documentation/git-ls-remote.txt | 12 +++++-
>  builtin/ls-remote.c             | 90 +++++++++++++++++------------------------
>  t/t5512-ls-remote.sh            | 20 +++++++++
>  3 files changed, 68 insertions(+), 54 deletions(-)

Thanks for working on this. One of my favorite things about open source
is when I realize I'm too lazy/busy to work on something, and then it
magically appears in my inbox. :)

This looks like a good start. I left a few comments on the specific
patches.

-Peff
