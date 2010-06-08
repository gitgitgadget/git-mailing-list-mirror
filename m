From: Jeff King <peff@peff.net>
Subject: Re: DWIM "git checkout frotz" to "git checkout -b frotz
 origin/frotz"
Date: Tue, 8 Jun 2010 03:52:42 -0400
Message-ID: <20100608075241.GA3166@coredump.intra.peff.net>
References: <20100605110930.GA10526@localhost>
 <vpqljas5e33.fsf@bauges.imag.fr>
 <20100606164642.GA10104@localhost>
 <buobpbnz6mh.fsf@dhlpc061.dev.necel.com>
 <20100607185439.GB17343@localhost>
 <AANLkTilccgKxO7YCTJYc5rTzhov5Tku2z8jSfWU_B4ui@mail.gmail.com>
 <20100608072958.GA24302@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miles Bader <miles@gnu.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Peter Rabbitson <ribasushi@cpan.org>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jun 08 09:52:52 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLtcB-0000J3-UX
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 09:52:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751810Ab0FHHwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 03:52:46 -0400
Received: from peff.net ([208.65.91.99]:46122 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750743Ab0FHHwp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 03:52:45 -0400
Received: (qmail 3394 invoked by uid 107); 8 Jun 2010 07:52:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 08 Jun 2010 03:52:55 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jun 2010 03:52:42 -0400
Content-Disposition: inline
In-Reply-To: <20100608072958.GA24302@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148649>

On Tue, Jun 08, 2010 at 09:29:58AM +0200, Clemens Buchacher wrote:

> Let's assume the user "just wants to check out branch X." Such a
> use case has been mentioned previously in this thread. So they say
> "git checkout X", and voila, they get what they wanted.
> 
> It did what they meant it to do. Everybody is happy. But not for
> long.
> 
> Because the next time they "just want to check out branch X," they
> will remember, it's time for "git checkout X." But what's this?
> This is not what they wanted. It does not have the latest changes
> on branch X! Didn't they do the same thing they did last time?
> 
> No they did not, because last time they _created a branch_.
> Eventually, if they are lucky, they will learn in #git that they
> were supposed to "git merge <remote>/X." And they will think "WTF?
> Why do I have to _merge_? And what's this business about remotes?
> Why is git is so complicated?"

FWIW, I made this same complaint at the GitTogether, and the response I
got is that git does help the user along through the second "checkout".
You get something like:

  $ git checkout foo
  Branch private set up to track remote branch foo from origin.
  Switched to a new branch 'foo'

  ... time passes ...

  $ git checkout foo
  Switched to branch 'foo'
  Your branch is behind 'origin/foo' by 5 commits, and can be fast-forwarded.

Now you can certainly argue that a clueless user won't know what to do
with those messages, but it is not entirely true that git leaves them
without any advice. Perhaps we could lessen the "wtf" moment in your
example above by making that advice better.

-Peff
