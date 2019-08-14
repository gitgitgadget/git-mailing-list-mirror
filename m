Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD081F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 10:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbfHNKcx (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 06:32:53 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34614 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbfHNKcv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 06:32:51 -0400
Received: by mail-yw1-f65.google.com with SMTP id n126so3321504ywf.1
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 03:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=adsbSK1ypS8UI4lnCh12SqHLkI/PfoUCVNOH0dcjLQI=;
        b=P8Hhb79M1BgoA/C9oBXOTd4oCer8vLSzVEYRInAIm/0hauic7TGCOnjDOcsQiQ2dc/
         SbX/wreRZm1Mj6ovjYN0//M2IK3uJphr7+Q0HpY6f3lENTyMBKz+JUowtjiGk4Ct8J+Z
         tec5mqu6rqyvRPqfl6/XwSdtBm8c6xAWIyWXEfxHijwacoMDRoQ3AiAXdivlx9zeirKA
         w5lM2pIAbqSjyTVZo3d5tlfkHtJpn9DLSZbvizXLASPAWKDPbggyKi7YN5pDoBRmCbkV
         Tvsdl5EPHrRzyrDkk8MEVUnwtzOOAPdda5dFN29v+MsBSLIWtGZqXZkeVT4jgnWj+mnv
         W0fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=adsbSK1ypS8UI4lnCh12SqHLkI/PfoUCVNOH0dcjLQI=;
        b=VYevLzF+wAbLN6g1C2Qnu+S+XzsNbrNWzvd+c6JwEXL//YQ2EwOZ+xIoWdxBh5gS2w
         voUW+Q92r4H81gfA8JMGWiFt3ohbcXz/M8WOiVAfG5j1SvFWCDGNQDyoF+V3/fi11oHD
         ScIxCIGwTZfuUTQuwBiKEBBu9MAPHE4pXPLBAFMGkkQkyRsRn0baZnZMP8l7a2ERTc+R
         +6VTYnrty0ibbTSKgWsbKEbnT4JrBerqPnHOR7gvFumBKrDcyOn/LmE6+0g+4kTZRUQH
         ZG9fjoU6lNgI7P8qNWSDZ5mnLtd4y7ZuQ1yP80fgi1B6KQGAJywkg1nkxivKoK+CO9I7
         RXpQ==
X-Gm-Message-State: APjAAAUeIjgc54FF5wF+KQ+83FBUJbLzRzUBLQ2dQYpvFDMbYuSgqdCv
        QL3YEC1ix9G7M71Wg/BgJN4=
X-Google-Smtp-Source: APXvYqxRWCAxIdR5sZzN3cLGRfoaWUgj9fyNCfTZzQ5NImGh/ZPvcobmAItbZAvzL1JUVVogBRd8Gg==
X-Received: by 2002:a81:350b:: with SMTP id c11mr31872784ywa.123.1565778771010;
        Wed, 14 Aug 2019 03:32:51 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id i137sm24926638ywa.3.2019.08.14.03.32.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 03:32:50 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Create 'feature.*' config area and some
 centralized config parsing
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <xmqqmugc7p6e.fsf@gitster-ct.c.googlers.com>
 <xmqqimr07ozp.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b7fc8353-abcb-742e-3dc4-4a404bbc55eb@gmail.com>
Date:   Wed, 14 Aug 2019 06:32:32 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqimr07ozp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/13/2019 5:08 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>>  * Update docs and 0 constant in feature.experimental around
>>>    merge.directoryRenames.
>>
>> I somehow thought that the concensus was that *.experimental is for
>> things that should become the future default, and this one is not
>> something we would want to make the default.
> 
> Ah, I see merge.directoryRenames is gone.  Sorry for a confusion.

Confusion is my fault. This was a terrible way to say, "I cleaned up the
adjustments to merge.directoryRenames AND removed it from features.experimental"

Thanks,
-Stolee
