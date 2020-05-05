Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F75C47254
	for <git@archiver.kernel.org>; Tue,  5 May 2020 20:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B38E22075A
	for <git@archiver.kernel.org>; Tue,  5 May 2020 20:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbgEEUmr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 16:42:47 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:52263 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728481AbgEEUmr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 16:42:47 -0400
Received: from [89.243.191.101] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jW4Or-00095w-BU; Tue, 05 May 2020 21:42:45 +0100
Subject: Re: RFE: teach gitk to automatically mark
 .git/rebase-merge/stopped-sha
To:     phillip.wood@dunelm.org.uk,
        Mikko Rantalainen <mikko.rantalainen@peda.net>,
        git@vger.kernel.org
References: <1dbc41e9-b2e5-0b77-26c4-c912c82f9069@peda.net>
 <79d0c40d-3bfb-2902-3538-1eb1a6cd68fe@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <18b66ddb-b490-883e-43e9-3c04f9d95448@iee.email>
Date:   Tue, 5 May 2020 21:42:45 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <79d0c40d-3bfb-2902-3538-1eb1a6cd68fe@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On 05/05/2020 20:42, Phillip Wood wrote:
> Hi Mikko
>
> On 04/05/2020 09:26, Mikko Rantalainen wrote:
>> While doing long rebases (I'm currently rebasing a feature branch with
>> 166 patches) and rebase stopping in the middle of rebase, locating the
>> old patch in gitk is sometimes hard.
>>
>> Could gitk automatically mark the original patch that failed to rebase
>> after I press F5?
>>
>> The failing original commit SHA-1 can be found in file
>> .git/rebase-merge/stopped-sha but as far as I know, git does have
>> logical commit name similar to HEAD, ORIG_HEAD or anything else for this
>> case so there's no easy way to get already running gitk to mark this
>> patch.
>
> Since git v2.17 rebase which should set REBASE_HEAD to point to the
> failing commit.

Is that a proper Pseudo Ref or is it just a temporary feature during a
rebase?

I see it's only mentioned once in the Documentation in the Rebase man page.

(I see a lot of discussion on the reftable support, with the pseudo refs
being at least one sticking point.)

Philip
>
> Best Wishes
>
> Phillip
>
>> Of course, doing the same thing for failed cherry-picks would be nice,
>> too but in that case it's pretty clear where the source patch is.
>>
>> As a workaround I currently have to do something like
>>    git tag -f FAILED_HEAD $(cat .git/rebase-merge/stopped-sha)
>> after seeing rebase failure. Then I can hit F5 in gitk to easily locate
>> the source commit.
>>
>> PS. Is there a way to automatically run git tag -f FAILED_HEAD $(cat
>> .git/rebase-merge/stopped-sha) if rebase fails in the middle of branch?
>>

