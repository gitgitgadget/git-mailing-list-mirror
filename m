Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADE851F453
	for <e@80x24.org>; Thu, 31 Jan 2019 23:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727213AbfAaXa6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 18:30:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54516 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAaXa6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 18:30:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id a62so4233716wmh.4
        for <git@vger.kernel.org>; Thu, 31 Jan 2019 15:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=k8+2VE09Dl1fCHtWWV1nKeDhkLw3XsdNO3JkVpb5l70=;
        b=UHG3Oe+9nbcYcrvkhY8Kxro8qsVgtUiSGYarA38zjf0IxI9aTTV3pSFx5AcROwhEBt
         IMzDoNjdS3oYv0hrjnkNMwvGxsrNJ+WkybEglYk2yMRpZh1DiWn16e3U+SFnhofjv1x9
         a/nt7XiWBpvkXN4ws6a4gf2OtfGFCvJg+nKFU8E4BQQJ2fOxxSgFqJJypg0HD2/ajHjy
         vrZFppFAXzaTwZ2zp4ODWpISuPvKSpVZxy/UwS8h/vr0Hy2Kt0AunOcR+TqHbweEtm9k
         T/wGdz4YM0Sux7GM7nn2B57z3TRopmBfJY0ikx22JrULHlj2nIWYbf5rKiLRbCsqXRwL
         +LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=k8+2VE09Dl1fCHtWWV1nKeDhkLw3XsdNO3JkVpb5l70=;
        b=RlQmkBAZB6evx8UE4awA9T5OzTJFuV/h9BtL1HsWGe1mAtUQQrN+ql4duxcmrHnYVe
         WUjV2M6EkQV3vxq36koQnGk504avdPY+KFZkMhPnlBP9qyA6lyTA1+JB74If3NduGwpA
         aNYpiRUzkstwxRz+r4gj2hVS6AswY08rfYHDXPOzUzXek5bnqdm2bKRO/tthDp8H6c32
         slkJGkDgp8E4y4v6YxsimfJ9Zv3+ljaBpjLkHoLEFIGDnQb97MxrkwPHf1FfztfqmnsO
         QjMzwdz76BXhSlZ8D/zmVWkKjofA8qNVlJ1Es7lWneen1Y5WKJuEaycWaaCTdlQjldgd
         b7JQ==
X-Gm-Message-State: AHQUAuajBccsFZeq54psXVhLd8woPLpYNE8RL2K6WPF5++YJhNUo98I6
        8KmYvfqN/zQBmfRPGOmbKUU=
X-Google-Smtp-Source: AHgI3IZLvq5aONBH3MT02MjgKGHjKyq3AWwmCDLlgWijr7dwO8DdNCWAdsaK9XY1gvQsAZ8VGH9DQw==
X-Received: by 2002:a1c:5dce:: with SMTP id r197mr9031wmb.130.1548977455713;
        Thu, 31 Jan 2019 15:30:55 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b13sm4335570wrn.28.2019.01.31.15.30.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 15:30:54 -0800 (PST)
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
        <xmqqbm3w3bjz.fsf@gitster-ct.c.googlers.com>
        <0764948c-f3ac-3bd1-fd82-2bd3f59b463d@jeffhostetler.com>
        <a2b7a14d-5829-45dc-81b2-9ff9b876c017@jeffhostetler.com>
Date:   Thu, 31 Jan 2019 15:30:54 -0800
In-Reply-To: <a2b7a14d-5829-45dc-81b2-9ff9b876c017@jeffhostetler.com> (Jeff
        Hostetler's message of "Thu, 31 Jan 2019 17:11:48 -0500")
Message-ID: <xmqq36p81k29.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> On 1/31/2019 2:45 PM, Jeff Hostetler wrote:
>>
> ...
>>
>> I can undo my formatting changes if we want to update the settings.
>> I'll give that a try if there are no objections.
>>
>
> I'll push up a V5 in the morning that adds the foreach
> macros to the .clang-format and updates the code accordingly.

Wonderful.  Thanks for being thorough.

> Currently, waiting for the CI builds to finish.
>
> Jeff
