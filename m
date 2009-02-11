From: Jeff King <peff@peff.net>
Subject: Re: [RFC] New command: 'git snapshot'.
Date: Wed, 11 Feb 2009 08:43:22 -0500
Message-ID: <20090211134322.GB19223@coredump.intra.peff.net>
References: <38cfbb550902091054u78f2e706u67752b4dc9de6c3b@mail.gmail.com> <etsYQzEDjdk-_NxhvO3i6EyShR6eZ202GBdQx7ZZpPHH5iNfWiuV6g@cipher.nrlssc.navy.mil> <38cfbb550902101240x1202c592ra7eb01d66e22da43@mail.gmail.com> <20090210230054.GD26954@coredump.intra.peff.net> <7vy6wdkhzk.fsf@gitster.siamese.dyndns.org> <83d7aaa40902101539m3c40deeeo2d452f6dbb7c379c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Geoffrey Lee <geoffreyj.lee@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 14:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXFOg-00036k-LL
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 14:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755186AbZBKNn0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 08:43:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbZBKNn0
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 08:43:26 -0500
Received: from peff.net ([208.65.91.99]:48734 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbZBKNnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 08:43:25 -0500
Received: (qmail 30031 invoked by uid 107); 11 Feb 2009 13:43:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 11 Feb 2009 08:43:41 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Feb 2009 08:43:22 -0500
Content-Disposition: inline
In-Reply-To: <83d7aaa40902101539m3c40deeeo2d452f6dbb7c379c@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109414>

On Tue, Feb 10, 2009 at 03:39:19PM -0800, Geoffrey Lee wrote:

> Git stash doesn't touch untracked files, whereas git snapshot would.
> Take another closer look at the table in the original post titled
> "What are the differences between 'git stash' and 'git snapshot'?"

Sure, I was just responding to that particular statement about reset.
But I think it generalizes. Why not "--untracked" as an option?

In other words, there are several behaviors that people might not like
about stash, and I think they can be combined in multiple ways. So one
solution is to make another command which chooses a different set of
behaviors. But what about the person who wants "--untracked" but not
"--no-reset"? Do they make a third command?

So it is much more flexible to make orthogonal switches that can be
turned on and off independently. And of course if you have a workflow
which always uses a particular set of switches, it is convenient to hide
it behind an alias.  And if there are just a few workflows that are
common to a lot of people, those can graduate to become git commands.

But this proposal seems to be starting in the opposite direction, with a
new command that is closely related to stash but changes a few
behaviors. I haven't seen a convincing argument that between stash and
snapshot, git will now serve all or most people's workflows (and we
don't need another command that does something in between).

-Peff
