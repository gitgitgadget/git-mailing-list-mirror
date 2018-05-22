Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 081F61F51C
	for <e@80x24.org>; Tue, 22 May 2018 02:20:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751601AbeEVCUC (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 22:20:02 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:41862 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbeEVCUC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 22:20:02 -0400
Received: by mail-qk0-f193.google.com with SMTP id d125-v6so13396089qkb.8
        for <git@vger.kernel.org>; Mon, 21 May 2018 19:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=jEJTUNTP7GcIFR9TNIFo+aR8OqFPqdp6NhIswc038v8=;
        b=qMa4J3MFhDbACae0jPj+9TgRF4qH9YAnJXRG8c9CYv4XZJ1xY5qpuvcx0TEv02hf1M
         4qM6WaUG88WdvVd0zQK7gT0WrVkQ7mQ1FP7sGGDgkZYO0aFL6HHzgTOLif3p8tPlCWY6
         yqiTw2N4SocMJ+0F/yxhpLNxhM5E50EJ6OzbH2lqoifNkV+KDTXhOiUXs157mF7n2M5s
         5dodIXb8AVvPWqihdPE3vpGhfIS5ebFvfFxh8MaC7DSOZkP0rxhuWNiidPNMusBePp4O
         JOLu38VHRTjXgSTrDTknwQ1eBsAgPsdXQo9NqxrsIp7CZFnwNjYIs/Lo3auuYhJshus3
         UnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=jEJTUNTP7GcIFR9TNIFo+aR8OqFPqdp6NhIswc038v8=;
        b=ZKhrBf6yNKwQfNEelmCT1mZW6krgElMF7SxlhZ616QmGVKcVcpNhReZS8i3JmeRtTy
         fw+URzOPyjL9Wb2y8VID2sBvvI7VqNNOLQnZHKDHvrlQg9vGcuCCyIlZV3dAKo/KpCAI
         tRbLdj+mP5D2tpXMgiSCaJRqwOTUi5P9t8TDB/JYYMXsixAbSAowJ9Qf/CFg3McJshfq
         c9pCo27bZ99uQ7Wd+hnKLFhAXzjoKDCvf4vOzVs0uPBfKBnGydVxfwnCN2QHXAxCVnCs
         Epr7M7utH4s8Xlj5pid4/uG3y/9YZnlLgp9toLcPYZ2zdf4qeYvLI8c8prTw+ysExyIe
         EQOA==
X-Gm-Message-State: ALKqPwezrelYeEo37AdKX59q7ZlBNNM6ugmul27MtJxda63QWxj5gUrw
        mnd/PEVOUjHRMxX3dCKlVy70r7GeizGLcZd5kiA=
X-Google-Smtp-Source: AB8JxZro+Zofgc4pxmwQAI/kaTk4Hd+cEqj4AoS56KN2aimpORDD96ePiQOwEMt8l+SBj8t3E4pAPQdyJhZYPNra/XA=
X-Received: by 2002:a37:6d04:: with SMTP id i4-v6mr18256064qkc.361.1526955601264;
 Mon, 21 May 2018 19:20:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Mon, 21 May 2018 19:20:00 -0700 (PDT)
In-Reply-To: <CAGZ79kZotwAFauTkCJ6YZ_C-MuaQpNaaS8LCniL_Or=_ccfC4w@mail.gmail.com>
References: <CAPig+cQaJmsJe=E6HdBw0s6eN-qW0OCezBacRcQ+UnJYMbODsw@mail.gmail.com>
 <20180520105032.9464-1-martin.agren@gmail.com> <CAGZ79kZotwAFauTkCJ6YZ_C-MuaQpNaaS8LCniL_Or=_ccfC4w@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 21 May 2018 22:20:00 -0400
X-Google-Sender-Auth: 4gpqW9pholUNxtRcN6k9TONV1WM
Message-ID: <CAPig+cQevUoYJOisFt9BDhLP1_SjPqX+2hmFKDPcBvAh2D7ksA@mail.gmail.com>
Subject: Re: [PATCH] regex: do not call `regfree()` if compilation fails
To:     Stefan Beller <sbeller@google.com>
Cc:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        git <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 2:43 PM, Stefan Beller <sbeller@google.com> wrote:
> On Sun, May 20, 2018 at 3:50 AM, Martin =C3=85gren <martin.agren@gmail.co=
m> wrote:
>> It is apparently undefined behavior to call `regfree()` on a regex where
>> `regcomp()` failed. [...]
>>
>> diff --git a/diffcore-pickaxe.c b/diffcore-pickaxe.c
>> @@ -215,7 +215,6 @@ static void regcomp_or_die(regex_t *regex, const cha=
r *needle, int cflags)
>>                 /* The POSIX.2 people are surely sick */
>>                 char errbuf[1024];
>>                 regerror(err, regex, errbuf, 1024);
>> -               regfree(regex);
>>                 die("invalid regex: %s", errbuf);
>
> While the commit message is very clear why we supposedly introduce a leak=
 here,
> it is hard to be found from the source code (as we only delete code
> there, so digging
> for history is not obvious), so maybe
>
>      /* regfree(regex) is invalid here */
>
> instead?

The commit message doesn't say that we are supposedly introducing a
leak (and, indeed, no resources should have been allocated to the
'regex' upon failed compile). It's saying that removing this call
potentially avoids a crash under some implementations.

Given that the very next line is die(), and that the function name has
"_or_die" in it, I'm not sure that an in-code comment about regfree()
being invalid upon failed compile would be all that helpful; indeed,
it could be confusing, causing the reader to wonder why that is
significant if we're just dying anyhow. I find that the patch, as is,
clarifies rather than muddles the situation.
