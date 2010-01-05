From: Junio C Hamano <gitster@pobox.com>
Subject: Re: submodules' shortcomings, was Re: RFC: display dirty submodule
 working directory in git gui and gitk
Date: Tue, 05 Jan 2010 01:33:51 -0800
Message-ID: <7v1vi428w0.fsf@alter.siamese.dyndns.org>
References: <4B3F6742.6060402@web.de>
 <alpine.DEB.1.00.1001041038520.4985@pacific.mpi-cbg.de>
 <4B421F90.4090402@web.de>
 <alpine.DEB.1.00.1001042217370.4985@pacific.mpi-cbg.de>
 <4B42F425.4010901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Paul Mackerras <paulus@samba.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Lars Hjemli <hjemli@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Jan 05 10:34:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS5nx-0001Tl-1N
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 10:34:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753479Ab0AEJeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 04:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753435Ab0AEJeQ
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 04:34:16 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752923Ab0AEJeN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 04:34:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1EFC98EA98;
	Tue,  5 Jan 2010 04:34:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=St/EjRxMjqMzx5KP2WJD0fgr+z4=; b=GVbkmK
	1VNtFnXDzN2YL6MGb6Q++2o8j2R4pkzY6YJ0oi6INiqyVPbkhWs5cG4//YASJzgP
	GxGqeIcCK8C3heqjJUL+3o1EnFHnarYdGh87MtZWNTO5IbLXn7aVOQ/keZDIk90W
	ObprEPg8bWHwynbtJiB7GrlQ9cK86N6PEWkUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iun9vM7BeITeTFQNR8gf2hs/AV9hMw4m
	dbySbN4hbnFabW3E3YIWBrxDC3YEuche9nT8YAMBA3Cw5xf78/y6Fp/haxmurgBb
	58Xppge9iznNRA28QBEHY4bOOeylPbbmaHlvqh1v9BObR4K+i8gMXGbZNhbq8bMp
	AXh1AR8uz3M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 80B948EA96;
	Tue,  5 Jan 2010 04:34:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEE8E8EA94; Tue,  5 Jan
 2010 04:33:52 -0500 (EST)
In-Reply-To: <4B42F425.4010901@web.de> (Jens Lehmann's message of "Tue\, 05
 Jan 2010 09\:11\:17 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 75AA684C-F9DD-11DE-8D2D-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136178>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 04.01.2010 23:29, schrieb Johannes Schindelin:
> ...
>> - submodules were designed with a strong emphasis on not being forced to 
>>   check them out.  But Git makes it very unconvenient to actually check 
>>   submodules out, let alone check them out at clone-time.  And it is 
>>   outright impossible to _enforce_ a submodule to be checked out.
>
> Absolutely. But i think the group mappings discussed by Junio and Heiko
> are a good starting point to solve that problem:
> http://thread.gmane.org/gmane.comp.version-control.git/130928/
>
> This should be solvable by putting the necessary information into
> .gitmodules and have git clone use it.

I sense there is a chicken and egg problem, but I'll let it pass for now.

>> - among other use cases, submodules are recommended for sharing content 
>>   between two different repositories. But it is part of the design that it 
>>   is _very_ easy to forget to commit, or push the changes in the submodule 
>>   that are required for the integrity of the superproject.
>
> Definitely (and if i got that right, svn externals have the same problem).
>
> What about checking for every submodule before a push in the superproject
> that its HEAD is on a remote branch? I don't think we can provide full
> safety here, but we could handle the 99% case of a forgotten push in the
> submodule. This could even be done with a rather simple hook (if we had a
> pre-push hook that is :-).

You don't need "pre-push" hook, if the eventual goal is to integrate this
into "git push" proper; it can notice submodule directories, descending
into them, check if the remote lacks the necessary commit and invoke "git
push" via run_command() interface as needed.

>> - related are the use cases where it is desired not to have a fixed 
>>   submodule tip committed to the superproject, but always to update to the 
>>   current, say, master (like Subversion's externals).  This use case has 
>>   been wished away by the people who implemented submodules in Git.  But 
>>   reality has this nasty habit of ignoring your wishes, does it not?
>
> Having read up about svn externals in the meantime, what about something
> like this:
> - Add a command like "git submodule forward" (as update is already in
>   use) that takes an optional -b <branchname>. It does a fetch in the
>   submodule, then tries to fast forward (or rebase) to master or the
>   branch given and stages this commit in the superproject. This should
>   be the equivalent to doing an "svn update" in a repo with externals.
>   Or am i missing something?
>   (And we could avoid the detached HEAD in the fast forward case by
>   really checking out the branch in the submodule)
> - We could also add an option to "git submodule add" to specify the
>   default branch name for forward.

Instead of recording a specific submodule commit in the superproject, we
could record a branch name (this would need a separate "gitlink" type of
object we toyed around during the early days of submodule design) to say
"the tip of the branch".

But there is a difference between a distributed system and a centralized
one like Subversion.  When you say "tip of the branch", you have to say
"which repository".  If your position is that _any_ repository will do as
long as the commit is at the tip of the named branch, that is like saying
you don't care what commit it really is, as you are free to muck with
branch heads in your copy of submodule repository, by adding commits, or
resetting new ones away.  For that matter, your 'master' branch in the
submodule repository may not build-on/fork-from the 'master' branch in the
upstream of it, so even "tip of the branch by _this name_" is still fuzzy.

I am not saying "any commit will do" is necessarily a bad position to
take.  But people who claim they want to say "this branch" need to realize
what they are really saying: whatever you record in the superproject
commit is immaterial.  In other words, "this superproject will work no
matter which version of submodule is checked out at its location".

Thatv actually is a very valid thing to say in some situations (Dscho
mentioned different versions of artwork checked out as a submodule in a
developer's superproject to build an app).  Interestingly enough, some
people seem to think that we place too much importance on not having to
check out submodules, but it indeed is a very natural extention of "any
commit will do".  If the configuration you chose for your build does not
depend on any files from there, it will truly be "any commit will do",
including "nothing checked out there is just fine".

So it is not necessarily a bad thing if the commit checked out in the
submodule repository is different from what the superproject records in
its index when a commit is made in the superproject.  We allow committing
with local changes in regular files, while we do notify the users about
them to avoid mistakes.  We should give the same kind of notification
about submodules, but the "local changes" need to be thought out more
carefully than plain files in the superproject itself.  Does uncommitted
changes in the index of submodule repository count?  Local changes in the
work tree files?  What about untracked files that the user might have
forgot to add?  Should they be warned?  What about the commit in the
submodule repository being a non-descendant of the commit recorded in the
HEAD of the superproject's tree, resulting in a non-ff change at the
submodule level?

What this also means is that it is important to

 (1) be able to simply be a user of the submodule (in such a scenario, the
     developer who uses artwork from designer's repository does _not_ want
     to commit the submodule, but he does want to have a recent checkout
     of it, and he might even make some tweaks); and

 (2) being able to commit the state of the superproject, even if there is
     a mismatch between the submodule commit recorded in the superproject
     and the actual version that is checked into the authoritative
     submodule project by the designer (perhaps he hasn't pulled in the
     submodule while traveling).

In other words, even if the default is made to "always clone and checkout
all the submodules, and before allowing anything be done in the higher
levels of superprojects, submodules must be made in sync with their
latest", there has to be a way to override such a rigid constraints for
the resulting system to be usable.

> I think in the long run to make submodules first class citizens the
> following submodule commands must be obsoleted by their regular git
> parts: init (by git clone), status (by git status), update (by git
> checkout), summary (already in git diff thanks to your patch) and sync
> (maybe Avery's idea of only relying on .gitmodules and not copying data
> int .git/config would solve this).

I think "clone" has a chicken-and-egg problem.  If all of your project
participant are expected to check out all the submodules, are expected to
make commits in all of them, and essentially have to track everything in
sync, then "clone" can obviously do that without asking what kind of
participant you are [*1*].  Otherwise, you need to have some mechanism
(e.g. "group mapping" you mentioned earlier) for the user to specify "I am
interested in these submodules" before the actual sub-clones to happen,
but until you clone the superproject that has some description for that
mechanism to use, and the user to see what's available, you cannot say
what kind of participant you are.  It has to become two-step process;
either "clone" going interactive in the middle, or you let the clone to
happen and then "submodule init" to express that information.


[Footnote]

*1* of course, in such a scenario you have to question what you are using
submodules for.
