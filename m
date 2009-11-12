From: Raman Gupta <rocketraman@fastmail.fm>
Subject: Re: [PATCHv2] Update gitworkflows man page to include release workflow
Date: Wed, 11 Nov 2009 19:32:35 -0500
Message-ID: <4AFB57A3.2020002@fastmail.fm>
References: <1257869339-15999-1-git-send-email-rocketraman@fastmail.fm> <1257869339-15999-2-git-send-email-rocketraman@fastmail.fm> <7vzl6soniu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 12 01:33:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8NcV-0006OA-W0
	for gcvg-git-2@lo.gmane.org; Thu, 12 Nov 2009 01:33:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759855AbZKLAco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 19:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759851AbZKLAco
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 19:32:44 -0500
Received: from smtp117.rog.mail.re2.yahoo.com ([68.142.225.233]:42281 "HELO
	smtp117.rog.mail.re2.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1759831AbZKLAcn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Nov 2009 19:32:43 -0500
Received: (qmail 67322 invoked from network); 12 Nov 2009 00:32:47 -0000
Received: from CPE000db9166236-CM00186845d2ae.cpe.net.cable.rogers.com (rocketraman@99.224.155.40 with login)
        by smtp117.rog.mail.re2.yahoo.com with SMTP; 11 Nov 2009 16:32:47 -0800 PST
X-Yahoo-SMTP: 5CKRlKeswBAtrcX.EVB04BFKSgZiN0yKOK0iylIm064Zdzo-
X-YMail-OSG: mySMMWUVM1nTKwX8ihTtIDnhA5RgPRXzfZR4l3JZIFw4UsboH_0UWa3zOnOpEh3knw--
X-Yahoo-Newman-Property: ymail-3
Received: from localhost (localhost.localdomain [127.0.0.1])
	by apollo.rocketraman.com (Postfix) with ESMTP id B6FCF21C05CC;
	Wed, 11 Nov 2009 19:32:46 -0500 (EST)
X-Virus-Scanned: amavisd-new at rocketraman.com
Received: from apollo.rocketraman.com ([127.0.0.1])
	by localhost (apollo.rocketraman.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o3g-7+3HZO6w; Wed, 11 Nov 2009 19:32:35 -0500 (EST)
Received: from [192.168.1.5] (zeus.rocketraman.com [192.168.1.5])
	by apollo.rocketraman.com (Postfix) with ESMTP id 3EEDB21C058C;
	Wed, 11 Nov 2009 19:32:35 -0500 (EST)
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <7vzl6soniu.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 0.95.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132731>

Thanks for your review. Comments inline.

Junio C Hamano wrote:
> rocketraman@fastmail.fm writes:
> 
>> From: Raman Gupta <raman@rocketraman.com>
>>
>> The gitworkflows man page currently provides an overview of the workflows
>> used by git.git itself to serve as inspiration for people to use when
>> designing their own workflows. The current man page does a reasonable
>> job at describing the development process, but it does not contain any
>> guidance as to the workflow used for releases. Now add a basic
>> introduction to the branch management required for a release, so that a
>> reader may understand how the maint, master, next, and topic branches are
>> affected.
>> ---
> 
> Is this meant to show how git.git does its release to serve as an
> inspiration to others?  The document does not seem to describe how I make
> releases.

Here is the existing intro to gitworkflows:

===================
This document attempts to write down and motivate some of the workflow
elements used for git.git itself. Many ideas apply in general, though
the full workflow is rarely required for smaller projects with fewer
people involved.

We formulate a set of rules for quick reference, while the prose tries
to motivate each of them. Do not always take them literally; you
should value good reasons for your actions higher than manpages such
as this one.
===================

It is in this spirit that I am attempting to add to this document in
relation to the release process. If after you read through this email
you don't agree this patch has any value in gitworkflows, let me know
so that I can stop wasting my time and yours.

>> diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
>> index 2b021e3..69b789a 100644
>> --- a/Documentation/gitworkflows.txt
>> +++ b/Documentation/gitworkflows.txt
>> @@ -348,6 +348,103 @@ in patches to figure out the merge base.  See linkgit:git-am[1] for
>>  other options.
>>  
>>  
>> +RELEASE WORKFLOW
>> +----------------
>> +
>> +The maintainer may use the following release workflow:
> 
> Please set the tone straight.  If this is to suggest various possible
> workflows in general vague terms, "may use" would be good.  If this is to
> precisely describe what I do, then there won't be "you could do this, or
> you could do that."  Your "may use" suggests the former, but the commit
> log message claims the latter.  Which document are you writing?

Ok. The current document is inconsistent. In places it uses "the
maintainer" and in other places it uses "you". In any case, it seems
that the "maintainer" here is not "Junio Hamano" -- rather, it is the
reader.

Let me create a separate (and first) cleanup patch to fix the existing
inconsistencies in this man page. I would prefer to use the pronoun
"you" consistently as also suggested by Thomas Rast.

In addition, I will update the commit log message to be consistent.

>
> Assuming that you are writing what I do...
>
>> +He first tags the tip of 'master' with a release tag, then he updates
>> +the 'maint' branch to the current tip of 'master' for managing future
>> +maintenance fixes on the current release, and lastly he optionally
>> +rebuilds 'next' from the tip of 'master'.
> 
> Not in that order.

Ok, I'll work on the order.

> 	- doubly make sure that there is nothing left in 'maint' that
> 	  is not in 'master';
> 	- review 'master' more thoroughly than usual;

As per the intro to the man page, I think you will agree these items
are not required. They follow under the category of the user thinking
about what they are doing -- the man page is not meant to provide the
user with a "monkey-see, monkey-do" series of steps.

> 	- review RelNotes symlink, Documentation/RelNotes-X.Y.Z.txt,
>           the stalenotes section in Documentation/git.git, and
>           GIT-VERSION-GEN for the last time;
>         - tag it;
>         - review it again for the last time;
> 	- test on buildfarm;
> 	- cut tarball;
>         - cut RPM on FC11 i386 and FC11 x86_64;

I will update the commit log message to show that my intent was to
talk about how the git.git integration and topic branches are affected
by the release rather than providing a complete project release
process. General items like release notes, version files, reviews,
tests, and cutting distribution tarballs are not specific to git.git
nor git. For git.git, these items better belong in MaintNotes and the
release checklist.txt (as they do) rather than this user distributed
man page.

>         - push the tag and master branch alone to the public server---this
>           triggers an autobuilder for documentation pages, updates man and
>           html branches and documentation tarballs;

I think it makes sense to include some verbiage around the push
aspect, as it is part of the distributed nature of git. I'll add this.
The autobuilder is not git specific so should be excluded via the
logic above -- except perhaps the hook part, which I could mention in
general terms when discussing the push e.g.

"You may decide to use a hook script on the public repository to
initiate release-related items such as building documentation."

> When making a maintenance release, everything is the same except that
> 'maint' is used instead of 'master'.

Good point -- I will add a section about maintenance releases.

> Then, after all the release task on 'master' (or 'maint') is done,
> propagate that upwards (i.e. merge 'master' to 'next' and 'pu').

Will add this.

> Merging 'master' to 'maint' is done totally as a separate step, often a
> few days later, "Now the big release is done, let's start maintenance
> track for that relase".
> 
> And then after that, 'next' may be rebuilt.

Ok, I'll change the order/wording accordingly.

>> +Release Tagging
>> +~~~~~~~~~~~~~~~
>> +
>> +The new feature release is tagged on 'master' with a tag matching
>> +vX.Y.Z, where X.Y.Z is the new feature release version.
>> +
>> +.Release tagging
>> +[caption="Recipe: "]
>> +=====================================
>> +`git tag -s -m "GIT X.Y.Z" vX.Y.Z master`
>> +=====================================
> 
> There is no incorrect information here, but I do not think there is
> anything particularly worth saying here, either.  It is in "git tag"
> manpage and anybody can run "git cat-file tag v1.6.3" to learn what is in
> there.

The intention of this is not to illustrate the "git tag" syntax but
rather so that the user understands the tag description and naming
conventions used by git.git -- this prompts them mentally to consider
defining conventions for their project. Therefore, I'd like to keep this.

>> +Maintenance branch update
>> +~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> This section largely overlaps with Documentation/howto/maintain-git.txt; I
> am starting to doubt if we even need a new section in the workflows
> document.  Perhaps we could have a release management section in the
> Documentation/howto/maintain-git.txt, though.

Based on my comments and changes above, do you still have this doubt?
 Remember that the audience of a man page is not the git team -- it is
users. A new user to git who is considering developing branch
processes and conventions around their git project will have access to
a man page such as gitworkflows but will not have (easy) access to
maintain-git.txt.

This is in fact why I decided to make this patch submission -- I found
gitworkflows to be very helpful in creating a layout for my git
projects, but found that gitworkflows was missing any guidance as to
what to do with my integration and topic branches when I needed to cut
a release. It was a while before I found maintain-git.txt, and most
users will never find it.

>> +[caption="Recipe: "]
>> +=====================================
>> +* `git checkout maint`
>> +* `git merge master`
>> +=====================================
>> +
>> +This updates 'maint' from 'master', while preserving the 'maint'
>> +reflog.
>> +
>> +An alternative approach to updating the 'maint' branch is to run
>> +
>> +  $ git branch -f maint master
> 
> As I already said, I never do this "alternative", and I do not want
> anybody who will take over git.git maintenance to do so.  There is no
> reason to encourage nor even mention "branch -f" here.  As 'maint' is
> supposed to be a strict subset, pulling 'master' to 'maint' should fast
> forward and otherwise you (the maintainer) would notice that there was a
> mistake made.  If you use "branch -f", you will never notice.

I know you do not do this alternative, however I added it as per our
previous discussion. I quote from
http://article.gmane.org/gmane.comp.version-control.git/115183:

>> I'll add some discussion about the branch -f bit -- I hope you agree
>> that in this document that is distributed with git, some
>> beginner-level explanation of the difference between the branch -f and
>> the merge approach is warranted?
> 
> Surely and thanks.

I will try to make the reason why "branch -f" is not a good option
more clear. I'd like to keep this because many newbies coming from VCs
like subversion will default to taking the "branch -f" approach
because that is conceptually closer to the way subversion works (I
know I did).

Thanks for your comments.

Cheers,
Raman
