From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Hey - A Conceptual Simplication....
Date: Fri, 20 Nov 2009 04:35:46 +0300
Message-ID: <20091120013545.GA22556@dpotapov.dyndns.org>
References: <005a01ca684e$71a1d710$54e58530$@com> <20091118142512.1313744e@perceptron> <008401ca6880$33d7e550$9b87aff0$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: 'Jan =?iso-8859-1?Q?Kr=FCger'?= <jk@jk.gs>, git@vger.kernel.org
To: George Dennie <gdennie@pospeople.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 02:36:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBIPu-0002yj-TZ
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 02:36:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755828AbZKTBfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Nov 2009 20:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755611AbZKTBfz
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Nov 2009 20:35:55 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:61407 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754734AbZKTBfy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Nov 2009 20:35:54 -0500
Received: by bwz27 with SMTP id 27so3002216bwz.21
        for <git@vger.kernel.org>; Thu, 19 Nov 2009 17:35:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=26rY9UQB2s5Ee84mBA4FStn4GmitANoZhaMgzX480jM=;
        b=IMm/jEDxqw6UQrVVO+XWzW83rDUwVcUK4PC1dihe1Dov9M1S45WkptMiFnJO1LB4AH
         j39o0T6iD51kpkw+pzsb0DKa8pcvX9Q+QNoFk/XCPI+LWLX4TGuOlehdbzfTA+n0g2dq
         LxIQURjBeLzqQIyG168v/6KhEnELxMVh1ONGk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=A56w7P8JHWFBxRLfld0UgGc7e4pTOdOSq/QcBB+YdRuPzEPvPLh0UpfRItKpTs4Y5W
         8kCDWP/34olQ02mDSR/mN39bXj8C8JL6/prqZEpM5vg0gVBFxBITq1rfI+XPVCh0OwDD
         hQxgEwRy6rzViQtC+OEJzaPVa8VlE+1+Ui2u4=
Received: by 10.204.154.85 with SMTP id n21mr673139bkw.171.1258680958985;
        Thu, 19 Nov 2009 17:35:58 -0800 (PST)
Received: from localhost (ppp91-76-17-113.pppoe.mtu-net.ru [91.76.17.113])
        by mx.google.com with ESMTPS id 16sm305394bwz.15.2009.11.19.17.35.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 19 Nov 2009 17:35:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <008401ca6880$33d7e550$9b87aff0$@com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133279>

On Wed, Nov 18, 2009 at 01:51:56PM -0500, George Dennie wrote:
> 
> One of the concerns I have with the manual pick-n-commit is that you can
> forget a file or two.

It is more difficult to make this mistake with Git than many others
VCSes, because Git shows the list of files that are changed but not
committed as well as the list of untracked files when you try to commit
something. So, it has never been a real issue for me in practice...

> Consequently, unless you do a clean checkout and test
> of the commit, you don't know that your publishable version even compiles.

If you want to be sure that clean checkout will be compiled, the only
way to guarantee that is to do a clean checkout. Even if you commit all
files except those that are specified in .gitignore, it is not enough to
be sure that a clean checkout will be compiled... But in most cases, you
do not need to do that to be *reasonable* sure that a clean checkout
will be compiled later, and if you have any doubts, you can do a clean
checkout and testing _after_ committing your changes. There is no reason
to be afraid to commit something that may not work if you can amend that
later (until you publish your changes).

> It seems safer to commit the entirety of your work in its working state and
> then do a clean checkout from a dedicated publishable branch and manually
> merge the changes in that, test, and commit.

Maybe I did not understand your words, but I am not sure what is gained
in this way... Clearly there is no reason to publish a work that you
have not tested yet. And no one cares about crap that you keep in your
working tree either... So, a better approach is to commit your changes
as a series of patches that can be reviewed easily, then do all testing
and then publish them for integration with the main development branch.

> 
> It seems the intuitive model is to treat version control as applying to the
> whole document, not parts of it. In this respect the document is defined by
> the IDE, namely the entire solution, warts and all.

This is a very bogus idea. If you want to preserve all warts etc, you
just do backup of the whole disk and now you have a state that can be
compiled any time later (provided that your hardware do not change too
much). In my experience, in most cases when I was not able to compile
an old version were caused not by forgetting to commit something, but
changing in the environment (like new compiler, new libraries, etc).

But when your commits are fine-grained, you can always cherry-pick the
corresponding fix-up and compile this old version if it is necessary.

In my experience, the value of VCS history is the ability to look at it
(sometimes many years later) and understand who wrote this line and why.
Also, nearly all cases when I had to compile some old version were due
to bisecting some tricky bug. In both cases, having fine-grained commits
was crucial to success.

> When you start
> selectively saving parts of the document then you are doing two things,
> versioning and publishing; and at the same time.

No, you don't. Committing some changes and publishing them are two
separated operations in Git, and that it is pretty much fundamental.
Normally, you commit changes in a few separated patches, review them to
make sure that changes match commit messages, do all testing, and only
then you publish them.


Dmitry
