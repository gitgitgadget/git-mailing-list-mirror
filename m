Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E8E91F404
	for <e@80x24.org>; Thu, 15 Feb 2018 18:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166556AbeBOSbz (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 13:31:55 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34110 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163136AbeBOSbw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 13:31:52 -0500
Received: by mail-wr0-f194.google.com with SMTP id m5so648079wrg.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 10:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=gcBEeCqF8uGndi3FtXeH685gZLoOwwwCVGBFlOr+8HE=;
        b=sn5HSFbfRcHU9GDOOZPVbi8APWw/wfZEi44rN4b1GZZmlunMMEL0mV8TfsA3hvPmbc
         HOYDn8p5aj8UEv9sSKwVd1b7BeiW/rhAxUNVQH1dnGNTJGSV14PyFZ7MxSawZAwom+1u
         5LbFlIMBhmeLcV7UrXAEFfHFLhZTYoDOTVNvv3hRu/r2kd83bVf4G/AknBp82qyfI72t
         CQi0uFo8axTXWEs9ywTOXr5PSHDpK8gjOYBFi+k1e99W+siZhMSm7b7fVydZOHyJk6LA
         ZASbmwpodq3xuPtf4NUy8V61kCsUVetKg2h3Mnr8vnGoW1eLwjI8DkkahpNjgviBuSCe
         ErBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=gcBEeCqF8uGndi3FtXeH685gZLoOwwwCVGBFlOr+8HE=;
        b=Vu9gMJ5A/YV2G3GT7qSqrGos+Cdv5M/X/IHA1PcqbEu6Yk1tnPRufLabxT0xrawxgg
         CerGARuWzmQWZrceuZRq2MafqGYan3Hg2RwD/yo6MJ3Ev4G3tYWo9ScDAY5j0B8bTkaV
         MBTHIpsEDfHig5yiGGst5xzqu1QpVdCSkmyG3imunEp6QBAeLCIBaogJLbYj13+BiyvJ
         qGm4AXPXcVcBkZIIOownPWsJyV4H917lp14SXCC/AOT39WJCvbJkkRXIrYfXFGNEvNJk
         ekisrSHlo6RsurqAUaRop9eiy22plj2wsvf6RQbAHN6q8euHK8/D9YQSTBw7+UKpCh2b
         CWnA==
X-Gm-Message-State: APf1xPAyDh3eK8jq047+4TzCLKGWRFz9KM5U8iTK+C1dYgdd/ez6fuhV
        sZb4E6Ln/r5BvhjygvotttygUv9d
X-Google-Smtp-Source: AH8x225MsYY3rF/R1f19SL9WeLbZnvwYoL/w5XkKiCB/+f42GJvbZBmdPTGb2P/jBck0aTy3OTo/kw==
X-Received: by 10.223.128.14 with SMTP id 14mr3573537wrk.94.1518719511174;
        Thu, 15 Feb 2018 10:31:51 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 90sm5971557wrp.2.2018.02.15.10.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Feb 2018 10:31:50 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>
Cc:     Jeff King <peff@peff.net>, git <git@vger.kernel.org>
Subject: Re: [PATCH v3 20/23] ref-filter: unifying formatting of cat-file opts
References: <01020161890f4236-47989eb4-c19f-4282-9084-9d4f90c2ebeb-000000@eu-west-1.amazonses.com>
        <01020161890f437a-302b1577-f034-4a24-a3a2-851d1cda0044-000000@eu-west-1.amazonses.com>
        <20180215055618.GP18780@sigill.intra.peff.net>
        <CAL21BmkVgCzihUOxM=Mih=EzYKZwYzpgkSrAZFVr12nkfoCtXw@mail.gmail.com>
Date:   Thu, 15 Feb 2018 10:31:49 -0800
In-Reply-To: <CAL21BmkVgCzihUOxM=Mih=EzYKZwYzpgkSrAZFVr12nkfoCtXw@mail.gmail.com>
        (=?utf-8?B?ItCe0LvRjyDQotC10LvQtdC20L3QsNGPIidz?= message of "Thu, 15 Feb
 2018 13:34:48
        +0300")
Message-ID: <xmqq8tbu9ka2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Оля Тележная  <olyatelezhnaya@gmail.com> writes:

>>> -             else if (deref)
>>> +             } else if (!strcmp(name, "objectsize:disk")) {
>>> +                     if (cat_file_info.is_cat_file) {
>>> +                             v->value = cat_file_info.disk_size;
>>> +                             v->s = xstrfmt("%"PRIuMAX, (uintmax_t)v->value);
>>> +                     }
>>> +             } else if (deref)
>>
>> Why do we care about is_cat_file here. Shouldn't:
>>
>>   git for-each-ref --format='%(objectsize:disk)'
>>
>> work? I.e., shouldn't the cat_file_info.disk_size variable be held
>> somewhere in a used_atom struct?
>
> At that point - no.
> I think it sounds like other separate task to add this functionality
> and to test it properly.

What does "that point" refer to?  This point at 20th patch in the
23-patch series it is not premature, but it will become feasible in
later steps?

As Peff already said in his review on earlier steps like 4/23 and
7/23, I too found the series quite confusing and felt as if I was
watching somebody stumbling in all directions in the dark in the
earlier steps in the series before deciding to go in one direction.
