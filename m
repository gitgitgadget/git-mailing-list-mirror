From: John Keeping <john@keeping.me.uk>
Subject: Re: What's cooking in git.git (Apr 2014, #09; Tue, 29)
Date: Wed, 7 May 2014 20:28:05 +0100
Message-ID: <20140507192805.GA9035@serenity.lan>
References: <xmqq7g67iwxc.fsf@gitster.dls.corp.google.com>
 <20140505184546.GB23935@serenity.lan>
 <xmqqd2fqcv7s.fsf@gitster.dls.corp.google.com>
 <20140507080558.GH23935@serenity.lan>
 <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 07 21:38:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi7fh-0007TX-0H
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 21:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751009AbaEGTiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 15:38:25 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:43947 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750880AbaEGTiY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 15:38:24 -0400
X-Greylist: delayed 607 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 May 2014 15:38:24 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id B274A21B15;
	Wed,  7 May 2014 20:28:16 +0100 (BST)
X-Quarantine-ID: <HYjyB2BGuxzt>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HYjyB2BGuxzt; Wed,  7 May 2014 20:28:15 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by hyena.aluminati.org (Postfix) with ESMTP id 9626121AD0;
	Wed,  7 May 2014 20:28:15 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id 85F7E161E581;
	Wed,  7 May 2014 20:28:15 +0100 (BST)
X-Quarantine-ID: <dwNCHX4zvwlZ>
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id dwNCHX4zvwlZ; Wed,  7 May 2014 20:28:14 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id 4634F161E358;
	Wed,  7 May 2014 20:28:09 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <xmqqvbtha04t.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248351>

On Wed, May 07, 2014 at 11:56:18AM -0700, Junio C Hamano wrote:
> John Keeping <john@keeping.me.uk> writes:
> 
> > On Tue, May 06, 2014 at 05:01:59PM -0700, Junio C Hamano wrote:
> > ...
> >> Another thing to keep in mind is that we need to ensure that we give
> >> a good way for these third-party tools to integrate well with the
> >> core Git tools to form a single toolchest for the users.  I would
> >> love to be able to do
> >> 
> >>     $ (cd git.git && make install)
> >>     $ (cd git-imerge.git && make install)
> >> 
> >> and then say "git imerge", "git --help imerge", etc.  The same for
> >> the remote helpers that we may be splitting out of my tree into
> >> their own stand-alone projects.
> >
> > This can already work given suitable installation.  With
> > git-integration[1] I can type `git help integration` and it shows me the
> > man page in the same way that `git help commit` does.  When I manually
> > linked the HTML file to the right place `git help -w integration` worked
> > as well.
> 
> That "when I manually" part is what I meant by "we give a good way
> for these third-party tools" above, and "make it really easy to
> install these third-party tools" in the remaining part of the
> message you are responding to.
> 
> > I think this is enough...

Having thought about it a bit more after reading Felipe's reply, it
would be nice if there were some way for third-party tools to install
HTML documentation without relying on `git --html-path` but I cannot see
an obvious way to do that as there isn't a standard $HTML_PATH to match
$MAN_PATH and $PATH.

I've never tried `git help --info` until this thread, but I think we
could make some trivial improvements to that in order to support .info
documentation for third-party tools.

> The reason why I CC'ed Michael was primarily because I thought you
> were not one of those third-party tools maintainers (and secondarily
> I am a fairly big fan of imerge), but it is good to hear your
> opinion as another third-party provider.  Your git-integrate might
> turn into something I could augment my workflow with with some
> additions.  What is missing (I only read the full manual page at
> http://johnkeeping.github.io/git-integration/git-integration.html)
> to support my workflow seems to be:
> 
>  - specifying a merge strategy per branch being merged;

This is already supported by the "merge" instruction:

	If any options are given after the ref (and on the same line)
	then these are passed to git merge. This may be useful for
	specifying an alternative merge strategy for a branch.

>  - support evil merges or picking a fix-up commit;

I have an implementation of this on a branch, but have never merged it
because it's not something I need to do often and it is very hard to
support for git-integration's "status" output.

One of my primary use cases for git-integration involves pulling
together branches owned by others (either in the same repository or by
having fetched from their repositories); in this case it is interesting
to see if/how a branch has changed since the last time the integration
branch was built.  This also handles changes to the instruction sheet
without an immediate rebuild.

I have not found a good way of figuring out whether a fixup commit has
been applied and squashed into a merge) so I have let the branch sit
there awaiting a perfect solution (which I doubt exists).  It may be
that the status of a fixup is unimportant, so it could just be marked as
unknown; I am mostly convinced that marking it as unknown is going to be
better than an heuristic that is right most of the time.

>  - leaving an empty commit only to leave comment in the history.

This would be easy to add.

> and until that happens, I'll keep using the Reintegrate script found
> in my 'todo' branch.

When I originally wrote git-integration I purposefully did not target
your workflow because I (perhaps wrongly) assumed that the interaction
between the different integration branches would mean that Git was
better served sticking to the custom Reintegrate script.
