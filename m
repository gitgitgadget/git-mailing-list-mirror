Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4620F1F463
	for <e@80x24.org>; Mon, 16 Sep 2019 09:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbfIPJpv (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Sep 2019 05:45:51 -0400
Received: from wp558.webpack.hosteurope.de ([80.237.130.80]:36394 "EHLO
        wp558.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726387AbfIPJpu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 16 Sep 2019 05:45:50 -0400
X-Greylist: delayed 2609 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Sep 2019 05:45:50 EDT
Received: from mail1.i-concept.de ([130.180.70.237] helo=[192.168.122.235]); authenticated
        by wp558.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1i9mto-0004aO-DI; Mon, 16 Sep 2019 11:02:20 +0200
To:     git <git@vger.kernel.org>
From:   Stefanie Leisestreichler <stefanie.leisestreichler@peter-speer.de>
Subject: Git diff|status against remote repo
Message-ID: <3218b394-4dcf-0b99-c561-b1811f0be3d6@peter-speer.de>
Date:   Mon, 16 Sep 2019 11:02:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-bounce-key: webpack.hosteurope.de;stefanie.leisestreichler@peter-speer.de;1568627150;a30930a6;
X-HE-SMSGID: 1i9mto-0004aO-DI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi.

I am far from being a pro in git.
There is something I do not understand.

This is my git config:
[core]
         repositoryformatversion = 0
         filemode = true
         bare = false
         logallrefupdates = true
[remote "origin"]
         url = ssh://git@192.168.2.2:/home/git/PROJECT.git
         fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
         remote = origin
         merge = refs/heads/master
[branch "develop"]
         remote = origin
         merge = refs/heads/develop

I have a local repo called "develop" also on each involved dev machine.

Developer A has made changes on nearly each file of the project by 
changing the namespace and locally commited those changes to his local 
branch "develop". After that he did a git push.

On a not involved machine M I did a git clone 
ssh://git@192.168.2.2:/home/git/PROJECT.git and after that I did a "git 
checkout develop" which was followed by a message like "Branch develop 
is following remote branch develop from origin". I can see all the 
changes Developer A has made.

On my machine DEV I am on my local branch develop. Since I did not pull 
or merge from origin already, I am not able to see any of those changes 
developer A has made. So far so good. But I would expect, that git 
status (which results in "On branch develop. Your branch is up to date 
with origin/develop) or "git diff origin/develop develop" or "git diff 
origin/develop...develop" (both no output at all) would give me a hint 
that I am x commits behind origin/master or (git diff) will show me the 
changes Developer A committed to the Repro. But nothing...

What am I doing wrong?

Thanks,
Steffi

