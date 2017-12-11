Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B77F31F406
	for <e@80x24.org>; Mon, 11 Dec 2017 08:40:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752103AbdLKIkh convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Mon, 11 Dec 2017 03:40:37 -0500
Received: from rrzmta1.uni-regensburg.de ([194.94.155.51]:42561 "EHLO
        rrzmta1.uni-regensburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751543AbdLKIkg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Dec 2017 03:40:36 -0500
Received: from rrzmta1.uni-regensburg.de (localhost [127.0.0.1])
        by localhost (Postfix) with SMTP id 684335D53D
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 09:40:34 +0100 (CET)
Received: from gwsmtp1.uni-regensburg.de (gwsmtp1.uni-regensburg.de [132.199.5.51])
        by rrzmta1.uni-regensburg.de (Postfix) with ESMTP id 449DE5D450
        for <git@vger.kernel.org>; Mon, 11 Dec 2017 09:40:34 +0100 (CET)
Received: from uni-regensburg-smtp1-MTA by gwsmtp1.uni-regensburg.de
        with Novell_GroupWise; Mon, 11 Dec 2017 09:40:34 +0100
Message-Id: <5A2E4480020000A1000293D8@gwsmtp1.uni-regensburg.de>
X-Mailer: Novell GroupWise Internet Agent 18.0.0 
Date:   Mon, 11 Dec 2017 09:40:32 +0100
From:   "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
To:     <philipoakley@iee.org>
Cc:     <git@vger.kernel.org>
Subject: Antw: Re: Re: bug deleting "unmerged" branch (2.12.3)
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de><xmqqtvxd6gu9.fsf@gitster.mtv.corp.google.com><5A1E70AA020000A100029175@gwsmtp1.uni-regensburg.de><7973FF5C21C64E6492828DD0B91F5AF7@PhilipOakley>
 <xmqq1skcleo7.fsf@gitster.mtv.corp.google.com>
 <AB9C836772CD4391A8866DC71103CCFE@PhilipOakley>
 <5A25705C020000A1000292B0@gwsmtp1.uni-regensburg.de>
 <582105F8768F4DA6AF4EC82888F0BFBE@PhilipOakley>
In-Reply-To: <582105F8768F4DA6AF4EC82888F0BFBE@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Sorry for the late response:
On a somewhat not-up-to date manual:

       -d, --delete
           Delete a branch. The branch must be fully merged in its upstream
           branch, or in HEAD if no upstream was set with --track or
           --set-upstream.


Maybe the topic of multiple branches pointing to the same commit could be mentioned (regarding the status of each such branch being considered to be merged or not). Also "fully merged" could be made a bit more precise, maybe.

Maybe gitglossary could have definitions for "merged" and "fully merged" with manual pages referring to it.

Regards,
Ulrich


>>> "Philip Oakley" <philipoakley@iee.org> schrieb am 08.12.2017 um 21:26 in
Nachricht <582105F8768F4DA6AF4EC82888F0BFBE@PhilipOakley>:
> From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
>> Hi Philip!
>>
>> I'm unsure what you are asking for...
>>
>> Ulrich
> 
> Hi Ulrich,
> 
> I was doing a retrospective follow up (of the second kind [1]).
> 
> In your initial email
> https://public-inbox.org/git/5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.d 
> e/
> you said
> 
> "I wanted to delete the temporary branch (which is of no use now), I got a
> message that the branch is unmerged.
> I think if more than one branches are pointing to the same commit, one
> should be allowed to delete all but the last one without warning."
> 
> My retrospectives question was to find what what part of the documentation
> could be improved to assist fellow coders and Git users in gaining a better
> understanding here. I think it's an easy mistake [2] to make and that we
> should try to make the man pages more assistive.
> 
> I suspect that the description for the `git branch -d` needs a few more
> words to clarify the 'merged/unmerged' issue for those who recieve the
> warning message. Or maybe the git-glossary, etc. I tend to believe that most
> users will read some of the man pages, and would continue to do so if they
> are useful.
> 
> I'd welcome any feedback or suggestions you could provide.
> --
> Philip
> 
>> >>> "Philip Oakley" <philipoakley@iee.org> 04.12.17 0.30 Uhr >>>
>> From: "Junio C Hamano" <gitster@pobox.com>
>> > "Philip Oakley" <philipoakley@iee.org> writes:
>> >
>> >> I think it was that currently you are on M, and neither A nor B are
>> >> ancestors (i.e. merged) of M.
>> >>
>> >> As Junio said:- "branch -d" protects branches that are yet to be
>> >> merged to the **current branch**.
>> >
>> > Actually, I think people loosened this over time and removal of
>> > branch X is not rejected even if the range HEAD..X is not empty, as
>> > long as X is marked to integrate with/build on something else with
>> > branch.X.{remote,merge} and the range X@{upstream}..X is empty.
>> >
>> > So the stress of "current branch" above you added is a bit of a
>> > white lie.
>>
>> Ah, thanks. [I haven't had chance to check the code]
>>
>> The man page does say:
>> .    -d
>> .    Delete a branch. The branch must be fully merged in its upstream
>> .    branch, or in HEAD if no upstream was set with --track
>> .    or --set-upstream.
>>
>> It's whether or not Ulrich had joined the two aspects together, and if the
>> doc was sufficient to help recognise the 'unmerged' issue. Ulrich?
>> --
>> Philip
>>
>>
> 
> [1] Retrospective Second Directive, section 3.4.2 of (15th Ed) Agile
> Processes in software engineering and extreme programming. ISBN 1628251042
> (for the perspective of the retrospective..)
> [2] 'mistake' colloquial part of the error categories of slips lapses and
> mistakes : Human Error, by Reason (James, prof) ISBN 0521314194 (worthwhile)

