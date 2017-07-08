Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6AEA202AE
	for <e@80x24.org>; Sat,  8 Jul 2017 07:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752496AbdGHHTM (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 03:19:12 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:33364 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbdGHHTL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 03:19:11 -0400
Received: by mail-qt0-f177.google.com with SMTP id r30so42543374qtc.0
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 00:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=f775nh5coYxA3MsshE/XM2zGk7gDrEDnQ9UQdXDoznU=;
        b=DCJ3QJScXwEIK9qCg0XecImi+cKkEiCOkcz/s8xmu/5cN3STGMnaQptz/piTj4GYHZ
         oxeUAG0ZdFiyLmp0SSPiv96xXkiNheLcup6grSmQKT0//YA1jwQUw/+9pzOaI9Owljv5
         CXMXeDb99qhLI96kBws0Mt31IblIUQyfQuiSlHt21QkjJAdkR9VkKAZH8GF/KUgdFErj
         vy2krbwA2Yo5u5c20XlVpWhOr+wumPRutTL91sXw4fYgI+kmFVgob+nhUkU7Ya+srmJu
         XE8YvpNYXxlBtqeZYVkNAtyZcGpXUieb9jK6xldj1ex8S8cv+F5dekNaosTzgXX1o5tJ
         uyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f775nh5coYxA3MsshE/XM2zGk7gDrEDnQ9UQdXDoznU=;
        b=CG+Lg4w+flnngwWmmKlgXiofuM2fanCOqplzsMCOiYBFAIwgLEu1j6LsfZIVYCHz/q
         uoQfr2TmjHFxVZd5UmvsQXzqjAGdfsI04m9iMbsmUYwZEsBXPQVClriebBESz7umY7SI
         BDZ7+TU6LF8J8ZLTiP7SjqoZPeGshnlXRT18aHMm+mvSctyoCW/w8oFpWJiC0Zc5XEzv
         HjR5hvZ+slo7VvgOWhLwxTxRGF8K+/lV/GnApWHiIBFPgjcoEzp8BnhyhNup2+WJU24o
         OYLFPq/rCBOXyv1XdwiTi4MYRBHFaWB22KEgY1hSFKTYouIFhsi1OhSRA9MHdtdlR/Rw
         U5Nw==
X-Gm-Message-State: AKS2vOz7qKJ5ww/7tuo3AfaUKBB2tcUWPF8BLO7LzpfGy3p8Xu7mfsWP
        u9rvieVR/VWcXTXaVTOCDwyuCGYfPw==
X-Received: by 10.200.53.151 with SMTP id k23mr76690529qtb.104.1499498350008;
 Sat, 08 Jul 2017 00:19:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.55.31.94 with HTTP; Sat, 8 Jul 2017 00:19:09 -0700 (PDT)
In-Reply-To: <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
References: <20170610134026.104552-1-benpeart@microsoft.com>
 <20170610134026.104552-8-benpeart@microsoft.com> <xmqqo9tsn9qg.fsf@gitster.mtv.corp.google.com>
 <9c1ed8d4-6bdb-e709-758d-4b010525e9e3@gmail.com> <xmqqvany2z84.fsf@gitster.mtv.corp.google.com>
 <7ec36d90-7fbc-c30f-e15e-f06d39e1f206@gmail.com> <xmqqeftsayeg.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 8 Jul 2017 09:19:09 +0200
Message-ID: <CAP8UFD1hEtiBhRWvrMq+uugkez74fsaHnZLfC=tyEnMNeLGW8g@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] fsmonitor: add a performance test
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>, git <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 7, 2017 at 8:35 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> On 6/14/2017 2:36 PM, Junio C Hamano wrote:
>>> Ben Peart <peartben@gmail.com> writes:
>>>
>>>>> Having said all that, I think you are using this ONLY on windows;
>>>>> perhaps it is better to drop #ifdef GIT_WINDOWS_NATIVE from all of
>>>>> the above and arrange Makefile to build test-drop-cache only on that
>>>>> platform, or something?
>>>>
>>>> I didn't find any other examples of Windows only tools.  I'll update
>>>> the #ifdef to properly dump the file system cache on Linux as well and
>>>> only error out on other platforms.
>>>
>>> If this will become Windows-only, then I have no problem with
>>> platform specfic typedef ;-) I have no problem with CamelCase,
>>> either, as that follows the local convention on the platform
>>> (similar to those in compat/* that are only for Windows).
>>>
>>> Having said all that.
>>>
>>> Another approach is to build this helper on all platforms, ...
>
> ... and having said all that, I think it is perfectly fine to do
> such a clean-up long after the series gets more exposure to wider
> audiences as a follow-up patch.  Let's get the primary part that
> affects people's everyday use of Git right and then worry about the
> test details later.
>
> A quick show of hands to the list audiences.  How many of you guys
> actually tried this series on 'pu' and checked to see its
> performance (and correctness ;-) characteristics?

As you can guess from my previous replies to this thread (and the
previous version of this patch series), I lightly tried it and checked
its performance for Booking.com.

> Do you folks like it?  Rather not have such complexity in the core
> part of the system?  A good first step to start adding more
> performance improvements?  No opinion?

I already gave my opinion which I think is shared with =C3=86var. In short
I don't think it should be a hook, as that limits the performance and
is not necessary, but it is going in the right direction.
