Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C81CC4338F
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 06:31:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D7D61076
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 06:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhHYGcH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 02:32:07 -0400
Received: from mout01.posteo.de ([185.67.36.65]:55399 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238210AbhHYGcG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 02:32:06 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id 62CA9240027
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 08:31:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1629873079; bh=Y+OP4DLPfBiMLKFHDZ2mVCbf4DrPWvmhpWMnaHN65LQ=;
        h=Subject:To:Cc:From:Date:From;
        b=bb1KMgVDuU5wEuVmeQI8YH1xkl7oJYshxc6n7E4wHHmovN87SYw/rd0xSR8w6k3iY
         l1YnvzSjOHHASSJ26jfwW9aXaTVKj8jpxgfVXPYYi9OXC8EqPvtoWzqJBVmXQOiy7G
         PpwudcWxK0giUwonqnGDwGaOt2Eczd1G6O08IGc/O1DfMF2Vbl5U9oZ58TAqjCfr3e
         7I61hsKXsRFtous0QMeNPpWO68J8L/C3AvshzWSrU4vOkIn0equZuSXHCU9MCQesqn
         NXSksRnM5UzDTddxpK7WCPVj4D1xaIZpq/rYzubZaTPkUiIIQxlTxn0vIQwA0PxQ29
         unbPL/TlsWsdw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Gvbj26DPzz6tmM;
        Wed, 25 Aug 2021 08:31:18 +0200 (CEST)
Subject: Re: [RFC PATCH] send-email: allow fixing the cover letter subject
To:     Carlo Arenas <carenas@gmail.com>
Cc:     git@vger.kernel.org, tr@thomasrast.ch
References: <20210824114135.54810-1-carenas@gmail.com>
 <5a38e420-eea3-a5f2-38c5-64682bd1ba2e@posteo.de>
 <CAPUEspgmKPhbPGs+ujy7KVJCyNxS95ph2Dwvd7A7cH2J0em20g@mail.gmail.com>
From:   =?UTF-8?Q?Marvin_H=c3=a4user?= <mhaeuser@posteo.de>
Message-ID: <e781b15c-8c59-9827-b052-ebe971b01cad@posteo.de>
Date:   Wed, 25 Aug 2021 06:31:18 +0000
MIME-Version: 1.0
In-Reply-To: <CAPUEspgmKPhbPGs+ujy7KVJCyNxS95ph2Dwvd7A7cH2J0em20g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/08/2021 18:11, Carlo Arenas wrote:
> On Tue, Aug 24, 2021 at 8:19 AM Marvin Häuser <mhaeuser@posteo.de> wrote:
>> On 24/08/2021 13:41, Carlo Marcelo Arenas Belón wrote:
>>> @@ -1719,7 +1719,6 @@ sub process_file {
>>>        @xh = ();
>>>        my $input_format = undef;
>>>        my @header = ();
>>> -     $subject = $initial_subject;
>> This change from my patch is still controversial, and I'd rather not
>> submit the addition if it's immediately removed again.
>> Why are you dropping it here anyway, does it break any related
>> functionality?
> I was expecting it to break --compose, but it didn't because in there
> we were using $initial_subject directly instead.

Right, ok.

> AFAIK; I couldn't see a difference eitherway, but as Peff pointed out
> it doesn't make sense leaving it only as a global so just found
> instead a more useful place for it to be reset in the loop, which also
> "fix" another issue of mine.

Well, this only "sometimes" resets it (from a control flow perspective), 
which is exactly what I tried to avoid globally.
Can we somehow agree on something? Because I'd like to submit my patch asap.

Best regards,
Marvin
