Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82DA200B9
	for <e@80x24.org>; Mon,  7 May 2018 20:53:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752964AbeEGUxP (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 May 2018 16:53:15 -0400
Received: from mail-yb0-f174.google.com ([209.85.213.174]:34223 "EHLO
        mail-yb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752855AbeEGUxO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 May 2018 16:53:14 -0400
Received: by mail-yb0-f174.google.com with SMTP id b14-v6so10421947ybk.1
        for <git@vger.kernel.org>; Mon, 07 May 2018 13:53:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fsu5lFQyvY3/2zjS5fyxYLY5gy+AyCvUKODRpk9p6tI=;
        b=LFK+Ny8QWvbiHBqL17fmFexgtol+xHK7nDOuE4ZknKogZt4KvfBiDh28ev+RFQgo12
         O3OwUdG/OUlORwV9QhdcPmimqErXVhtZnJZTqQH6+fmXOhsGe7DbJ6oU+qHbFru16I0l
         O8pfHQWXJ2O3XR482jr2qId4OpRGI+TFrHUll6HHCjt1nTkkZ69JdMG/6RuVEZwNdj6x
         uwQx6xGGWf4SPAOS0iN4l1/zFG8OdL/AEQOjQZo1s96Y/Apli495zaeGUgrDKrz4wHg1
         cnbk0MmOimfT2i80t/0ej3L0AMJBlZrxCapWwvMcEkdKWDY/h0o90YC2XLFjc9hvawCz
         5/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fsu5lFQyvY3/2zjS5fyxYLY5gy+AyCvUKODRpk9p6tI=;
        b=PUUb0/Db0KrKIBCk9wp8i5RxAPSKiuJl234XUkgUPuaHn9k4WX6cZNwVPdJY43NIA4
         B/nhCFUEY8s0qM1sw/LwebdTsV8EGhvNC3ryQbOMv8nS8dmtOB4avzaBH0UwVEK9GXBm
         yLnqjSVwq3OiatIsoZb1A8gHbQSiFdfNQRuKC3zXjHz8HMm16GIljyLcZxxGcHag+HMc
         La+sXRf0tG3peJCdqDCACNMr+oLvMPxihBV/Lfqb5h0lHkdWtrHotYshpYyHJciwKGqm
         38w1/Mu+se7ZK1M2jBL/uHWlv096c6FY9kJePpimLdx/WSewMJLOErr1XqKuR/sFS7W2
         aYzQ==
X-Gm-Message-State: ALQs6tAhmHwaDjZzD2BFG8EYXOaFCD985d57ZF/fCU6Y8l17kIZxexP2
        tm68lO2YKcpROFST5ggV9kmNSzlkpuLmE8OrufLREA==
X-Google-Smtp-Source: AB8JxZqxpJxMxHejVApl7eyprrHvQkyM6J7V0oz7ydwur7FcpsqA+i+3Hza4A6JDOVGS2xD4BndhW3ei+kebJfDdFFU=
X-Received: by 2002:a25:a567:: with SMTP id h94-v6mr20607576ybi.515.1525726393377;
 Mon, 07 May 2018 13:53:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 7 May 2018 13:53:12 -0700 (PDT)
In-Reply-To: <xmqqo9hrpnn6.fsf@gitster-ct.c.googlers.com>
References: <20180501213403.14643-1-sbeller@google.com> <xmqqo9hrpnn6.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 7 May 2018 13:53:12 -0700
Message-ID: <CAGZ79kbb8KOTjAVSrxN2GhRmem_A9BdUmaHjM64UoDP3MfHqSQ@mail.gmail.com>
Subject: Re: [PATCH 00/13] object store: alloc
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>, Jameson Miller <jamill@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, May 7, 2018 at 7:05 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> This applies on top of sb/oid-object-info and is the logical continuum of
>> the series that it builds on; this brings the object store into more of
>> Gits code, removing global state, such that reasoning about the state of
>> the in-memory representation of the repository is easier.
>
> I am not sure how well this topic is done, but I've queued the
> following patch at the tip of the topic to make it compile after
> getting merged to integration branches (curiously, the topic by
> itself compiled file for whatever reason).

Thanks for the fixup; I will include it with other fixes in a reroll.

The investigation why it would not compile is not found in alloc.c
but in 1da1580e4c2 (Makefile: detect compiler and enable more
warnings in DEVELOPER=1, 2018-04-14), which enabled
-Werror=missing-prototypes, that requires a prototype which
is found in alloc.h

Thanks,
Stefan
