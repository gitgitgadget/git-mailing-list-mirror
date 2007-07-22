From: david@lang.hm
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 23:38:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707212332530.6350@asgard.lang.hm>
References: <85lkdezi08.fsf@lola.goethe.zz>
 <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
 <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
 <851wf2bcqy.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<alpine.LFD.0.99?=
 =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
 =?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
 <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
 <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
 <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
 <85644dqoig.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211737090.3607@woody.linux-foundation.org>
 <85r6n1p7sb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211840000.3607@woody.linux-foundation.org>
 <85fy3hp3f2.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707212040340.3607@woody.linux-foundation.org>
 <85abtpoydg.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 08:39:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICV6R-0003at-KF
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 08:39:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbXGVGjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 02:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752576AbXGVGjg
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 02:39:36 -0400
Received: from dsl081-033-126.lax1.dsl.speakeasy.net ([64.81.33.126]:57844
	"EHLO bifrost.lang.hm" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751675AbXGVGjf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Jul 2007 02:39:35 -0400
Received: from asgard (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id l6M6dIhe014141;
	Sat, 21 Jul 2007 23:39:18 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <85abtpoydg.fsf@lola.goethe.zz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53223>

On Sun, 22 Jul 2007, David Kastrup wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> On Sun, 22 Jul 2007, David Kastrup wrote:
>>>
>>> "." _is_ visible and detectable in every tree.
>>
>> I'm going to add you to my "clueless" filter, because it's not worth
>> my time to answr you any more.
>
> Too bad I can't do the same.
>
>> I told you. Several times. That "." is pointless exactly because
>> it's in _every_ tree, and as such is no longer "content".
>
> "." is in every _non-empty_ directory tree.  But we are talking about
> permitting _empty_ trees in the repository.  And for an empty tree in
> the repository, "." may or may not be in the corresponding work
> directory tree, depending on whether the directory exists or not.  So
> when we are talking about a repository tree _becoming_ empty, we need
> the information whether or whether not we should remove it upon
> becoming empty.  _That_ is the information content of "." being or not
> being considered part of the trackable material.  And the information
> is no longer available at the time the repository tree becomes empty
> _unless_ we already store it there when the tree is still populated.

David, the point where you and Linus are talking past each other is that 
Linus is assuming that you only want to track some specific directories, 
and for that tracking "." doesn't work becouse it's in every directory

you apparently consider every directory equal and therefor the fact that 
"." exists in every directory doesn't bother you becouse you want to track 
every directory.

what you are not hearing is that while Linus and the other git developers 
can see reasons to track directories sometimes, they definantly don't 
agree that you want to track directories all the time.

sometimes the fact that a directory exists is significant, most of the 
time it's not. and the difference between what is and what isn't 
significant isn't a per-repository or per-project thing, it's a 
per-directory thing.

in one repository you will have some directories that only exist becouse 
files are in them, and you may have some directories that exist becouse 
you explicitly want them to exist.

both types have the "." file in them (or appear to, some OS's/filesystems 
don't actually have a "." on disk, they add it when needed when reporting 
to userspace), so git has no way to tell which ones you explicitly want 
tracked.

creating .gitignore in the directories that you want tracked lets the 
other directories not be trackes.

David Lang

>> It's not something that the user can care about, because it has no
>> meaning. There's no point in tracking it, because even if we do
>> *not* track it, it's there, and we cannot do anything about it.
>
> Ok, here we go _again_.  Test case 1:
>
> mkdir a
> touch a/b
> git-add a/b
> git-commit -m x
> git-rm a/b
> git-commit -m x
>
> Now we want to have the directory a _removed_.
>
> Test case 2:
>
> mkdir a
> touch a/b
> git-add a
> git-commit -m x
> git-rm a/b
> git-commit -m x
>
> Now we want to have the directory a _retained_.
>
> After the first commit in _both_ test cases, the only file in the
> trees / and /a is a/b.  The working directory state is _identical_ at
> this point, and we do identical commands afterwards.
>
> The end result is not identical, so there must be some information
> different in the repository after the first commit.  This information
> _can't_ be encoded in a remaining empty tree, because both the trees /
> and /a are _non_-empty yet.
>
> So we _must_ encode the evaporate-or-not-when-empty information
> _otherwise_ into the repository.  And we do that by _not_ having
> /a/. in the set of tracked files in test case 1, and by _having_ it in
> the set of tracked files in test case 2.
>
>> That was the whole difference between "." and ".gitignore", and I
>> explicitly pointed out that that was the difference (and the _only_
>> one), and why it mattered.
>
> You are underestimating the power of ".gitignore": while it is true
> that its _physical_ presence will reliably keep git from removing the
> directory, its physical presence is not _actually_ required.
>
> It is sufficient that git _believes_ in its continuing physical
> existence.  And if we tell it "it is still there" whenever it takes a
> look, then git will keep the record of .gitignore in its tree, and
> consequently won't remove the tree and not try deleting the directory.
> However, once we explicitly tell it "remove the record of .gitignore
> from the repository", it will do so, and in the course of doing so
> remove the directory in the work directory together with the tree in
> the repository.
>
> From a user interface and logical standpoint, adding or not adding "."
> to the tracked content is a perfectly consistent and convenient way of
> having the directory kept around or not.
>
> From the viewpoint of the internal data structures, I'll likely go
> with tampering with (pseudo-)permissions.
>
>> And you didn't listen. And now you claim that I don't read your
>> emails. I do. They just don't make any sense.
>>
>> Consider this discussion ended. I simply don't care any more.
>
> It is painfully clear that I could invest a few weeks of time in
> coding better than in explaining stuff.  And I guess that's what I'll
> have to do.  And afterwards it will be your job to wrack your head
> about why something does all the right things for the wrong reasons
> and come up with a different explanation how and why the code works.
>
>
