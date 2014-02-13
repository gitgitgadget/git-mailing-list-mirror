From: Jeff King <peff@peff.net>
Subject: Re: [RFH] hackday and GSoC topic suggestions
Date: Thu, 13 Feb 2014 03:37:55 -0500
Message-ID: <20140213083755.GA28679@sigill.intra.peff.net>
References: <20140205225702.GA12589@sigill.intra.peff.net>
 <xmqq1tz9qxyl.fsf@gitster.dls.corp.google.com>
 <xmqqeh39phi6.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 13 09:38:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WDro5-0005UX-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 13 Feb 2014 09:38:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbaBMIh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Feb 2014 03:37:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:49681 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753283AbaBMIh5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Feb 2014 03:37:57 -0500
Received: (qmail 6902 invoked by uid 102); 13 Feb 2014 08:37:57 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Feb 2014 02:37:57 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 13 Feb 2014 03:37:55 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh39phi6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242047>

On Tue, Feb 11, 2014 at 11:38:09AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >>  - Branch rename breaks local downstream branches
> >>    http://article.gmane.org/gmane.comp.version-control.git/241228
> >
> > If you have a branch B that builds on A, if you are renaming A to C,
> > you may want B to automatically set to build on C in some cases, and
> > in other cases your renaming A is done explicitly in order to severe
> > the tie between A and B and setting the latter to build on C can be
> > a bad thing---after all, the user's intention may be to create a
> > branch A starting at some commit immediately after this rename so
> > that B will keep building on that updated A.
> >
> > So I am not sure if this is a bug.
> 
> Having said that, the current behaviour of leaving B half-configured
> to build on a missing branch is undesirable. If we were to change
> this so that any branch B that used to build on branch A being
> renamed to build on the branch under the new name C, the user may
> have to do an extra "--set-upstream-to A" on B after recreating A if
> this was done to save away the current state of A to C and then keep
> building B on an updated A, so we may have to give _some_ clue what
> we are doing behind their back when we rename, e.g.
> 
> 	$ git branch -m A C
>         warning: branch B is set to build on C now.
> 
> or something.

Yeah, I agree. I think most of the time people would want the dependency
to move with the branch, and the key is being clear about it so the user
can override. I don't think there is a problem with overriding with
`--set-upstream-to` after the fact, rather than giving a special option
to the move operation.

There was a team working on this at the hackday, and they seemed to make
reasonable progress, but I haven't seen the final output yet. Most teams
did not finish their projects, or if they did, I didn't get a chance to
coach them through the patch submission process. I'll hopefully be
revisiting those in the next week or two as they finish them up offline.

My goal is to get them all posting to the list themselves, but I fear I
may have to pick up the pieces in some cases.

-Peff
