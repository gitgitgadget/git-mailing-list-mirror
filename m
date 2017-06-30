Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11656201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:41:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752011AbdF3SlV (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:41:21 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33877 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751666AbdF3SlU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:41:20 -0400
Received: by mail-pg0-f66.google.com with SMTP id j186so16161193pge.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RDPReVlHT9DF7mYEomd2zzTNKBJk/snGKFBWJMDskQY=;
        b=EJnXbNkzcmd/Orl4LxGhuOjKMq7JEfIR+u6WVHG019rpfO5nExRY4xWZK7XoaWsCTp
         /HtdSd7j3hQ0tyLobJkq6l7BG6rsw4tlfwnP4uMHLLmR/vFP4NC+tsAjavGzEf9TRCN6
         8cW9AMQ/jGzLAHPxY7l2EM1JGukYq2gGnrvTrbaLnq0Lpu5qU/a8LK1XJqZQEH5a1hIg
         03L551zo6jl76Uh9OTeT6Yrr1olsTm9T9G5HM/0YuYKv/NmA2B7eE/bzhh9uLY47oL0D
         zqXcDISJoVAa02TgKU+4bRwL58JuYObX/wz7fFt4itv7KeeToN0UijPc6nXAn39b1+nn
         ktEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RDPReVlHT9DF7mYEomd2zzTNKBJk/snGKFBWJMDskQY=;
        b=ce0GZZULWKxJPUBtD3S1/FyvHCcI8PkrrBZT08QfSDZhNtUoq6rzavKvtX1gVZPphi
         8sHY5LgRjm2AXZZEbAgLGjwEKf8HyAxfRp/XkZ+ehmseURMPAjyvPI5eoIP2GuW/6L54
         oPRWK0y1xEIDf6908DYXzL6TS36gM/w/4A1EYRffzFZIIBEhdUevtGkrkVqzKi23k8CB
         TrRqYfwTpdxM9Ix2dMVb/9Fq3X41LhDCXZmVBkFedLg/4bIRfxJF/7n5lkYvikjWGDlC
         kSw6WgaSz6HPyoBegx2AeHE5NKA1trIYLdLq/i5IZySl9cIYtBgoPUNAX4iUN9i+zBKk
         hWFw==
X-Gm-Message-State: AKS2vOy3AL2f6cWf0E53VmdL6RGHtsMqIwB2z5vwYRNC/iTSrWkl2WTH
        b8BgM5cn2Yplbg==
X-Received: by 10.84.247.16 with SMTP id n16mr25373181pll.74.1498848079714;
        Fri, 30 Jun 2017 11:41:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id r63sm16462121pgr.65.2017.06.30.11.41.18
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 11:41:19 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 22/25] diff.c: color moved lines differently
References: <20170630000710.10601-1-sbeller@google.com>
        <20170630000710.10601-23-sbeller@google.com>
        <xmqqd19ls6no.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaK00CpXOtXnx_u7_KHbZq4Mz8vWHKy2a8p1gQ8ogE-OA@mail.gmail.com>
Date:   Fri, 30 Jun 2017 11:41:18 -0700
In-Reply-To: <CAGZ79kaK00CpXOtXnx_u7_KHbZq4Mz8vWHKy2a8p1gQ8ogE-OA@mail.gmail.com>
        (Stefan Beller's message of "Fri, 30 Jun 2017 11:13:40 -0700")
Message-ID: <xmqqvandqpwx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> On Fri, Jun 30, 2017 at 10:54 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> +static int next_byte(const char **cp, const char **endp,
>>> +                  const struct diff_options *diffopt)
>>> +{
>>> +     int retval;
>>> +
>>> +     if (DIFF_XDL_TST(diffopt, IGNORE_WHITESPACE_AT_EOL)) {
>>> +             while (*endp > *cp && isspace(**endp))
>>> +                     (*endp)--;
>>> +     }
>>
>> This should be done by the callers (both moved_entry_cmp() and
>> get_string_hash()) before starting to iterate over the bytes from
>> the beginning, no?
>
> Good point.
>
>>> +
>>> +     retval = **cp;
>>
>> The char could be signed, and byte 0xff may become indistinguishable
>> from the EOF (i.e. -1) you returned earlier.
>
> Ah, I messed up there. I think EOF is wrong, too.
> So maybe we'll just return 256 to indicate the end of memory chunk
> to not have to deal with signedness

I would just say that next_byte() returns -1 (at end of string) or
0-255 if it is returning a byte that matters.
