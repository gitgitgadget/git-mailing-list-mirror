X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Seth Falcon <sethfalcon@gmail.com>
Subject: Re: git-svn bug?
Date: Wed, 15 Nov 2006 14:33:47 -0800
Message-ID: <m2psbocpbo.fsf@ziti.local>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 22:34:40 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:to:subject:references:from:date:in-reply-to:message-id:user-agent:mime-version:content-type;
        b=n2RWZIjO3NSydKrb51H2Ks9DPrZNNDyQk2MeJ0v1zDSROrPF5GhoqZYEQfIy03mg0424wdlD20dLGsEiYmI6K5g7vkAim+rfMpnljLrZUzhWyONcpDNtNi73mJjivvgxtepgezW0osp2a6LL9Jh4nVEAbxGVrHaorah2Gq/RsiQ=
In-Reply-To: <op.ti2svo0ozidtg1@rygel.lnxi.com> (Troy Telford's message of "Wed, 15 Nov 2006 14:05:37 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (darwin)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31519>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTKw-0007uw-1h for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:34:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162011AbWKOWe0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:34:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162012AbWKOWe0
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:34:26 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:49539 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1162011AbWKOWeZ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:34:25 -0500
Received: by ug-out-1314.google.com with SMTP id m3so286240ugc for
 <git@vger.kernel.org>; Wed, 15 Nov 2006 14:34:24 -0800 (PST)
Received: by 10.66.232.11 with SMTP id e11mr36014ugh.1163630064322; Wed, 15
 Nov 2006 14:34:24 -0800 (PST)
Received: from ziti.local ( [67.171.24.140]) by mx.google.com with ESMTP id
 e33sm658767ugd.2006.11.15.14.34.23; Wed, 15 Nov 2006 14:34:24 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

"Troy Telford" <ttelford.groups@gmail.com> writes:

> I've got a repository I've converted over to git from svn.  (using
> git-svn.  since there's only been one branch, I figured I could skip
> git-svnimport).
>
> For quite a while, all I did was fetch/rebase from the svn repository
> to  my git repository; all of my own work was committed to the git
> repository;  none of the changes were commited to the svn repository.
>
> Then came the time to commit changes from my git repository to the svn
> repository.
>
> Being somewhat cautious, I created an empty 'dummy' svn repository and
> familiarize myself with using git-svn to commit from git -> svn.
>
> I ran:
> git-svn fetch
> git-svn rebase remotes/git-svn (already updated)
> git-svn dcommit (to push my changes to the svn repository)

I always send commits as:

git-svn dcommit remotes/git-svn..master

Possibly replacing master with whatever git branch I'm working on.
One nice thing about this approach is that you can sort of preview the
commit as:

  git diff remotes/git-svn..master

[but that just shows overall diffs and git-svn dcommit will apply each
commit in master separately to svn]

