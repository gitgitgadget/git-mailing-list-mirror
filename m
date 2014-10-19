From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision: remove definition of unused 'add_object'
 function
Date: Sat, 18 Oct 2014 21:36:46 -0400
Message-ID: <20141019013646.GA17908@peff.net>
References: <5442DD4C.9050908@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Oct 19 03:37:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XffQd-0002Ny-UM
	for gcvg-git-2@plane.gmane.org; Sun, 19 Oct 2014 03:37:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751617AbaJSBgt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Oct 2014 21:36:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:59880 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751593AbaJSBgt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Oct 2014 21:36:49 -0400
Received: (qmail 30923 invoked by uid 102); 19 Oct 2014 01:36:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Oct 2014 20:36:49 -0500
Received: (qmail 18019 invoked by uid 107); 19 Oct 2014 01:36:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 18 Oct 2014 21:36:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 18 Oct 2014 21:36:46 -0400
Content-Disposition: inline
In-Reply-To: <5442DD4C.9050908@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 18, 2014 at 10:36:12PM +0100, Ramsay Jones wrote:

> I noticed that your 'jk/prune-mtime' branch removes the last caller
> of the add_object() function; specifically commit 5f78a431a
> ("reachable: use traverse_commit_list instead of custom walk", 15-10-2014).

Thanks. I usually rely on the compiler to catch any static instances
that I missed, but of course this one is extern. Did you use an
automated tool for this (I know you often catch "X has no declaration;
should it be static?" with clang, but does clang catch this, too?).

> If you need to re-roll those patches, could you please squash this
> patch into the above commit. (unless you have plans to add some new
> callers, of course! ;-) ).

Nope, I just didn't notice that I dropped the last caller. I don't think
we need another re-roll (fingers crossed), but I'd be happy to have this
on top.

-Peff
