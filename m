From: Jeff King <peff@peff.net>
Subject: Re: VCS comparison table
Date: Mon, 23 Oct 2006 16:06:48 -0400
Message-ID: <20061023200648.GB31068@coredump.intra.peff.net>
References: <45357CC3.4040507@utoronto.ca> <200610222206.13973.jnareb@gmail.com> <1161604564.22276.173.camel@zepto.home.zettazebra.com> <200610231454.06355.jnareb@gmail.com> <a7e835d40610230801m4ac92409gbddcf66dcd1bb429@mail.gmail.com> <453CF966.7000308@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Henstridge <james@jamesh.id.au>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com,
	"Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, Carl Worth <cworth@cworth.org>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 22:12:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc69g-0002bJ-Do
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 22:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWJWUMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 16:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965042AbWJWUMM
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 16:12:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:8381 "HELO
	peff.net") by vger.kernel.org with SMTP id S965032AbWJWUML (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 16:12:11 -0400
Received: (qmail 7189 invoked from network); 23 Oct 2006 16:05:53 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 23 Oct 2006 16:05:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Oct 2006 16:06:48 -0400
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <453CF966.7000308@utoronto.ca>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29872>

On Mon, Oct 23, 2006 at 01:18:30PM -0400, Aaron Bentley wrote:

> And, unlike git, Bazaar branches are all independent entities[1], and
[...]
> [1] The fact that they may share storage is not important to the model.

Sorry, I don't understand this statement. How are git branches not
independent? Sure, they tend to exist in repositories with other
branches, but there's no need to (it simply allows the sharing of object
storage). There's no reason I can't move any branch from any repo into
its own repo, or vice versa move any unrelated branch into a repo with
other branches.

It all Just Works because there _isn't_ any branch information. It's
simply a pointer into the DAG, so if I have the right parts of the DAG
(which git is careful to make sure of), I can just make a pointer, and I
have absolutely zero connection to wherever the DAG came from.

> they each have a URL.

In cogito, branches can each have a URL, but git-clone doesn't have a
way (that I know of) to clone only a subset of branches. It would be
fairly trivial to implement, I think.

> So:
> 
> http://code.aaronbentley.com/bzrrepo/bzr.ab 1695
> 
> is a name for
> 
> abentley@panoramicfeedback.com-20060927202832-9795d0528e311e31

The git analog is of course:

http://kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git v2.6.18

as a name for

e478bec0ba0a83a48a0f6982934b6de079e7e6b3

The difference being that Linus assigned the "local" name of v2.6.18
rather than having git auto-assign it.

> And it does not depend on any other branch, especially not bzr.dev

Of course. For me, the above commit is actually

  ssh://peff.net/home/peff/git/linux-2.6 v2.6.18

but once it is in my local repository, it's indistinguishable from one I
pulled directly from kernel.org.

And I wonder if THAT is at the root of this discussion. bzr isn't
"centralized" in the sense that you have to talk to a central server, or
rely on it for doing any operations.  But you actually CARE about where
your commits come from, and git fundamentally doesn't.

-Peff
