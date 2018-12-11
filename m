Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C48B20A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 12:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLKMcl (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 07:32:41 -0500
Received: from mail-yb1-f175.google.com ([209.85.219.175]:42842 "EHLO
        mail-yb1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbeLKMck (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Dec 2018 07:32:40 -0500
Received: by mail-yb1-f175.google.com with SMTP id b4so3625015ybg.9
        for <git@vger.kernel.org>; Tue, 11 Dec 2018 04:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=NSMa/Dnhbnk9NWmpU+xn+YzuGzQ5IyBrK9uvI1lP6uI=;
        b=OwHIcKXw9U/Dxg51mBDzhwkgNaQr16jyUrtEJWAGWsGfi+ROlu1y67hGAEwO9oBVjR
         CGFBjK8XMfC2VD1bTbcr6A0eii2AJJ1NzWItBg2MHeaC917MXeltwwGKkjd33TqBi4hp
         +MalBcOCYgtWqNDljYtbyvVkcupPLUA7MUK1HFIq30/wbzW4i81cyMHYjkeU2nF9Ljkx
         GI2volzK9U6tGez1rhIdZXUtO4+3urwtWu8dFwmqLZSPqOeohZg8QFS/v+oBOVWPYOsN
         nY/Ab7AxPlOyFoQmv9irlq8VQJETgzw2AWrjXgMOTZFjxZhEdmz3X2iFXXcxevFy8eO5
         XmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=NSMa/Dnhbnk9NWmpU+xn+YzuGzQ5IyBrK9uvI1lP6uI=;
        b=M7UCqAuEbApIKNZj8M/zFjBBViC/JLMRSQCiQpDVYBkNIh7NmPASxCvZ4NVEjn/WXe
         Q3QlSP1xlHjioTfWiv0fzEdv8gct1wPeDaCFLboVjukCypI3I4pBxPuDJBkoyP1IWVmx
         G87IDf2f7aRrRIVhossjrsgWFpzX5yUvD9P3AtEqKlundrFXjiYT7WSe0vkYh/sXnFy2
         8jBn1C8O/F68okbEeEpF8xDHmL3qkAbae7BKStsKx8ts/J9SPz1ekdGsDWXEQVMZG8Ex
         qThuAE1oJRVjl8sw4L0ru1Wd7sJD+bcmoIirZIUapf8xMKFEjOTebvkOTvf2U1XnGham
         dV8Q==
X-Gm-Message-State: AA+aEWbW84YLUvWk7fNmhSWbFYBq3G47vgMSwWK+RwbCpHgUso/rRV0I
        +aRrPmTyaI56DPU4HZrGpwY=
X-Google-Smtp-Source: AFSGD/Wgl5zWkQ5R/Kcuwb89iSSwLUNRtUbWg43P8fHuKoYdiGL8k2iGR223aYVhxPgiVyebqBlfvw==
X-Received: by 2002:a25:af04:: with SMTP id a4mr944420ybh.195.1544531558576;
        Tue, 11 Dec 2018 04:32:38 -0800 (PST)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id u4sm5421731ywl.29.2018.12.11.04.32.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Dec 2018 04:32:37 -0800 (PST)
Subject: Re: [PATCH 1/5] multi-pack-index: prepare for 'expire' verb
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     gitgitgadget@gmail.com, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.92.git.gitgitgadget@gmail.com>
 <1e34b48a2051089052c0b53b0059576b5ace45de.1544465177.git.gitgitgadget@gmail.com>
 <CAGZ79kYeHgCdzNNXUnp1NaokT=Vpj4mUVt1bZb5c+EkgO2z-4w@mail.gmail.com>
 <20181211015957.GR30222@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0f0888e6-2df5-ec5c-5c9a-7e6956cb9612@gmail.com>
Date:   Tue, 11 Dec 2018 07:32:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:64.0) Gecko/20100101
 Thunderbird/64.0
MIME-Version: 1.0
In-Reply-To: <20181211015957.GR30222@szeder.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2018 8:59 PM, SZEDER Gábor wrote:
> On Mon, Dec 10, 2018 at 05:35:28PM -0800, Stefan Beller wrote:
>> On Mon, Dec 10, 2018 at 10:06 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>> +expire::
>>> +       When given as the verb,
>> Can it be given in another way? Or rather "if the verb is expire",
>> then ...
>> (I just checked the current man page, and both write and verify use
>> this pattern as well. I find it strange as this first part of the sentence
>> conveys little information, but is repeated 3 times now (once for
>> each verb)).
>>
>> Maybe we can restructure the man page to have it more like
>>
>>      The following verbs are available:
>>      +write::
>>      +    create a new MIDX file, writing to <dir>/packs/multi-pack-index.
>>      +
>>      +verify::
>>      +    verify the contents ...
> I think a s/verb/subcommand/ would help a lot, too, because that's
> what we call it everywhere else.

Thanks, both. V2 will include a new patch that reformats the doc to use 
these suggestions, then extend it for the new subcommand.

-Stolee

