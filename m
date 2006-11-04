X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Kevin Shanahan <kmshanah@disenchant.net>
Subject: Re: Problem with git-apply?
Date: Sat, 4 Nov 2006 18:37:51 +1030
Message-ID: <20061104080751.GB19667@cubit>
References: <20061104072349.GA19667@cubit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 08:08:18 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061104072349.GA19667@cubit>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30909>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgGZX-0006j8-0B for gcvg-git@gmane.org; Sat, 04 Nov
 2006 09:08:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964871AbWKDIH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 03:07:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964876AbWKDIH5
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 03:07:57 -0500
Received: from whirlwind.netspace.net.au ([203.10.110.76]:54285 "EHLO
 mail.netspace.net.au") by vger.kernel.org with ESMTP id S964871AbWKDIH5
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 03:07:57 -0500
Received: from mail.localnet (dsl-202-45-120-45-static.SA.netspace.net.au
 [202.45.120.45]) by mail.netspace.net.au (Postfix) with ESMTP id 3D632131D0A
 for <git@vger.kernel.org>; Sat,  4 Nov 2006 19:07:53 +1100 (EST)
Received: by mail.localnet (Postfix, from userid 1000) id 9923CBB00D2; Sat, 
 4 Nov 2006 18:37:51 +1030 (CST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

On Sat, Nov 04, 2006 at 05:53:49PM +1030, Kevin Shanahan wrote:
> I seem to be having problems using git-apply to apply any patch which
> creates a new file. Unfortunately it's been a few weeks since I last
> used git here locally, but this seems like some behaviour change since
> the last version I was using. I'm currently using version 1.4.3.3 from
> Debian Sid. This little test script demonstrates the problem I'm
> having:

Sorry, I probably should have said to CC me, as I'm not subscribed.

Thanks for your reply Shawn, but --index doesn't seem to make any
difference. If it helps, I can confirm that the script works fine with
version 1.4.1.1.

> #!/bin/sh
> 
> mkdir a b repo
> echo foo > b/foo
> diff -urN a b > test.diff
> 
> (
>     cd repo
>     echo bar > bar # need something to init the db
>     git init-db
>     git add .
>     git commit -a -m "Test Commit"
> 
>     git apply ../test.diff
>     git commit -a -m "Test Commit (file added)"
> )
> 
> Here, this outputs for me:
> 
> defaulting to local storage area
> Committing initial tree ee314a31b622b027c10981acaed7903a3607dbd4
> error: foo: No such file or directory
> nothing to commit
> 
> Has something broken or am I doing something wrong here?
> 
> Thanks,
