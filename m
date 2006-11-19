X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn bug?
Date: Sun, 19 Nov 2006 08:52:21 -0800
Message-ID: <20061119165221.GA6478@soma>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <7vejs4jshp.fsf@assigned-by-dhcp.cox.net> <op.ti2xykijzidtg1@rygel.lnxi.com> <20061117085509.GA29644@localdomain> <op.ti6irtilzidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 19 Nov 2006 16:52:33 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <op.ti6irtilzidtg1@rygel.lnxi.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31840>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Glpu7-0005N4-96 for gcvg-git@gmane.org; Sun, 19 Nov
 2006 17:52:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756777AbWKSQwX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 19 Nov 2006
 11:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756778AbWKSQwX
 (ORCPT <rfc822;git-outgoing>); Sun, 19 Nov 2006 11:52:23 -0500
Received: from hand.yhbt.net ([66.150.188.102]:30895 "EHLO hand.yhbt.net") by
 vger.kernel.org with ESMTP id S1756777AbWKSQwX (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 19 Nov 2006 11:52:23 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 6E7937DC0A3; Sun, 19 Nov 2006 08:52:21 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sun, 19 Nov 2006
 08:52:21 -0800
To: Troy Telford <ttelford.groups@gmail.com>
Sender: git-owner@vger.kernel.org

Troy Telford <ttelford.groups@gmail.com> wrote:
> My 'dummy' repo was imported using git-svn.
> My 'real' repo was imported using git-svnimport.
> 
> Having not read any of the code, I'm just taking a wild guess; but is it  
> reasonable to say that since the repository was originally imported to git  
> using git-svnimport (rather than git-svn), git-svn doesn't have some of  
> the data it needs to push to the remote svn repo?

Exactly, git-svn needs the git-svn-id: lines at the end of each commit
for 'commit' and 'dcommit' to work.  So using a repo created by
git-svnimport will not work.

'commit-diff' will work, however it's intended as a low-level command
('commit' should be that, too).

> Would it be reasonable to use git-svn to import the SVN repository into a  
> new git repo, and then rebase from the old git-svnimport'ed repo into the  
> new git-svn imported one?  (did that even make sense?!?)

Yes, something along those lines would work.

-- 
