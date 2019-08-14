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
	by dcvr.yhbt.net (Postfix) with ESMTP id 366C61F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 10:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726770AbfHNKid (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 06:38:33 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:46809 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfHNKid (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 06:38:33 -0400
Received: by mail-yw1-f66.google.com with SMTP id w10so7415084ywa.13
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8/rl7fR8ZbakNlTMV96RzZDChyQ+pCChUJqeDrLSk1E=;
        b=IDFT6hTcmIuEJGsZUtfyPlSffT24S0hzV50jNkADN7U6hAqWjjwXLN1uwvVQRiN0RS
         UcRDWJmC8Yt3IwEOa+oTCd3tkVxubSIA40PT5JAcVcZ3/pTYlsj3tK1p4agB9ZlqCvYB
         mNAScBcarG7coetWfynY+cnF/+m2kfH3N4xLyyE4Uq5c+xYxiATdiRnOeu25abDFiOhI
         oluUBGrdsUnUv0uWk+AC99KOs99iGnq+PwQebI6ZbjDSKrNpW2ibdXUdUhJ/drlnPG6j
         5fUi3ryY5y47SRl6ui4SFy4FCxZ/dx73kB5QMA397X/Up1gcLJ2sSmqMlAefBZksd8jW
         CWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8/rl7fR8ZbakNlTMV96RzZDChyQ+pCChUJqeDrLSk1E=;
        b=lAIB//rEX18w9nV/pxEqvpsYflHwNwli2fxlHw2jRz6CQvyqd7l8pKG7Dx9/N2p2rG
         6OQaYQf6MPJAasYwmhh3cxEyb6fZJ5tNmZjqb+sIMDYOPVQnfD6xB3kmyy4uTCsGBwy9
         h5dJ2/tVeZsUr4CWRYN++Cbu870KKfoU0rsIz+3FDPj/ulbVIc5d5vpC8ahZvZYt25vF
         PJYAypRXHlibFojYCSr8VcI1aa+qlXS5fOCaIE7pRrjy2Esw8BlZSzBJU3TujOotRJ42
         PHtMmNBE8vCby4h6SUzr+H4Xpf/QDsLhm5R6tXbun8m29GyNaIzt1KRfr1PIZk9L8nIz
         eoxg==
X-Gm-Message-State: APjAAAVnKDdb7xUg5ldtUEsw9c6rxvaOl2hxFFop2PHKGSosEUzk/ztV
        j+G9Rd1L8X7XHQxNN7WiR+o=
X-Google-Smtp-Source: APXvYqxTu/lZTtoHgwrSelwLcrslznaDv/Hn6OW/zmJQHC0k7EAzhodEQP5Sw3C/g+OIOzCO9BomzQ==
X-Received: by 2002:a0d:f6c7:: with SMTP id g190mr14667167ywf.13.1565779112139;
        Wed, 14 Aug 2019 03:38:32 -0700 (PDT)
Received: from [192.168.1.9] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id q65sm5413229ywc.11.2019.08.14.03.38.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 03:38:31 -0700 (PDT)
Subject: Re: [PATCH v4 0/6] Create 'feature.*' config area and some
 centralized config parsing
From:   Derrick Stolee <stolee@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com
References: <pull.292.v3.git.gitgitgadget@gmail.com>
 <pull.292.v4.git.gitgitgadget@gmail.com>
 <xmqqmugc7p6e.fsf@gitster-ct.c.googlers.com>
 <xmqqimr07ozp.fsf@gitster-ct.c.googlers.com>
 <b7fc8353-abcb-742e-3dc4-4a404bbc55eb@gmail.com>
Message-ID: <60fdb58a-3f83-5e65-9286-7164f42b60b4@gmail.com>
Date:   Wed, 14 Aug 2019 06:38:28 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <b7fc8353-abcb-742e-3dc4-4a404bbc55eb@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2019 6:32 AM, Derrick Stolee wrote:
> On 8/13/2019 5:08 PM, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>>  * Update docs and 0 constant in feature.experimental around
>>>>    merge.directoryRenames.
>>>
>>> I somehow thought that the concensus was that *.experimental is for
>>> things that should become the future default, and this one is not
>>> something we would want to make the default.
>>
>> Ah, I see merge.directoryRenames is gone.  Sorry for a confusion.
> 
> Confusion is my fault. This was a terrible way to say, "I cleaned up the
> adjustments to merge.directoryRenames AND removed it from features.experimental"

It's too early for me to say things... let's try this again.

1. merge.directoryRenames is removed from this series.

2. The commit where I did the cleanup according to Elijahs' recommendation is 
   available as a tag, as mentioned in [1].

[1] https://public-inbox.org/git/1a2bf8e1-5cc1-c626-9dfc-dd6dc58fa0ad@gmail.com/
