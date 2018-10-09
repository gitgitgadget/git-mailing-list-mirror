Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DF5D1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 00:10:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725874AbeJJH3i (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 03:29:38 -0400
Received: from cp423.agava.net ([80.78.250.67]:2919 "EHLO cp423.agava.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725811AbeJJH3i (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 03:29:38 -0400
X-Greylist: delayed 1891 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Oct 2018 03:29:38 EDT
Received: from [176.117.192.62] (port=52664 helo=[127.0.0.1])
        by cp423.agava.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <artem.semenov@jarillolabs.com>)
        id 1gA1aO-0005QH-In
        for git@vger.kernel.org; Wed, 10 Oct 2018 02:38:44 +0300
From:   =?UTF-8?B?0JDRgNGC0LXQvCDQodC10LzQtdC90L7Qsg==?= 
        <artem.semenov@jarillolabs.com>
Subject: Git svn bug on merging svn branches
To:     git@vger.kernel.org
Message-ID: <49aa05bf-1848-51ca-8b98-5f1796dd8bdf@jarillolabs.com>
Date:   Wed, 10 Oct 2018 02:38:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cp423.agava.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - jarillolabs.com
X-Get-Message-Sender-Via: cp423.agava.net: authenticated_id: artem.semenov@jarillolabs.com
X-Authenticated-Sender: cp423.agava.net: artem.semenov@jarillolabs.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello.

Git svn bug on merging svn branches:

Svn repository (branches tag trunk).

1. Add a some file by svn tools.
2. Create a new branch by svn tools (e.g. br1) .
3. Create a new branch by svn tools on branch br1 (e.g. br2).
4. Add some changes to file f1 in branch br1. Commit by svn tools.
5. Clone repository by git svn.
6. Create two local branches – br1_svn (on origin/br1) and br2_svn (on 
origin/br2);
7. Checkout to br2_svn. Add some changes (e.g add file f2). Execute git 
add, git commit.
8. Execute “git merge br1_svn”.
9. Checkout to br1_svn.
10. Execute “git svn info” - URL refers to br1. (URL: 
https://127.0.0.1/svn/branchtest/branches/br1)
11. Execute “git merge br2_svn”.
12. Execute “git svn info” - URL refers to br2. (URL: 
https://127.0.0.1/svn/branchtest/branches/br2)

-- 
With my best regards,
  Artem Semenov               mailto:artem.semenov@jarillolabs.com
