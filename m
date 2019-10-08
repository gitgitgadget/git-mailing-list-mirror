Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C23011F4BE
	for <e@80x24.org>; Tue,  8 Oct 2019 13:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfJHN43 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 09:56:29 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:45859 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbfJHN43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 09:56:29 -0400
Received: by mail-qt1-f195.google.com with SMTP id c21so25356407qtj.12
        for <git@vger.kernel.org>; Tue, 08 Oct 2019 06:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1voVdbtdUmzVKa41zWGvHZXctO/vwm1t7Nlx8PvsxE=;
        b=DDzby6nOMSPwAD6RAy5uhcHUIPnrFlsFcG++9Zot1ZIrCl9wTkicvRXyJs27dS+7D0
         GZ2Jo5WMgSxET6l/Vmnu4ZUtzE+Jus0aVmCFtU35AiJHtMG4rkvQ5NgVbbJHQw0E6jHa
         i3zKPAlNfg9zGSqvg7xqaW+AV2SzBA8ftYT8KwH8FiYxTUMnYAdTNRJcbZX+kHZ3yvG3
         S+nOWM4/qmFzMf4lO3LCWRrvazqiaJx6Zc9vgfPfQCD5E852vx4ySIIz1TmKZJcn8LUH
         IaP278t7BFk0YRPyq1BPZpiOpoawzwz9v42j+e2foL9+ZtMHZTllyYA/RGw0Rx5yvvBt
         Zyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1voVdbtdUmzVKa41zWGvHZXctO/vwm1t7Nlx8PvsxE=;
        b=E4jgiE4j1woNG2JnPkHqomz6A0Mrfw1SSKHPL/9eRmqHWOv8QJ/H1ROA593mPb0Plo
         7pveJQLFJpkY5wZ4f+lw/jvVLb//gXnRYDeP/tAiia/1sIg0DbX5EX64ycjkajXAFhkZ
         H0AiwxcoGZ4Mrf1Clp9g9vxGqYwQankuWk0miE91BcnaFnStTAb3610YCkI5hzanA+pB
         8UckxUt7tl+fhjjk0znTdjfiXU5nDZ66gK0ena+4goFowKBYQCoAHTJvr2om10/LQLFP
         ACw/2Hx6QjwqisttiR6uTOOkh2c2K3qIKRmnrqDa6apUSb3pCz1EEXx7Y2S/6KNTXcO8
         UBzg==
X-Gm-Message-State: APjAAAWxrXel16jHqdKjo1uBMLdB0yDQSExOBJy6tR1OIb/PNpofZxPk
        RVAkAmvdCgife1URomDRU9A0o28nj4E=
X-Google-Smtp-Source: APXvYqy5cQ0jDHmk3r9aCPpu6kbvVQOP/RbmjGQWYeJF/e4K0SUVh/EBtmqzajFIy0agdXTDYr44cg==
X-Received: by 2002:ad4:458d:: with SMTP id x13mr33454466qvu.85.1570542988355;
        Tue, 08 Oct 2019 06:56:28 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c988:3ed2:5e14:1c0f? ([2001:4898:a800:1012:7abc:3ed2:5e14:1c0f])
        by smtp.gmail.com with ESMTPSA id b16sm12350920qtk.65.2019.10.08.06.56.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2019 06:56:27 -0700 (PDT)
Subject: Re: [PATCH v3 00/20] hashmap bug/safety/ease-of-use fixes
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Phillip Wood <phillip.wood123@gmail.com>
References: <20191006233043.3516-1-e@80x24.org>
 <nycvar.QRO.7.76.6.1910081055210.46@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <111295eb-8bac-7074-158d-a65903de9db7@gmail.com>
Date:   Tue, 8 Oct 2019 09:56:26 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910081055210.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/8/2019 4:58 AM, Johannes Schindelin wrote:
> Hi Eric & Junio,
> 
> On Sun, 6 Oct 2019, Eric Wong wrote:
> 
>> v3 changes:
>> - use __typeof__ to avoid invalid clang warning on uninitialized var
>> - formatting fixes recommended by Stolee
>> - add Reviewed-by for Stolee
>> - add patch 20 to update docs to drop first member requirement
> 
> This has quite a bit of fallout, even more than previous rounds, it
> seems. I need at least these fixup???s to fix the build of `pu`:
> 
> https://github.com/git-for-windows/git/commit/f74259754971b427a14e6290681e18950824b99d
> https://github.com/git-for-windows/git/commit/124c8bc08e974e76ca7d956dc07eb288e71d639e
> https://github.com/git-for-windows/git/commit/45948433d1b48ff513fbd37f134c0f1491c78192
> 
> Junio, feel free to fetch and squash those into the appropriate merge
> commit(s) (I feel that 4432e8b5f36 (Merge branch 'ds/sparse-cone' into
> pu, 2019-10-08) may be the right spot).

I expected that my series would have semantic conflicts with this series [1].
I could re-work my code to take these changes into account, based on an
appropriate merge of ds/include-exclude and ew/hashmap. ew/hashmap is likely
much closer to merging than ds/sparse-cone.

Thanks for doing most of the heavy lifting, Johannes! I'll probably start by
taking your fixups into the appropriate commits of my series.

-Stolee

[1] https://public-inbox.org/git/d16b22c9-c437-0947-fb5a-9421f987a1f1@gmail.com/
