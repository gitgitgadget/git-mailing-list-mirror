Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B36771F404
	for <e@80x24.org>; Tue, 28 Aug 2018 12:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeH1Qkt (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 12:40:49 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:42159 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbeH1Qkt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 12:40:49 -0400
Received: by mail-qt0-f196.google.com with SMTP id z8-v6so1448863qto.9
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 05:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=MY4iiqBBxg0mRohVOkAxPzzf2YBBBXSINDth0hY+WdY=;
        b=ZxhOBc5PJ+ma6BvO2dWs2++erAD9E+QOG3tsn+JoLYBiTrOQ8tv73MmXUWBohWyRqs
         OddXv+l+J2MC4HFc5BNVR21XSSoZrVTPnDbCNWrCASu8bmq5aZ9VZYloreDWkyjPNF5s
         vFBYSrE3BMnM11m42ApS/aMAM0l7o4FgYb6UQl39ZwrIIg18zR5a1YQsvO++fw8Qg1s7
         QpmCv8/aVU0kv/xG2qSp2fCRs+HuU5hemSoZwBedPY0g/FEZQlFMZ7msX3KqAhMqCqyh
         ozo+3q1UsDJFizfCZyhcWMpWat1AmdcvT5OtLE9zsZECbNXhhzyTE/kdJqIKhLxzDp9K
         6MCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=MY4iiqBBxg0mRohVOkAxPzzf2YBBBXSINDth0hY+WdY=;
        b=Qd82Ia2q1nR3JIPqCfVyyd3+xiHzNYfQVwxxFybJgzBVvkfJN7RbRB93vFMhcxPOGl
         ez46jy68EVEuw+J+GHoOE6bwMECUMJPpVS0N+QsOXo3azzYeguiY/HAL0f+WW5WMUtu9
         RaOvBYVUYHjuWcPbilef3NLrp33vsux3nNxHCQfij2uUwXbeTPqUY+ncoTHivhD99WS6
         AvjMUx1nECFIhItOzlfIHpIBkBhuNqQsnEYzUf2fWuhxR/IQc3gAGAveoxYKkm4L4v78
         NewGlIPPmdeFZwrO4Cj5/u1e8ZSgRt84OuDhk/HfRRq/1Sh0jYaI7sjtUOEMeNpvz7x6
         SMWw==
X-Gm-Message-State: APzg51C9Pqp5mk3WSPq6ogau3/YvkeIMn424HvwyIndaeTOP+3O6KcE+
        NzadUWR+85pgUka8USisUHM=
X-Google-Smtp-Source: ANB0Vdbvh9/69zDBJMq/L4SWGxUPn8eTtS8kjUkqQBiIn23TLp52kWjcT3RUOznSJymIMLZZVrLARA==
X-Received: by 2002:ac8:3630:: with SMTP id m45-v6mr1425271qtb.210.1535460558396;
        Tue, 28 Aug 2018 05:49:18 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:b56e:35ef:8f5a:7d37? ([2001:4898:8010:0:9ea4:35ef:8f5a:7d37])
        by smtp.gmail.com with ESMTPSA id m9-v6sm642446qta.55.2018.08.28.05.49.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Aug 2018 05:49:17 -0700 (PDT)
Subject: Re: Questions about the hash function transition
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>
References: <878t4xfaes.fsf@evledraar.gmail.com>
 <20180824014703.GE99542@aiede.svl.corp.google.com>
 <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <c098b0c6-1062-6581-81a9-7ce15f3738de@gmail.com>
Date:   Tue, 28 Aug 2018 08:49:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1808281402510.73@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/28/2018 8:04 AM, Johannes Schindelin wrote:
> Hi,
>
> On Thu, 23 Aug 2018, Jonathan Nieder wrote:
>
>> Ævar Arnfjörð Bjarmason wrote:
>>
>> [...]
>>>> Since all operations that make new objects (e.g., "git commit") add
>>>> the new objects to the corresponding index, this mapping is possible
>>>> for all objects in the object store.
>>> Are we going to need a midx version of these mapping files? How does
>>> midx fit into this picture? Perhaps it's too obscure to worry about...
>> That's a great question!  I think the simplest answer is to have a
>> midx only for the primary object format and fall back to using
>> ordinary idx files for the others.
>>
>> The midx format already has a field for hash function (thanks,
>> Derrick!).
> Related: I wondered whether we could simply leverage the midx code for the
> bidirectional SHA-1 <-> SHA-256 mapping, as it strikes me as very similar
> in concept and challenges.

If we would like such a mapping, then I would propose the following:

1. The object store has everything in SHA-256, so the HASH_LEN parameter 
of the multi-pack-index is 32.

2. We create an optional chunk to add to the multi-pack-index that 
stores the SHA-1 for each object. This list would be in lex order.

3. We create two optional chunks that store the bijection between 
SHA-256 and SHA-1: the first is a list of integers i_0, i_1, ..., 
i_{N-1} such that i_k is the position in the SHA-1 list corresponding to 
the kth SHA-256. The second is a list of integers j_0, j_1, ..., j_{N-1} 
such that j_k is the position in the SHA-256 list of the kth SHA-1.

I'm not super-familiar with how the transition plan specifically needs 
this mapping, but it seems like a good place to put it.

Thanks,

-Stolee

