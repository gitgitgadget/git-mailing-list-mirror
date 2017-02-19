Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEC19201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 23:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751517AbdBSXDp (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 18:03:45 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:35282 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdBSXDo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 18:03:44 -0500
Received: by mail-lf0-f67.google.com with SMTP id z127so5282728lfa.2
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 15:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pCqPz8BGMhPkH8fO/bLUEierAkhxq2FIc0mHbKLBTc8=;
        b=SR9jxpPZIuxRwUszEQOBSn077st3ml0S1M5CwKsxbQNlE4WKDT4HwHldU23glHjMGg
         qXNg1uPtfsRMc06eGiBuvP+yPD61EPTd7lMiZjbeCYJL7yZhYpYAbtkd4vYiV/cEPMPc
         qmPgjcSOKCvoTjXTqG2YLaU+VawWCnC9G9FVUgwmoVc7VwpOTZzpTL6isqmB+9gzI82U
         H8lIU6YjmLZ8hymIppHjgxSHfXjXemOrrdWOEHnhezekEk+wiTNpe1Wbzy0z7GFLtMDt
         Uo+HeDrziotEZEu+LGPABjaXeXpNUxSWfavqkv0pOaf4TCaVO5eJ5vZHhTtihERAKcIE
         74Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pCqPz8BGMhPkH8fO/bLUEierAkhxq2FIc0mHbKLBTc8=;
        b=EfUB+IjJX4GNsb7+1wdMk4mQMVKj39Pr9HWDZrL8MTUesqj45ktstz8TkCcvynMTOr
         u7eKTHzsXgWeQ+ysLm7q+Sm03AzqMpeQZzJjeJFbL3TykGNhwQHxLW/3Giuc6AYKZNLr
         941eysDz0O/Axn8BbWRluRUvcVo80zHU4AE6JkzflkmQ20R2pzVER2PCkPkt2fHVfjUL
         B9kFKLQqtJjlGNjjGQIjhkiPox2CZRsYNtq+XfrpQpLRQRKeMrtw0r6BtodgG/kd8uBm
         l/NqYve1NHs5Wclrzn45ZPbV0J9pZNWHTT2aoLmyR7RFzLOH+mkGQB4xXItr8RSwLYU+
         /+aA==
X-Gm-Message-State: AMke39kWbIzI8sYfJxuDVOo6ydsav12YfdJYbuM6nIEGvdHpnR2xhjpVyS5BTwIbzMqf5wHpWSHc/bx8Bf+LhA==
X-Received: by 10.25.87.196 with SMTP id l187mr5195300lfb.143.1487545422117;
 Sun, 19 Feb 2017 15:03:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Sun, 19 Feb 2017 15:03:21 -0800 (PST)
In-Reply-To: <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan> <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
 <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com> <CA+55aFy-vvOBu5Y4KDeteUyK-7U7yTa1HoqHo+hME1=8bq7Xhw@mail.gmail.com>
 <xmqq7f4tdcua.fsf@gitster.mtv.corp.google.com> <xmqqr330779h.fsf@gitster.mtv.corp.google.com>
 <20170215002901.gtzegvhyy7d6cvrb@sigill.intra.peff.net> <xmqqefywnk5a.fsf@gitster.mtv.corp.google.com>
 <CA+55aFw3ZRtgsLGW-TFqpq-3uCw55L42p7cF=Q-73qM_VPuYsQ@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 19 Feb 2017 15:03:21 -0800
Message-ID: <CA+P7+xqtPwzt3J6O05TP=E_hh-ko97adn+__Zmc0DNSDqEnEHw@mail.gmail.com>
Subject: Re: [RFC PATCH] show decorations at the end of the line
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 19, 2017 at 2:33 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Fri, Feb 17, 2017 at 9:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I just got bitten by a fallout.  I have
>>
>>     $ git recent --help
>>     `git recent' is aliased to `log --oneline --branches --no-merges \
>>          --source --since=3.weeks'
>>
>> but now the branch names are shown at the end, which defeats the
>> whole point of the alias.
>
> Yes, your situation actually wants those decorations as primary
> things, so having them at the end is indeed pointless.
>
> So I think we should just discard that patch of mine.
>
>                  Linus

I would think that in general putting them at the end makes more
sense, but we should have the ability to use them in format specifiers
so that users are free to customize it exactly how they want. That is,
I agree with the reasoning presented in the original patch, but think
Junio's case can be solved by strengthening the custom formats.

Thanks,
Jake
