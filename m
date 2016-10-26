Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54202022A
	for <e@80x24.org>; Wed, 26 Oct 2016 20:46:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933088AbcJZUqR (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Oct 2016 16:46:17 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:33998 "EHLO
        mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932333AbcJZUqR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2016 16:46:17 -0400
Received: by mail-qk0-f170.google.com with SMTP id x11so19251632qka.1
        for <git@vger.kernel.org>; Wed, 26 Oct 2016 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=dMB7ijnwR4SicXIc92CgmWrTf/JBGCB0FgXLXRBk54A=;
        b=mFwSAJ8xkO8n3ALZNthPVnhsAYAvHlnDSTPIBLy0kNgq7PyjcN+l1kX4/fn2mSUACB
         H0IHqBfIU8owDmrnnTsBPAR79thDeS2Auo7edhm+gDAhYlqKeAVcZ2g0P+qAqFSoreFz
         M6aaKqzLMOoI1SbQM5QFH79Qp1dZFQgd7eUCI2ypSNIf71Q52zdzNY198FmddtDn1k/W
         HmjOdOHYETJY7PfZhZHmWUpuFuPJpELMhF7wG1Y+cyE+gPl3H+2Lkz56iGn/M2R2/ApR
         qruAih5bqMtGycqs7ixYxAV1fO1nMRnF8AWZosFW3UoE5XT67TB2+MgVhx/7vN/3NPnH
         CqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=dMB7ijnwR4SicXIc92CgmWrTf/JBGCB0FgXLXRBk54A=;
        b=C0vBQUeGpM5z2uTxRGOSZHDQxmoqPMtgawbzFXOgyWFPKLSmpSLzmFESMcZ/t9Hscz
         NR7eszzejE0hcZ/QeFNqOfrovyZGYZFX9W1KI1KZU0+Mem/zuVdLn9JQc4WPwI1q+zqu
         df7iT4cX5s1AU+Nh4dQBTYtRmebDRoNru7v2jhHbnnccsE/HiAYMh/kVS7jnDvudWhk2
         IP312jATa18Cb8Qxt978mjNocnaa5T4XmeJB0oPW77IJXMK6SBHf0EO8BzYsetXVnVQx
         zwzxzwOjgUB4swu4Xv9BwaPu+pxPeFQB93hBnaTprc+ny4CDeZLTMQK9hoMDgaRzLdsP
         LK/w==
X-Gm-Message-State: ABUngvdkq5AxXnHov1shJbT0jhyh6xFpvK2p7XrRt3g0rm96QeGMW5MY3VeW0JSOMm2CT7b8YHyUx+HmhZfLuNLq
X-Received: by 10.55.184.2 with SMTP id i2mr3666027qkf.47.1477514776037; Wed,
 26 Oct 2016 13:46:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.135.40 with HTTP; Wed, 26 Oct 2016 13:46:15 -0700 (PDT)
In-Reply-To: <6f231a78-5d74-b93f-a644-a4700c9dfbe7@kdbg.org>
References: <20161022233225.8883-1-sbeller@google.com> <20161022233225.8883-28-sbeller@google.com>
 <alpine.DEB.2.20.1610261049470.3264@virtualbox> <20161026093558.drsdwn2hm7bbcktt@ruderich.org>
 <20161026121525.twgiavpgfbr2ahvn@sigill.intra.peff.net> <CAGZ79kYgk9rQDju0MT2uniaxhAWpzJ9f1T9czgNnxfq+Wz6m+A@mail.gmail.com>
 <e1f760f5-27a7-8266-5d6c-d61fab7e194d@kdbg.org> <20161026202652.kz63mxqqjan7swvl@sigill.intra.peff.net>
 <6f231a78-5d74-b93f-a644-a4700c9dfbe7@kdbg.org>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 26 Oct 2016 13:46:15 -0700
Message-ID: <CAGZ79kYhMVrKHhNGYcf_D9kWEYp+sC+tMGbuE+gnD8AU27dh8g@mail.gmail.com>
Subject: Re: [PATCH 27/36] attr: convert to new threadsafe API
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Jeff King <peff@peff.net>, Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 26, 2016 at 1:40 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 26.10.2016 um 22:26 schrieb Jeff King:
>>
>> On Wed, Oct 26, 2016 at 10:25:38PM +0200, Johannes Sixt wrote:
>>
>>> Am 26.10.2016 um 21:51 schrieb Stefan Beller:
>>>>
>>>> it is
>>>> very convenient to not have to explicitly initialize mutexes?
>>>
>>>
>>> Not to initialize a mutex is still wrong for pthreads.
>>
>>
>> I think Stefan was being loose with his wording. There would still be an
>> initializer, but it would be a constant (and in the case of pthread
>> emulation on Windows, would just be NULL).
>
>
> And I was loose, too: Not to initialize a mutex with at least
> PTHREAD_MUTEX_INITILIZER (if not pthread_mutex_init) is still wrong.
>

My words were wrong, I meant statically initialized instead of the need to
call a function to initialize a mutex. (For the attribute subsystem, where would
that function go? We use attrs all over the place. My current thinking would
be in git.c to initialize the Big Single Attr Lock. I feel like that
is not very well
maintainable though).

Sorry for the confusion,
Stefan
