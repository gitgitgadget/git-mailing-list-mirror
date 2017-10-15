Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D484E20445
	for <e@80x24.org>; Sun, 15 Oct 2017 15:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751441AbdJOPJg (ORCPT <rfc822;e@80x24.org>);
        Sun, 15 Oct 2017 11:09:36 -0400
Received: from bsmtp8.bon.at ([213.33.87.20]:31485 "EHLO bsmtp8.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751245AbdJOPJf (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Oct 2017 11:09:35 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp8.bon.at (Postfix) with ESMTPSA id 3yFPxp1JL4z5tlB;
        Sun, 15 Oct 2017 17:09:34 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 906D3308;
        Sun, 15 Oct 2017 17:09:33 +0200 (CEST)
Subject: Re: [PATCH/RFC] git-post: the opposite of git-cherry-pick
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
References: <c6b52120-98bf-d685-6dc0-3c83e9e80d30@kdbg.org>
 <CAGZ79kbr=zBc5GEL7hYyCnBcbdE8ZRp65QwxKMUVsQ+qXvRAAw@mail.gmail.com>
 <3d362037-3eb6-83db-a17f-47a984135580@kdbg.org>
 <87wp3zs4la.fsf@evledraar.booking.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <33f7d379-126d-e27e-7dbf-616f5dfbc98a@kdbg.org>
Date:   Sun, 15 Oct 2017 17:09:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87wp3zs4la.fsf@evledraar.booking.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.10.2017 um 12:51 schrieb Ævar Arnfjörð Bjarmason:
> On Thu, Oct 05 2017, Johannes Sixt jotted:
>> Am 05.10.2017 um 21:33 schrieb Stefan Beller:
>>> * Is it a good design choice to have a different command, just because the
>>>     target branch is [not] checked out?
>>
>> I would not want to make it a sub-mode of cherry-pick, if that is what
>> you mean, because "cherry picking" is about getting something, not
>> giving something away.
> 
> It occurs to me that a better long-term UI design might be to make
> git-{cherry-pick,pick) some sort of submodes for git-commit.

I don't quite agree. To commit an index state that is derived from a 
worktree state is such a common and important operation that it deserves 
to be its own command. Adding different modi operandi would make it 
confusing.

> Right now git-commit picks the current index for committing, but "use a
> patch as the source instead" could be a submode.
> 
> Right now it commits that change on top of your checked out commit, but
> "other non-checked-out target commit" could be a mode instead,
> i.e. exposing more of the power of the underlying git-commit-tree.

This is worth discussing, though not my preference. The picture to "pick 
cherries" has become quite common, and now that we use it for the name 
of the command, "cherry-pick", the direction of flow is quite obvious 
and strongly implied: from somewhere else to me (and not to somebody else).

> [Not entirely serious]. Well if cherry-picking is taking a thing and
> eating it here, maybe git-cherry-puke takes an already digested thing
> and "throws" it elsewhere ?:)
> 
> It's a silly name but it's somewhat symmetric :)

One of the decisions to be made is whether to begin the new command with 
"git-cherry-" or not, because it introduces a new abiguity for command 
line completion.

-- Hannes
