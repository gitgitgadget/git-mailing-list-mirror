Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2331E1F453
	for <e@80x24.org>; Mon, 29 Apr 2019 13:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfD2Ngb (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Apr 2019 09:36:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:39225 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbfD2Ngb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Apr 2019 09:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1556544983;
        bh=8AF7uIuYrHYBqVMSwYJgG5GdDJO6lqNPyuDWB4sW99s=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LVuq7uPyyXJqhAPuDSFzTL03DVQ9oPJ7bplRhw68CMy0MpVb/WN9Me8B/3IKm+ktc
         kDH5f7zHb7A1E3xfRXedBlkSvCsJXV/o3Qv2kas6o3yczGTb9qX8ejzd4WMIUUNjZ0
         RYMQSmcwqwMxt0xfoA/0lX8/EVTszd5/KcffE5TY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [10.106.210.16] ([167.220.152.144]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LbA4j-1gwzvC1NUH-00keAZ; Mon, 29
 Apr 2019 15:36:23 +0200
Date:   Mon, 29 Apr 2019 09:36:25 -0400 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: Re: do people find t5504.8 flaky?
In-Reply-To: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1904290927210.45@tvgsbejvaqbjf.bet>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c1z7yDkujtzd+GbsupRjZHDaNeRx0tLpADorDIgzIqZltiHR7MM
 TD3JhqHLETj/EhHlLNGVUKp0rfI8N+0BOhmSHodpEa/ZNozZ8GMOoP6TCjMr8MH3i1txBrt
 Q0U/qC6jeZsHcR9nEnB8JhaQgarhbp3EUeOvTStAWZHpm5y0FrefXWGgPXy3tVp4BiI6w4F
 mXKXKu+Eag6wDA+71Daiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I8B/JfDHSCY=:BvKdCBbZSS0QZon/UnuJ9p
 cbczBeVcf7n64RA/b2T1UJZdTK+RL20ZGghp3nyqjRH0Bwzq+m8OhITHojoUlCtvFf09doImu
 QgyUsb93jgZARgxBlFEUF5J3TdxiQuSjcGP7bHYZLVqo81ksTTiSI1oLk0jA1QBv5MoaXvMCN
 qQOGVSE3TAD+0IHYTyJRxOa41W8ZnwaIPdnljl5aCQvSrDlghm/rIap3yoHQc9HcorPW9zrRE
 qFGeagTLLds2ZLg72G3oAD4LEKbgG/dBCcsE1ib+esrkLoDNi/0ur4Bf1IvJSEu1dt4VwHn3P
 GL3fto8GFsTMxQxA34oVL41HFEo1e1R7RqtL5l6BMsNGVY47OCMdN6lMguHqCcIx8uxrRSvim
 K2xkDCAFnLmwhONUw5kJHNf+q4UcLjPmd5g7FAowJqsp+Ps7RjzQn98HBSUmsb9RYfI8Jcn4e
 KI+Wy1SvPRZgEp+Tb2qseS9e08TZD9X9YGg317jQGQcd6G6xbHtQ3aDAR/gopQoKy0piN0AZg
 eM/nsgAN5irAfyRw4mUTtYKGKrRcKw50Ui1NQXjxfC0NFvfi4ICaIzcfqGERzj5a/9k6YuZm/
 ixcSZbmPlVzKwrvYVgz6Ar1CY6OO7chJa2lEcMtmaG8D4mR6j/qnFqTkrPbCFt4iRE5rSYahg
 QAK2i9TXywx5/z+8P/xEF8W8KR9asbkS2IK9BquMtFSZkPBcvxW25uptFHD4YmKeqhGCSFTXN
 a8v9BlSEYtPoEQ31rj3JuiyZIToMJAQoL+gv/YvchEDF9SAgZDk2nMzWGGj56WvNxMAiXR/Mp
 az2lK5VbnVIFecwOcQ8/h5IpMZKwGGibKVho8g/fAxqrzLh5i5xNazdytFw6VofCOlU6uaIsc
 aLg/fq+ue3IOevokp+9zC7NHthQuGxJJdqGQmAbLmHVFrKuWaq/dcaM/YpJ5z986EW7/WkX+M
 dFZu7lUKQBg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 23 Apr 2019, Junio C Hamano wrote:

> I have been seeing occasional failures of t5504-fetch-receive-strict
> test on the cc/replace-graft-peel-tags topic, but it seems that the
> fork point of that topic from the mainline already fails the same
> step #8, only less frequently.

Sounds familiar. IIRC it fails on Azure Pipelines from time to time, most
often in linux-clang, less often in linux32. But I don't have hard data on
that, I am still trying to get a grip on making the CI builds more robust
without having to ask you to integrate azure-pipelines.yml changes into
*all* branches.

Currently, my idea is to have two different Azure Pipelines set up: one
that performs the continuous testing using azure-pipelines.yml on your
maint, master, next and pu (do you want jch, too?) [*1*], and one that has
a separate build definition and tries to work around many (all?) known
issues with existing branches, e.g. coping with the known SIGPIPE issues
in the git-daemon tests on macOS that *have* been addressed in master but
not in some of the other branches that are accumulated into pu [*2*]. This
latter build is *not* using azure-pipelines.yml, but a build definition
that is maintained directly in Azure Pipelines ("Visual Designer" is what
this feature is called in Azure Pipelines).

Ciao,
Dscho

Footnote *1*: https://dev.azure.com/gitgitgadget/git/_build?definitionId=6

Footnote *2*: https://dev.azure.com/gitgitgadget/git/_build?definitionId=4
