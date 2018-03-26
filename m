Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891DC1F404
	for <e@80x24.org>; Mon, 26 Mar 2018 18:38:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeCZSil (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Mar 2018 14:38:41 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:36818 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751926AbeCZSik (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Mar 2018 14:38:40 -0400
Received: by mail-wm0-f47.google.com with SMTP id x82so17239180wmg.1
        for <git@vger.kernel.org>; Mon, 26 Mar 2018 11:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4knxl6iNNIQVCNbD514Cl+fV9KGwdWBzMwtgI0NtOVU=;
        b=DbgpgUu5urOuHLs23ReDvRNaxh2q6JusUDk/wxLBO9yMl+B1f9etcT+gL0jwHMistb
         FMednDByEFba2TCVxijlVZko3opLz0qL1Mmnj6p6e8AK2a/zNsWtLRcK+ObMHWthpom2
         w+9H8mHucTqQo97ZPcou0L7c4GBMjBbRUTW17+Wa1g1EF0eIaWeMdnAJnUr1Q3Ov2v4p
         x6M4PIdzxBZd30ulk9TakhTQUMLF3Ach7Kt54XhHrmxg81kZPVsyqKVW1hrHwcIC0Pyp
         CDPpkA0lGwn0Dsu4Fbrdt3psOZbRgBilnrAF/ip4zqPdVsT1mB216S4Z4NvL2Q4Qg34e
         QsEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4knxl6iNNIQVCNbD514Cl+fV9KGwdWBzMwtgI0NtOVU=;
        b=aTenkkd15SBWNGk3Jq0gQcVLG49yN68bxeSVAqW3F14gaLLyTc7/b04NP3KvgM+QV1
         Nzhdc4YALo2bDHbWlY+7JXvrBf+pQCymhDuL0BABlzzGmTBT5jzxSRJHnkfUtn7BmECy
         fWhfzVgT3mUoHwxWJsw8FQ38OkRJgIgikm5iDvAfLnW3Vv9FdrfwrNyROaz9y5dJMzC+
         QP8ahndEi7efqQXSvBHo/im0xM6oRs1QrW12m6cW7TS2/tx9mfOiFcB4P7Jlrinfjxud
         eAld1Om9NSyDtWnTZmktACd0h3Nvmnqjh8QDmDHABQ27veQgyuTSRPe/pxdZodKG0R5M
         2BfQ==
X-Gm-Message-State: AElRT7HmtOw+6+MeJfw2PDxujKL0f5dO+gJkfMqmg60o0LcJkZ0CwL1o
        UT3GgerFDc29Z7GeL/ZkIY9Dw69Zxm0QnaHs/js=
X-Google-Smtp-Source: AG47ELuqGHkoM+v63CW5+3UV9mu/InooHBFH1FW0JmwBa+2N3rXwNBJ4soJBSS4AK3ef/Mx73phEfxRgumSWT1UaFTg=
X-Received: by 10.80.172.196 with SMTP id x62mr18782487edc.265.1522089519144;
 Mon, 26 Mar 2018 11:38:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.203.135 with HTTP; Mon, 26 Mar 2018 11:38:18 -0700 (PDT)
In-Reply-To: <CAPig+cTcqSa6AfeMQivnSdL=y2+WWw2MtSavDciMc84RcKURMA@mail.gmail.com>
References: <20180324183844.4565-1-kaartic.sivaraam@gmail.com>
 <CAPig+cQ8xw23SGhpx5qtDEyzJGR1v4L2Lm9tEWe56Rh3c8Q3cg@mail.gmail.com>
 <87ea8cac-c745-b7e6-7804-5116cd94ed48@gmail.com> <20180325041056.GA22321@sigill.intra.peff.net>
 <CAPig+cRe9AmFv=GCxPOo5vcLGFuT1qdM60M4KV5P6UN+Ai-QoQ@mail.gmail.com>
 <20180325043337.GA32465@sigill.intra.peff.net> <CA+P7+xr2-OidiX9ve6GwOR4pSOe4Gn=A3Aow5L=oLZgZE+XqMQ@mail.gmail.com>
 <20180326072505.GA12436@sigill.intra.peff.net> <CAPig+cTcqSa6AfeMQivnSdL=y2+WWw2MtSavDciMc84RcKURMA@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 26 Mar 2018 11:38:18 -0700
Message-ID: <CA+P7+xp3QMzpqDaB0O_kza+bBcP1vM6Nm_u0=D0tzDsduhnmEQ@mail.gmail.com>
Subject: Re: [PATCH] branch -l: print useful info whilst rebasing a non-local branch
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 26, 2018 at 12:44 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Mon, Mar 26, 2018 at 3:25 AM, Jeff King <peff@peff.net> wrote:
>> OK, so here's some patches. We could do the first three now, wait a
>> while before the fourth, and then wait a while (or never) on the fifth.
>>
>>   [1/5]: t3200: unset core.logallrefupdates when testing reflog creation
>>   [2/5]: t: switch "branch -l" to "branch --create-reflog"
>>   [3/5]: branch: deprecate "-l" option
>>   [4/5]: branch: drop deprecated "-l" option
>>   [5/5]: branch: make "-l" a synonym for "--list"
>
> The entire series looks good to me. FWIW,
>
> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>

Same to me.

Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

Thanks,
Jake
