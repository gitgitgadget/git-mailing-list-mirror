Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6D61F462
	for <e@80x24.org>; Sun, 16 Jun 2019 22:49:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbfFPWta (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jun 2019 18:49:30 -0400
Received: from smtp-out-3.talktalk.net ([62.24.135.67]:24934 "EHLO
        smtp-out-3.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfFPWta (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jun 2019 18:49:30 -0400
Received: from [192.168.1.22] ([89.243.184.39])
        by smtp.talktalk.net with SMTP
        id cdxmhZnkXdraxcdxmhZYBE; Sun, 16 Jun 2019 23:49:26 +0100
X-Originating-IP: [89.243.184.39]
X-Spam: 0
X-OAuthority: v=2.3 cv=QfUYQfTv c=1 sm=1 tr=0 a=3GZFt4OQGy0NQQxJwP7nlQ==:117
 a=3GZFt4OQGy0NQQxJwP7nlQ==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=IkcTkHD0fZMA:10 a=a_U1oVfrAAAA:8 a=yMhMjlubAAAA:8 a=B7zLjwyU46utUBqsHqgA:9
 a=QEXdDO2ut3YA:10 a=ILgoY2Ve9XsnFM_ECIJt:22
Subject: Re: commit sized around 100 gb in changes failed to push to a TFS
 remote - Git
To:     "Aram Maliachi (WIPRO LIMITED)" <v-armal@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "Kranz, Peter" <kranz.peter.ext@siemens-healthineers.com>,
        "Brettschneider, Marco" 
        <marco.brettschneider.ext@siemens-healthineers.com>
References: <MN2PR21MB1231B057E9E662BB151B2819E9EF0@MN2PR21MB1231.namprd21.prod.outlook.com>
 <DE8A44FD55B8BE44AC9861D8ECF567F801FEEC1D@DEFTHW99EM2MSX.ww902.siemens.net>
 <MN2PR21MB1231DB1D2FCE7622F0AED616E9EE0@MN2PR21MB1231.namprd21.prod.outlook.com>
From:   Philip Oakley <philipoakley@iee.org>
Message-ID: <ae1936db-00ab-0c9b-3d50-7b5b50e68771@iee.org>
Date:   Sun, 16 Jun 2019 23:49:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <MN2PR21MB1231DB1D2FCE7622F0AED616E9EE0@MN2PR21MB1231.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-CMAE-Envelope: MS4wfGsd4cYTAq2rHO2g4mVkN0DPDVsXL8wYp3N3M51DO4kVdg/cmTRxzhPsnR0evlzAt8AQhDnmdQSm7LTK6CTm6GaAWaUy67L7+y+SI0keLfPJOkw8lHwq
 JOgLNQU3YI59JXdnEp/SOynpXVhaY1uEvC83s1HcmlAsA8HopDbnwvML6b5lYQo3n1bcSsvvb9hPGFh418LRiK3Ch0ImtVzDxjudh6qEXRjS0VkDs+0G0HW8
 sNmp12Fm2svzEAjVNLi8W4zbv6g0Bkx84Bdy7hoKCm6Mqh6fQ+7Q0zojVGeKW5+tzfvZMUn940oHEkq63Ik90vla4FLr4ecIlkZfDeUOtGQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Aram
On 14/06/2019 17:47, Aram Maliachi (WIPRO LIMITED) wrote:
> To @Git Community
>  From the perspective of an Azure DevOps support engineer. I have a customer who is unable to make a push with following error:
>
> fatal: The remote end hung up unexpectedly
> failed to push some refs into https://zelos.healthcare.siemens.com/tfs/Hoover/VA20A.DevInt.Gvfs/_git/Saturn
>
> The local repository has only one change when comparing it to the remote and it is a commit labelled with SHA value: 504aedfdbb to a branch called gitTest
> This being said the scheme is as following:
>
> [Remote] - master
> b946c27c
>
> [Local] - gitTest branch
> 504aedfdbb
> b946c27c
>
>
> Important data:
> - The commit 504aedfdbb contains +100 GB in file changes
> - The remote git repository is a TFS server
> - Customer isn't building code - it is using the remote kind of as a storage service <- We understand these are not best practices but is the way customer is using Git and TFS. If @Git Community could confirm/elaborate on this customer may change up the current approach he is using.
>
> Things tried:
> - reset the history for the local repository back to the latest shared commit b946c27c  and committed something small which succeeded to push into remote into a brand new branch by running $ git push origin <name of local branch>
> - cherry-picked the commit into local master and attempted to push = failed. <- this makes me think this is entirely caused by the oversized commit
> - boosted up the http post buffer configuration = failed. Rolled configuration back to default according to the MSFT docs https://docs.microsoft.com/en-us/azure/devops/repos/git/rpc-failures-http-postbuffer?view=azure-devops
> - since this is a TFS server I initially though this could be caused by insufficient disk storage capacity in the server containing the TFS product. But @Vimal Thiagaraj has confirmed that the repositories size limit depend upon the remote TFS databases and not the server itself. Is there a limit on these databases or on how much changes can a git commit contain?
>
> Things I've suggested to customer:
> - commit more frequently in smaller batches
> - understand that the nature of git is to collaborate and track versions of files over time - not a cloud storage provider
>
> Would appreciate any insight on this @Git Community. Thanks to @Phillip Oakley who took the time to answer last time I posted a question to this mailing list.
Can you confirm the operating system versions and Git versions for the 
machine doing the push and the server attempting the receiving? 
Especially are either of them Windows systems which currently have a 
32bit size limit (which is sizeof(long)..).

I have a patch series in review on the Git-for-Windows Github repo 
(#2179) that should allow objects and packs greater than 4Gb. However..

This may still be a limit on the 'transfer' process (100Gb could take a 
long time, have time outs, break internal virus checkers that monitor 
the feed, etc).

Philip
