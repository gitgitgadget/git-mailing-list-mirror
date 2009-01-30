From: Jeff King <peff@peff.net>
Subject: Re: [ANNOUNCE] EasyGit (eg) 0.97
Date: Fri, 30 Jan 2009 15:29:17 -0500
Message-ID: <20090130202917.GA3370@coredump.intra.peff.net>
References: <51419b2c0901300842rb993454u7e8b6d1032c12ac8@mail.gmail.com> <e2b179460901300859r438a4230hc990305688b4f29e@mail.gmail.com> <51419b2c0901301035g6867b9d8l2d4de9590035bd4e@mail.gmail.com> <20090130194727.GA31927@coredump.intra.peff.net> <51419b2c0901301221n45cde1abw7a57a13bfa74b34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mike Ralphson <mike.ralphson@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 30 21:30:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT00k-0001ow-0q
	for gcvg-git-2@gmane.org; Fri, 30 Jan 2009 21:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216AbZA3U3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 15:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753995AbZA3U3U
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 15:29:20 -0500
Received: from peff.net ([208.65.91.99]:55658 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753983AbZA3U3U (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 15:29:20 -0500
Received: (qmail 4398 invoked by uid 107); 30 Jan 2009 20:29:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 30 Jan 2009 15:29:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Jan 2009 15:29:17 -0500
Content-Disposition: inline
In-Reply-To: <51419b2c0901301221n45cde1abw7a57a13bfa74b34@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107871>

On Fri, Jan 30, 2009 at 01:21:00PM -0700, Elijah Newren wrote:

> Whenever I try to load the output in perl, git won't show the
> colorization.  I guess I could manually add it when I am printing the
> information, but it'd be nicer to just have git do the colorization
> despite the fact that its output is not a tty.  Is there an easy way
> to do that (without mucking with the user's config file)?
> 
> (It looks like eg status is also affected, for similar reasons.)

If you pass --color on the command line, it is equivalent to "color =
always" (whereas the default is "auto", which turns it on only if output
is to a tty).

So you would have to read color.diff yourself and then decide whether to
add --color.

Note that in general you are playing things a bit risky with these sorts
of outputs. You are calling porcelain (like log and status) and piping
it into your program. There's no guarantee that user config might not be
affecting the results of those programs.

But I think that is sort of the nature of "eg": to be a thin wrapper
around git. So maybe it is OK for your use.

-Peff
