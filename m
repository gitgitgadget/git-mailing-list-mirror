X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alan Chandler <alan@chandlerfamily.org.uk>
Subject: Re: Resolving conflicts
Date: Fri, 1 Dec 2006 07:30:25 +0000
Message-ID: <200612010730.25700.alan@chandlerfamily.org.uk>
References: <456FD461.4080002@saville.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 1 Dec 2006 07:30:46 +0000 (UTC)
Cc: Wink Saville <wink@saville.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
In-Reply-To: <456FD461.4080002@saville.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32858>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq2qz-00064h-9y for gcvg-git@gmane.org; Fri, 01 Dec
 2006 08:30:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933843AbWLAHac (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 02:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934176AbWLAHac
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 02:30:32 -0500
Received: from 82-44-22-127.cable.ubr06.croy.blueyonder.co.uk
 ([82.44.22.127]:24746 "EHLO home.chandlerfamily.org.uk") by vger.kernel.org
 with ESMTP id S933843AbWLAHab (ORCPT <rfc822;git@vger.kernel.org>); Fri, 1
 Dec 2006 02:30:31 -0500
Received: from kanger.home ([192.168.0.21]) by home.chandlerfamily.org.uk
 with esmtp (Exim 4.63) (envelope-from <alan@chandlerfamily.org.uk>) id
 1Gq2qr-0007sG-CR; Fri, 01 Dec 2006 07:30:29 +0000
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Friday 01 December 2006 07:06, Wink Saville wrote:
...
>    git-pull . master
>
> But that failed:
I am not the worlds expert in this, but since most seem to be in bed I'll 
attempt to answer you

...
>    CONFLICT (content): Merge conflict in kernel/fork.c
>    Auto-merging kernel/spinlock.c
>    CONFLICT (content): Merge conflict in kernel/spinlock.c

These show that these two files had some conflicts in the contents from the 
kernel and your local branch
...
> And git-status shows:
...
>    # Changed but not updated:
>    #   (use git-update-index to mark for commit)
>    #
>    #       unmerged: kernel/fork.c
>    #       modified: kernel/fork.c
>    #       unmerged: kernel/spinlock.c
>    #       modified: kernel/spinlock.c
>    #
>
> So what have I done wrong?

Nothing - its asking you to manually resolve the conflict.  

> Did the pull complete and I just need to resolve this or
> do I need to redo the git-pull?

Take a look in these two files - you should see conflict markers of the form
<<<<<<<<<<<<<<<< 
some content
================
some other content
>>>>>>>>>>>>>>>>

which is the contents that failed from your side and the new version of the 
kernel you pulled in.

Edit so the files have sensible content

then use

git update-index <filename>

to tell git that that particular conflict has been resolved.


When you have done that for both files

just do 

git commit







-- 
Alan Chandler
