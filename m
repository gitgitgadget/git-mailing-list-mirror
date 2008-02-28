From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Thu, 28 Feb 2008 03:43:28 -0500
Message-ID: <20080228084328.GA18350@coredump.intra.peff.net>
References: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com> <76718490802250631p262baf1bw23873e5fdbbb7180@mail.gmail.com> <20080225184648.GC15131@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 09:44:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUeND-000055-Rw
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 09:44:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbYB1Inc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 03:43:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753987AbYB1Inb
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 03:43:31 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3251 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754201AbYB1Inb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 03:43:31 -0500
Received: (qmail 19736 invoked by uid 111); 28 Feb 2008 08:43:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 28 Feb 2008 03:43:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2008 03:43:28 -0500
Content-Disposition: inline
In-Reply-To: <20080225184648.GC15131@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75369>

On Mon, Feb 25, 2008 at 01:46:48PM -0500, Jeff King wrote:

> > On Thu, Feb 21, 2008 at 12:12 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> > > Always calling the thing on the left-side of a merge "local" and on the
> > >  right side "remote" isn't correct. You could be rebasing, in which case
> > >  the left side is the new base/upstream and the right side is the saved
> > >  commits which are being re-applied. So,
> 
> I'll try out your patch and comment next time I use it.

I finally got a chance to use this today (hey, I don't get a lot of
conflicts!).

I like it; I think it made it a lot more obvious which side was which
during the rebase. I checked with cherry-pick, as well; it more or less
makes sense, except that the cherry-picked commit is called "upstream."
Which sort of makes sense, but it would be nice to call it something
more obvious. Unfortunately I'm not sure that there is a good way to
determine we are in a failed cherry-pick (probably a failed 'revert' is
in a similar situation).

So like I said before, I think the eventual "right" thing is to have a
more verbose status file. But in the meantime, I think this patch is
sensible.

-Peff
