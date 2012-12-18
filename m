From: Jeff King <peff@peff.net>
Subject: Re: Feature suggestion: new 'git add -i' command to discard working
 copy changes
Date: Tue, 18 Dec 2012 16:59:14 -0500
Message-ID: <20121218215914.GB1806@sigill.intra.peff.net>
References: <50D0DA19.5030606@cs.wisc.edu>
 <7vvcbzdoy9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Evan Driscoll <driscoll@cs.wisc.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 22:59:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tl5CJ-0003E4-2g
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 22:59:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357Ab2LRV7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 16:59:17 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57977 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753394Ab2LRV7R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 16:59:17 -0500
Received: (qmail 23455 invoked by uid 107); 18 Dec 2012 22:00:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 18 Dec 2012 17:00:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 18 Dec 2012 16:59:14 -0500
Content-Disposition: inline
In-Reply-To: <7vvcbzdoy9.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211788>

On Tue, Dec 18, 2012 at 01:34:38PM -0800, Junio C Hamano wrote:

> Evan Driscoll <driscoll@cs.wisc.edu> writes:
> 
> > It's not infrequent that I want to discard changes I've made locally to
> > files ('git checkout file.txt') and find myself wishing that this was an
> > action available from the 'git add --interactive' UI; it feels like it
> > would fit in.
> 
> Hrm, not really.  "git add" is about manipulating the index and its
> promise is that it won't touch working tree files.  And people rely
> on that promise.
> 
> I can see how it would be useful to have a UI that is more
> interactive than CLI that shows you a list of paths and lets you
> pick from the list to run "git checkout" on, but I think "git add"
> is a bad match to it.

Yeah. We already generalized "git add -p" to "git checkout -p" (and
"reset -p", etc) to do hunk selection. Nobody bothered to generalize
the rest of "git add --interactive", but logically having "git checkout
--interactive" (and "git reset --interactive") would make sense.

I always assumed nobody really used the full "add -i", but maybe it is
because I am such a command-line snob. Evan, are you after hunk
selection (like choosing "patch" from the interactive UI), or full path
selection?

-Peff
