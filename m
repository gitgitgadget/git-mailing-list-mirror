Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB83C07E9B
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 22:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AD8C61353
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 22:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhGJWQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 18:16:30 -0400
Received: from smtprelay05.ispgateway.de ([80.67.18.28]:11864 "EHLO
        smtprelay05.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhGJWQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 18:16:29 -0400
Received: from [84.163.65.41] (helo=[192.168.2.202])
        by smtprelay05.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m2LDH-00071w-VC; Sun, 11 Jul 2021 00:12:43 +0200
Subject: Naming the --forec option [[Re: PATCH: improve git switch
 documentation]]
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
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
 <60e88a4b8592f_16bcb2082b@natae.notmuch>
 <ad58bd54-a9dd-59a9-4fce-f90be469cd60@mfriebe.de>
 <60e9f8d462bd9_7ef20898@natae.notmuch>
 <6f43b36b-abe1-41f2-6138-e820c974b1bd@mfriebe.de>
 <60ea07e3495e8_7ef2081d@natae.notmuch>
From:   Martin <git@mfriebe.de>
Message-ID: <43b8d0bb-67f3-11dd-ec31-e102ce8e3b31@mfriebe.de>
Date:   Sun, 11 Jul 2021 00:13:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <60ea07e3495e8_7ef2081d@natae.notmuch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/07/2021 22:49, Felipe Contreras wrote:
> Martin wrote:
>> For each force-needing action, you should have to specify it's own force 
>> flag. >
 > OK, but I don't see the concrete proposal. What would be the
 > flag that
 > makes -c "forceful"?
 >

Well that starts yet another topic.

At the moment, it is
    --force-create which is absorbing the flag into the option.

And by (apparent) convention it also is the uppercasing of the option
    -C
same as the uppercasing of the -B in checkout.

I am not really sure if the uppercasing is the best idea.
If your suggestion "core.advanced " were to come, I would vote that 
uppercase single letter force options should be restricted to advanced.


If -n is introduced, we can think about what to do about -N.
Should the  --force-*  style be kept?
    --force-new
    -N

Or the (unfortunate? / see below ) "--discard-changes" style:
    --discard-existing-branch -n <branchname>

I am against using --reset instead of --force-new.
At least I can say, if I use "-N", I want a *new* branch. I don't care 
about any old branch under that name.

Also "--reset" does not have the same alerting properties to me, as 
"force" or "discard" have.
This may be my English, but to me "reset" does not have the same 
alerting property.




The general problem is, if there is more than one force-needing action, 
then which one does -f  act on?

Any force-needing action, that only applies with another option (such as 
-N) can have a --force-*. So the plain -f is not used for it.

But, what if more than one force-needing event can happen (not just 
switch, but any command), even without any extra options? (May not yet 
be the case / not checked).

git switch has attempted to solve that.
The result IMHO is a disaster.
"-f" / "--force" is made an alias in favour for
    --discard-changes
What changes?



