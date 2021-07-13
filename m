Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624AFC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 11:20:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414E561183
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 11:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235671AbhGMLXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 07:23:11 -0400
Received: from smtprelay05.ispgateway.de ([80.67.31.94]:27246 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235552AbhGMLXK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 07:23:10 -0400
Received: from [84.163.66.71] (helo=[192.168.2.202])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m3GRU-0004Eh-Ef; Tue, 13 Jul 2021 13:19:12 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
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
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
 <87a6mudt9b.fsf@osv.gnss.ru> <60e9ff4430c57_7ef20815@natae.notmuch>
 <874kd1gr0q.fsf@osv.gnss.ru> <60ec6cd622c4c_a4525208a0@natae.notmuch>
 <87czrnf8bj.fsf@osv.gnss.ru>
From:   Martin <git@mfriebe.de>
Message-ID: <3c32c82c-5121-285a-036f-08e6daa320eb@mfriebe.de>
Date:   Tue, 13 Jul 2021 13:20:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87czrnf8bj.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/07/2021 00:58, Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> I disagree. I prefer the former.
> 
>       git create branch "nice-feature"
> 
> Almost plain human language. Isn't it nice? I mean I fail to see why
> you prefer the former, but I don't care that much either.
> 

But human language is not always the best to express something to a 
computer (sometimes not even to a human). Human language for starters is 
often very ambiguous. (Not in this particular example, but in general).

So even if it looks like human language, its not (not a "duck" either;) ).
It still needs each token (each word is a token) to be documented.

The "create" vs "new" is a good example.
- "creating" still happens when you add commits into the branch (human 
language "branch"). Because that's what the branch wants to be, a series 
of commits. You keep creating it, until its done, then you merge it.
- "new" of course is not a verb...

    git prepare branch
would probably be more accurate.
But I am sure it has flaws too.


> No, I don't think it's an option, as unfortunately for your preferences,
> 
>          git branch new
> 
> looks impossible to introduce in a backward compatible manner, nor there
> is significant need to, as
> 
>          git branch
> 
> already does the job, even if by introducing syntax irregularity.

It is not that it already does the job ("git stash push" and "git stash" 
both do the job)

But in
    git branch new
"new" would be the name of a branch. :(

But at some point, it was indicated that this is about finding 
guidelines for future additions.
So not all old commands need to be "fixed".

Not that they are broken. They are fine. We do not need to break them by 
adding a rule like that.

And
    git noun verb <opts>
    git verb <opts>
works as guideline for new additions.

Of course you want to add
    git verb noun
which I personally to not favour.

