Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DD3C07E9C
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F52E61220
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbhGKJ3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 05:29:55 -0400
Received: from smtprelay06.ispgateway.de ([80.67.31.96]:61719 "EHLO
        smtprelay06.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJ3y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 05:29:54 -0400
Received: from [87.152.144.190] (helo=[192.168.2.202])
        by smtprelay06.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2Viy-0008GK-4Q; Sun, 11 Jul 2021 11:26:08 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <87bl7d3l8r.fsf@osv.gnss.ru> <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <878s2dgu4d.fsf@osv.gnss.ru>
From:   Martin <git@mfriebe.de>
Message-ID: <0d7190ae-e64e-d1fa-2367-29f302c2ff7e@mfriebe.de>
Date:   Sun, 11 Jul 2021 11:27:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <878s2dgu4d.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2021 09:57, Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
> 
> 
> [...]
> 
>> Currently only the branch is mentioned.
>> Currently nothing does explicitly say that *commits* can be affected.
> 
> Commits cannot be immediately affected. One of the most essential
> features of Git is that commits could only be affected (deleted) by
> garbage collection. That's what makes Git so nicely safe in operation.
> 
> It'd be unfortunate to have statements in the manual pages that
> contradict this.
> 

Tell that a new user, who never heard of "dangling commits" or the reflog.

For ages, I wondered what git fsck meant by "dangling commits" and why 
my repro always had "that problem".
And what I might do with that hash it gave me.

For a new user, a commit that is not in any branch listed by
"git branch --all" or "git stash"
is effectively not existent.

For a new user, it is also "no help" (and the doc should help) to avoid 
saying it, and instead refer to something else from which it could be 
concluded.
"reset the branch" talks about the branch, and not the commit.
A new user, even if he read about it before, may very well not make the 
conclusion.
So "reset the branch" does nothing for a new user. And an expert already 
knows it. So for whom should that be there?

We can use the term unreachable. But it is no better than say "drop"

Technically they are not "unreachable". If I have the hash, I (as 
expert) can reach them.
If I do not, I can get it from "fsck". (And spend a good amount of time, 
going through a few dozen hashes. (That is, if the reflog was disabled)

"Drop" does not mean "deleted". More like "dropped from view", "given up"
But a new user reading "dropped" will take it as a hint to be careful.

We can add "dropped commit" to the glossary. Then there is no ambiguity. 
(I don't think its needed, but...)

We can say "may no longer have a reference" instead of "dropped"
But it is long, and again obscure (to a new user).
