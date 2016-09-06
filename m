Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8331F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 22:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933472AbcIFWIK (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 18:08:10 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:35086 "EHLO
        mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932110AbcIFWIJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 18:08:09 -0400
Received: by mail-pa0-f54.google.com with SMTP id b2so6274553pat.2
        for <git@vger.kernel.org>; Tue, 06 Sep 2016 15:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=RR7mJEwMlVWoGjitietEr8ASpvFf4dUpvD0YZH4Gyic=;
        b=D+dqoYChIJIlRVG08+1kHC9ziPkRPH+KNvSBtIv8rsdLB4Szh702OhFfZ83fR6R/Zy
         L7U+IYMV13Ke7jsVDSAL0EMqiYLWUpS8SJ+qI4vwli0LReeSKHhBQnLFTU1YLfOVBXNn
         cVPptayYXhbsfwztLY1/bNoCS0G9e5lgot3BPZgdMfJt8ps9D8T8q59V0jWYSIU2wqSc
         U/AfVP8a/GSgAR38C1Mh/TAFyR/hOaObH5pNOG3sYBIMlCQe7qyaFomEfpS0tdl7aHug
         4k93B5wzarHu5LODHZ50OF7CKaaZx7YuFPlpWnUyDtus+gdc8/v0jX9CYpDC0gSv+veO
         qhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=RR7mJEwMlVWoGjitietEr8ASpvFf4dUpvD0YZH4Gyic=;
        b=dCxmSheb2r/Dt2tmCGeDzOVWZKKUVMRDzh6UWHSYIosAFWhoC7RWGIwrARlnZm1fvS
         ogFU7iIVYpT+PjAOpOQZTocAnUR5u+W7Z3N5eA/a4utLRJF/pDjlxSU7QhB7xIBEgwYS
         jAnbubPO0lPMGPwozDvTPsfWd0G/dwUnOSp9p/zJptDIDPptbmS0FNDXgvA4RMgiihgt
         Y7f3JS2mzXJE3yx8PvafBuuMXvOoWyy8caJw5SzCiXGLFlCbTBFOoi4g94Bb/Gbngyyh
         +rxZBjcxbsRq3tjiBUIa003kdYAgrH4ZsdrPLRpnbvwZSpiXTonkfI7QrtHGfeO1Tr/V
         JH0w==
X-Gm-Message-State: AE9vXwPS++XajAUwtWaC5Ui7t0Iw1kec4P9z0d5vu+24IHOG7FoGNs+gCtqzoiF6EgYl5xxX
X-Received: by 10.66.152.238 with SMTP id vb14mr10771613pab.78.1473199687795;
        Tue, 06 Sep 2016 15:08:07 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([2620:0:1000:5b10:4170:9855:c486:2b8c])
        by smtp.gmail.com with ESMTPSA id c18sm26366461pfc.40.2016.09.06.15.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2016 15:08:06 -0700 (PDT)
Subject: Re: [PATCH] sequencer: support folding in rfc2822 footer
To:     Junio C Hamano <gitster@pobox.com>
References: <1472846322-5592-1-git-send-email-jonathantanmy@google.com>
 <xmqqy439rabb.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <29cb0f55-f729-80af-cdca-64e927fa97c0@google.com>
Date:   Tue, 6 Sep 2016 15:08:05 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <xmqqy439rabb.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/02/2016 07:23 PM, Junio C Hamano wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> Sample-field: multiple-line field body
>>  that causes a blank line below
>
> I am not sure this is unconditionally good, or may cause problems to
> those with workflows you did not consider when you wrote this patch.
>
> Not being too lenient here historically has been a deliberate
> decision to avoid misidentification of non "footers".  Does Git
> itself produce some folded footer line?  If Git itself produced such
> folded lines, I'd be a lot more receptive to this change, but I do
> not think that is the case here.

I don't think Git produces any folded lines, but folded lines do appear 
in footers in projects that use Git. For example, some Android commits 
have multi-line "Test:" fields (example, [1]) and some Linux commits 
have multi-line "Tested-by:" fields (example, [2]).

Taking the Android commit as an example, this would mean that 
cherrypicking that commit would create a whole new footer, and tripping 
up tools (for example, Gerrit, which looks for "Change-Id:" in the last 
paragraph). But this would not happen if "Test:" was single-line instead 
of multi-line - which seems inconsistent.

[1] 
https://android.googlesource.com/platform/frameworks/base/+/4c5281862f750cbc9d7355a07ef1a5545b9b3523
[2] 
https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux-stable/+/69f92f67b68ab7028ffe15f0eea76b59f8859383

> A slightly related tangent.  An unconditionally good change you
> could make is to allow folding of in-body headers.  I.e. you can
> have e.g.
>
> 	-- >8 --
> 	Subject: [PATCH] sequencer: support in-body headers that are
>          folded according to RFC2822 rules
>
> 	The first paragraph after the above long title begins
> 	here...
>
> in the body of the msssage, and I _think_ we do not fold it properly
> when applying such a patch.  We should, as that is something that
> appears in format-patch output (i.e. something Git itself produces,
> unlike the folded "footer").

OK, I'll take a look at this.
