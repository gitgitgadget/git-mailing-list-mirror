X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn breakage
Date: Tue, 12 Dec 2006 01:19:18 -0800
Message-ID: <20061212091918.GC8179@localdomain>
References: <4b3406f0612112123h13e346d2r5a3b196595bc017a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 12 Dec 2006 09:19:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4b3406f0612112123h13e346d2r5a3b196595bc017a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34072>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu3nJ-0001HH-Se for gcvg-git@gmane.org; Tue, 12 Dec
 2006 10:19:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932164AbWLLJTW (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 04:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932165AbWLLJTW
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 04:19:22 -0500
Received: from hand.yhbt.net ([66.150.188.102]:53409 "EHLO hand.yhbt.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932164AbWLLJTV
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 04:19:21 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1]) by hand.yhbt.net
 (Postfix) with SMTP id 58B6A7DC02A; Tue, 12 Dec 2006 01:19:19 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 12 Dec 2006
 01:19:18 -0800
To: Dongsheng Song <dongsheng.song@gmail.com>
Sender: git-owner@vger.kernel.org

Dongsheng Song <dongsheng.song@gmail.com> wrote:
> Hi,
> 
> I am trying to use git-svn synchronize git with svn.
> 
> When git-fetch failed midway, and resumed later.The git-svn log output
> fine, but git-log output only before resumed.
> 
> How can I fix it ?

git-svn only updates refs/heads/master to the last refs/remotes/git-svn
revision on the first time fetch runs.  Since git-log defaults
to HEAD (which most likely points to refs/heads/master, use git-branch
to find out), it'll only show the information in refs/heads/master.

So if you want to see the latest revisions that git-svn fetched,
then use 'git log remotes/git-svn'

To pull changes into your working copy (or HEAD) use:
  git rebase refs/remotes/git-svn

-- 
