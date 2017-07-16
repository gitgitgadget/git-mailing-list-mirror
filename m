Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,
	STOX_REPLY_TYPE shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F1BC20357
	for <e@80x24.org>; Sun, 16 Jul 2017 11:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751248AbdGPLjU (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Jul 2017 07:39:20 -0400
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:54515 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751087AbdGPLjU (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jul 2017 07:39:20 -0400
Received: from PhilipOakley ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id WhtOdTmvO0DqZWhtOdQFHV; Sun, 16 Jul 2017 12:39:18 +0100
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=PvPRVEE3 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=8nJEP1OIZ-IA:10 a=ybZZDoGAAAAA:8
 a=pGLkceISAAAA:8 a=wa_UfRSMaioVwd9_nx4A:9 a=wPNLvfGTeEIA:10
 a=0RhZnL1DYvcuLYC8JZ5M:22 a=6kGIvZw6iX1k4Y-7sg4_:22
Message-ID: <7E67FF115BB146A49D486E77404882F2@PhilipOakley>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
From:   "Philip Oakley" <philipoakley@iee.org>
To:     "Junio C Hamano" <gitster@pobox.com>,
        "William Duclot" <william.duclot@gmail.com>
Cc:     <git@vger.kernel.org>
References: <20170709202520.21739-1-william.duclot@gmail.com>        <xmqqvan06yo8.fsf@gitster.mtv.corp.google.com>        <20170710183101.GA13122@Haydn> <xmqq4luh1gzw.fsf@gitster.mtv.corp.google.com>
Subject: Re: [PATCH/RFC] rebase: make resolve message clearer for inexperienced users
Date:   Sun, 16 Jul 2017 12:39:16 +0100
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
X-Antivirus: AVG (VPS 170715-0, 15/07/2017), Outbound message
X-Antivirus-Status: Clean
X-CMAE-Envelope: MS4wfPpQcUM9RfHIl8S3VSJlKMzPtghGzIO9NNHjqc1f8ui6KNBbtGBkRFswvlVKSUarxDiWiuuB4fulfk35lsyq6zeFrQq5YlENKcHUdbxNk24CSmZmod6D
 fCFwGIllVNQKp0WEPBOiQWv6UD5DRUBvbPA5PhbGtKp/f+NsmAk5Cr52eOWswV8sqM1DXDwI3FW4OvN5AWSQwvm2D3k9dkHt4+rck8yFiV5Ak5ot8TOcYjpC
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: "Junio C Hamano" <gitster@pobox.com>
Sent: Wednesday, July 12, 2017 10:29 PM
> William Duclot <william.duclot@gmail.com> writes:
>
>>>  - The original said "When you have resolved this problem", without
>>>    giving a guidance how to resolve, and without saying what the
>>>    problem is.  The updated one says "conflict" to clarify the
>>>    "problem", and suggests "git add" as the tool to use after a
>>>    manual resolition.
>>>
>>>    Modulo that there are cases where "git rm" is the right tool, the
>>>    updated one is strict improvement.
>>
>> I also wrote "<conflicted_file>" when there could be several. Maybe
>> 'mark it as resolved with "git add/rm"' would be a better (and shorter)
>> formulation?
>
> Another potential source of confusion is if we are seeing "a"
> conflict, or multiple ones.  I'd say it is OK to treat the whole
> thing as "a conflict" that Git needs help with by the user editing
> multiple files and using multiple "git add" or "git rm".  So "mark
> it as resolved with 'git add/rm'" is fine, I would think, but
> anything that I say about UI's understandability to new people needs
> to be taken with a large grain of salt ;-).
>
>> ... I feel like a lot of git messages could be improved this way
>> to offer a UI more welcoming to inexperienced user (which is a
>> *broad* segment of users). But I am not aware of the cost of
>> translation of this kind of patch: would several patches like this
>> one be welcomed?
>
> Surely, as long as I can depend on other reviewers who are more
> passionate about end-user experience than I am, I'll take such
> patches with their help.
>
> Thanks.

One of the other confusions I had / have (and I have a saved note to remind 
me) is when rebase stops with a conflict, and asks the user to "fix" it, 
then ues "--continue".

I always expect that Git will do the 'add' of the resolved conflict because 
that is what it would do normally as the next step after the merge.

I also had a similar issue with the --allow-empty case of 'nothing added to 
commit but untracked files present' where I had been expecting the commit to 
be simply omitted. You have to go through a reset dance before continuing.

Philip
[I'll be off line till Friday] 

