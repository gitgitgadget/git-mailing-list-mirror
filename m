X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
Subject: git-svn and rebase causes duplicate  log entries in svn
Date: Tue, 14 Nov 2006 22:49:14 +0100
Message-ID: <00ff01c70836$ba7e3d00$1e67a8c0@Jocke>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Tue, 14 Nov 2006 21:49:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
Thread-Index: AccINrn2O63BMLgaSPm3hvXSmxtvnQ==
X-OriginalArrivalTime: 14 Nov 2006 21:49:20.0745 (UTC) FILETIME=[BDB65D90:01C70836]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31382>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk69p-0006us-V8 for gcvg-git@gmane.org; Tue, 14 Nov
 2006 22:49:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966381AbWKNVtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 16:49:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966389AbWKNVtY
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 16:49:24 -0500
Received: from 147.175.241.83.in-addr.dgcsystems.net ([83.241.175.147]:26686
 "EHLO tmnt04.transmode.se") by vger.kernel.org with ESMTP id S966381AbWKNVtY
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 16:49:24 -0500
Received: from Jocke ([84.217.89.56]) by tmnt04.transmode.se with Microsoft
 SMTPSVC(5.0.2195.6713); Tue, 14 Nov 2006 22:49:20 +0100
To: <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

I have my own u-boot tree with a local branch where I do my own development.
This this branch(called svn) is connected to a svn repo using git-svn.

Now I want to rebase my svn branch against latest u-boot and commit
my rebased svn branch to svn.

I use git-svn commit -b svn -q remotes/git-svn..svn to commit my latest
changes and when I do so I see my local changes once more in the svn log:
------------------------------------------------------------------------
r321 | jocke | 2006-11-14 09:45:14 +0100 (Tue, 14 Nov 2006) | 2 lines

Add install of HRCW into I2C EEPROM.

and here:
------------------------------------------------------------------------
r46 | jocke | 2006-11-13 19:09:19 +0100 (Mon, 13 Nov 2006) | 2 lines

Add install of HRCW into I2C EEPROM.

Any way to avoid that?

Question, I found that 
  git-svn fetch && git-rebase remotes/git-svn^2 svn
leaves the svn branch at the tip of my latest commit in the
svn branch which makes better sense to me then
  git-svn fetch && git-rebase remotes/git-svn svn
which puts svn at HEAD of remotes/git-svn.

Any reason I should not do the ...-svn^2 variant?

I am using git 1.4.3.5 and subversion 1.4.0
