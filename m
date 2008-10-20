From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] Fail to pull from kernel.org: pack has bad object
Date: Mon, 20 Oct 2008 08:15:33 -0400
Message-ID: <20081020121533.GA2177@coredump.intra.peff.net>
References: <200810201010.29173.johan@herland.net> <200810201026.57306.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@cam.org>, Johan Herland <johan@herland.net>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Oct 20 19:09:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KrthE-0004DF-Cc
	for gcvg-git-2@gmane.org; Mon, 20 Oct 2008 14:17:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752364AbYJTMPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 08:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751246AbYJTMPh
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 08:15:37 -0400
Received: from peff.net ([208.65.91.99]:4726 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbYJTMPg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 08:15:36 -0400
Received: (qmail 12545 invoked by uid 111); 20 Oct 2008 12:15:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 08:15:34 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 08:15:33 -0400
Content-Disposition: inline
In-Reply-To: <200810201026.57306.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98682>

On Mon, Oct 20, 2008 at 10:26:55AM +0200, Thomas Rast wrote:

> > Currently I get the following error when trying to pull from git.git at 
> > kernel.org:
> > 
> > $ git pull
> > remote: Counting objects: 279, done.
> > remote: Compressing objects: 100% (78/78), done.
> > remote: Total 177 (delta 136), reused 135 (delta 99)
> > Receiving objects: 100% (177/177), 66.59 KiB | 59 KiB/s, done.
> > fatal: pack has bad object at offset 53487: failed to apply delta
> > fatal: index-pack failed
> 
> I just had the same, panicked, then compiled 'maint' and the fetch
> worked.  Unfortunately I wasn't awake enough to make a copy of the
> repo.  Maybe you can make one, then use it to bisect the problem
> between maint and next...

I am getting it, too, but I remembered to save my repo. :) The 'next'
branch is broken, but master works fine. The bisect points to

  commit 9441b61dc5c3f1f984114ec8bd470dc20c55dfe0
  Author: Nicolas Pitre <nico@cam.org>
  Date:   Fri Oct 17 15:57:57 2008 -0400

      index-pack: rationalize delta resolution code

but I don't have time to look further right now (there is a small child
who apparently thinks coloring with crayons is more interesting than
bisecting bugs).

I can make my broken repo available if need be (though given the number
of us seeing the problem, I doubt it is hard to reproduce).

-Peff
