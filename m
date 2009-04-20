From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: What are branches?
Date: Mon, 20 Apr 2009 15:52:59 +0200
Message-ID: <49EC7E3B.9050909@drmicha.warpmail.net>
References: <alpine.DEB.1.00.0904191709220.10279@pacific.mpi-cbg.de> <20090420113216.GC25059@dpotapov.dyndns.org> <49EC6596.8060208@drmicha.warpmail.net> <20090420132414.GD25059@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 15:54:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvtxL-00015J-7L
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 15:54:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755396AbZDTNxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 09:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755385AbZDTNxJ
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 09:53:09 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:57552 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755301AbZDTNxI (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 09:53:08 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 3725D31E960;
	Mon, 20 Apr 2009 09:53:07 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Mon, 20 Apr 2009 09:53:07 -0400
X-Sasl-enc: gdZL8zUdGR9XU7r8/+B3OC2WwtzUQy4XFZvz5oCwfvX4 1240235586
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 55B43DD35;
	Mon, 20 Apr 2009 09:53:06 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090420 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090420132414.GD25059@dpotapov.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116985>

Dmitry Potapov venit, vidit, dixit 20.04.2009 15:24:
> On Mon, Apr 20, 2009 at 02:07:50PM +0200, Michael J Gruber wrote:
>> Dmitry Potapov venit, vidit, dixit 20.04.2009 13:32:
>>> On Sun, Apr 19, 2009 at 05:17:52PM +0200, Johannes Schindelin wrote:
>>>>
>>>> But it is important to keep in mind that our concept of branches is not 
>>>> intuitive:
>>>>
>>>> http://longair.net/blog/2009/04/16/git-fetch-and-merge/
>>>
>>> I don't see how our concept of branches is any different from what other
>>> version control systems have; but I see why it is so confusing for many
>>
>> It is very different, and for a good reason, indeed.
>>
>> git's branches really are moving tags. As such, there is no single
>> branch that a commit would be tied to. A commit does not belong to a
>> specific branch; you commit on a branch (usually), and it may be
>> contained in 1 or more branches, of course.
> 
> When you create a new commit, it is always belong to _one_ branch and
> never to two or more branches. After that you can create a child branch
> that will also contain this commit, but it is so in any other VCS.

There is nothing in a git commit that ties it to a specific branch; in
that sense, it does not "belong" to any.

A git branch is a pointer to a commit. That commit and its predecessors
are contained in the branch. A commit may be contained in multiple
branches, on equal footing: there is no "prime branch".

> 
> Perhaps, the only difference with some other VCSes can be that some VCS
> remember name on what branch the commit was initially created, but you
> can add that information to Git commit manually if you really want.

I don't want it. I want things the git way ;)

I just want to emphasize that the branch concept is really different.
Emphasizing that helps people who switch from other VCS to git.

In other VCS, a commit always belongs to exactly one branch: the one you
committed it to, which is stored in the commit. It may be contained in
multiple branches, but belongs to the one only.

> 
> But even better approach is to write the branch name only once when
> it is merged to the upstream, and Git does that by default. Have you
> seen a lot of merge commits like this:
> 
>    Merge branch 'bs/maint-1.6.0-tree-walk-prefix' into maint
>    ....
> 
> though the name of branch does not exist in the upstream repository,
> there is no problem to find all commits created on that branch. In fact,
> if Git stored those names in the upstream then Git repository would
> contain over 2,000 branches already and that number would be only grow.
> 
>>
>> This is fundamentally different from what is named "branch" in hg, e.g.
>> There, a commit stores the branch name, which is why you can't delete
>> branches easily. [For me, this is also why hg branches are useless, but
>> I don't want to start flames here - for me they are useless, for others
>> they may still be perfect.]
> 
> I don't see it as fundamentally different. Basically, Hg has some
> restriction that does not let you to remove branches that outlived their
> usefulness (and thus polluting name space), but the underlying structure
> is the same...

The underlying structure is the directed graph, with predecessorship
being the incidence relation. But what's being discussed here is the
various VCS concepts going by the name "branch" (the concept overlaying
the graph structure), and those are inherently different. Not being able
to delete a branch (without taking all its commits down) is one
consequence of a specific concept.

> 
>>
>> Branches in cvs etc. are much like the latter: You commit on a specific
>> branch, *and* you can't change that later. The branch name at time of
>> creating a commit is stored in the commit.
> 
> IIRC, it is not. CVS uses numbers which identify each branch. The name
> of branch can be changed later, but you cannot change the underlying ID.
> You can even remove the name, but branch will remain, and you can follow
> it if you know numbers. 

So, that ID is exactly equivalent to hg's branch name: stored in the
commit; just like svn's branches/paths if you follow a standard layout.

> Incidentally, you can always follow Git branch
> in similar way by using --first-parent option...
> 
>>
>> Hg is introducing "bookmarks" now, corresponding to git branches. I
>> think this name describes the nature of git branches very well.
> 
> Honestly, the first thing that comes to my mind when I hear bookmarks
> in relation to VCS is unannotated tags... The idea of self advancing
> bookmarks is really weird...

... but exactly what git's branches are, and what makes them so useful ;)

Michael
