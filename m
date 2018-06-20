Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74DC51F403
	for <e@80x24.org>; Wed, 20 Jun 2018 23:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932735AbeFTXbt (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 19:31:49 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:41690 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932259AbeFTXbs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 19:31:48 -0400
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id VmZmfIFH7whzSVmZmfq4ZL; Thu, 21 Jun 2018 00:31:46 +0100
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.3 cv=e8Iot5h/ c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=IkcTkHD0fZMA:10 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=4RBUngkUAAAA:8 a=Nd32ofHJAAAA:20
 a=1XWaLZrsAAAA:8 a=P4Dod5UqqMsDCdVH5SkA:9 a=QEXdDO2ut3YA:10 a=dwJyxut4DK8A:10
 a=x8gzFH9gYPwA:10 a=AjGcO6oz07-iQ99wixmX:22 a=_sbA2Q-Kp09kWB8D3iXc:22
Message-ID: <C819900A5BFB45E0903348544ED79581@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Frank Li" <lznuaa@gmail.com>
Cc:     "\"msysGit\"" <msysgit@googlegroups.com>,
        "\"Git List\"" <git@vger.kernel.org>
References: <AANLkTi=87fUaOH3Y0PVeeH5N7oCVVJyKY3jsf93jw-t7@mail.gmail.com>
Subject: Re: [msysGit] Possible git status problem at case insensitive file system
Date:   Thu, 21 Jun 2018 00:31:46 +0100
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="UTF-8";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 180620-4, 20/06/2018), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfN0FiP3eZa9qAQQKwgS4iKUU+6/IltKbbm1YRnfUg+kThyE1vWdPEzhdr5KjjAqHJig7rVatu3drqP+36VHmW8rQ40kkFE7s3WvJw6arOhBUSzZawffM
 nEpc9URCSiG0XI/hG0zMCji5lsCYthh7VIyQK4LjM9DhMswNNx/pLBGqgXR0pc+OPXQxEgIhDWSjvqRqUdv7eLJlMbf61Pte+1Ov29ZywU2Kq31YULPwSJO5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Frank,

Your system Clock looks to be providing the wrong date for your emails.

The last XP version was 
https://github.com/git-for-windows/git/releases/tag/v2.10.0.windows.1 so you 
may want to upgrade to that. (see FAQs 
https://github.com/git-for-windows/git/wiki/FAQ)

It won't solve the capitalisation problem - that is a Windows FS issue. Git 
assumes case matters, but the FS will fetch directories and branches case 
insensitively.

Philip


----- Original Message ----- 
From: "Frank Li" <lznuaa@gmail.com>
To: "Git List" <git@vger.kernel.org>; "msysGit" <msysgit@googlegroups.com>
Sent: Monday, August 09, 2010 5:22 AM
Subject: [msysGit] Possible git status problem at case insensitive file 
system


> All:
>        I use msysgit 1.7.0.2 at windows xp.
>        Problem: git status will list tracked directory as untracked dir.
>        Duplicate:
>        1. mkdir test, cd test
>        2. git init-db
>        3. mkdir d, cd d
>        4. touch a.c
>        5. git add a.c
>        6. git commit -a -m "test"
>        7. cd ..
>        8.  mv d d1
>        9.  mv d1 D
>       10. git status
>
>
> # On branch master
> # Untracked files:
> #   (use "git add <file>..." to include in what will be committed)
> #
> #       D/
> nothing added to commit but untracked files present (use "git add" to 
> track)
>
>        D/ should be same as d/ at case insensitive file system.
>        D/ should not listed by git status.
>
> best regards
> Frank Li
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> -- 
> -- 
> *** Please reply-to-all at all times ***
> *** (do not pretend to know who is subscribed and who is not) ***
> *** Please avoid top-posting. ***
> The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github 
> accounts are free.
>
> You received this message because you are subscribed to the Google
> Groups "msysGit" group.
> To post to this group, send email to msysgit@googlegroups.com
> To unsubscribe from this group, send email to
> msysgit+unsubscribe@googlegroups.com
> For more options, and view previous threads, visit this group at
> http://groups.google.com/group/msysgit?hl=en_US?hl=en
>
> --- 
> You received this message because you are subscribed to the Google Groups 
> "Git for Windows" group.
> To unsubscribe from this group and stop receiving emails from it, send an 
> email to msysgit+unsubscribe@googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
> 

