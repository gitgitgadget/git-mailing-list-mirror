Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370441F597
	for <e@80x24.org>; Fri, 27 Jul 2018 15:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388666AbeG0RN3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 13:13:29 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:41471 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388563AbeG0RN3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 13:13:29 -0400
Received: by mail-qt0-f177.google.com with SMTP id e19-v6so5491737qtp.8
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 08:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Lt3rYIvSSwkXwoDiwuTmFBHMt+jf/4wnYO2FcP51I+c=;
        b=XPel6zc9mpUQ0HGmoXZRjFZS7xPVIn9kQYPdi6vGOV96t1afe1wKA/A7OTfmEShClA
         MyTg72+CynZv8HyQNS6kSrPLW90PRlZtQkLFA+WPtC1ah6vvOUohVp7g43+nDxPKvDse
         0gGxpQnU5Pm7YlWLPu7dYey1W1GkScntQI+a5vwhUaTT97iqSSEJgmnUVDva5hALVaKm
         tE6T1BKYgAg6Vfm1foX7Mn162wS4eWkq8Vg4BSlQNaGe6UUFtPEyzTk0K+yQnNuZTjOn
         a//iKb7cO/fcJsQK0PStDG8RxXS7BnveR6Y+v1eMQLrd8ZMAKKqXNtMbxzI58Wt6Jdlr
         f43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Lt3rYIvSSwkXwoDiwuTmFBHMt+jf/4wnYO2FcP51I+c=;
        b=Cy18p8AWkSdqucxW6TT89TxCGu3KO0HrZJSTSTniwjWN9ENG/zJd7ZmCLj5PvvaBjt
         X72/BiV3+ZU03L8IMfxbeDNKGKh9g8S9bEip3lJrEkB6akx+IMqd1271+S8tmG6bXt6S
         IqphUKC0LYdA2FmAF7rTEqnL7n+QNtAQ1rhf4IcAdoJOcsyvfk9XtgSkXYLtkq6zfag1
         6RMs5Ar2Xl7PaKDFgIh/lqJZCKymhgfyK7ma7BE2iwOaihd2q7IjDLDe7zyVvrFNVTqf
         BVB0K9En40oNRRGXlHsMse4WIqE+4NEmaRApxDt6dKOHVzo4OG2ph493VGj8GuvvktSs
         tygw==
X-Gm-Message-State: AOUpUlGt6JZkHs8+FtojBkN89FcjPr67pTkvrN0QzYsBqkMTKWjCinoq
        YvWM5QEVvpYmP9HUT7T70ziydnT5
X-Google-Smtp-Source: AAOMgpcEqNMdB3XxNkFgpBHGQWpKm9qgtsi6D5V553HA9d0IzuQgyd6nzNdsMMTUItzByBIVOwZClw==
X-Received: by 2002:a0c:ae17:: with SMTP id y23-v6mr6135363qvc.157.1532706658094;
        Fri, 27 Jul 2018 08:50:58 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k5-v6sm2296094qke.92.2018.07.27.08.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Jul 2018 08:50:57 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
To:     Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
 <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
 <20180724042017.GA13248@sigill.intra.peff.net>
 <CACsJy8Du28jMyfdyhxpVxyw5+Xh+9eX==3x8YJSnmw6GAoRhTA@mail.gmail.com>
 <0102d204-8be7-618a-69f4-9f924c4e6731@gmail.com>
 <CACsJy8AWcHVYNBZGRUTdcg8FmwOGz3MSUHH+3uVSGrg6MMZMng@mail.gmail.com>
 <20180726163049.GA15572@duynguyen.home>
 <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <ab7338a4-4a63-c722-35b1-a5b0784d66bf@gmail.com>
Date:   Fri, 27 Jul 2018 11:50:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqd0v9pyzu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/26/2018 3:40 PM, Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> 
>> I'm excited so I decided to try out anyway. This is what I've come up
>> with. Switching trees on git.git shows it could skip plenty entries,
>> so promising. It's ugly and it fails at t6020 though, there's still
>> work ahead. But I think it'll stop here.
> 
> We are extremely shallow compared to projects like the kernel and
> stuff from java land, so that is quite an interesting find.
> 

I had a few minutes so applied this patch to the latest git for windows 
and ran the p0006-read-tree-checkout.sh perf test on the git repo as 
well as a synthetic large repo.  The results look quite promising - up 
to a 28.8% savings!

I'm out of time this week but am _very_ interested in seeing if this can 
be completed successfully.

Ben


git repo results
================

Test                                                            this 
tree          gfw
---------------------------------------------------------------------------------------------------------
0006.2: read-tree br_base br_ballast (1000001) 
1.37(0.04+0.09)    1.34(0.03+0.09) -2.2%
0006.3: switch between br_base br_ballast (1000001) 
50.21(0.07+0.09)   50.22(0.03+0.09) +0.0%
0006.4: switch between br_ballast br_ballast_plus_1 (1000001) 
3.58(0.03+0.09)    4.61(0.03+0.10) +28.8%
0006.5: switch between aliases (1000001) 
3.67(0.03+0.07)    4.56(0.01+0.07) +24.3%


large synthetic repo results
============================

Test                                                            this 
tree          gfw
---------------------------------------------------------------------------------------------------------
0006.2: read-tree br_base br_ballast (1000001) 
1.33(0.04+0.04)    1.33(0.04+0.06) +0.0%
0006.3: switch between br_base br_ballast (1000001) 
48.96(0.03+0.12)   50.76(0.03+0.07) +3.7%
0006.4: switch between br_ballast br_ballast_plus_1 (1000001) 
3.64(0.01+0.09)    4.59(0.06+0.07) +26.1%
0006.5: switch between aliases (1000001) 
3.68(0.03+0.07)    4.66(0.04+0.06) +26.6%
