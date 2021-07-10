Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32154C07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 11:06:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3BE613BF
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 11:06:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbhGJLIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 07:08:45 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.110]:27113 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhGJLIo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 07:08:44 -0400
Received: from [84.163.65.41] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2AnS-0004zH-JI; Sat, 10 Jul 2021 13:05:22 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru> <60e5f3981de5f_301437208bc@natae.notmuch>
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
From:   Martin <git@mfriebe.de>
Message-ID: <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
Date:   Sat, 10 Jul 2021 13:05:54 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87im1ieaba.fsf@osv.gnss.ru>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2021 12:24, Sergey Organov wrote:
> Martin <git@mfriebe.de> writes:
>> Actually, "new" or "create" would make sense in "git branch". But in
>> git switch, they actually raise the question "create what?" / "new
>> what?".
> 
> I believe that's because "git switch" tries to do too much. "git switch"
> should rather switch between existing branches, and do nothing else. As
> I said once in this discussion already: trouble writing good
> documentation is often indication of some flaws in the design.
> 
> Creating (a branch) is fundamentally different operation than switching
> to (a branch), and that's why the former doesn't fit into "git switch".
> 

Right, yes. But creating a branch is often followed by switching to it.

So this is A shortcuts, that I actually think to be fine.
It does add value, as it does speed up a common operation.

Of course you could have
    git create-switch
or
    git branch-switch

I am not sure, that is really an improvement.



There is even discussion to add "-c" for  "copy branch + switch" to git 
switch.
Which I have no personal objection. Only find it regrettable that it 
means an incompatible change to -c. (Never mind that git switch is still 
"experimental". It has been so for a long time, for many people out 
there long enough to forget the "experimental")

And there is even discussion to add "-m" move/rename, to git switch.
Only that for the latter, most people would not even perceive a rename 
as doing a switch/checkout (technically the branchname in HEAD is 
updated, I guess).
So technically
    git branch -m newname
should change the branchname, but NOT update HEAD (detach)?
(Not sure what it does / not tested)
If git branch actually updates HEAD in that case, then "git switch -m" 
would be an identical copy, adding no value, therefore not required.
