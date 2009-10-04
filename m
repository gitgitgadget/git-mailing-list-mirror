Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: **
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=2.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD,STOX_REPLY_TYPE,
	STOX_REPLY_TYPE_WITHOUT_QUOTES,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: (qmail 10651 invoked by uid 107); 4 Oct 2009 12:28:23 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Sun, 04 Oct 2009 08:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbZJDMWW (ORCPT <rfc822;peff@peff.net>);
	Sun, 4 Oct 2009 08:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754682AbZJDMWW
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Oct 2009 08:22:22 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:62932 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754398AbZJDMWV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Oct 2009 08:22:21 -0400
Received: by bwz6 with SMTP id 6so1935291bwz.37
        for <git@vger.kernel.org>; Sun, 04 Oct 2009 05:21:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:from:to:subject
         :date:mime-version:content-type:content-transfer-encoding:x-priority
         :x-msmail-priority:x-mailer:x-mimeole;
        bh=4sYDJZDMQcKlQHTORPajhHD4r2KsV1WjMTG4d4K5DoM=;
        b=PfAwxKIbsTtfOuKEIkrpfVKI4cDEpfYeMAgBuCkGe0VCk4CVNxWcSHmCHTmRiZNR2a
         fiZjebZ+oKdfMAiw+BJX9kAywNhi/phYbEvzW8beYd232Yv0J/WD2tauAP6hHJnjviTf
         UukHmOyd7khHwmc+JR1sLwUL9iUWRxgZqkZ+Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:from:to:subject:date:mime-version:content-type
         :content-transfer-encoding:x-priority:x-msmail-priority:x-mailer
         :x-mimeole;
        b=o4pAMzH3Rscwlh9Tdgx+ve8crzIEpiZi47FCrRzuwrB99kxVk2pT8Bqdf8jrj6jjc5
         uOxgqjpWr8kC/RITMBjFfJl/1rALcwG+ceo39QDfxso61mGn8y5KEj9Y3/v4zIoD6+AK
         +WhRNBWLGgZHIZ5cI16M0maXhNLjKcomOhRAI=
Received: by 10.204.162.143 with SMTP id v15mr3013789bkx.50.1254658903616;
        Sun, 04 Oct 2009 05:21:43 -0700 (PDT)
Received: from teddy ([81.180.162.194])
        by mx.google.com with ESMTPS id g28sm2360659fkg.15.2009.10.04.05.21.43
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 04 Oct 2009 05:21:43 -0700 (PDT)
Message-ID: <98300251CB1D46A0B635B4495138C3A7@teddy>
From:	=?utf-8?B?T2N0YXZpYW4gUsOixZ9uacWjxIM=?= <orasnita@gmail.com>
To:	<git@vger.kernel.org>
Subject: reset doesn't reset a revert?
Date:	Sun, 4 Oct 2009 15:18:36 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5843
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.5579
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi,

Under Windows XP, using git version 1.6.4.msysgit.0, I have tried:

E:\lucru\git\k>echo foo > file.txt
E:\lucru\git\k>echo bar >> file.txt
E:\lucru\git\k>git init
Initialized empty Git repository in E:/lucru/git/k/.git/
E:\lucru\git\k>git add .
warning: CRLF will be replaced by LF in file.txt.
E:\lucru\git\k>git commit -a
[master (root-commit) e969cd5] First commit
warning: CRLF will be replaced by LF in file.txt.
1 files changed, 2 insertions(+), 0 deletions(-)
create mode 100644 file.txt
E:\lucru\git\k>echo baz >> file.txt
E:\lucru\git\k>git commit -a
warning: CRLF will be replaced by LF in file.txt.
warning: CRLF will be replaced by LF in file.txt.
[master warning: CRLF will be replaced by LF in file.txt.
fabd2f2] Added baz to file.txt
1 files changed, 1 insertions(+), 0 deletions(-)
E:\lucru\git\k>type file.txt
foo
bar
baz

#Until here, everything's OK.

E:\lucru\git\k>git  revert HEAD~
fatal: Cannot revert a root commit

#Does anyone know what does this mean? So I've tried with HEAD^ instead.

E:\lucru\git\k>git  revert HEAD^
More?
More?
Finished one revert.
[master 1beba20] Revert "Added baz to file.txt"
1 files changed, 0 insertions(+), 1 deletions(-)

# What should I respond to the questions More?
#I've seen that no matter what I type, it adds to the "HEAD" and tells that 
that commit can't be found, so I just pressed enter.

E:\lucru\git\k>git status
# On branch master
nothing to commit (working directory clean)
E:\lucru\git\k>git log --pretty=format:"%s %h"
WARNING: terminal is not fully functional
Revert "Added baz to file.txt" 1beba20
Added baz to file.txt fabd2f2
First commit e969cd5
(END)

#It seems that the revert commit was added successfully.

E:\lucru\git\k>type file.txt
foo
bar

#And it seems that not only the repository was changed, but the working 
directory also. Is it correct?

#Well, now let's say I discovered that this new commit was an error and I 
want to reset it.
#And I used HEAD^ because HEAD~ didn't work with revert.

E:\lucru\git\k>git reset HEAD^
More?
More?
E:\lucru\git\k>git log --pretty=format:"%s %h"
WARNING: terminal is not fully functional
Revert "Added baz to file.txt" 1beba20
Added baz to file.txt fabd2f2
First commit e969cd5
(END)

#Well, git reset didn't reset the latest commit.
#Does anyone know why or what I am doing wrong?

E:\lucru\git\k>git status
# On branch master
nothing to commit (working directory clean)
E:\lucru\git\k>git reset HEAD~
file.txt: locally modified
E:\lucru\git\k>git log --pretty=format:"%s %h"
WARNING: terminal is not fully functional
Added baz to file.txt fabd2f2
First commit e969cd5
(END)

#This time git reset resetted the latest HEAD.
#It seems that git reset wants the HEAD~ commit, while git revert wants the 
HEAD^ commit. Do you know why (or can I find an explanation for this 
somewhere)?

E:\lucru\git\k>type file.txt
foo
bar

#However, git reset modified just the repository and not the working 
directory.

I added the line baz in the file file.txt, commited this change and then 
reverted to the previous commit. This has also deleted the line "baz" from 
the file.
Then I resetted the last commit (the revert), however the line "baz" didn't 
appear in the file.

Is this something normal I should expect, or I am doing something wrong?

Thank you very much.

Octavian

