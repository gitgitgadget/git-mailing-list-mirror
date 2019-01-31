Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD34E1F453
	for <e@80x24.org>; Thu, 31 Jan 2019 18:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbfAaSvs (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 13:51:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38953 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfAaSvs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 13:51:48 -0500
Received: by mail-wr1-f67.google.com with SMTP id t27so4495665wra.6
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 10:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZVl3AvVBGshK0GtBFUdLMy/GWN1oQ/s3R5LO4KX7ATg=;
        b=CKSDCWUwOj2k8o13zzU5pRrZ2VIffUUfREq3Up0vs+nMJQyKOTr9UaTZRNfDpsOdyS
         A/RlE4SNs7vDT3EbmSk6BdvwKZS879c+kHxewxI1ylmshzXKRJWMvSQ5TryfO1eMv+jv
         X/TOQ28uyPoDpxDkhO/iOXFEl1L/D5//TY2n4i/EVHPzXi8VZsQeQBtvg7hXn/rEFLlX
         D0kb59xhqbxBAw6U+9DACyz9B1CuTao8Br6EGihIYsZMnyy2Rlniwe7cQ+SpFI67CBdz
         BGRqIXJOf1M/QmES/69U3JaHnHASGcntdfMssEEY4HDTha0NaXEj2OYYzrXfuRIm6kVc
         gOBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZVl3AvVBGshK0GtBFUdLMy/GWN1oQ/s3R5LO4KX7ATg=;
        b=BrdlDteTNFGSCbNuC4msAigTO2UXoccnVxxml+P2Pd5qjgE5EhlTropBkf4qb3oUGw
         2GBoXk6uI5JTzFJTnCzs5FJIBNhUZOaYmFXTaOStte558Od1QUp2xuDYox3lWNxjEda+
         g6I1CyE+ApfZMVsp5JPXhsn1oYtPmxjvm3t+laalKjsmKsfEn9QGY8Xrbde5WbZAzByR
         ZLEfrm4NKYRTYhBMvN+YU0hnRu8iT76fjK3eHI5MseRTiW7k4G5ILSRpbjyWH6KsE1Sp
         JMXZQ9x+4LBM+oQ4u7SKG3VtaraH0eYyFZcuPp+F4u9WHPSl7yjxfdYqqtxB+t5GYqgE
         qS2g==
X-Gm-Message-State: AJcUukdTvR+BBdZKfFhKO77qpyPKlcnE2F2mcdlMrojqvBYs57a1opND
        yGfj0T3ApbacfFSuNvI+jpM=
X-Google-Smtp-Source: ALg8bN4w8GDwMYLCRp/chMD8U2enHz2EI5CLuMHzxftaRCqYMd0AMsHkr8b38Otefk7n1jKV7sRxLA==
X-Received: by 2002:adf:f703:: with SMTP id r3mr34762014wrp.93.1548960706084;
        Thu, 31 Jan 2019 10:51:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v8sm6829872wrq.53.2019.01.31.10.51.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 10:51:44 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH v3 00/14] Trace2 tracing facility
References: <pull.108.v2.git.gitgitgadget@gmail.com>
        <pull.108.v3.git.gitgitgadget@gmail.com>
        <20190131143811.GB10587@szeder.dev>
        <9b603fd7-d8f0-1ce7-7c7c-8b17484d7d0a@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 10:51:44 -0800
In-Reply-To: <9b603fd7-d8f0-1ce7-7c7c-8b17484d7d0a@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 31 Jan 2019 09:53:29 -0500")
Message-ID: <xmqqbm3w3bjz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

>>>       -+	for_each_builtin(j, tgt_j) {
>>>       ++	for_each_builtin(j, tgt_j)
>>>       ++	{
>>>        +		tgt_j->pfn_term();
>>>        +	}
>>
>> Our CodingGuidelines prefer the opening brace on the same line after
>> the if/for/while/struct/etc. statement, and even omitting the braces
>> if the if arm or loop body consists of a single statement.  So
>> unfortunately a considerable part of this range diff goes in the wrong
>> direction.
>
> I know they do and I had them on the same line originally.
>
> Clang-format was complaining about every use of the for_each_builtin
> macro, so I changed them to be on the next line to quiet it.

Well, clang-format is wrong then ;-)

> I hesitate to remove braces around a statement adjacent to a
> for_each macro trick for the usual safety reasons.

Sorry, but what's "usual safety reasons"?  Isn't a macro that
requires {} in order to work correctly simply broken?

I see (from a previous iteration---sorry, but I haven't caught up)

#define for_each_builtin(j, tgt_j)                      \
        for (j = 0, tgt_j = tr2_tgt_builtins[j];        \
             tgt_j;                                     \
             j++, tgt_j = tr2_tgt_builtins[j])
                                  

and I do not think

	for (j = 0, tgt_j = ...; tgt_j; j++, tgt_j = ...)
		statement;

is unsafe (iow, your macro is not broken).

Puzzled.
