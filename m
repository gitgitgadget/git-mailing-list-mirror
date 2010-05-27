From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Use "git pull --ff-only" by default?
Date: Thu, 27 May 2010 22:09:08 +0400
Message-ID: <20100527180908.GA10398@dpotapov.dyndns.org>
References: <A612847CFE53224C91B23E3A5B48BAC74483234E90@xmail3.se.axis.com>
 <4BF68F5F.9010309@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234EDE@xmail3.se.axis.com>
 <4BF6A445.1030105@drmicha.warpmail.net>
 <A612847CFE53224C91B23E3A5B48BAC74483234FAA@xmail3.se.axis.com>
 <20100524125637.GE3005@dpotapov.dyndns.org>
 <A612847CFE53224C91B23E3A5B48BAC74483677DDC@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Thu May 27 20:09:36 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHhWS-00031X-5E
	for gcvg-git-2@lo.gmane.org; Thu, 27 May 2010 20:09:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212Ab0E0SJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 May 2010 14:09:17 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41570 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932243Ab0E0SJO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 May 2010 14:09:14 -0400
Received: by fxm10 with SMTP id 10so79515fxm.19
        for <git@vger.kernel.org>; Thu, 27 May 2010 11:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=62v3+pw6r0RlR4G1nxlDvZg0ZvDtYEQ0cdMoDPlJjJc=;
        b=jK4kbllZudzCbOwpmdzg0tOyOkeutJnVpnhqE9gkx7oMY2cBSNNskfu0CeQAGbyMGG
         WOHGQm3W5GRkACEX1S3X6hJaZ5GXoUehkUefYEMocSTnvNRe+UGq2i3o+aFEd0zOXOfj
         E9ndrIOaxxqzUkD0pl2USyk5RKBMHyrFNHojM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hfXDXSPKyJg13JKZnGp7z6ajf4LT/2NkcieuQY++msXytJaMPxRQDOOk5LYEYx5hNn
         y71EIihh4jEczF0RwvN6PyMMcqXyZ5+BOOevTrBw4QGKKSh5nAHHW4As7Ghpd9GwonY6
         Xt7zRJd3vhsWuZt5qUUkAT2ewVRnEwWCL5VuM=
Received: by 10.204.75.67 with SMTP id x3mr4761388bkj.116.1274983751956;
        Thu, 27 May 2010 11:09:11 -0700 (PDT)
Received: from localhost (ppp85-140-126-176.pppoe.mtu-net.ru [85.140.126.176])
        by mx.google.com with ESMTPS id h21sm6446405bkh.23.2010.05.27.11.09.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 27 May 2010 11:09:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483677DDC@xmail3.se.axis.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147891>

On Tue, May 25, 2010 at 10:43:22AM +0200, Peter Kjellerstedt wrote:
> 
> > > > I think this boils down to having a few people who are allowed to
> > > > push merges because they can make these decisions. Even if people
> > > > don't merge "origin" but their own branches they can create a mess, 
> > > > so you cannot differentiate based on that.
> > >
> > > In a larger organization this does not work. Most of our developers
> > > are responsible for at least one subsystem and expected to be the one
> > > responsible for its master branch.
> > 
> > Right. Now, if only one person who is responsible for this subsystem is
> > expected to be able to push changes to the master branch then this
> > person will never need "git pull --ff-only". In fact, when he pulls
> 
> Well, most of our subsystems have at least one backup maintainer 

Which is very reasonable, but I do not see how it contradicts to
anything what I said above...

> > changes from others, he needs a real merge. So, this alone a very
> > strong argument against making ff-only by default in any configuration.
> 
> Well, we use a central repository with development made on official
> topic branches, so he is not supposed to pull from others.

I am not sure what kind of workflow you are talking here, but in any
case, the maintainer can pull those official topic branches when he
believes it is ready for integration...

> He will 
> fetch from the central repository and merge the topic branches.

of course, you can do that using two commands instead of one...

> That way the user 
> would have to take an explicit action, and decide whether he should
> do a git pull --rebase, put his local changes on a branch or resolve
> the problem some other way (initially that would probably be by 
> asking me what is going on and what to do, and that way learn how to
> handle the situation). Silently creating an automatic merge that does 

It is as much automatic as those that are created by "git merge". If
someone says "git pull", it means to do merge. In fact, before Git 1.5,
"git pull" was the only porcelain command to do local merges (while
"git merge" was a plumbing command with a different arguments than it
has now). So, if you are only interested in fetching new changes then
you should use "git fetch". Changing the default for "git pull" to
do --ff-only is akin changing "git merge" to do --ff-only...

> not have any meaning and will just confuse anyone looking at the 
> revision history later is not something that I want, especially as it
> would make the job harder for the maintainer who is supposed to merge
> the changes later and then has to untangle the mess.

First, when you make a presentation of Git and the workflow that you are
going to use, you can explicitly say what commands should be and what
should not be normally used in this workflow. Second, when a maintainer
sees a mess, he can just tell to this developer to rebase his changes
and never use "git pull"... In fact, this is the least problem comparing
to all other typical mistakes that inexperience developers do, such as,
writing meaningless comments to commits, failure to split changes in
logic steps, forget to test changes, etc...

> 
> > And if you think that "pull --ff-only" is very useful for some reason,
> > nobody prevents to add an alias for that command, but this command
> > should never be called as "pull", because "pull" has always been about
> > merging changes, and if it does something different, you should call it
> > differently. Why don't call it as "fast-forward" or "ff" for short?
> 
> I do not agree with you. When I do git pull it is to get all changes
> made to the official repository. I do not want any local changes I have
> to be merged with the official changes, but rather I want my changes
> to stay separate, either by using git pull --rebase (if I have hacked
> on the same branch for some reason), or by using a private topic branch
> that I keep rebasing on master.

If you want to get changes then you should use "git fetch", and not "git
pull", because the latter is about getting and _merging_. Why are you
trying so hard to change a well established meaning of the pull command?


Dmitry
