Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6581320C11
	for <e@80x24.org>; Mon, 27 Nov 2017 16:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbdK0QkW (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Nov 2017 11:40:22 -0500
Received: from mail-ua0-f179.google.com ([209.85.217.179]:38126 "EHLO
        mail-ua0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753291AbdK0QkU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Nov 2017 11:40:20 -0500
Received: by mail-ua0-f179.google.com with SMTP id f14so19458434uaa.5
        for <git@vger.kernel.org>; Mon, 27 Nov 2017 08:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pgFouP9TN3snc0BmIiISVGAuMu7Q+iuZsGaPZE59rCk=;
        b=sqz7tGkMBN3V4W5i4HnZ1iAcRvvFSsCvDWBKz7YdpB7Yvvui93xitRis2CeV0tOmcd
         iXyRpSQs9V4dX8BEmOndU7huEmrlIy5BOaOT5htIqc5CLmpH4S/XWSBmMzbA762y1RgW
         vWM2xtu3CsaIU+l3d2bM+0Ijlm8Cwp81nf31pSEN5+pHwtrWWd8wtaq1BUxhglQtlyUG
         a2Ocwza9xLSSum4METqFtUgxoAi6W+JIYQ0NZ9prbV9/3w+6SZk8Aj7UbwvpEtehfMZh
         miCvAOylGZHXVEc2h8dLFj2Wwmsg6g/UPdc1RsJQSGZphP4wTXfYVyt5YXkmjIT9akLH
         j7MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pgFouP9TN3snc0BmIiISVGAuMu7Q+iuZsGaPZE59rCk=;
        b=Y1h+64hvekaJ3KrZ12I8vi2kiMiFPWpZ7u6J10VXoR2czT+2GMScxUZsYTqFqQS7bo
         2ivULy+y8WMzEP1u8gEyNY+g7oQ2Xj/g9Bw4htPAGfS+cygfQ8PH+VaYuNE6HxCefG4u
         i82IlvI4kxTKEz4khBYXCU9o/SRRZ+Baax9xbsX5TAu/4nyCQQ7ItykmCKn/tkngr/sY
         8/oMMz4AbtMUFLUxOj9/CDRbuPWfpL5l7JUqEbCKUnYIrOJgiQxHQtGUKyGBFz+HNvLr
         wLUXx/6qZtjV4seC3/uKKNV23kUXjQV5nxC84TIUpSEPO7PBSXgjwoTjAEZy3fgy5SdB
         DezA==
X-Gm-Message-State: AJaThX5nW57nVL/L7sc4i9KY1acsaYFUoC3EuLhRODGNYfBAoltg9oy1
        anRF9l7tZg1j9oM4diJAbeLJDMxQQoa+CrwvkPY=
X-Google-Smtp-Source: AGs4zMblx1V3F6DXvsiGphOQvu/2l7B85WVSV2A5Vqb3/UZF50/n6AeIeP/iXqfxeGkBqEnTX1V0RxmUrr1z9wSHdD0=
X-Received: by 10.176.78.238 with SMTP id x46mr33197382uah.147.1511800818913;
 Mon, 27 Nov 2017 08:40:18 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.70.138 with HTTP; Mon, 27 Nov 2017 08:40:17 -0800 (PST)
In-Reply-To: <xmqq4lpgfkyb.fsf@gitster.mtv.corp.google.com>
References: <20171124195901.2581-1-newren@gmail.com> <xmqq4lpgfkyb.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 27 Nov 2017 08:40:17 -0800
Message-ID: <CABPp-BELci79tuiPFVRKQwm_-j6tN-DxqcKsvjD2xG_8ZWNxGw@mail.gmail.com>
Subject: Re: [PATCH] merge-recursive: ignore_case shouldn't reject intentional removals
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Adam Dinwoodie <adam@dinwoodie.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Removed cc's that just bounce]

On Sun, Nov 26, 2017 at 7:40 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> In commit ae352c7f3 (merge-recursive.c: fix case-changing merge bug,
>> 2014-05-01), it was observed that removing files could be problematic on
<snip>
>>
>> If that description leaves more questions than answers, we may need to
>> augment the above commit message with the following explanation...
>> ...
>>  merge-recursive.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> As a fix, this sorely wants something new in t/ directory.

Well, then perhaps I was wrong to submit it independent of my
directory rename series.  As noted in the (very lengthy) extended
commit message explanation, the assumption the previous code made just
happened to work until a few extra tweaks (from directory renames)
caused us to want to remove a file from the working copy that was
found at stage 0 in the index.  Thus, the only testcase we can really
use for this commit, is testcase 7b of the new t6043 added by that
other patch series, and it's only valid with the code from that other
series.

When I submitted this patch, I was thinking about just including this
fix with the next reroll of my rename-directory-detection series but
it partially felt like an independent fix...but maybe I chose wrong.

Would you prefer I include it in my next en/rename-directory-detection reroll?
