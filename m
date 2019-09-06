Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF03C1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 21:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbfIFVE3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 17:04:29 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:45887 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731199AbfIFVE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 17:04:29 -0400
Received: by mail-pf1-f193.google.com with SMTP id y72so5367664pfb.12
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 14:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=vFkI8j+3IN2p6po/oavYJpJCq38lKh1HLj/sZZBuV6g=;
        b=EAgY2Lk3qdyzd4HHxq5dGm3oa5CiFL/BiaVolp/PNoiPEbVeUDFhvj1a60+LRU6clv
         XqQK0jAW4jcXsPVHG9ysovRMlN3a+0YtCI18PiaTdNzBwA6x6LJ8M/730HPriGmMFkXN
         h6LLFPDPwDakVsHihOgMemo/zxCGZwYdMH5c0ohkGBwb5qSIqzmX9IaO/3KZ/eJTEu2N
         T59xioE9/jlot8T8zsqknz2hIU1Msp6bhRXf7EBEooryVndoS2k6OJeH6wX1aTJ4XO3+
         9VWsygvIifyExU6sQ2ytTI98n+G22abGhORaylrvgMl5+AgFmy8fiE6AGNyS0+O12xyq
         Ddbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=vFkI8j+3IN2p6po/oavYJpJCq38lKh1HLj/sZZBuV6g=;
        b=LeYd05J1JKuzeYdbFpxpxiaFkuxdNHarMkgMNQY2UHbOKSGzDO6AuhuZ6sDUBhKK1w
         NsIaxIOhAeU3UA6HQPAvmhccouM+Trz210RxL1du4aXzt5Wd1FiKMR4eyzvcIYUt494Y
         IRam2sB9plP38ay7j0NAmIm8QvEdEtYF9ax5ZSKP4g6pYZ5ogKY6gRsi9B1fjfiFz9Mu
         ZxJbe6+SoC04ECyhmqi+AVqaS5sHFwdU0ENwyTMhdbii+pP1MAMpNLRvZz7Ybve12aPA
         Tv+8wTeTu7UqmvYhtLvQZP/nJ1dy8lUjjfQPq3IYIYwy6je2c22XTv29QRuEW2WgAsf6
         AqBA==
X-Gm-Message-State: APjAAAUd9q+bvoiq47vnglMOY4xYj/Lhjt/rTq69ZvFoLALuVetzsbH5
        CSJ3aIwHFHhNdS7WDv5LI14=
X-Google-Smtp-Source: APXvYqwri1VkazsCl+nI0z1AFdhhpF+qoiwZVn1EAb4ZlOEZ7/OGdlg6xXVKa1Z/tbbE94VnttN9nA==
X-Received: by 2002:a63:4823:: with SMTP id v35mr9713826pga.138.1567803868530;
        Fri, 06 Sep 2019 14:04:28 -0700 (PDT)
Received: from [172.20.15.13] ([209.119.211.66])
        by smtp.gmail.com with ESMTPSA id m19sm4918257pjv.9.2019.09.06.14.04.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2019 14:04:27 -0700 (PDT)
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, avarab@gmail.com, garimasigit@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <20190904030829.GB28836@sigill.intra.peff.net>
 <xmqqa7bipjil.fsf@gitster-ct.c.googlers.com>
 <a697c4de-e269-c330-ece2-8ac7007e6c55@gmail.com>
 <20190906175628.GH23181@sigill.intra.peff.net>
 <xmqq1rwtnv03.fsf@gitster-ct.c.googlers.com>
 <20190906191622.GA7096@sigill.intra.peff.net>
 <xmqqpnkdma0g.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <25ed1562-dc74-1ebc-46ff-d6cd643504a4@gmail.com>
Date:   Fri, 6 Sep 2019 17:04:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqpnkdma0g.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/6/2019 4:42 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> I suppose so. But I think the "stock git without any other job
>> infrastructure" case would still benefit.
> 
> Oh, no question about it.
> 
> I did question if an automatic writing would benefit the side that
> receives a push when you brought up the usual "fetch.* and receive.*
> for separate configuration, transfer.* when want to rule them both"
> convention, which is a good idea if only for consistency, but the
> question was if it helps the receiving end of a push to the same
> degree as it would help the repository that fetches.

I think the "stock git without any other job infrastructure" is
a very important scenario. Putting the simplest version of
"commit-graph writes in-line with every push" seems to be ripe
for failure under load. I'd rather think deeply about what is
best for this scenario.

Spit-balling: what if we used the same mechanism as running GC
in the background to launch 'git commit-graph write' commands?
And we could have the command give up (without failure) if the
commit-graph.lock file is already created, so concurrent pushes
would not fight each other.

Thanks,
-Stolee
