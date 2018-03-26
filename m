Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 675FF1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 17:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752762AbeCZRFD (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 13:05:03 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:33001 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752138AbeCZRFB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 13:05:01 -0400
Received: by mail-wm0-f51.google.com with SMTP id o23so6006422wmf.0
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 10:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DT5/+TLXceORZxWPI8wg4Cw5mtAC9tqrWUTHwQedas4=;
        b=nc1iFf6k5AzDXZLS29hIROYUUHY2AyydV+olAo/5tpwH+m0xUKCdHzZLvvzcXjSZKB
         ST621XbXeiBRUiKNXNkOuCUCNO7WB068APGbJova8LfRIZJjQYndVKVEgz0pRz9xsRVP
         dst6cmqERnUyEvwLoY1a4zA/xHzW46sg2AXGXpoTxEgRgSzOsrl0Bl0ttXQhOho0XgAU
         +PANObak3VnrxhTqiDAtN3RK5DNF5ezSWPP4e7YFbUEXtyjl/k9D01wJsABUy93bMCyu
         wD6H6d9Qs4mLV0TrEH+QLUtH1rkgPxB4Q8s44oZg+E7Q8J8QTrZDBAiw+hyt1Ke7dHBF
         7fwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DT5/+TLXceORZxWPI8wg4Cw5mtAC9tqrWUTHwQedas4=;
        b=HC90dlxNAnkJ1uvvYtDx2aDVqFeE2wTU2twn8jct4CAh7KnV8a7uglqmbEj7b0Kni2
         gnH7OE72HsEYqJJbc/gLD5Z/0ln19JuPJfbPH4FKYuYje6SSu3+ap7Wd5uv+RBTniQdS
         /7adqoI0C++84DlZ93Yb1xTKzwEe+zazL1h1X9t6bQ5xP2FLw66g7kzVK7sKNM3ilFXq
         Z+3FhwBvFQEAEFoqQvXv9T4zoGYI9RdaJ0JP3pWsFOZf2BmSKoaRdX2/NI9aSXSASmra
         T43+bv82vEGa86f569r1+8Wq709DCzY+wOwOWkYM6pD4k3N9WgO39CVqmtb2lNX1xH5b
         Edow==
X-Gm-Message-State: AElRT7ENqwq5KVVgaDfZs6vZMfQ7To8p9MIku4DRyOHETwSttVX26BLJ
        n4tKRQdo51z/TeEgN4RZJe0=
X-Google-Smtp-Source: AG47ELuaw0s4Q6/J/igEg1bi/gHleiTFNAAJNl0AloB4A3r5r5qTBMQNT5bGBKZ0MAVB4VfU7qziYw==
X-Received: by 10.28.66.65 with SMTP id p62mr15403381wma.8.1522083899338;
        Mon, 26 Mar 2018 10:04:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c141sm16009547wmh.21.2018.03.26.10.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Mar 2018 10:04:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Wink Saville <wink@saville.com>, git@vger.kernel.org,
        jeffhost@microsoft.com
Subject: Re: [RFC PATCH 1/1] json-writer: incorrect format specifier
References: <cover.1521868951.git.wink@saville.com>
        <140b7646e7efa4175f9d82e6eb2909f2f94771fe.1521868951.git.wink@saville.com>
        <4f4221d9-2ad9-2282-d26f-412ba0bfd719@ramsayjones.plus.com>
        <c8628770-71d7-42f4-4bc5-444ea0160d26@ramsayjones.plus.com>
Date:   Mon, 26 Mar 2018 10:04:58 -0700
In-Reply-To: <c8628770-71d7-42f4-4bc5-444ea0160d26@ramsayjones.plus.com>
        (Ramsay Jones's message of "Sat, 24 Mar 2018 16:07:43 +0000")
Message-ID: <xmqqr2o6dayt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ramsay Jones <ramsay@ramsayjones.plus.com> writes:

>>> @@ -120,7 +120,7 @@ void jw_object_uint64(struct json_writer *jw, const char *key, uint64_t value)
>>>  	maybe_add_comma(jw);
>>>  
>>>  	append_quoted_string(&jw->json, key);
>>> -	strbuf_addf(&jw->json, ":%"PRIuMAX, value);
>>> +	strbuf_addf(&jw->json, ":%"PRIu64, value);
>> 
>> In this code-base, that would normally be written as:
>> 
>> 	strbuf_addf(&jw->json, ":%"PRIuMAX, (uintmax_t) value);
>
> heh, I should learn not to reply in a hurry, just before
> going out ...
>
> I had not noticed that 'value' was declared with an 'sized type'
> of uint64_t, so using PRIu64 should be fine.

But why is this codepath using a sized type in the first place?  It
is not like it wants to read/write a fixed binary file format---it
just wants to use an integer type that is wide enough to handle any
inttype the platform uses, for which uintmax_t would be a more
appropriate type, no?
