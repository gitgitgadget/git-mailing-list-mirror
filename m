Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3903DC433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 16:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240683AbiCJQJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 11:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240657AbiCJQJa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 11:09:30 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B06418460C
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:08:28 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k24so8731322wrd.7
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 08:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qpoVsIHlYtYgIKeW21tOMJNoZErsQ+3yVnzx/+0QfAQ=;
        b=cgUd3FTOwaxUv8Sr8NueF3dxqgo4fmGuwdAcGbC0j7hZlkmBsWFGsq6S4vwgYTvMQ1
         jkHcuyIHoWn70Ao52Jw/C+7M5H/6qy65zmp++XXJ8oa0C0DFmGAjg53ley6gCCcRs6kU
         yMkHYCqINI0pKAKjfuZ3wBAOL2grarizM06ZRRYj/JuOCGL1kMDll/7trd6tq4+Sr3Es
         E9TqvSflAVtPhzOWeAxtu7perYbO4xh+vTfMTNHB2YgcEONSN5u0DpWoryQQ3sU6h9J4
         YahvmB/fTviNLYDVDIrJjQoMhb9K8vYSvkrzU1A1EZS8wtB+1FCXeFudNe1XmcxoCs5A
         KKbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=qpoVsIHlYtYgIKeW21tOMJNoZErsQ+3yVnzx/+0QfAQ=;
        b=gbXLVllG04GjMM2fRFIQaulNEUij+whMieO0spxmXo9Mm11eAATiTOdfOBmqS/8+t2
         CIWUW7mvJ653N5DAPRSaeY2GG5mR1pO4cRBO2QrM6LlU+fouhhvgOmRqJnjDSBeIYy9O
         VpoW8Xt7JyyZlwU9XGxhXhsXxuQ9+aWe94UvPqh1F08ZMqrracKXX46Oiv2guDyhf74H
         ufGyj3PFIgChVaWgnMm6i0k19Amg3imQjh57wJB2eBLphXdBjqBwFpENBsnqKOjjoqnV
         X91H39DRl1hR4mImhH+CDciWznhbPAFFYY96uYvlZZrSNw7N4/O1IpDtmlWPe4cWChXd
         lZzw==
X-Gm-Message-State: AOAM531lfC1OwWCz2yS4LvCm/S5IqRCVzh5KjS5rHN7/jjBbTp/Mix0t
        6hyaBvzfEa4ZGZDtIsqe/6s1EwW7I6Y=
X-Google-Smtp-Source: ABdhPJzzlXltoFLg2+dIWFbr0hISGZGMxT1mDkD/RzIuQ9hzasBOWL3xrYR7UNJW+tKRb7rqkSDnPA==
X-Received: by 2002:a5d:6d0f:0:b0:203:9157:1c48 with SMTP id e15-20020a5d6d0f000000b0020391571c48mr1298042wrq.192.1646928506883;
        Thu, 10 Mar 2022 08:08:26 -0800 (PST)
Received: from [192.168.1.240] (217.2.7.51.dyn.plus.net. [51.7.2.217])
        by smtp.gmail.com with ESMTPSA id p2-20020a1c7402000000b0038159076d30sm7996453wmc.22.2022.03.10.08.08.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 08:08:26 -0800 (PST)
Message-ID: <e22e2b8b-55b5-5392-5772-e8a5ff0ee245@gmail.com>
Date:   Thu, 10 Mar 2022 16:08:23 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 0/4] builtin add -p: hopefully final readkey fixes
Content-Language: en-GB-large
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
References: <20220304131126.8293-1-phillip.wood123@gmail.com>
 <20220309110325.36917-1-phillip.wood123@gmail.com>
 <nycvar.QRO.7.76.6.2203101422500.357@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <nycvar.QRO.7.76.6.2203101422500.357@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 10/03/2022 13:25, Johannes Schindelin wrote:
> Hi Phillip,
> 
> On Wed, 9 Mar 2022, Phillip Wood wrote:
> 
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Thanks to Ramsay and Ævar for their comments on V1.
>> Changes since V1:
>>   * Patch 1
>>     - use an enum for save_term()'s flags (suggested by Ævar)
>>     - fixed argument order in the windows code (thanks to Ramsay)
>>   * Patch 2
>>     - fixed a typo in a comment (thanks to Ramsay)
>>   * Patch 4
>>     - stopped duplicating the strings returned by gettext() (suggested by
>>       Ævar)
>>     - reworked error message handling in the signal handler to add an
>>       "error: " prefix (suggested by Ævar)
>>     - tweaked the background resume error message
> 
> While I did not ask for any of these changes, they look good to me. I had
> a look over the range-diff and found it reasonable.
> 
> Onwards to a bright built-in `add -p` future!

Hopefully! I spotted a couple more small issues earlier so there will be 
a v3 soonish

Best Wishes

Phillip
