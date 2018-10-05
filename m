Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F5CB1F453
	for <e@80x24.org>; Fri,  5 Oct 2018 12:49:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbeJETrq (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 15:47:46 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38768 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728118AbeJETrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 15:47:46 -0400
Received: by mail-wm1-f65.google.com with SMTP id 193-v6so1815946wme.3
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 05:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QHQQmqW4HEbMPttLhIE86T2YejU4ORZ7yEDgVOatSlU=;
        b=cpgyTu6BhE3fvVvvbgqDVp09Pprh+d4JX2srE/he42M7iSWgCEyyvj/YoxIthW65HG
         o6JfGEwJWv6nlDUul7Dqw0YCeei2Pc5RtLazz7OqpJ8gHozCX5VlTKzmW0iEX1nDxNQy
         qRHMYJ8g+zVX7ok5tMFrKGiqFa8k/DQgUyV4t2vfU4WULwr1Seh0/oXpZhELaQ5rzHqV
         bsOB41JBDV47VUzUytFXNf3z3GrJG/CWqA6ad24xwvku9gU03q22mqKmucRflqQqUe9o
         IFQ3Jmc9kpPpfeiN9JgMy4WQzNWW7L2UT3awAzv7HCGZ2Yiq0qpJZHmyihJuXhSbGpCc
         qsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=QHQQmqW4HEbMPttLhIE86T2YejU4ORZ7yEDgVOatSlU=;
        b=AJkM06qWRDNbwlsyFA/4fnrHwDJmp0Cuhza1o0p+CwSJye9oR7tlhqSV9zEYrh5Ilb
         6Tp+K4xVyHRs92Sb9yghFSh6ibgZK4NhAIp12k4B3QKE+VK3nIkqRPcRT1eean8MHes7
         WHjXQ+l9YX2Q2Fq4pbfEvFY5J91qMmSHEfDlfw1NymXOaLyCW4p5itpEQVWgaS+qn4Vl
         h2JZdJTkN4Klp2LQghjSiDdc3mt3pY3GMhE4Rx+YIcsY1Wv3F3A/Xry6FaYF9MjXYx1H
         fF+7CxrmjSLQcXtIvdVzo73Jysrc4TTQXQ99p6NxpJTdOOHnsUJagN7oLkmQJwbi6Ov0
         xaHw==
X-Gm-Message-State: ABuFfogSy+Ygl9y3+C+fYO4Xh9TMXXglxMDY/nKypqjq9MLkL0hhWsTw
        11lwXDt2fmTfnBwFigf3c5c=
X-Google-Smtp-Source: ACcGV62Gb3WGqAUHkqfDqJn6UKeg9K2GClg/JC75SYBOjiWmeRlHWJqmDhaPFpyUEP9si1YUM299lg==
X-Received: by 2002:a1c:578c:: with SMTP id l134-v6mr8126983wmb.135.1538743749850;
        Fri, 05 Oct 2018 05:49:09 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id 12-v6sm2313886wms.11.2018.10.05.05.49.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 05:49:08 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Christoph Berg <myon@debian.org>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] grep: provide a noop --recursive option
References: <20180929140132.GA31238@msg.df7cb.de>
        <20180929145527.23444-1-avarab@gmail.com>
        <xmqq8t3k9qjs.fsf@gitster-ct.c.googlers.com>
        <ffc574a9-cf78-2dd5-084a-a6005547d363@web.de>
        <xmqqmurszu2d.fsf@gitster-ct.c.googlers.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <xmqqmurszu2d.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 05 Oct 2018 14:49:07 +0200
Message-ID: <87h8i0h83g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 05 2018, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
>
>>
>> Recognize -r and --recursive as synonyms for --max-depth=-1 for
>> compatibility with GNU grep; it's still the default for git grep.
>>
>> This also adds --no-recursive as synonym for --max-depth=0 for free,
>> which is welcome for completeness and consistency.
>>
>> Fix the description for --max-depth, while we're at it -- negative
>> values other than -1 actually disable recursion, i.e. they are
>> equivalent to --max-depth=0.
>> ...
>> diff --git a/builtin/grep.c b/builtin/grep.c
>> index 601f801158..f6e127f0bc 100644
>> --- a/builtin/grep.c
>> +++ b/builtin/grep.c
>> @@ -811,6 +811,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
>>  			GREP_BINARY_NOMATCH),
>>  		OPT_BOOL(0, "textconv", &opt.allow_textconv,
>>  			 N_("process binary files with textconv filters")),
>> +		OPT_SET_INT('r', "recursive", &opt.max_depth,
>> +			    N_("search in subdirectories (default)"), -1),
>
> Wow.
>
> I didn't think of this trick to let OPT_SET_INT() to grok --no-* and
> set the variable to 0.  Being able to do this without a custom
> callback is certainly very nice.
>
> The patch looks good.

FWIW I'm not going to carry this series forward, I wrote it more as a
"here's how this could be done". But if Christoph / René wants to hack
on it...
