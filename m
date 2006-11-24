X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: Pull and fetch
Date: Fri, 24 Nov 2006 11:11:44 -0500
Message-ID: <20061124161144.GA19708@fieldses.org>
References: <20061123203950.5d47421f@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 24 Nov 2006 16:11:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061123203950.5d47421f@paolo-desktop>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32229>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GndeY-0000Ge-KW for gcvg-git@gmane.org; Fri, 24 Nov
 2006 17:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934953AbWKXQLr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 24 Nov 2006
 11:11:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934954AbWKXQLr
 (ORCPT <rfc822;git-outgoing>); Fri, 24 Nov 2006 11:11:47 -0500
Received: from mail.fieldses.org ([66.93.2.214]:15513 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S934953AbWKXQLq (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 24 Nov 2006 11:11:46 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GndeS-0005Ke-Up; Fri, 24 Nov 2006
 11:11:44 -0500
To: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Sender: git-owner@vger.kernel.org

On Thu, Nov 23, 2006 at 08:39:50PM +0100, Paolo Ciarrocchi wrote:
> I'm still reading git tutorial.txt and I'm again confused.
> 
>   A more cautious Alice might wish to examine Bob's changes before
>   pulling them.  She can do this by creating a temporary branch just
>   for the purpose of studying Bob's changes:
> 
>   -------------------------------------
>   $ git fetch /home/bob/myrepo master:bob-incoming
>   -------------------------------------
> 
>   which fetches the changes from Bob's master branch into a new branch
>   named bob-incoming.  (Unlike git pull, git fetch just fetches a copy
>   of Bob's line of development without doing any merging).  Then
> 
>   -------------------------------------
>   $ git log -p master..bob-incoming
>   -------------------------------------
> 
>   shows a list of all the changes that Bob made since he branched from
>   Alice's master branch.
> 
> OK, make sense. So let's try with an experiment:

Your experiment is quite different from what's described above; you're
fetching into an *empty* repository, instead of fetching a branch that
diverged from the work in the repository:

> paolo@paolo-desktop:~/test$ git-init-db 
> defaulting to local storage area
> paolo@paolo-desktop:~/test$ git fetch ../git master:testbranch
> warning: no common commits

and you're running "pull" with a syntax that has so far only been
introduced for "fetch":

> paolo@paolo-desktop:~/test$ git pull ../git master:testbranchpull

By its nature a tutorial tends to follow a narrow path, and not offer
much explanation of what will happen if you stray from that path.

That said, I agree that the treatment of pull and fetch here could be
better.  And the ref:ref syntax for pull may be an obvious enough thing
to try that we should document it here.  Just as long as we keep it
short....

