From: Jeff King <peff@peff.net>
Subject: Re: Completion message for git-clone?
Date: Fri, 8 Feb 2008 03:29:57 -0500
Message-ID: <20080208082957.GA23616@coredump.intra.peff.net>
References: <ad4f9af90802071909s4dad180as26b2dd8b7600342f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Dees <undees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 08 09:30:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNOd3-0008My-Uw
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 09:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761794AbYBHIaE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 03:30:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761427AbYBHIaD
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 03:30:03 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1621 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761247AbYBHIaA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 03:30:00 -0500
Received: (qmail 26372 invoked by uid 111); 8 Feb 2008 08:29:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 08 Feb 2008 03:29:58 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2008 03:29:57 -0500
Content-Disposition: inline
In-Reply-To: <ad4f9af90802071909s4dad180as26b2dd8b7600342f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73052>

On Thu, Feb 07, 2008 at 07:09:54PM -0800, Ian Dees wrote:

>   Initialized empty Git repository in path/to/new-repo/.git
>   0 blocks
> 
> I'd wager "empty" means, "empty because Git is about to populate it."
> Even so, this wording could be a bit surprising to new adopters,
> especially coupled with the "0 blocks" suffix (is it really creating
> hardlinks on NTFS?).  The impression is that the clone didn't work.
> The impression is, of course, eventually dispelled by looking inside
> the new directory.  Is there a way to clarify the overall status of
> the clone operation?

The '0 blocks' actually comes from cpio, because it's hardlinking. I
complained about this when it first appeared, but getting cpio to print
something sane is a bit tricky. However, there has been talk of making
git-clone a builtin in the near future, and I suspect it will be much
easier to generate more user-friendly muessages then. So it is probably
simplest to hold your breath and see what comes of that effort (though I
can't seem to find any mention of it in the archives...)

> One other minor thing I noticed while futzing with clones: if you try
> to clone an empty repository, you get the same "Initialized empty
> repository" message, even though no such second directory is created.
> I'm not suggesting Git should suddenly start allowing empty cloning,
> but perhaps a "Empty repository; skipping clone" message would be
> helpful.

What version are you using? This should be fixed in v1.5.4 (see commit
ef4cffde).

-Peff
