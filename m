From: "John J. Franey" <jjfraney@gmail.com>
Subject: Re: Working with Git and CVS in a team.
Date: Mon, 16 Jun 2008 12:04:44 -0400
Message-ID: <1213632284.11517.78.camel@isidore.myhome.westell.com>
References: <200806131633.34980.mirko.stocker@hsr.ch>
	 <20080613145010.GU29404@genesis.frugalware.org>
	 <200806132243.36695.m1stocke@hsr.ch>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <m1stocke@hsr.ch>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:06:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HDR-0005EF-CD
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:05:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbYFPQEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753765AbYFPQEw
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:04:52 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:31227 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750953AbYFPQEv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:04:51 -0400
Received: by rv-out-0506.google.com with SMTP id k40so3664673rvb.1
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=RQS8cXslfGo50M55KRXiv3A/0qDHBOaaoIAeG9lDHxw=;
        b=ce2iY5Do5Eg8Qp0Fk/LsxEVKotCOoKDhWWUkrQeaQjfs4bImH71sz0xmfUhw/Qyui0
         VAWV3C6C7WcsvZ6JUWtXoGRvQL2RCwmMaknt0FsOnjjYOfSqyiH6/jXVO76QkNC0LPXO
         +UpG4gh60o4jTytGrn5ZU99ShHtwG90dG4B7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date
         :message-id:mime-version:x-mailer:content-transfer-encoding;
        b=wsIGB7F+zgcjeUG0WzZjSvMw8k/I69TchCkJ0G9bfzzkO0rB4kGRw1T+qDnnkK88AW
         lLYI6zxb4u74aX73NRYw+MjXq4R4vl1goXvdJXOVkzI7bmMIbHoBs6MCKX3korVNmsRt
         dRO4zyQSATfJ3H3j5WRx+tpju+mYyBtfwipcI=
Received: by 10.114.201.1 with SMTP id y1mr6420288waf.93.1213632291019;
        Mon, 16 Jun 2008 09:04:51 -0700 (PDT)
Received: from ?192.168.2.102? ( [70.21.168.140])
        by mx.google.com with ESMTPS id i19sm235536wxd.7.2008.06.16.09.04.47
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 09:04:49 -0700 (PDT)
In-Reply-To: <200806132243.36695.m1stocke@hsr.ch>
X-Mailer: Evolution 2.22.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85199>

On Fri, 2008-06-13 at 14:33 +0200, Mirko Stocker wrote:


> Our team works on an existing project that's in CVS, but we don't have
> the permissions to commit directly to it. We still need to make
> changes and want to stay as up to date as possible, so we are trying
> to use git to track the CVS repository and to collaborate inside the
> team.
> 

I'm in a team that is all CVS.  I'm the only one using git.

I can commit to CVS, unlike your situation.

> 
> Now, I'm quite new to git, so I'm not sure if the solution I created
> is "correct", not way too complicated, or if there are problems waiting
> for us.
> 

I don't think there is a 'wrong' way.  'Whatever works' is the motto. 
The configuration should match the workflow.  So, I don't have any
comment on yours.  I thought I'd share mine, in case there is value.  I
think I will learn something


My setup is:

+----------+
| cvs repo |
+----------+
     |
     | (1)
     |
+----------+
| /cvs_git |
+----------+
     |
     | (2)
    \|/
+---------------------+   (5)   +--------------------+
| john's private repo |-------->| john's public repo |
+---------------------+         +--------------------+
     |
     | (3)
    \|/
+--------------------+
| john's cvs sandbox |
+--------------------+
     |
    \|/ (4)
+----------+
| cvs repo |
+----------+

(1) git-cvsimport -i ...

Runs in cron every 30 minutes.

The output git repo is on a shared server.  git users (me) can clone/fetch/pull.

The git repo for cvs is purely one way: no commits are to be pushed to
this repo.  All content comes from the cvs repo.

This is importing ALL branches from CVS because it git users (me)
require access to all cvs branches. 


(2) git clone -o cvs 

Using -o, my private repo uses 'cvs' as the name of the git remote that
tracks cvs.  This lets me do 'git fetch cvs', which feels right.

And, to create a branch from the cvs head branch:

'git checkout -b br cvs/origin'




(3) git cvsexportcommit
(4) cvs commit

These close the loop: my changes are committed to cvs repo. 
Alternatively, the loop can be closed by emailing patch files to a cvs
committer.



(5) git push public

'public' is the name of my public repo.  The commits I push to public
are for developers that are using git (currently zero) who want to see
my work before it gets to cvs' head (which is under high contention).

I expect my team members to push to their one public repo.  Then I can
do: 'git fetch alice' to get Alice's work.

At the end of all this, when I do a 'git branch -r' I will see something like:

cvs/br1
cvs/br2
alice/br4
alice/br5
bob/br6
bob/br7

Thus making obvious which branch originates from which developer or from cvs.


In this configuration, the 'merge-dude' is simply another user with a
private and public repo.






Issue with being the git user in a team of cvs users:

git makes merges easier and more robust.  I don't want to use cvs anymore.

My main problem is sharing my changes to cvs users.  cvs head is under
contention and protection, so I can't simply commit all my changes to
cvs head.  Our cvs strategy is to create a branch for each developer or
topic.  If I create a branch in cvs repo for my git commits, I'd also
want to keep that cvs branch upto date wrt cvs head. I haven't sorted
out how to do that easily with the git tools.




> 
> 
> What I don't like is how we have to make the upstream patch(es). Is
> there an easy way we can get multiple patches, lets say for each
> commit we made? Or is it easier to make a lots of branches and to
> then create a patch from the diff between the branch and origin/origin?
> 
> 

I don't know enough.  I'd try it both ways to see which works for you. 
Doesn't git easily create a patch file in either case?  (This is the
part I'm not sure of.)


Regards,
John
