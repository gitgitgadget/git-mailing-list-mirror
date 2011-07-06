From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: Re: [PATCH 2/2] git-rebase.txt: clarify that --abort checks out
 <branch>
Date: Tue, 5 Jul 2011 22:19:09 -0400 (EDT)
Message-ID: <alpine.DEB.2.00.1107052148370.7799@debian>
References: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com> <1309902196.31762.30.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Wed Jul 06 04:19:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeHiH-0004ny-4N
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 04:19:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755841Ab1GFCTN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jul 2011 22:19:13 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52070 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755620Ab1GFCTM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2011 22:19:12 -0400
Received: by vxb39 with SMTP id 39so4613838vxb.19
        for <git@vger.kernel.org>; Tue, 05 Jul 2011 19:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type;
        bh=boPGEh1oYzLD+gy+pZ5hW61vm054up9Yf5qlQQOzp8c=;
        b=CinC0VoyUCpN4N84eguqKwgyvSXhl4vYiJow4X12qrU2LGwL8O8cE1mh8FK7fF3mEr
         FJilP5xpVLDisLQuqqUGXUY23Dkmqq3bdmELdY6aA/iiSPtGAE0RQqgaKU6HfBhvbYrd
         ejpX24VGhy7vS6IRocx7OJ4rxam0PK8jSEc20=
Received: by 10.220.176.195 with SMTP id bf3mr3081794vcb.0.1309918751959;
        Tue, 05 Jul 2011 19:19:11 -0700 (PDT)
Received: from [192.168.1.101] (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id dp3sm683896vcb.19.2011.07.05.19.19.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jul 2011 19:19:10 -0700 (PDT)
X-X-Sender: martin@debian
In-Reply-To: <1309902196.31762.30.camel@drew-northup.unet.maine.edu>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176635>

On Tue, 5 Jul 2011, Drew Northup wrote:

> 
> On Fri, 2011-07-01 at 22:38 -0400, Martin von Zweigbergk wrote:
> > The description for 'git rebase --abort' currently says:
> > 
> >     Restore the original branch and abort the rebase operation.
> > 
> > The "restore" can be misinterpreted to imply that the original branch
> > was somehow in a broken state during the rebase operation. 
> 
> When you are in the middle of a rebase you _are_not_on_any_branch_. This
> is why "Restore the original branch" is used.

Are you saying that something (what?) in "Abort the rebase operation
and check out <branch>." suggests to the user that he/she _is_ on some
branch?

> > It is also
> > not completely clear what "the original branch" is --- is it the
> > branch that was checked out before the rebase operation was called or
> > is the the branch that is being rebased (it is the latter)? Although
> > both issues are made clear in the DESCRIPTION section, let us also
> > make the entry in the OPTIONS secion more clear, like so:
> > 
> >     Abort the rebase operation and check out <branch>.
> 
> So when I rebase I'm really checking out another branch--which, just to
> increase confusion, doesn't actually exist?

Same question as above: what makes it sound like rebase is checking
out another branch?

> What if there isn't another
> branch (rebase -i on a single-branch repo, for instance)? This doesn't
> solve the problem.

That reminds me that <branch> may not have been specified. How about
saying things more explicitly like this?

  Abort the rebase operation and reset HEAD to the original branch. If
  <branch> was provided when the rebase operation was started, then
  HEAD will be reset to <branch>. Otherwise HEAD will be reset to
  where it was when the rebase operation was started.

Does phrasing it as "reset HEAD to" instead of "check out" also
address your concern about "checking out another branch"?


Martin
