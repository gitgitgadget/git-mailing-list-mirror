From: Sergey Organov <sorganov@gmail.com>
Subject: Re: git rebase: yet another newbie quest.
Date: Mon, 08 Sep 2014 23:49:25 +0400
Message-ID: <87egvlzyd6.fsf@osv.gnss.ru>
References: <87a96ecqe9.fsf@osv.gnss.ru> <20140905154159.GB1510@thunk.org>
	<87sik28bir.fsf@osv.gnss.ru> <20140908140758.GI1066@thunk.org>
	<87fvg23yhx.fsf@osv.gnss.ru> <20140908173251.GA24855@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Sep 08 21:49:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR4wV-0003eY-64
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 21:49:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753171AbaIHTt3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 15:49:29 -0400
Received: from mail.javad.com ([54.86.164.124]:33874 "EHLO mail.javad.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752665AbaIHTt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 15:49:28 -0400
Received: from osv.gnss.ru (unknown [89.175.180.246])
	by mail.javad.com (Postfix) with ESMTPSA id 4D38D615BB;
	Mon,  8 Sep 2014 19:49:27 +0000 (UTC)
Received: from osv by osv.gnss.ru with local (Exim 4.72)
	(envelope-from <sorganov@gmail.com>)
	id 1XR4wH-0001K1-Hk; Mon, 08 Sep 2014 23:49:25 +0400
In-Reply-To: <20140908173251.GA24855@thunk.org> (Theodore Ts'o's message of
	"Mon, 8 Sep 2014 13:32:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256672>

Theodore Ts'o <tytso@mit.edu> writes:

> On Mon, Sep 08, 2014 at 07:47:38PM +0400, Sergey Organov wrote:
>> 
>> except that I wanted to configure upstream as well for the topic-branch,
>> that looks like pretty legit desire. If I didn't, I'd need to specify
>> upstream explicitly in the "git rebase", and I'd not notice the problem
>> at all, as the actual problem is that "git rebase" and "git rebase
>> <upstream>" work differently!
>
> Right, so I never do that.  I have master track origin/master, where
> it automagically does the right thing, but I'm not even sure I can
> articulate what it *means* to have topic also track origin/master.

You got it somewhat wrong. I intended 'topic' to track 'master', not
'origin/master'.

> I just don't have a mental model for it, and so it falls in the category
> of "it's too complicated for my simple brain to figure out".

I thought it's rather common for one local branch to track another in
the git world. At least all machinery is there, and I don't see how
tracking local branch is different from tracking remote branch,
fundamentally.

> So I just do "git rebase master", and I would never even *consider*
> doing a "git pull --rebase".  I'll do a "git fetch", and then look at
> what just landed, and and then checkout master, update it to
> origin/master, and then run the regression tests to make sure what
> just came in from outside actually was *sane*, and only then would I
> do a "git checkout topic; git rebase master", and then re-run the
> regression tests a third time.

Yeah, and I simply wanted to shorten it to "git checkout topic; git
rebase", by making git remember I want to rebase w.r.t. 'master' by
default. 

> Otherwise, how would I know whether the regression came in from
> origin/master, or from my topic branch, or from the result of rebasing
> the topic branch on top of origin/master?

As far as I can see, what I did is almost exactly what you do, except I
didn't want to tell "master" every time I want to rebase 'topic' branch.
Configuring tracking branch and saying just "git rebase" when you are on
the branch seems to be logical, and there doesn't seem to be anything
wrong with it (except strange git default behavior), or does it?

> And of course, this goes back to my observation that I don't rebase my
> topic branchs all that often anyway, just because the moment you do
> the rebase, you've invalidated all of the testing that you've done to
> date.  In fact, some upstreams will tell explicitly tell you to never
> rebase a topic branch before you ask them to pull it in, unless you
> need to handle some non-trivial merge conflict.

That's good advice indeed, but it's unrelated to the issue at hand, as you
still rebase, sooner or later.

-- 
Sergey.
