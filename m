Return-Path: <SRS0=MFMM=EH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAF9C2D0A3
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 20:51:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D963E21527
	for <git@archiver.kernel.org>; Sun,  1 Nov 2020 20:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgKAUvp convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sun, 1 Nov 2020 15:51:45 -0500
Received: from wp368.webpack.hosteurope.de ([80.237.133.137]:36800 "EHLO
        wp368.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgKAUvp (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 1 Nov 2020 15:51:45 -0500
Received: from [2a02:810d:8abf:c4a8:7881:19a0:11:8ba]; authenticated
        by wp368.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1kZJnb-0002gV-VQ; Sun, 01 Nov 2020 21:18:00 +0100
To:     Philip Oakley <philipoakley@iee.email>,
        Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
References: <945ab20e-dcde-540e-83a5-83992c2187b1@enigmage.de>
 <CAP8UFD2dWrUXJUuiFtgCu6krbnbGGqJZ7K+6KqstGTcNmSc_xQ@mail.gmail.com>
 <b1adedaa-5809-9ea1-f664-3a7cabaf0d14@iee.email>
From:   =?UTF-8?Q?Manuel_B=c3=a4renz?= <manuel@enigmage.de>
Subject: Re: Feature request: Exponential search in git bisect
Message-ID: <a03a9674-921e-d8f4-19f8-ca60aa4a473a@enigmage.de>
Date:   Sun, 1 Nov 2020 21:17:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <b1adedaa-5809-9ea1-f664-3a7cabaf0d14@iee.email>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-bounce-key: webpack.hosteurope.de;manuel@enigmage.de;1604263904;034e4d7b;
X-HE-SMSGID: 1kZJnb-0002gV-VQ
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 25.10.20 18:15, Philip Oakley wrote:
> Hi Manuel,
>
> On 10/10/2020 10:22, Christian Couder wrote:
>> On Fri, Oct 9, 2020 at 9:35 PM Manuel Bärenz <manuel@enigmage.de> wrote:
>>> This feature was requested 8 years ago and briefly discussed:
>>> https://public-inbox.org/git/20120318212957.GS1219@chaosreigns.com/
>>>
>>>
>>>   TL;DR
>>>
>>> Before doing git bisect, I want to use exponential search to
>>> automatically find a good commit, in logarithmic time.
>> Ok, but the conclusion of the above discussion is that the problem
>> with this idea is being able to distinguish between a commit that is
>> bad and a commit where the feature that you want to test cannot be
>> tested for example because it hasn't been implemented yet.
> Does any of the proposed improvement in the "bisect: loosen halfway()
> check for a large number of commits"
> https://lore.kernel.org/git/20201022103806.26680-1-szeder.dev@gmail.com/
> assist in this.

I'm afraid not, since the time to recompile and run tests usually
dominates the search (at least in my case). So the fewer commits have to
be tested, the better.

The hard part is distinguishing in an automated way on an old commit
when to skip and when to mark as good.


