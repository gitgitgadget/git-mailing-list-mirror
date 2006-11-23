X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>
Subject: Pull and fetch
Date: Thu, 23 Nov 2006 20:39:50 +0100
Message-ID: <20061123203950.5d47421f@paolo-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 23 Nov 2006 19:40:16 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=gVvPhfb7LscQ8lAjvPuhchdJVCITH1WCYXNvJT7ZHUCfeR3LwyiP5h0iKQ+I3El/B/eGTUeOdXf4wi+lqZsdx5+/kG82g4rSMfpcv7HhGU76/TaxvV15sa8kUeapnu2Qk9jTrHbvtHgvxGdaOwERcEUxa5QlYnkDHwYCiJMsE0g=
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32154>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GnKQb-0003jX-Rd for gcvg-git@gmane.org; Thu, 23 Nov
 2006 20:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757456AbWKWTj6 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 23 Nov 2006
 14:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757458AbWKWTj6
 (ORCPT <rfc822;git-outgoing>); Thu, 23 Nov 2006 14:39:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:27059 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1757456AbWKWTj5
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 23 Nov 2006 14:39:57 -0500
Received: by nf-out-0910.google.com with SMTP id o25so983588nfa for
 <git@vger.kernel.org>; Thu, 23 Nov 2006 11:39:56 -0800 (PST)
Received: by 10.49.10.3 with SMTP id n3mr4810855nfi.1164310795956; Thu, 23
 Nov 2006 11:39:55 -0800 (PST)
Received: from paolo-desktop ( [87.0.67.108]) by mx.google.com with ESMTP id
 z73sm7006308nfb.2006.11.23.11.39.55; Thu, 23 Nov 2006 11:39:55 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi all,
I'm still reading git tutorial.txt and I'm again confused.

  A more cautious Alice might wish to examine Bob's changes before
  pulling them.  She can do this by creating a temporary branch just
  for the purpose of studying Bob's changes:

  -------------------------------------
  $ git fetch /home/bob/myrepo master:bob-incoming
  -------------------------------------

  which fetches the changes from Bob's master branch into a new branch
  named bob-incoming.  (Unlike git pull, git fetch just fetches a copy
  of Bob's line of development without doing any merging).  Then

  -------------------------------------
  $ git log -p master..bob-incoming
  -------------------------------------

  shows a list of all the changes that Bob made since he branched from
  Alice's master branch.

OK, make sense. So let's try with an experiment:
paolo@paolo-desktop:~$ mkdir test
paolo@paolo-desktop:~$ cd test
paolo@paolo-desktop:~/test$ git-init-db 
defaulting to local storage area
paolo@paolo-desktop:~/test$ git fetch ../git master:testbranch
warning: no common commits
remote: Generating pack...
[skip]
paolo@paolo-desktop:~/test$ git pull ../git master:testbranchpull
* refs/heads/testbranchpull: storing branch 'master' of ../git
  commit: e945f95

Now I have 3 branches:
paolo@paolo-desktop:~/test$ git branch
* master
  testbranch
  testbranchpull

All the branches have the same content, I expect to see differences between testbranch 
and testbranchpull. The first one is the end result of a fetch, the second one is
the end result of a pull.

git status always says:
  nothing to commit

Why?
What will happen if I repeat the same commands:
  git fetch ../git master:testbranch
  git pull ../git master:testbranchpull
after a change in the git master branch?

Thanks in advance?

Kind regards,
Paolo Ciarrocchi
