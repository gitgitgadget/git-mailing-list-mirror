From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Documentation: A few minor fixes to Git User's Manual
Date: Wed, 4 Apr 2007 20:31:41 +0200
Message-ID: <200704042031.41475.jnareb@gmail.com>
References: <11756176481314-git-send-email-jnareb@gmail.com> <7vlkh9xotn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@fieldses.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 05 01:14:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZEgY-0002vs-On
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 01:14:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbXDDXOe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Apr 2007 19:14:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752791AbXDDXOe
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Apr 2007 19:14:34 -0400
Received: from mu-out-0910.google.com ([209.85.134.186]:3707 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbXDDXOc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Apr 2007 19:14:32 -0400
Received: by mu-out-0910.google.com with SMTP id g7so527378muf
        for <git@vger.kernel.org>; Wed, 04 Apr 2007 16:14:30 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Q6tKp6odGtQNp7pFCSy5lbvba87K2e444nNZ17FDs2KiwYFpIM9dXLg9VKwMb8fM2pKPjH9ge5lfCt/XWz2lRKAGTOhnvhrVUo3u+C6QGZDI6r1K0GvkP2gHvSqk8TXu+FRyiaUOgFEdnvKYB34ul5Td9VquU3SSstYiEyf7OfE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=kME/OJhsian3a1M3Ky68cUPrTjcxBP5bsjHr6C8Bifj75nqJ/fDUFsfJFC9sVp0l8t+MY/GH0Ox+pcO3tOUV1PjBpE4rxU6ZJIGnQJL3B24B71fwr6WjQW/P89W5vJqdtbN987mwHt9Rzqq9Xc5VZoQoxxtmdSWhUQqr5uNvNgc=
Received: by 10.82.178.11 with SMTP id a11mr1723876buf.1175728470445;
        Wed, 04 Apr 2007 16:14:30 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id w5sm2670402mue.2007.04.04.16.14.28;
        Wed, 04 Apr 2007 16:14:29 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7vlkh9xotn.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43787>

On Thu, Apr 03, 2007, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
>> * no "detached head" feature (since 1.5.0.5 at least)
> 
> That is a 1.5.0 feature.
> 
> Care to volunteer to write that section?

I'd rather not write about somthing I don't personally use.
But I can add one sentence mentioning detached head as an
alternative to "checkout -b tmp", "reset --hard" for sightseeing.
See also below.
 
>                                          I think illustrating 
> what you would want to achieve by detaching your HEAD would be
> useful, and I offhand know of two different uses:
> 
>  - Sightseeing.  You do not intend to build on, but seek around
>    to see what was there in the past.  Checking out a tag or a
>    remote branch falls into this.
> 
>  - Rebuilding history.  When you want to futz with a commit 5
>    revs ago, you would detach your HEAD to that commit, fix it
>    up, and rebase the original branch on top of that detached
>    HEAD.
> 
> I am sure people may have invented more creative ways to use it.
> The topic probably belongs to "advanced user's manual", though.

If I remember correctly I have added this note because of using
"git checkout -b new remotes/branch" (or tag) together with
"git reset --hard tag" for sight-seeing.
 
>> * uses ssh://host/path syntax instead of scp-like host:path
>>   (which one is preferred? documentation has URL-like first)
> 
> My impression is that site:path is preferred.

So perhaps we should use this syntax in Git User's Manual?
 
>> * no mention of receive.denyNonFastForwards (in about push)
> 
> I think the "Setting up a shared repository" section refers most
> of the material to cvs-migration.txt, so you probably want to
> add a sentence to "Advanced Shared Repository Management"
> section in the latter.

I was referring to the following fragment:

  As with git-fetch, git-push will complain if this does not result in
  a <<fast-forwards,fast forward>>.  Normally this is a sign of
  something wrong.  However, if you are sure you know what you're
  doing, you may force git-push to perform the update anyway by
  proceeding the branch name by a plus sign:

  -------------------------------------------------
  $ git push ssh://yourserver.com/~you/proj.git +master
  -------------------------------------------------

I'd like to have note here that if receive.denyNonFastForwards is set
on remote repository side (and it is set by default when initializing
shared repository), then you would not be able to force non fast-forward
push. Just to avoid potential confusion (why it is not accepting push?).
 
>> * no git rebase --merge (e.g. renames)
>> * git cherry-pick --no-commit + git commit, instead of
>>   git cherry-pick + git commit --amend
> 
> It usually is not a good idea for a manual to show two ways to
> do the same thing without explaining pros and cons.
> 
> I typically use rebase *without* --merge because it tends to be
> faster (recently 'mailinfo' was broken for i18n contents, and I
> had to use "rebase --merge" until it was fixed; now I can go
> back to my old ways of running it without --merge ;-)).  I think
> the only reason to use --merge is when you want the rename thing
> in merge-recursive.

It would be enough to have one sentence mentioning it, like e.g.
"Use 'git rebase --merge' if rebased commits include renames",
or something like that.
 
> I do not think "cherry-pick -n + commit" vs "cherry-pick +
> commit --amend" is an interesting contrast for a single commit.
> Squashing more than one commit is why you would want to pick
> without committing, which you cannot do with the latter.  So
> they are not "instead of" -- they serve different purposes.

Well, perhaps in "Advanced..." section it should be mentioned
that you can use 'git cherry-pick --no-commit' to concatenate
together some commits (and 'git merge --squash' to concatenate
whole branch to single commit).

Chosing "cherry-pick -n + commit" vs "cherry-pick + commit --amend"
is IMVHO a matter of taste; I think commit --amend is encouraged.

>> * legitimate use of multiple root commits: joining projects
>>   (e.g. git = git-core + git-tools (mail) + gitk + gitweb + git-gui)
> 
> I am not sure if you would even need to talk about it.  As long
> as the document does not say "you shouldn't have more than one
> root", I think we are Ok.

I was thinking about adding a sentence that you can have multiple
root commits in repository, and usually they are result of joining
two projects (git can join projects, which is a plus), or rather
including one project in the other.

Git User's Manual says:

  As a special case, a commit object with no parents is called the
  "root" object, and is the point of an initial project commit.  Each
  project must have at least one root, and while you can tie several
  different root objects together into one project by creating a commit
  object which has two or more separate roots as its ultimate parents,
  that's probably just going to confuse people.  So aim for the notion
  of "one root object per project", even if git itself does not enforce
  that.

I'd rather have this softened: try do not use it for the sake of using 
it, but joining projects (swallowing other project) results in multiple 
roots.

-- 
Jakub Narebski
ShadeHawk on #git
Poland
