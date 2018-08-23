Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FE951F404
	for <e@80x24.org>; Thu, 23 Aug 2018 22:09:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728500AbeHXBkm (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 21:40:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35660 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbeHXBkm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 21:40:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id j26-v6so5859390wre.2
        for <git@vger.kernel.org>; Thu, 23 Aug 2018 15:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NxG8102H82iEVjtgDGPwN+CfVz0rGbDwuG5L433PLQw=;
        b=OJDBirx/e05ibB+HS1E/sIhOtgSXIhCFU4lbW612M+VDM7QyS3VKUBsZT4Iy0pZHJ5
         UXdjWxg/n0VMfpcsyNqmJHdPYqg7cpJOeS2wunZNKEp7ooJIXykDmud8dmAYxXB8sPqp
         9P7vvnTqPTXpwy2csKOAlNJw2wAMPc5x7vwKu9/7YPYruxrtPPgDt4xNsQFTDynfihyF
         9Xy0astm6CIPrU1Xq6EFdpT/5Oo0ia8tN+f/lYEGUikLIuAshClpR1dokqW4+pLWrOyW
         h+jrQYydwervCfPgnsfW+8guB5Ct3zcGo3RJItdYxTBaqDHznBuDrxJLl1UJjuJ+TT9m
         1sCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NxG8102H82iEVjtgDGPwN+CfVz0rGbDwuG5L433PLQw=;
        b=kkQAeU8Q7Hl0IaYpCcm6wjFRhzGLjQF9BhRwNme92T4beWwehSTfyjNghxfhgVZbIS
         SkOVhjzodSo1jMjPk+4BUqUG2ZB5J9c2o3N71rXgVhGUMAg9aSHiglmVz3yuAJWb5hAM
         GAFNCu88XnoLJDZzITKt3z+c4LIhlaw+BU/sUUCrk5ixWEmC1bIDLZp7JZjBiA1w7CY4
         uzc0bgAVdC+VqNP7/7NUIzL4VzgqHax4OJHAoY3m2k2m1n/bBGQd7WdVlzUfbcIhYI24
         aTen2jlqXYMyfFWGjvY6Bk5kRc9el0TmAXm4dd9xPJ9bZZKTMtL9MS/R9SR0m+XO/k68
         +7rg==
X-Gm-Message-State: APzg51AjDfKyFb1RDUXkkHB/5RyGEQcZqYDXV5xZHoLL5KXH1lbWkdQW
        BBHLTB+oYGIBEPRkPyyNxAs=
X-Google-Smtp-Source: ANB0VdY6eCw7B2M1G6QfsfDnXRaazw+aCablHnEsECi9LdK9136P7tF2LOT21zfaWt5T0nfTaSMPCQ==
X-Received: by 2002:adf:92c2:: with SMTP id 60-v6mr13230626wrn.153.1535062137782;
        Thu, 23 Aug 2018 15:08:57 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id v192-v6sm5354152wmf.40.2018.08.23.15.08.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 23 Aug 2018 15:08:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kyle Meyer <kyle@kyleam.com>, git@vger.kernel.org,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v3] range-diff: update stale summary of --no-dual-color
References: <20180823211028.GA99542@aiede.svl.corp.google.com>
        <20180823215748.3474-1-kyle@kyleam.com>
        <20180823220207.GC99542@aiede.svl.corp.google.com>
Date:   Thu, 23 Aug 2018 15:08:56 -0700
In-Reply-To: <20180823220207.GC99542@aiede.svl.corp.google.com> (Jonathan
        Nieder's message of "Thu, 23 Aug 2018 15:02:07 -0700")
Message-ID: <xmqqo9dshh1j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Kyle Meyer wrote:
>
>> 275267937b (range-diff: make dual-color the default mode, 2018-08-13)
>> replaced --dual-color with --no-dual-color but left the option's
>> summary untouched.  Rewrite the summary to describe --no-dual-color
>> rather than dual-color.
>>
>> Helped-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Ha, I don't think I deserve much credit here, but I'll take it. ;-)
>
>> Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>> Signed-off-by: Kyle Meyer <kyle@kyleam.com>
>> ---
>>  builtin/range-diff.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Sorry, too late.  I'll revert the merge of the previous round out of
'next' and requeue this one, but that will have to wait until the
next integration cycle.
