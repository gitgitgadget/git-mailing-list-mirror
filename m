From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Feb 2015, #06; Sun, 22)
Date: Mon, 23 Feb 2015 15:27:52 -0500
Message-ID: <20150223202752.GA30429@peff.net>
References: <xmqqk2z9vd38.fsf@gitster.dls.corp.google.com>
 <54EB30F0.4010404@drmicha.warpmail.net>
 <xmqqk2z8tpve.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 23 21:28:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YPzbk-0001MI-My
	for gcvg-git-2@plane.gmane.org; Mon, 23 Feb 2015 21:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752756AbbBWU1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2015 15:27:55 -0500
Received: from cloud.peff.net ([50.56.180.127]:52464 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752330AbbBWU1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2015 15:27:54 -0500
Received: (qmail 448 invoked by uid 102); 23 Feb 2015 20:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 14:27:54 -0600
Received: (qmail 27206 invoked by uid 107); 23 Feb 2015 20:27:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 23 Feb 2015 15:27:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Feb 2015 15:27:52 -0500
Content-Disposition: inline
In-Reply-To: <xmqqk2z8tpve.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264296>

On Mon, Feb 23, 2015 at 11:00:21AM -0800, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> > status, status -s and the like are in an ordinary user's tool box.
> > ls-files isn't, at least not with "-t", which we even mark as deprecated.
> >
> > That makes me wonder, though, how difficult it would be to
> > wt_status_collect_unchanged() and to leverage the status machinery
> > rather than ls-files.
> 
> Good point.  wt-status feels like a much better infrastructure to
> build on than "ls-files -t", which should die ;-).  Especially if
> the command is interested in showing the state of the working tree
> files relative to the tree of HEAD, as "ls-files" is purely between
> the index and the working tree.

I had to look up "-t", having never used it myself. ;)

What I noticed in the manpage was rather gross:

   -t
       This feature is semi-deprecated. For scripting purpose, git-status(1)--porcelain
       and git-diff-files(1)--name-status are almost always superior alternatives, and
       users should look at git-status(1)--short or git-diff(1)--name-status for more
       user-friendly alternatives.

It looks like asciidoc sucks up the space between a linkgit macro and
the next word. I can fix it with "{nbsp}", but I'm not sure if there's a
better way.

It's also rather hard to read the commands as intended with the "(1)"
stuck there. I'm tempted to just make this `git status --porcelain` and
drop the link entirely, but I guess it is helping people who read the
HTML version.

-Peff
