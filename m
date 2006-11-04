X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Kevin Shanahan <kmshanah@disenchant.net>
Subject: Problem with git-apply?
Date: Sat, 4 Nov 2006 17:53:49 +1030
Message-ID: <20061104072349.GA19667@cubit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 07:24:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30906>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgFst-0006Xj-FF for gcvg-git@gmane.org; Sat, 04 Nov
 2006 08:24:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964809AbWKDHXz (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 02:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWKDHXz
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 02:23:55 -0500
Received: from cumulus.netspace.net.au ([203.10.110.72]:7180 "EHLO
 mail.netspace.net.au") by vger.kernel.org with ESMTP id S964809AbWKDHXz
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 02:23:55 -0500
Received: from mail.localnet (dsl-202-45-120-45-static.SA.netspace.net.au
 [202.45.120.45]) by mail.netspace.net.au (Postfix) with ESMTP id 679F967F6F
 for <git@vger.kernel.org>; Sat,  4 Nov 2006 18:23:51 +1100 (EST)
Received: by mail.localnet (Postfix, from userid 1000) id 992A2BB00D2; Sat, 
 4 Nov 2006 17:53:49 +1030 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

Hi,

I seem to be having problems using git-apply to apply any patch which
creates a new file. Unfortunately it's been a few weeks since I last
used git here locally, but this seems like some behaviour change since
the last version I was using. I'm currently using version 1.4.3.3 from
Debian Sid. This little test script demonstrates the problem I'm
having:

#!/bin/sh

mkdir a b repo
echo foo > b/foo
diff -urN a b > test.diff

(
    cd repo
    echo bar > bar # need something to init the db
    git init-db
    git add .
    git commit -a -m "Test Commit"

    git apply ../test.diff
    git commit -a -m "Test Commit (file added)"
)

Here, this outputs for me:

defaulting to local storage area
Committing initial tree ee314a31b622b027c10981acaed7903a3607dbd4
error: foo: No such file or directory
nothing to commit

Has something broken or am I doing something wrong here?

Thanks,
