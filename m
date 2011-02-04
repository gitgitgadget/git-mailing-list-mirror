From: Jeff King <peff@peff.net>
Subject: Re: moving to a git-backed wiki
Date: Fri, 4 Feb 2011 01:16:22 -0500
Message-ID: <20110204061622.GB2455@sigill.intra.peff.net>
References: <7vzkqg4x2h.fsf_-_@alter.siamese.dyndns.org>
 <20110131225529.GC14419@sigill.intra.peff.net>
 <AANLkTimHCp_JKUw1keJoA4zD_q7Sci+rOwPeAs_T=7xH@mail.gmail.com>
 <20110201201144.GA16003@sigill.intra.peff.net>
 <AANLkTikfzzELUaN3B+20rh9D51St8mUYs4p-WYjp8JVV@mail.gmail.com>
 <4D488DCD.3080305@eaglescrag.net>
 <4D4929F4.3020805@snarc.org>
 <4D4A11D7.4040103@eaglescrag.net>
 <20110203174518.GA14871@sigill.intra.peff.net>
 <AANLkTi=qR5xYBg3NKRASuyatnEm1k3fVNc-i5VOwszpM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "J.H." <warthog19@eaglescrag.net>, Vincent Hanquez <tab@snarc.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 07:24:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlF5g-00027O-5q
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 07:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752026Ab1BDGQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 01:16:27 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:52617 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751712Ab1BDGQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 01:16:26 -0500
Received: (qmail 5711 invoked by uid 111); 4 Feb 2011 06:16:25 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 04 Feb 2011 06:16:25 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 04 Feb 2011 01:16:22 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=qR5xYBg3NKRASuyatnEm1k3fVNc-i5VOwszpM@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166023>

On Thu, Feb 03, 2011 at 10:34:38PM +0200, Felipe Contreras wrote:

> > Forget about a git-backed wiki for a moment, and imagine a regular old
> > Mediawiki. What are the operations you can perform? You can look at
> > the current or any past version of a page, you can do diffs between
> > versions of pages, and you can create a new version of a page. All
> > through some CGI forms.
> 
> Howe about these?

I've never really used a wiki in any in-depth way, so be gentle if my
utter cluelessness about these features shows through.

> 1) Support for discussion; since changes can be controversial.

Doesn't this just happen on special Talk: pages? Couldn't these just be
pages with special names?

> 2) Support for article move; so everything is kept organized.

Isn't that even simpler in a git-backed wiki? You just move the files.
Obviously you would want to update links, too, and presumably the wiki
software helps with that. But that is outside the scope of data storage.
In a git-backed wiki, you would get one atomic commit with the move and
link updating.

> 3) Support for "who is linking here". Also helps reorganization.

Again, is that a fundamental storage issue? It seems like you could
implement that easily on top of basic storage with a grep (and some
caching if you are going to let people do it a lot via the web).

> 4) Support for categories. Ditto.

I have no idea how categories work. Special page naming and/or
directories?

> 5) Support for watchlist, e-mail notifications. So that you are
> up-to-date with the changes.

Post-receive hook?

> 6) Support for contribution backtracking. So that it's easy to know who's who.

git log? git blame? :)

> 7) Personal wiki pages (with discussion). So you can put information
> about yourself, and general notes.

Specially named pages for people?


Obviously I'm just filling in these features off the top of my head.
MediaWiki is a mature system, and I doubt that either ikiwiki or gollum
has nearly the same featureset. But that was never my point. In the bit
you quoted, my point was that a git-interface to a wiki was useful and
feasible. And I stand by that.

Even with just the basic functionality of fetch/diff/push, that still
makes it a useful interface into an existing wiki for a large number of
users who just want to do simple stuff (or power users who happen to be
doing simple stuff at the moment).

I also happen to think you could put all of those features into a
git-backed wiki, and build the web features on _top_ of git access. But
I'm not volunteering to work on that.

-Peff
