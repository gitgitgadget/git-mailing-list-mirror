Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_03_06,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD,STOX_REPLY_TYPE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6EA20193
	for <e@80x24.org>; Thu, 27 Oct 2016 18:36:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942492AbcJ0SgV (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 14:36:21 -0400
Received: from smtp-out-6.talktalk.net ([62.24.135.70]:9670 "EHLO
        smtp-out-6.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934208AbcJ0SgU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 14:36:20 -0400
Received: from PhilipOakley ([92.22.33.212])
        by smtp.talktalk.net with SMTP
        id zpXFb4VTCgKstzpXFbqUzo; Thu, 27 Oct 2016 19:36:17 +0100
X-Originating-IP: [92.22.33.212]
X-Spam: 0
X-OAuthority: v=2.2 cv=GdBVpkfL c=1 sm=1 tr=0 a=oOvrHna8aJuNcgF4zcjVrw==:117
 a=oOvrHna8aJuNcgF4zcjVrw==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=wZiiOxDncIjJIqPblKEA:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <1EBA3205AB8B43A3BBC48C701191520E@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "Cody Sehl" <cody.sehl@gmail.com>
Cc:     <git@vger.kernel.org>
References: <010201580457bdd2-99237b54-5e36-4430-bb8d-7e9088aed522-000000@eu-west-1.amazonses.com> <xmqq8tta8f0x.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] Update git rebase documentation to clarify HEAD behavior
Date:   Thu, 27 Oct 2016 15:06:55 +0100
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
X-CMAE-Envelope: MS4wfJuwTCChfPMbLRB366Qk/q4WWCDr7YrFPJpxJkphA/Fsqv/AvSs1bTj488w/AMh2jjPgvZJth4NQd5697wqNXZ/5/aWaNWug9xhPucuxhtwI3Gm0Fvvk
 ZMr4kBZz7lZJihoyLH40+AsCZTBrUZi9/LrISwl7TZFonI2qOfRHwDpODsgAD4Xw6PSLEFpYe4nA8xUZVtYeC+tSPWh/2zdDndE0XKZG0mvpPiZ1sabgVrXR
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
> Cody Sehl <cody.sehl@gmail.com> writes:
>
>> The first few paragraphs in the git-rebase.txt documentation lay out the 
>> steps git takes during a rebase:
>> 1. everything from `<upstream>..HEAD` is saved to a temporary area
>> 2. `HEAD` is set to `<upstream>`
>> 3. the changes held in the temporary area are applied one by one in order 
>> on top of the new `HEAD`
>>
>> The second step was described using the phrase `The current branch is 
>> reset to <upstream>`, which is true (because `HEAD` == current branch), 
>> but not clear.
>> ---
>
> Please wrap your lines to reasonable lengths like 70 columns or so.
> Please sign off your patch.
>
>>  Documentation/git-rebase.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index de222c8..c47ca11 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -33,7 +33,7 @@ of commits that would be shown by `git log 
>> <upstream>..HEAD`; or by
>>  description on `--fork-point` below); or by `git log HEAD`, if the
>>  `--root` option is specified.
>>
>> -The current branch is reset to <upstream>, or <newbase> if the
>> +HEAD is reset to <upstream>, or <newbase> if the
>>  --onto option was supplied.  This has the exact same effect as
>>  `git reset --hard <upstream>` (or <newbase>).  ORIG_HEAD is set
>>  to point at the tip of the branch before the reset.
>
> This is describing an ancient behaviour before 6fd2f5e60d ("rebase:
> operate on a detached HEAD", 2007-11-08) in v1.5.4 timeframe.  We
> apparently failed to update the description.
>
> This depends on the desired technical detail of the description, but
> a correct rewrite would be "HEAD is detached at <upstream>, or
> <newbase>, and ORIG_HEAD is set to point at the tip of the branch
> before this happens".  Detaching the HEAD at <upstream> no longer
> has the same effect as "git reset --hard <upstream>" (or <newbase>),
> so that sentence must go.  It was the primary point of the ancient
> change at 6fd2f5e60d after all.
>
> And then there is a new step (to be numbered 4. in your description
> in the proposed log message), which updates the tip of the branch to
> the resulting HEAD (after replaying all these changes) and check the
> branch out, which needs to be added.  Perhaps after "one by one, in
> order."  Oh, the mention of "reapplied to the current branch" also
> needs to be updated to "reapplied to the detached HEAD", too.
>
> On the other hand, if we do not aim for that deep level of technical
> correctness, but want to tell a white lie to make it easier to
> understand at the conceptual level to new readers who haven't
> grasped the detached HEAD, then the current description is fine.  By
> bringing up "HEAD", you seem to be aiming for techincal correctness
> (which I tend to agree is a good direction to go in this part of the
> documentation), so the existing text needs a bit more work than your
> patch to be brought to the modern world.
>

A third option is to start with a short "Conceptually, .." description which 
gives that summary overview, and then have a few "In detail, .." paragraphs 
that cover the ORIG_HEAD and Detatched HEAD, etc., that users should at 
least be aware of (so they know they can come back and read the gory details 
when they need it;-)
--
Philip 

