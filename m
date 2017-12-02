Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,STOX_REPLY_TYPE,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A157320A40
	for <e@80x24.org>; Sat,  2 Dec 2017 20:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbdLBUwF (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Dec 2017 15:52:05 -0500
Received: from smtp-out-2.talktalk.net ([62.24.135.66]:41657 "EHLO
        smtp-out-2.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752186AbdLBUwE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Dec 2017 15:52:04 -0500
Received: from PhilipOakley ([92.29.14.162])
        by smtp.talktalk.net with SMTP
        id LElWewY7uNSVVLElWeYdGa; Sat, 02 Dec 2017 20:52:03 +0000
X-Originating-IP: [92.29.14.162]
X-Spam: 0
X-OAuthority: v=2.2 cv=NYGW7yL4 c=1 sm=1 tr=0 a=NXc+vVEgz70gitWznrz3ig==:117
 a=NXc+vVEgz70gitWznrz3ig==:17 a=8nJEP1OIZ-IA:10 a=VwQbUJbxAAAA:8
 a=NEAV23lmAAAA:8 a=5sHkZkKMQoxR-3jZkJIA:9 a=wPNLvfGTeEIA:10
 a=AjGcO6oz07-iQ99wixmX:22
Message-ID: <C75A5523697E4772A984765E8535FDE2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc:     <git@vger.kernel.org>,
        "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
References: <5A1D70FD020000A100029137@gwsmtp1.uni-regensburg.de> <alpine.DEB.2.21.1.1711281542400.6482@virtualbox> <5A1E6B27020000A10002916B@gwsmtp1.uni-regensburg.de> <alpine.DEB.2.21.1.1711291302370.6482@virtualbox>
Subject: Re: Antw: Re: bug deleting "unmerged" branch (2.12.3)
Date:   Sat, 2 Dec 2017 20:52:01 -0000
Organization: OPDS
MIME-Version: 1.0
Content-Type: text/plain;
        format=flowed;
        charset="iso-8859-1";
        reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
X-Antivirus: AVG (VPS 171202-2, 02/12/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfGrmsoVmZNJMnVKT2oXhHOv6+MiQ2cOZlo1eNPiHAZ9WneMzOdyX3mGSfTuxHTQpiw9srTIEqzqQ8JLyvOetwpMTAy2drNp/6R/a4SeRhsbp7X5+4YfW
 fMZsXb6lVRKaO4hzbIGb+jFHzSFQkTJVvxviZeTYgdrkkyk56VmaecoYwCt3szK2uEuY6sj1GHmj4mDF6ljnxTRJVQ1zB/LJdtkNJivt12crxwqY5fk/4qwA
 wjSLL8ijtbs41pGwHAKVaQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich

From: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Cc: <git@vger.kernel.org>
Sent: Wednesday, November 29, 2017 12:27 PM
Subject: Re: Antw: Re: bug deleting "unmerged" branch (2.12.3)


> Hi Ulrich,
>
> On Wed, 29 Nov 2017, Ulrich Windl wrote:
>
>> > On Tue, 28 Nov 2017, Ulrich Windl wrote:
>> >
>> >> During a rebase that turned out to be heavier than expected 8-( I
>> >> decided to keep the old branch by creating a temporary branch name to
>> >> the commit of the branch to rebase (which was still the old commit ID
>> >> at that time).
>> >>
>> >> When done rebasing, I attached a new name to the new (rebased)
>> >> branch, deleted the old name (pointing at the same rebase commit),
>> >> then recreated the old branch from the temporary branch name (created
>> >> to remember the commit id).
>> >>
>> >> When I wanted to delete the temporary branch (which is of no use
>> >> now), I got a message that the branch is unmerged.
>> >
>> > This is actually as designed, at least for performance reasons (it is
>> > not exactly cheap to figure out whether a given commit is contained in
>> > any other branch).
>> >
>> >> I think if more than one branches are pointing to the same commit,
>> >> one should be allowed to delete all but the last one without warning.
>> >> Do you agree?
>> >
>> > No, respectfully disagree, because I have found myself with branches
>> > pointing to the same commit, even if the branches served different
>> > purposes. I really like the current behavior where you can delete a
>> > branch with `git branch -d` as long as it is contained in its upstream
>> > branch.
>>
>> I'm not talking about the intention of a branch, but of the state of a
>> branch: If multiple branches point (not "contain") the same commit, they
>> are equivalent (besides the name) at that moment.
>
> I did a poor job of explaining myself, please let me try again. I'll give
> you one concrete example:
>
> Recently, while working on some topic, I stumbled over a bug and committed
> a bug fix, then committed that and branched off a new branch to remind
> myself to rebase the bug fix and contribute it.
>
> At that point, those branches were at the same revision, but distinctly
> not equivalent (except in just one, very narrow sense of the word, which I
> would argue is the wrong interpretation in this context).
>
> Sadly, I was called away at that moment to take care of something
> completely different. Even if I had not been, the worktree with the first
> branch would still have been at that revision for a longer time, as I had
> to try out a couple of changes before I could commit.
>
> This is just one example where the idea backfires that you can safely
> delete one of two branches that happen to point at the same commit at the
> same time.
>
> I am sure that you possess vivid enough of an imagination to come up with
> plenty more examples where that is the case.
>
>> As no program can predict the future or the intentions of the user, it
>> should be safe to delete the branch, because it can easily be recreated
>> (from the remaining branches pointing to the same commit).
>
> Yes, no program can predict the future (at least *accurately*).
>
> No, it is not safe to delete that branch. Especially if you take the
> current paradigm of "it is safe to delete a branch if it is up-to-date
> with, or at least fast-forwardable to, its upstream branch" into account.
>
> And no, a branch cannot easily be recreated from the remaining branches in
> the future, as branches can have different reflogs (and they are lost when
> deleting the branch).
>
>> It shouldn't need a lot of computational power to find out when multiple
>> branches point to the same commit.
>
> Sure, that test can even be scripted easily by using the `git for-each-ref
> --points-at=<revision>` command.
>
> By the way, if you are still convinced that my argument is flawed and that
> it should be considered safe to delete a branch if any other branch points
> to the same revision, I encourage you to work on a patch to make it so.
>
> For maximum chance of getting included, you would want to guard this
> behind a new config setting, say, branch.deleteRedundantIsSafe, parse it
> here:
>
> https://github.com/git/git/blob/v2.15.1/config.c#L1260-L1288
>
> or here:
>
> https://github.com/git/git/blob/v2.15.1/builtin/branch.c#L78-L97
>

I'd agree that it is easy to misinterpret the message. After close reading 
of the thread, Junio put his finger on the scenario with:

-      "branch -d" protects branches that are yet to be merged to the 
**current** branch.   (my emphasis)

Maybe the error message could say that (what exactly was the error 
message?),
or the documenation be improved to clarify.


> document it here:
>
> https://github.com/git/git/blob/v2.15.1/Documentation/git-branch.txt
>
> and here:
>
> https://github.com/git/git/blob/v2.15.1/Documentation/config.txt#L969
>
> and handle it here:
>
> https://github.com/git/git/blob/v2.15.1/builtin/branch.c#L185-L288
>
> (look for the places where `force` is used, likely just before the call to
> `check_branch_commit()`).
>
> The way you'd want it to handle is most lilkely by imitating the
> `--points-at` code here:
> https://github.com/git/git/blob/v2.15.1/builtin/for-each-ref.c#L42
>
> Ciao,
> Johannes 

