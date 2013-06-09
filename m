From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 9 Jun 2013 13:55:54 -0400
Message-ID: <20130609175554.GA810@sigill.intra.peff.net>
References: <CACsJy8A-qc0tHcsp5=syxv_7FjixahU7fGcZuUV=cGn_-qyWwg@mail.gmail.com>
 <CAMP44s2fP4_=HtOsuwmxXG8qmp8CmpgEhz=BJFOFZxsTf_3gcQ@mail.gmail.com>
 <CACsJy8CQRWU0mFLVD6RrpzJiHBH=9zFwf5xDo7UhGW6A-OAzuw@mail.gmail.com>
 <CALkWK0mLoeO5fKezE5S1LEC2LNH9qCwxHnNi_ZJpYzC7rVTqmg@mail.gmail.com>
 <CACsJy8B=m95mpRn1dAwQZAvHRUeJVjKy1hKXv43EKX08ZODsDw@mail.gmail.com>
 <CALkWK0mw8=CMuyw5-E0fzh+c6Om_NCgHohqa_p=J_kw3UfJCJQ@mail.gmail.com>
 <CACsJy8AtH6PQ06_-UgumV0dRdq28qKn-Oj7EAy3g+eOTGhOyYw@mail.gmail.com>
 <CAMP44s2uV6CwdyadnJXSd+3mhOdApDxqdtjNyOPj3CbdsEyG0Q@mail.gmail.com>
 <20130609043444.GA561@sigill.intra.peff.net>
 <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <drafnel@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 19:56:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UljqV-0005rn-1H
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 19:56:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751737Ab3FIRz7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 13:55:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:37098 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751717Ab3FIRz6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 13:55:58 -0400
Received: (qmail 17532 invoked by uid 102); 9 Jun 2013 17:56:47 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 09 Jun 2013 12:56:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 09 Jun 2013 13:55:54 -0400
Content-Disposition: inline
In-Reply-To: <CALkWK0kkGO8zoLSpZkaYgVr5eBX6AovYFxQZkgJKugSw0CmdXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227056>

On Sun, Jun 09, 2013 at 03:28:48PM +0530, Ramkumar Ramachandra wrote:

> Jeff King wrote:
> > Sorry that I cannot show you the source code, but you may interested to
> > know that libgit2 powers:
> 
> Yes, I'm well aware of these: libgit2 is LGPL, because of which these
> three proprietary applications have been made possible.  Isn't it
> completely orthogonal to the discussion about how best to lib'ify
> git.git though?  From what I understand, fc is not interested in
> building another application leveraging libgit.a or libgit2; he's
> interested in improving libgit.a and getting more users.

Perhaps I misunderstood the discussion, but it looked to me that there
was an assertion that libgit2 was not ready for useful work. I do not
think that is true, and I tried to counter it with facts.

If that was not useful to the discussion, I apologize for leading it
astray.

> > It is definitely not feature-complete when compared with git.git. But I
> > do think it is in a state that is usable for quite a few tasks.
> 
> What is this task you are discussing?

You snipped the part of Felipe's message that I quoted:

  Let the code speak. Show me a script in any language that does
  something useful using libgit2, doing the equivalent to at least a
  couple of 'git foo' commands.

I meant tasks that were "equivalent to at least a couple of 'git foo'
commands" as performed by the programs I mentioned. Like cloning,
checkout, commit, revision traversal, diffs, etc.

> fc is talking about improving libgit.a and getting an official git
> library with many users. Answer the question: what should we do now?

I do not think I was addressing that point at all in my email. But since
you ask...

> 1. Start moving irrelevant code out of libgit.a, and use inspiration
> from libgit2 to improve it (this might or might not involve taking
> code from libgit2).  Get _users_ of libgit.a via ruby bindings (or
> something) asap, so it puts pressure on fixing it.

I already mentioned elsewhere that I think it would be fine to massage
libgit.a in that direction. I even joined the conversation pointing out
some cases where Felipe's ruby module would break. But I do not think
that moving code in and out of libgit.a is an important first step at
all. That is simply code that no library users would want to call, and
is easy to deal with: move it out. The hard part is code that users
_would_ want to call, and is totally broken. Patches dealing with that
are the hard obstacle that people working in this direction would need
to overcome. But I do not see any such patches under discussion.

> 2. Wait indefinitely until libgit2.git magically becomes ready to be
> usable by git.git as-is.  Then throw libgit.a out the window, and
> rewrite git.git to call into libgit2.a instead [*1*].

I think the "magically" here could be "work on libgit2 to move it
towards being useful for git.git". I also do not think there needs to be
a "throw out libgit.a" flag day. We can make a decision later to start
adopting bits of libgit2 inside git.git (the big downside being an
increased dependency).

Maybe the code style will diverge too much and it will never be
appropriate to do so. We'll have to see.

> What you seem to be saying is "3. Work on libgit2 (and abandon
> git.git?)" [*2*], or worse: 2.

I didn't say that at all. If the two projects co-exist forever, working
compatibly on the same repositories, and git.git is the command line and
libgit2 is the library, I do not see that as the end of the world. The
downside there is is code duplication, which is why it may eventually
make sense for libgit.a to start adopting bits of libgit2 (it is usually
hard to go the other way, both for licensing reasons, and for the fact
that the library code tends to be more reusable).

> fc is in favor of 1.  Unless you are
> in favor of _not_ improving libgit.a, don't stand in his way:

I'm not. I tried to give pointers on the path that I think would be
useful (e.g., what would break with his ruby patch).

> *1* You have dismissed 1 as being unworkable, but do you realize how
> unrealistic this sounds?

I don't think I dismissed it as unworkable. I said it was a lot of work,
tried to describe some examples, and said that I think the other route
may be _less_ work.

> *2* git.git has _far_ more users and a _lot_ more contributors.  Don't
> be unwelcoming to contributors by asking them to go away and work on
> something else.  The three proprietary applications you have given as
> counter-examples (?) is not helping anyone.

They were counter-examples to the point "libgit2 is not ready for real
work", which I thought was being made. If that was not the point being
made, then no, they are not helping anyone.

-Peff
