Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 436821F404
	for <e@80x24.org>; Thu, 23 Aug 2018 21:18:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbeHXAuP (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 20:50:15 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35277 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbeHXAuP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 20:50:15 -0400
Received: by mail-wm0-f67.google.com with SMTP id o18-v6so7245549wmc.0
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 14:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=jy1/6plsObdWamDFwTnxVJoLziBYDn2w4jZQBHUCOSo=;
        b=tKmjyEl2sBeY135LhBpX6QjnIF4QZdM/+ppffFQOIwtPKaTxETf+TmK99o2ta7kIma
         TV8D6P48oSKg7BZSxHhQesFfFPlNyDT7uM+/z5qcKCgiR3/FXVWfRhKyWcw/AxpqmDpj
         MeDTjyLtoqWTLvv55zWc96jRV9vVWzZTEPQWC9DYeVB8rOmQTUApPG8xU9MsQcT5oS3/
         o1GcaUFrNKNQIhceGUxZmqsgcJQ17ZEYRTWefMbhlJxZzDdJxM6wn2SEMy5mwfaF5+TD
         ds9e9KlQ1d/SNjJbzzFDLjCar57oXL/4gqwKZ5wjzVU/vY1IpK+K5Mrx4x/hT9DADZcN
         VpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=jy1/6plsObdWamDFwTnxVJoLziBYDn2w4jZQBHUCOSo=;
        b=FStcVppHMGWEO3X47NMIbBrRU+p09mUjtEqSGX7J2yRhfqqAzcnEisCgc/f3YlVbly
         QnD7Q6Qxd9G5CQcG/lYJNaCmsfxWmBI3HaKSgVRz0bBqa6Z4IJOe6b8sQVRuDhuOMlS1
         e6op4VeQddjSiVOMqOBHY1uyyp/ky/VoGNi4PnpK86u0d7ZH11ubHeA1oO+aCjM3TaoK
         nAJCi3WjGJ8W4K9N4Z/t5EY9UHjKwNKfvFTKDMgyRssqFeJ5l5vKNWbkox2yJsVCU3/f
         B2HsGAPRTOQX3qRdPF1rAkrB/KFkBnxWHd2kCBb7+PgyUGzl3tv8oxq/q0Pv2oMCAkk+
         Vpug==
X-Gm-Message-State: APzg51Ak2FMAdJMcP/zP4J7vetHyZoQDc4ri6zfOh6jh4Yv35o7eLmh+
        agK+tsqLhlabnJjmOklTlE1tjJTJ
X-Google-Smtp-Source: ANB0VdYmbU/1F7Q5vXSRCX8cCk8QTijZepuMCxHDfe8BTuUNvJQTHgBlN5rfePNEHPj7cTBX+Gz7/g==
X-Received: by 2002:a1c:8dc6:: with SMTP id p189-v6mr4033990wmd.99.1535059120416;
        Thu, 23 Aug 2018 14:18:40 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h18-v6sm3461684wru.42.2018.08.23.14.18.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 14:18:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org
Subject: Re: [PATCH] range-diff: update stale summary of --no-dual-color
References: <20180823023955.12980-1-kyle@kyleam.com>
        <nycvar.QRO.7.76.6.1808232254260.73@tvgsbejvaqbjf.bet>
Date:   Thu, 23 Aug 2018 14:18:39 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1808232254260.73@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 23 Aug 2018 22:54:44 +0200 (DST)")
Message-ID: <xmqq1saoixxs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 22 Aug 2018, Kyle Meyer wrote:
>
>> 275267937b (range-diff: make dual-color the default mode, 2018-08-13)
>> replaced --dual-color with --no-dual-color but left the option's
>> summary untouched.  Rewrite the summary to describe --no-dual-color
>> rather than dual-color.
>> 
>> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
>> ---
>>  builtin/range-diff.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/builtin/range-diff.c b/builtin/range-diff.c
>> index f52d45d9d6..7dc90a5ec3 100644
>> --- a/builtin/range-diff.c
>> +++ b/builtin/range-diff.c
>> @@ -25,7 +25,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
>>  		OPT_INTEGER(0, "creation-factor", &creation_factor,
>>  			    N_("Percentage by which creation is weighted")),
>>  		OPT_BOOL(0, "no-dual-color", &simple_color,
>> -			    N_("color both diff and diff-between-diffs")),
>> +			    N_("restrict coloring to outer diff markers")),
>
> How about "use simple diff colors" instead?

I am wondering if it makes sense to remove the option altogether.
I've been trying to view the comparison of the same ranges in both
styles for the past few days, and I never found a reason to choose
"no dual color" option myself.
