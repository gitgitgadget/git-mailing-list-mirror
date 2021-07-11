Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 670D1C07E96
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 416B261279
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 09:10:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbhGKJNA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 05:13:00 -0400
Received: from smtprelay02.ispgateway.de ([80.67.18.44]:35574 "EHLO
        smtprelay02.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbhGKJM7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 05:12:59 -0400
Received: from [87.152.144.190] (helo=[192.168.2.202])
        by smtprelay02.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2VSh-0002xX-Ui; Sun, 11 Jul 2021 11:09:19 +0200
Subject: Re: PATCH: improve git switch documentation
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
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
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
 <30e4c874-6b87-b03d-fa33-fde5b7e50b2a@mfriebe.de>
 <60ea2eb562f26_2a69208e8@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <1e18c4ed-6975-5041-4b4f-75c4d3d21860@mfriebe.de>
Date:   Sun, 11 Jul 2021 11:10:08 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ea2eb562f26_2a69208e8@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/07/2021 01:35, Felipe Contreras wrote:
> Martin wrote:
>> At the end of the current or rewritten "-C" doc, add:
>>   >     This can drop commits
>>
>> 4 words. All that is needed.
> 
> OK. I'm not opposed to that, that would definitely be an improvement
> from the current text.
> 
> What I'm saying is that if we are trying to improve the text, it would
> behoove us to consider all other options, and instead if adding a note
> at the end (which is correct), reconsider the whole thing to *start*
> with what's important:

Ah, ok. So we have been missing each others point.


> Instead of this:
> 
>    -C <new-branch>::
>    --force-create <new-branch>::
>      Similar to `--create` except that if `<new-branch>` already
>      exists, it will be reset to `<start-point>`. This is a
>      convenient shortcut for:
>    +
>    ------------
>    $ git branch -f <new-branch>
>    $ git switch <new-branch>
>    ------------
> 
> Do this:
> 
>    -N <branch>::
>      Create a new branch like '--new', but if it already exists reset it
>      like '--reset'.

As I said, I try to avoid reset, and also there is no "--reset" to 
match. Only a "reset" command, and it does a wide range of diff things

     -force-new <branch-name> <commit>
     -N <branch-name> <commit>
       See the --new option.
       Allows to [re-]use the name of an existing branch.
       This may drop commits of that branch.

Or
       See the --new option.
       Can use the name of an existing branch.
       Removing that branch may drop commits.
If needs must
       "Removing" => "Resetting"


Or even shorter
       See the --new option.
       Allows to re-use a branch-name and may drop commits
       [resetting it].

