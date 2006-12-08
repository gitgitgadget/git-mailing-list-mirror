X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Trouble with git-svn when upstream svn URL changed
Date: Fri, 8 Dec 2006 10:11:09 -0800
Message-ID: <20061208181109.GA10475@localdomain>
References: <m21wnai8qe.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 18:11:36 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m21wnai8qe.fsf@ziti.local>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33715>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GskC6-0006yH-FM for gcvg-git@gmane.org; Fri, 08 Dec
 2006 19:11:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760799AbWLHSLN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 13:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760797AbWLHSLN
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 13:11:13 -0500
Received: from hand.yhbt.net ([66.150.188.102]:47620 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S1760799AbWLHSLL
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 13:11:11 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 4968D2DC034; Fri,  8 Dec 2006 10:11:10 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 08 Dec 2006
 10:11:09 -0800
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> Hi,
> 
> One of the repositories I have been tracking with git-svn was
> reorganized and the path that I have been tracking is now in a new
> location.
> 
> I was hoping that the following would work:
> 
>    git clone orig new
>    cd new
>    git svn rebuild $NEW_URL
> 
> I also tried 
> 
>    git svn rebuild --remote $NEW_URL
> 
> This have some output that looked reasonable (svn rev nums and git
> sha1's).  But git svn fetch does nothing and I don't seem to have any
> of the new content.  Am I using this incorrectly?

This is incorrect, rebuild is not designed to handle new urls.  However,
git/git-svn are very flexible beasts :)

> I guess I can create a fresh git repos using git-svn init and then
> fetch all of my dev branches from the original repository.

You can look at "Advanced Example: Tracking a Reorganized Repository"
in the manpage.  Ignore the text about --follow-parent since you
already have the old stuff fetched, and start following the instructions
beginning with "# And now, we continue tracking the new revisions:"

If that fails (I don't think it would); you can always link branches
together using grafts (git-svn graft-branches tries to automate this;
but it's imperfect).

-- 
