From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Modified the default git help message to be grouped by
	topic
Date: Tue, 2 Dec 2008 19:37:31 -0500
Message-ID: <20081203003731.GA23780@coredump.intra.peff.net>
References: <20081201173037.GA41967@agadorsparticus> <20081201183258.GB24443@coredump.intra.peff.net> <7v7i6jqriv.fsf@gitster.siamese.dyndns.org> <d411cc4a0812012210h4cb59974sbda71abd2c64f93b@mail.gmail.com> <885649360812021211u3d547982i8e1c3070972363e8@mail.gmail.com> <alpine.DEB.1.00.0812022353410.27091@racer> <20081202233004.GA22379@coredump.intra.peff.net> <7vfxl6m84g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	James Pickens <jepicken@gmail.com>,
	Scott Chacon <schacon@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 03 01:39:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7flf-0007pd-7O
	for gcvg-git-2@gmane.org; Wed, 03 Dec 2008 01:39:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754977AbYLCAhf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 19:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754875AbYLCAhf
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 19:37:35 -0500
Received: from peff.net ([208.65.91.99]:4904 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754766AbYLCAhd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 19:37:33 -0500
Received: (qmail 15452 invoked by uid 111); 3 Dec 2008 00:37:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 02 Dec 2008 19:37:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Dec 2008 19:37:31 -0500
Content-Disposition: inline
In-Reply-To: <7vfxl6m84g.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102193>

On Tue, Dec 02, 2008 at 04:10:07PM -0800, Junio C Hamano wrote:

> It might not be a bad idea to make this "top page help" into an
> interactive hierarchical help topic browser.  You would start a page that
> might look like this:
> 
>     Bootstrapping -- preparing an area to work in
>         init, clone
>     Basic -- review, undo and record your changes
>         diff, status, checkout <path>, add, reset, commit
>     History -- inspect what you have now, and what happened before
>         log, blame, grep, show
>     Branching and Merging -- build and use alternate histories
> 	branch, checkout -b, merge, rebase
>     Working with Others
> 	remote, fetch, pull, push

Yes, that is the sort of thing I was thinking of. And I think your
layout addresses Scott's concern, which is to keep names of commands
available for quick reference. So really we are ditching the
descriptions.

> with each of the command and the heading being a "link" (use ncurses for
> that).  If you choose the leaf-level command (say, 'diff'), you will get

I'm not sure we need anything so fancy. I was thinking of something
like:

  Bootstrapping -- preparing an area to work in (bootstrapping)
    init, clone
  ...
  Working with Others (others)
    remote, fetch, pull, push

  Use "git help <subject>" for more help on one of these subjects, or
  "git help <command>" for help with a specific command.

And maybe the "(bootstrapping)" could be typographically more obvious as
the subject keyword, but I think you get the point (and for
"Bootstrapping", it's obvious what the keyword would be, but for
"Working with Others" it's not).

And obviously something with ncurses would save you typing, but I have
no desire to recreate "info" or "lynx" here (and I also think that "git"
or "git foo" displaying help should remain non-interactive to cause the
least surprise).

-Peff
