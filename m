Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B457E1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 18:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753604AbdKJSgU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 13:36:20 -0500
Received: from mail-ua0-f169.google.com ([209.85.217.169]:51383 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753546AbdKJSgT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 13:36:19 -0500
Received: by mail-ua0-f169.google.com with SMTP id 65so7447200uaq.8
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 10:36:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8TLT0Xx8vhYdC/Pib/y6VqMgmH7+eNIDx63XlKuFTE8=;
        b=ZrfiqHTxLq/mcKv8do24QRWKuKXLsNcm+x7I7xO/3bCZy6qAKmLdPaEEgreBSPKzfC
         0/2sfGiilBLoMW7wVBEqwk1I6zhAZzeoKK/VJl/0Shhp8ZmFkahYVvljT9Zs4oNeG7Lo
         Moav51210OO2Eq5lazH+J8Kr9u2hNzeH11G4U1SUxd0xkM+BtFvmFuVJmJbUu8L/DMNw
         I+TeBoUdgt3VyzoJJNM/k/V/H+PhDIW0BCfFtwscxllhj4YWflZBl1r6qlsSMX3uyEha
         /qqkA2LB+P6GnVNHexB8mUxMfRP2Gd3KmA3gjz7htFvbB48V/o1HxS43yzdoQpDZ/sz7
         HxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8TLT0Xx8vhYdC/Pib/y6VqMgmH7+eNIDx63XlKuFTE8=;
        b=cicOtHKag7bVfQPSWtCTLq0ZESL2mJ+JR6mqA3Dxu+QnvZDwnP4F3VL2SzwjGZGSMh
         7zMyDhRK49UF0RcNO61/RSLNjX+D5Dk8ezD88sm81KfljmJN6wKjFkfRSL8A4co3SSEV
         SAC8W//iciKEyrFP4+XAPIpBTSq50eGFciH/WwPsKxeznvDDTUMqB9C3IYDjhTKybK8r
         EfqGGWAtaLPp6URRBWfbmoZ5RHxVGEawc3fbHswDdsD/pnii24S/9cHzR6EsTC4MI5T9
         u5pxuPE7ChzcrpnyR58jkOpw4s7/mgDajuQyTJNWQTVA5hhsN9W6MlMFP3UDww0oV0Jz
         JDoQ==
X-Gm-Message-State: AJaThX5v9ikJcqk5gxtx+SDixA26bM+RMIsRZ7k+B8gyFpXT+EbjK6Vp
        VFU+tzBmx9kANjs8FhMoPymgMtdxihkph17PqrQ=
X-Google-Smtp-Source: AGs4zMYlON5X1oVkXlG4/FxpTfDpfUtIJXsJlttEhZZ8msR+1EOjzQIrSccd4vB29+y24ULl2UAys3W9eUEuj14eldQ=
X-Received: by 10.176.23.19 with SMTP id j19mr1104724uaf.87.1510338978290;
 Fri, 10 Nov 2017 10:36:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Fri, 10 Nov 2017 10:36:17 -0800 (PST)
In-Reply-To: <CAGZ79kbqxA9U7EsU6_i895vgrTUwmqv8f02NCoUqPS1_nD2PtA@mail.gmail.com>
References: <20171110173956.25105-1-newren@gmail.com> <20171110173956.25105-3-newren@gmail.com>
 <CAGZ79kbqxA9U7EsU6_i895vgrTUwmqv8f02NCoUqPS1_nD2PtA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Nov 2017 10:36:17 -0800
Message-ID: <CABPp-BGwoduH_T7U4uN5A-h43wREfXdQgV8YCVWf8w5N09cYSw@mail.gmail.com>
Subject: Re: [PATCH 2/4] Remove silent clamp of renameLimit
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for taking a look!

On Fri, Nov 10, 2017 at 10:26 AM, Stefan Beller <sbeller@google.com> wrote:
<snip>
>> -       if (rename_limit <= 0 || rename_limit > 32767)
>> -               rename_limit = 32767;
>>         if ((num_create <= rename_limit || num_src <= rename_limit) &&
>> -           (num_create * num_src <= rename_limit * rename_limit))
>> +           ((double)num_create * (double)num_src
>> +            <= (double)rename_limit * (double)rename_limit))
>>                 return 0;
>
> From a technical perspective, I would think that if
> (num_create <= rename_limit || num_src <= rename_limit)
> holds true, that the double-cast condition would also be always true?
> Could we just remove that last check?

Not necessarily.  For example, if num_create = rename_limit-1 and
num_src = rename_limit+2, then the first condition will be satisfied
but the second won't.  If it was && rather than ||, then the second
condition would be superfluous.

> Or phrased differently, if we can cast to double and extend the check
> here, do we have to adapt code at other places as well?

Good point, and yes.  Perhaps I should have re-ordered my patch series
because I came back to it later and realized that the progress code
was broken due to overflow/wraparound, and a patch 3 fixed that.

Further, the later patch used uint64_t instead of double.  While
double works, perhaps I should change the double here to uint64_t for
consistency?
