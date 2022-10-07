Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D17AC433FE
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 10:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbiJGKDo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 06:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiJGKDm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 06:03:42 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C0A87A2
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 03:03:40 -0700 (PDT)
Received: from 88-110-102-84.dynamic.dsl.as9105.com ([88.110.102.84] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1ogkCg-000Bwr-7Q;
        Fri, 07 Oct 2022 11:03:38 +0100
Message-ID: <8e11ecf0-735a-a104-a3d1-8324fbd76862@iee.email>
Date:   Fri, 7 Oct 2022 11:03:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [feature request] resume capability for users in enemies of
 Internet countries
Content-Language: en-GB
To:     Eric Wong <e@80x24.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, m <mahg361@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>
References: <6e4a08d2-5d72-29fd-6917-11f0a74e9314@gmail.com>
 <83814bcb-1d72-07bf-32d1-d05db6cc6481@gmail.com>
 <20221007071459.GM28810@kitsune.suse.cz> <20221007072606.M704368@dcvr>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20221007072606.M704368@dcvr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/2022 08:26, Eric Wong wrote:
> Michal Suchánek <msuchanek@suse.de> wrote:
>> On Fri, Oct 07, 2022 at 08:44:09AM +0700, Bagas Sanjaya wrote:
>>> On 10/7/22 01:01, m wrote:
>>>> In my country government make connections unstable on purpose. Please add resume capability for commands like git clone
>>>>
>>> Bandwidth issue?
>>>
>> Bandwidth is one thing but the other thing is that git network
>> operations require that the whole operation succeeds in one go.
>>
>> If your connectivity is bad to the point that the TCP connection breaks
>> you have downloaded a bunch of data that is AFAIK just thrown away when
>> you retry.
>>
>> It is difficult to know if that data would be useful in the future, and
>> you cannot meaningfully 'resume' because the remote state might have
>> changed in the meantine as well.
>>
>> Further, this whole fetch operation is using a heuristic to fetch some
>> data in the hope that it will be enough to reconstruct the history that
>> is requested, and this has been wrong in some cases, too. Not very
>> precise and reproducible hence hard to 'resume' as well.
>>
>> Let's say that the git networking has been developed at and tuned for
>> the 'first world' Internet, and may be problematic to use in net-wise
>> backwater areas. And it would require non-trivial effort to change.
> Increased adoption of bundles would help, since `wget -c' and such
> would work nicely, but that puts the burden on hosts for extra storage.
>
> Perhaps GIT_SMART_HTTP=0 and having dumb clones not throwaway
> incomplete xfers would be more transparent to hosters, but dumb
> HTTP tends to be slow even on good connections.

There is work going on by Stollee (cc'd) on Bundle-URIs that look to
split up repository serving into bite sized chunk, so may be worth
looking at.
https://lore.kernel.org/git/pull.1248.v4.git.1660050761.gitgitgadget@gmail.com/
: [PATCH v4 0/2] bundle URIs: design doc

Also discussed at the recent Contributor's Summit
https://lore.kernel.org/git/YzXvwv%2FzK5AjhVvV@nand.local/ : [TOPIC 1/8]
Bundle URIs

--
Philip
