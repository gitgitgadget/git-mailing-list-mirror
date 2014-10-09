From: Jeff King <peff@peff.net>
Subject: Re: [bug] [UX] `stash save --untracked` produces a stash that
 *looks* empty
Date: Wed, 8 Oct 2014 22:51:12 -0400
Message-ID: <20141009025112.GA19897@peff.net>
References: <CACsY31pSeijqGC4Rw=q+qAGHJQ+bNibindVReYoZZACvYL7O+A@mail.gmail.com>
 <543501CE.5040705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 04:52:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xc3pj-00056I-MH
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 04:52:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756269AbaJICvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Oct 2014 22:51:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:56604 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756222AbaJICvO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Oct 2014 22:51:14 -0400
Received: (qmail 23726 invoked by uid 102); 9 Oct 2014 02:51:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 21:51:14 -0500
Received: (qmail 20866 invoked by uid 107); 9 Oct 2014 02:51:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Oct 2014 22:51:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Oct 2014 22:51:12 -0400
Content-Disposition: inline
In-Reply-To: <543501CE.5040705@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 08, 2014 at 02:50:14PM +0530, Tanay Abhra wrote:

> I think problem lies with  show_stash() which just shows the
> diff between working tree and the base tree, it ignores the
> untracked files. A quick and dirty fix can be to just show
> the diff between the untracked files and a NULL commit.
> Here's the patch, it works all right but can be implemented
> much better. I will try to find a better approach tomorrow.

You may want to read through another recent attempt at the same thing
here:

  http://thread.gmane.org/gmane.comp.version-control.git/254420

It ended with us just making "git stash list" behave like "git stash
show" (and show only the working tree); that ended up as 288c67c (stash:
default listing to working-tree diff, 2014-08-06).

Which isn't to say there isn't room for more improvement. But you may
find the backstory and pitfalls helpful (and I think Junio explicitly
said he prefers the current behavior in that thread).

-Peff
