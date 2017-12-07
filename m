Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B6A920C32
	for <e@80x24.org>; Thu,  7 Dec 2017 01:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752151AbdLGBWU (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Dec 2017 20:22:20 -0500
Received: from mail-wm0-f45.google.com ([74.125.82.45]:39174 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752155AbdLGBWT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Dec 2017 20:22:19 -0500
Received: by mail-wm0-f45.google.com with SMTP id i11so10154272wmf.4
        for <git@vger.kernel.org>; Wed, 06 Dec 2017 17:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=9N4zkNK5ihMP3cbOCQ9rnvVSu9puzPr2VLoxxdm27mU=;
        b=g+Omz3bUp8/9GmTEuQKkALHV8bWzu34AT2VX9pmf8pGpdixn1PXMDg8kMYl1pZsyZz
         4bjzkjmu3PWPEynsWMIsi2kOL8ij2h6tho+2Ls9FUpbBdZ+J5IOR4xxygx/syROvEQcH
         0Rzv/HdvSNi4qVYbBG88Xbgv8BOmOxRYTdFAAaHH2plt5rFkxknY0RJw0CZFczR8YYXp
         f0ukRIht4mRMQDvBDb5RbeRuPC/k/s7yiI2JDXfjQumDAMIaHzYybb38vz3xjchC7/PQ
         r/VJzbLDQDWHXD6Wd7Mukv/l+4Pf52UCC7tUOPBgrtUnnpDDJHsL0tERiOtAtBnxEHAu
         jE2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=9N4zkNK5ihMP3cbOCQ9rnvVSu9puzPr2VLoxxdm27mU=;
        b=gUPaqIkOdsHJekVKpCOtnaWSfR3Fm9nSJDlwmee684pKQTYIWBtE7h1L01fn1StWJy
         0EGs8Pc2Gn+3XzkZZKaDfB26fyczE3pziyEyXTPgMP2CVZfuEOk03tB8IbbpkLffBSU5
         lbwXYSobs+OhmL/jPYkkHbGXiToCKXHCSxPmRdPtr1f3yGn+uzj4qAjSylGeboBOaBLu
         6bxH0QshZdVRrPUiiM2o376QfIJfSHnfMj1V+WpKtB1L88wUdNrH9hkTRKHCoWrOq/bZ
         uxaGaQJd/J8M/NSy1fpTHvtM7SvjgB/XanrKI1/ZxmcKl/Mblkiv0VDtRl33pI1lMPmo
         M4uw==
X-Gm-Message-State: AJaThX5nDnwDrzmZQea5P8vhJgKEf7NoBoh7vZrf07Vom3fPd2k+edFn
        QNYHUIPjGEgMvDHP89bj22kJcedFQ9xVOrKmvBg=
X-Google-Smtp-Source: AGs4zMb+DAP9zZHRtDoubcF4TA1pXOTgCTI62+YUHr7ywQHw20B5OVWiLLlaKfc99Dlk73Xn0OgTFmZMKAZbucFM/H8=
X-Received: by 10.80.137.106 with SMTP id f39mr44447783edf.148.1512609737948;
 Wed, 06 Dec 2017 17:22:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Wed, 6 Dec 2017 17:21:57 -0800 (PST)
In-Reply-To: <20171207010421.GC1975@sigill.intra.peff.net>
References: <20171207003517.11729-1-jacob.e.keller@intel.com> <20171207010421.GC1975@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Wed, 6 Dec 2017 17:21:57 -0800
Message-ID: <CA+P7+xr8KobkY56-4qE4ZdVgC388L6=NKQc=3kTZvWz8XOD3ag@mail.gmail.com>
Subject: Re: [PATCH] diff: add test showing regression to --relative
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 6, 2017 at 5:04 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Dec 06, 2017 at 04:35:17PM -0800, Jacob Keller wrote:
>
>> Subject: [PATCH] diff: add test showing regression to --relative
>
> Since we'd hopefully not ever merge that regression, I think this patch
> ought to stand on its own. In which case it probably wants to say
> something like:
>
>   diff: test --relative without a prefix
>
>   We already test "diff --relative=subdir", but not that
>   "--relative" by itself should use the current directory as
>   its prefix.
>

Yea, I wasn't sure what the actual status of the changes were though,
so I thought I'd send the actual fix I did. It's definitely up to
Christian in determining what he thinks the best path forward is.

>> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
>> index 3950f5034d31..41e4f59b2ffb 100755
>> --- a/t/t4045-diff-relative.sh
>> +++ b/t/t4045-diff-relative.sh
>> @@ -70,4 +70,9 @@ for type in diff numstat stat raw; do
>>       check_$type dir/file2 --relative=sub
>>  done
>>
>> +cd subdir
>> +for type in diff numstat stat raw; do
>> +     check_$type file2 --relative
>> +done
>
> We should avoid moving the cwd of the whole test script in
> case we add tests later. Normally we'd do the cd inside a
> subshell, but that's complicated by the wrapper (we wouldn't
> want to increment the test counter just inside the subshell,
> for instance).
>
> Adding "cd .." is the smallest thing we could do to fix
> that. But I think the more robust solution is to actually
> teach the check_* helper about doing the "cd" inside the
> test_expect block. Or just pushing the helper down into the
> test block and living with repeating the
> "test_expect_success" parts for each call.


Yea, I tried cd inside the subshell and it didn't work, so I did this
as the quicker solution.

I think the best method would be to update the check_* helper
functions to take a dir parameter, and use that to do git -C "dir"
when calling the diff commands.

Thanks,
Jake

>
> -Peff
