Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0987A2023D
	for <e@80x24.org>; Mon, 22 May 2017 16:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935855AbdEVQgo (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 12:36:44 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:39813 "EHLO bsmtp1.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934291AbdEVQgn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 12:36:43 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp1.bon.at (Postfix) with ESMTPSA id 3wWknc6Fkxz5tlN;
        Mon, 22 May 2017 18:36:36 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 254F14329;
        Mon, 22 May 2017 18:36:35 +0200 (CEST)
Subject: Re: [PATCH 0/2] Fix warnings on access of a remote with Windows paths
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <cover.1495261020.git.j6t@kdbg.org>
 <alpine.DEB.2.21.1.1705221357360.3610@virtualbox>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <947b2453-52b6-4940-fd20-ddf350c5df4d@kdbg.org>
Date:   Mon, 22 May 2017 18:36:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1.1705221357360.3610@virtualbox>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 22.05.2017 um 13:59 schrieb Johannes Schindelin:
> On Sat, 20 May 2017, Johannes Sixt wrote:
>> This small series fixes these warnings on Windows:
>>
>> C:\Temp\gittest>git fetch C:\Temp\gittest
>> warning: unable to access '.git/remotes/C:\Temp\gittest': Invalid argument
>> warning: unable to access '.git/branches/C:\Temp\gittest': Invalid argument
>>  From C:\Temp\gittest
>>   * branch            HEAD       -> FETCH_HEAD
>>
>> The fix is in the second patch; the first patch is a
>> preparation that allows to write the fix in my preferred style.
> 
> Thank you!
> 
> Maybe you want to accompany these patches with a simple test case that
> uses e.g. ls-remote on $(pwd | tr / \\\\)?

Actually, no, I don't want to. It would have to be protected by MINGW, 
and I don't want to burden us (and here I mean Windows folks) with a 
check for a cosmetic deficiency. (Shell scripts, slow forks, yadda, 
yadda...)

-- Hannes
