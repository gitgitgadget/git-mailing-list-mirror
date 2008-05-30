From: Jeff King <peff@peff.net>
Subject: Re: gitk / diffcore-rename error message
Date: Fri, 30 May 2008 19:10:42 -0400
Message-ID: <20080530231041.GA11813@sigill.intra.peff.net>
References: <556d90580805300854k27e0ea9ev3aabcfb28f131228@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alf Clement <alf.clement@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 01:11:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2Dl7-0007pH-A9
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 01:11:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755832AbYE3XKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 19:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754689AbYE3XKq
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 19:10:46 -0400
Received: from peff.net ([208.65.91.99]:3385 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755689AbYE3XKp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 19:10:45 -0400
Received: (qmail 32157 invoked by uid 111); 30 May 2008 23:10:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 30 May 2008 19:10:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 May 2008 19:10:42 -0400
Content-Disposition: inline
In-Reply-To: <556d90580805300854k27e0ea9ev3aabcfb28f131228@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83356>

On Fri, May 30, 2008 at 05:54:42PM +0200, Alf Clement wrote:

> Now I get the following error while using gitk:
> warning: too many files, skipping inexact rename detection
> warning: too many files, skipping inexact rename detection
>     while executing
> "close $bdf"
>     (procedure "getblobdiffline" line
> ...
> 
> which seems to come out of diffcore-rename.c
> 
> Can I ignore it? Is it harmful?

It isn't harmful. You had a big commit, and git decided it wasn't worth
trying to do rename detection on such a big change (because it would
likely take too much CPU time).

The upcoming version of git suppresses this message since it confuses
gitk. So you can try upgrading to the most recent 'master' to fix it. In
the meantime, you can either ignore it (though I think it may interfere
with gitk showing the correct diff), or you can try setting the rename
limit higher (try "git config diff.renamelimit 400").

-Peff
