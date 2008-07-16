From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Considering teaching plumbing to users harmful
Date: Wed, 16 Jul 2008 14:35:16 -0400
Message-ID: <32541b130807161135h64024151xc60e23d222a3a508@mail.gmail.com>
References: <alpine.DEB.1.00.0807161804400.8950@racer>
	 <32541b130807161053w24a21d7bh1fa800a714ce75db@mail.gmail.com>
	 <alpine.DEB.1.00.0807161902400.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 16 20:36:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJBrP-0001dI-G6
	for gcvg-git-2@gmane.org; Wed, 16 Jul 2008 20:36:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753536AbYGPSfU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jul 2008 14:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752676AbYGPSfT
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jul 2008 14:35:19 -0400
Received: from an-out-0708.google.com ([209.85.132.241]:22925 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752559AbYGPSfR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jul 2008 14:35:17 -0400
Received: by an-out-0708.google.com with SMTP id d40so79965and.103
        for <git@vger.kernel.org>; Wed, 16 Jul 2008 11:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=aCJTF03PPMqJPpi4V/SCkcXtk4W9dJhzeVHfeJZnmbI=;
        b=JlCJVhYOziArcE3kvz/bAh5ROVCG3RctsgezPNtEyB5yuNn9ILTgwr6oEcH6iXOMZh
         yjJFZRFxYNFTiP3JJmfz/7vtjicg+iOk0HbK8acZd2BcOVmGJjB0wQT3avtxMQpi6CdQ
         Aziz5lG7eYdwzuinWmAz7V11ly/qZrvl01Bgk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=dQ2krVC9D+KnoiB3rrUa/hQW5glHUtw5xLJKfI2R0Yvh6zh6L8+vFGMqoncBYWfT+j
         EAP/blXacR41NZFoMKvUSJvEHTcQlIE+C8+l3t+epLd/DyfqDAAWyX2D5lycApSHN0ez
         UBd7zbqM3HJ0wALnH4LTtG5tOg0jqR+ik0eaY=
Received: by 10.100.58.19 with SMTP id g19mr2603128ana.41.1216233316748;
        Wed, 16 Jul 2008 11:35:16 -0700 (PDT)
Received: by 10.100.8.19 with HTTP; Wed, 16 Jul 2008 11:35:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0807161902400.8986@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88713>

On 7/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  And with my way of not even bothering to tell users that "git pull" has a
>  default remote and branch, it is easy to tell users about pulling from
>  somewhere else:

I agree that this is the best way to teach git pull.

>  > At the very least, there will be branches.
>
> Oh.  And you have to teach plumbing for that?

In svn, a branch is a revision-controlled directory.  In git, a branch
is a "ref".  What's a ref?  Well, it's a name for a commit.  What's a
commit?  Well, it's a blob.  What's a blob?  Err, that's complicated.
What happens when I delete a branch?  Well, it's still in the reflog.
What's the reflog?  Well, it's the local revision history of each
branch.  Local?  Why not shared?  In svn, the revision history of each
branch is shared, but in git, you don't need to, because...

Even git branches are surprisingly concept heavy, unless your users
ask a lot fewer questions than mine.  The really critical question is
why it's so easy to delete a branch in git, and that leads rapidly
into the commit-tree stuff, which is always a spiral into plumbing as
you try to explain the tree of commits.

>  > And so you suddenly need to find out about things like
>  >
>  >        git diff :{1,3}:path/to/filename
>
> No.  Nobody needed that.  All except one user were content with "git
>  diff".  That one wanted "git diff --ours".

I can't find that option in the git-diff man page.

>  I will not even bother to reply to your mentioning rebase, submodules, and
>  the "complicated" log due to merges for that very reason: all of this can
>  be done, easily, with porcelain.

My point was that the porcelain doesn't even make that stuff easy, and
thus you need to understand fundamental git internal concepts to use
them, and fundamental git internals are easiest to teach using the
plumbing, which doesn't try to hide them.

>  > Ironically, the plumbing is the only part of git that isn't supposed to
>  > ever change, so it's the most valuable knowledge to have.
>
> Aha.  So we changed porcelain recently, in a backwards-incompatible way?
>  Now, that is news to me.

There are frequent discussions on this list about changing the output
of various porcelains vs. plumbing.  Improving the porcelain output is
useful, because a lot of it right now is mostly accidental (especially
error and progress messages), and to make git easier to use over time,
it will presumably want to be cleaned up.

But if I write a script that uses git and I need to parse the output,
those very useful porcelain changes are backwards incompatible.

The common advice in that case is to only write scripts that use the
plumbing, not the porcelain.  That's fine advice, I think.  But in
svn, I can write scripts using the "svn" command, because its outputs
never change.  Quite unadvanced svn users write shell scripts around
svn, including basic things such as:

   svn status | grep ^C

...to list all conflicted files.  I don't think a similar script
around "git status" is guaranteed not to break.  Perhaps I've
misunderstood though.

Have fun,

Avery
