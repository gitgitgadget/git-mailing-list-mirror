From: Jeff King <peff@peff.net>
Subject: Re: Please support add -p with a new file, to add only part of the
 file
Date: Tue, 10 Jan 2012 13:38:33 -0500
Message-ID: <20120110183833.GA15787@sigill.intra.peff.net>
References: <20120109105134.1239.39047.reportbug@leaf>
 <20120109204721.GC23825@burratino>
 <87ty43fy7f.fsf@thomas.inf.ethz.ch>
 <7vpqer9znv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Triplett <josh@joshtriplett.org>, git@vger.kernel.org,
	Wincent Colaiuta <win@wincent.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 19:38:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkgan-0001WZ-2K
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 19:38:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756563Ab2AJSif (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 13:38:35 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33797
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653Ab2AJSif (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 13:38:35 -0500
Received: (qmail 12563 invoked by uid 107); 10 Jan 2012 18:45:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 13:45:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 13:38:33 -0500
Content-Disposition: inline
In-Reply-To: <7vpqer9znv.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188278>

On Tue, Jan 10, 2012 at 10:32:20AM -0800, Junio C Hamano wrote:

> Thomas Rast <trast@student.ethz.ch> writes:
> 
> > A not-so-proper solution might of course start by looking at which files
> > are untracked, and only run the 'git add -N' immediately before patch
> > application.
> 
> Isn't the real issue that we mistakenly gave an impression that "add -p"
> is the primary interface to the users, and forgot to tell them about the
> more general "add -i", which "add -p" is a small subset of?

Maybe it is just me, but I find "add -p" insanely useful, and the rest
of "add -i" to be worthless clutter. The "add -p" functionality is not
easily available anywhere else, but the rest of "add -i" can be easily
(and often more efficiently) mimicked using existing git commands.

> Even if you start with "add -N", there won't be individual "hunks" you can
> pick and choose from diffing emptiness and the whole new file, so you end
> up using "edit hunk" interface.

I don't think the main impetus for this is that people necessarily want
to pick and choose hunks from added files. I think it is simply a nice
workflow to do:

  $ hack hack hack
  $ git add -p ;# inspect and add changes
  $ git commit

which is very similar to the traditional git workflow:

  $ hack hack hack
  $ git diff ;# inspect changes
  $ git add foo ;# add changes
  $ git commit

I find myself using "add -p" almost exclusively these days, as it
combines the two middle steps (and even though I usually am just hitting
"y" after inspection, when I _do_ want to make a change, I am right
there in the hunk selection loop already).

-Peff
