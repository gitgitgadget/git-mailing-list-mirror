Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B380D1F404
	for <e@80x24.org>; Fri, 13 Apr 2018 12:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754554AbeDMMSL (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Apr 2018 08:18:11 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:38422 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754494AbeDMMSK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Apr 2018 08:18:10 -0400
Received: by mail-qk0-f182.google.com with SMTP id b39so3666027qkb.5
        for <git@vger.kernel.org>; Fri, 13 Apr 2018 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZJWytJvwMFnTzhgP+2trmeFqOBhaSseln7oJR3YYZ4M=;
        b=cJJwIl/pCvybkZcKYAdT7cB2bHwqLUuuKDtsOJ/BXrbi6vyD4cDPby4pzkE5kFdqho
         fJZ7/e5BDfanylS73iLVst2/X++f2qA1kyLrI7CaxxZg2wk0BM4+105Blbdt0Js6GpDv
         X57neVPEG690I1Jc2B/1a6Pp6TvjbzNo36tjq53UW73rlXblkriZ9PrRBLOCDib1xhSs
         lcBiP8VWd+Pa76ISOCv6jlOsc/Iks70tdnSKmsuPO0+ItMOda4DibTaUxWcTLco8cipT
         i30jYTnTnpqB+L3rVDJYv4+wLl/8R1h3T+7bFp/+sk1+xV60j752C/eeZRVmKA2vUh9N
         KiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZJWytJvwMFnTzhgP+2trmeFqOBhaSseln7oJR3YYZ4M=;
        b=MaR3gjkcilBPw9Ilm1nP1e7hDIy15qTrsGBERPrcwVeJUKgBZkSGHW1a7EpDOis9It
         Uc2cHjcPx5NhPt+S80vszhLthuqEbcj04ZUARXGHyH8whIyoXIkLSMJZD7ZcuQ5TqCwE
         4S10prMmgeoIUnl7mgmYHRnnxopBXRwzxq0PukCeJzc9CmFVObizbg1KQrMfefQcSmrD
         7nLY57gTBLbWzgygNpnHe/unuoaVTP7U5EW0SaB76Dx3ExFws2MccLBWUlozwDnGHi8n
         66/a1UVfWC5Loi3U88hPaJVuv4rQCVP3/RW+dtsWocTRWba7p/8CnLhH/u0YcvGLjell
         hn6A==
X-Gm-Message-State: ALQs6tASo1vqDjB/v9hio3TGxPC3uOW6zRJCWDIIU/e0CaK6hZGj2NfU
        9efnGdz9oW92hp1KRq0D7MI=
X-Google-Smtp-Source: AIpwx4/vBNKQQwwM+v1tGG/oDYvLDH8LYVlN/Ps4CiJKaiuV2BiZi4t3b0v7h5SlRhJL4f3I3yeY9A==
X-Received: by 10.55.22.41 with SMTP id g41mr3612654qkh.172.1523621889352;
        Fri, 13 Apr 2018 05:18:09 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id j186sm4330067qke.34.2018.04.13.05.18.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Apr 2018 05:18:08 -0700 (PDT)
Subject: Re: [PATCH v1] fsmonitor: fix incorrect buffer size when printing
 version number
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "gitster@pobox.com" <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "alexmv@dropbox.com" <alexmv@dropbox.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "johannes.schindelin@gmx.de" <johannes.schindelin@gmx.de>
References: <20180410184327.13896-1-benpeart@microsoft.com>
 <CAPig+cRvujJ2RmH62qnjS8asRn0wc+f-O+KA01NfFXuJDk3fog@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <2b6b2a54-8349-ea28-f752-4d752c798d5a@gmail.com>
Date:   Fri, 13 Apr 2018 08:18:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cRvujJ2RmH62qnjS8asRn0wc+f-O+KA01NfFXuJDk3fog@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/10/2018 4:17 PM, Eric Sunshine wrote:
> On Tue, Apr 10, 2018 at 2:43 PM, Ben Peart <Ben.Peart@microsoft.com> wrote:
>> This is a trivial bug fix for passing the incorrect size to snprintf() when
>> outputing the version.  It should be passing the size of the destination buffer
> 
> s/outputing/outputting/
> 
>> rather than the size of the value being printed.
>>
>> Signed-off-by: Ben Peart <benpeart@microsoft.com>

Junio, do you want a re-roll of this simple fix or can you fix the 
spelling of the commit message?
