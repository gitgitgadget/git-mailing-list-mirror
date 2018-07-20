Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B0A991F597
	for <e@80x24.org>; Fri, 20 Jul 2018 12:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390124AbeGTNbH (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 09:31:07 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34357 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389747AbeGTNbF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 09:31:05 -0400
Received: by mail-qt0-f194.google.com with SMTP id m13-v6so10102563qth.1
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 05:43:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=uHzIlHE+ZrFlzBrhdiQ0rDRUkvk13Z7afpdACiCbgpE=;
        b=UOjwHOJN+S+sWGTivxDDVcX7WgUfYKsKCsl23sTGGbMBm+IcDrpfoC4h60B6cGUbK4
         +g4Kkk8u5CXL9bujSsAc7cf9l86Sbgx/YbHlH3qsLThpsmGQ1Ic+0E96Xn6y1VVhIquu
         0bwAFhlxWUM11iueQO3SubX+FUWeUOsvIEP5n/Qv9pqs3BJ/WAa93TU3CyGAvdrLqpgW
         YbuUXzp4EOPd6PTEYtPDLIuyOHKcEpthOL/SfPmljHQ9epiJWWAWqx86fz+Mk5SLW+Sd
         AKf0lnbC754BT2bzuya4hA+sHUS0pwh9yKMrJIFsvqwWVuFszdVbgBgIfUKNDHzfGCk1
         sNJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=uHzIlHE+ZrFlzBrhdiQ0rDRUkvk13Z7afpdACiCbgpE=;
        b=c95/SaZPTAAKdk2I393rQ/B3g4quh05Dpf1cJG+S56dQcKoOLzoo/DcXHTr37zz4Uu
         dl/i3UNDGEjd6a05busvAO9qolcNenNhjGzASO99iFnloR8TYr5szf21Zz8GoDuBwyTX
         /XNxxo79HM+xmLUeWyOBONn7krzQB7pZKbuCGz1opyAJ30SvrBj1ufK9KOyjclfKQNer
         4F+TFHj7DdadCMy0mecpx7BSZ4eNgZzDM7nu0srfN7bdKltY8HOoZp4k8ukgPfh5+5GY
         JYxdFEbgaLZi6hR/pntsFz6RYleHopwYPwb9YKEHfxXUkmIYHkvcpAgw0xKwVpLhyNOS
         5JNw==
X-Gm-Message-State: AOUpUlFjTO9b4oYWVOZ3LR5kEWSzqbplfhAFNumKdM6rZNyBa93RxnL5
        CUr686po3aDtrhdlGBIx0Io=
X-Google-Smtp-Source: AAOMgpezbWlAXsInSuj/u2H4wyVv37uQthnsE2fxXtI0c7Q6PgvajakL7N7avZuguYI7g7/I8+EKrg==
X-Received: by 2002:ac8:42b:: with SMTP id v43-v6mr1592324qtg.319.1532090580085;
        Fri, 20 Jul 2018 05:43:00 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id r4-v6sm993605qtm.10.2018.07.20.05.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 05:42:59 -0700 (PDT)
Subject: Re: [PATCH 1/2] introduce "banned function" list
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
References: <20180719203259.GA7869@sigill.intra.peff.net>
 <20180719203901.GA8079@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <153e7256-cc45-c33e-d64a-27319b42a489@gmail.com>
Date:   Fri, 20 Jul 2018 08:42:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180719203901.GA8079@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/19/2018 4:39 PM, Jeff King wrote:
> There are a few standard C functions (like strcpy) which are
> easy to misuse. We generally discourage these in reviews,
> but we haven't put advice in CodingGuidelines, nor provided
> any automated enforcement. The latter is especially
> important because it's more consistent, and it can often
> save a round-trip of review.
>
> Let's start by banning strcpy() and sprintf(). It's not
> impossible to use these correctly, but it's easy to do so
> incorrectly, and there's always a better option.
>
> For enforcement, we can rely on the compiler and just
> introduce code which breaks compilation when it sees these
> functions. This has a few advantages:
>
>    1. We know it's run as part of a build cycle, so it's
>       hard to ignore. Whereas an external linter is an extra
>       step the developer needs to remember to do.
>
>    2. Likewise, it's basically free since the compiler is
>       parsing the code anyway.
>
>    3. We know it's robust against false positives (unlike a
>       grep-based linter).

I know I'm late to the party, but I just wanted to chime in that I think 
this is a great idea. The more checks we have as part of the developer 
cycle means we have fewer checks that need to be caught manually in 
review (or can be missed in review).

Thanks,

-Stolee

