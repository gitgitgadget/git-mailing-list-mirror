Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2C9C47091
	for <git@archiver.kernel.org>; Sun, 30 May 2021 11:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8068261059
	for <git@archiver.kernel.org>; Sun, 30 May 2021 11:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbhE3LCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 May 2021 07:02:38 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:12879 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhE3LCh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 May 2021 07:02:37 -0400
Received: from host-92-14-216-189.as13285.net ([92.14.216.189] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lnJBi-0007ge-8j; Sun, 30 May 2021 12:00:59 +0100
Subject: Re: fast forward merge overwriting my code
To:     David Aguilar <davvid@gmail.com>
Cc:     Andre Ulrich <andre.ulrich@smail.fh-koeln.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>,
        Pratyush Yadav <pratiy0100@gmail.com>
References: <20210522154815.Horde.rqiNSyIc3CGJECACotWLO1T@webmail.th-koeln.de>
 <4c1c3dbc-7a89-02db-3883-b7eea644cd83@kdbg.org>
 <YKrsC9CaG/KDvDBi@camp.crustytoothpaste.net>
 <20210524061355.Horde.I7EpK9A1l-KtI_TwFo97eNd@webmail.th-koeln.de>
 <e02cabf0-adb6-49bb-b379-b12f37ca6e1a@iee.email>
 <20210524150653.Horde.3GnmG8mUdIOZDFHiOKtoxAe@webmail.th-koeln.de>
 <9e6772ba-fee6-7a7f-2ff3-246e82f96ee3@iee.email>
 <CAJDDKr4GFcV4MSUP+Ku=B1JjZieKwwwuGgsb8yssc0vg0thFQA@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <75d301b3-3cbe-da2e-6611-1bf32a187284@iee.email>
Date:   Sun, 30 May 2021 12:00:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJDDKr4GFcV4MSUP+Ku=B1JjZieKwwwuGgsb8yssc0vg0thFQA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/05/2021 06:31, David Aguilar wrote:
> On Mon, May 24, 2021 at 11:51 AM Philip Oakley <philipoakley@iee.email> wrote:
>> adding Pratyush for the Git Gui stash suggestion..
>> [...]
>>>>> So my Question is: is there any possibility, to be able to view (and
>>>>> even edit, if necessary) the changed notebook in the merging process
>>>>> (as in my example with the 3way merge)?
>>>> I'm not aware of such a mechanism (as simply described) but I'm sure
>>>> there are ways to use the "staging area" view (e.g. via the Git-gui) to
>>>> selectively pick out hunks and lines that are staged (and non-selected
>>>> hunk/lines stashed) to give a testable worktree during the 'merge'.
>>> Ah ok, this could be an idea (it would requiere some more research, as
>>> I haven't used the git gui before (I want to learn everything from the
>>> scratch using the command line))
>> I commonly use the Gui when picking apart a large commit into smaller
>> ones when I'm happy that there's no overlaps. Small patches make for
>> easier merging and fault finding, and better commit messages (good
>> thesis practice)
>>
>>> But to be honest, I think even this approach might already be too
>>> cumbersome (as this selectively picking and stashing sounds like a lot
>>> of work itself).
>> Unfortunately the Git Gui doesn't have a menu for stashing remaining
>> changes, but it's simple to flip over to the terminal to stash from
>> there to do the testing, and un-stash the remainder afterwards - I'll
>> maybe suggest the gui could include that capability for these types of
>> workflows (cc Pratyush Yadav <pratiy0100@gmail.com>).
> Tangential, and doesn't apply in this use case, but I should mention
> that Git Cola[1] has had this feature for a while now.

+1. I haven't used/tried Cola myself, so..

>
> Cola's Stash dialog allows you to do a regular stash and the "keep
> index" stash alluded to here. "keep index" retains whatever has
> already been staged.
>
> One feature unique to cola is its "stash the index" feature, which
> will only stash stuff that you've selectively staged. That's for the
> cases where you just want to stash away a small bit, and selectively
> choosing the inverse is a lot of work, so instead you can select just
> the bits you want to be stashed away and stash 'em.

Sounds good.
When I did a quick test (Git-Gui & cli) with staging one line of a two
line change and then stashing, I found that the stash pop failed with a
conflict (your 'lot of work') which I hadn't expected, which to me is
totally wrong (against the spirit of the stash command).

>
> There's no shame in using a GUI for interactive editing. Cola is
> designed to be driven through keyboard interactions so it's easy to
> interactively edit the index without having to use a mouse.
>
> Cola also has affordances that can make learning core Git easier
> (enable its GIT_COLA_TRACE=1 mode in the environment and it'll print
> out every git command it runs).
>
> [1] https://git-cola.github.io/
> [1] https://github.com/git-cola/git-cola
>
> cheers,
Thanks
