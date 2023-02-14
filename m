Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B82DC61DA4
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 06:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbjBNGzq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 14 Feb 2023 01:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjBNGzp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 01:55:45 -0500
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D89A974F
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:55:44 -0800 (PST)
Received: by mail-pj1-f54.google.com with SMTP id w14-20020a17090a5e0e00b00233d3b9650eso6887101pjf.4
        for <git@vger.kernel.org>; Mon, 13 Feb 2023 22:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPftE/59CuxMyQ7vjD0ez8YNjJp5UGvyFAexTw2Aqhk=;
        b=gxv6ZS08FCOY6qdJM4QSPWDEO8mOueyGDIER7D4Dpzrfj551cxChOHXXjIuTIRlrcX
         ib+SLipPa1qVl/08z688vCvyZOlnQZfP8OPSItmubo5x9s19V9k8p700NA+ZL02iFrvs
         jmeaa1sjtha6p3GD3dNs3ha7Yelcd11LjYdI4aXJ731jVkS8/nAmCoBs2TB2O4YzNS14
         cyrrs6qj3BC8jsCUmdztjFNthRAXE9gxVI1xXulSYplW+R6o0eK1T7x4V5GY6AOkMWIw
         y2aJmPIY0gPnGlt9wpxkIRGMyPJckdiN7EocK7Xtl4+bHcbEqelSDRm1ukC2Fr0zyexe
         c3oA==
X-Gm-Message-State: AO0yUKVn4rUEbVLXwPLMZ+Wa0gq8yPzmQYFy2CxxUNN2gcxrThbI8VpW
        PCcqGfqN7oVq3LSOXuIh+u07gKRPPUDnfyqNZlI=
X-Google-Smtp-Source: AK7set8nWKxeZFglY9NkuipizskueGhKlaw2+8WE0gj/myV7ZgUGSJ0LDnp4z66HpumFhFi4pSD+QlErs5agxfCiQwo=
X-Received: by 2002:a17:90a:73cf:b0:233:d1eb:de8b with SMTP id
 n15-20020a17090a73cf00b00233d1ebde8bmr167343pjk.130.1676357743564; Mon, 13
 Feb 2023 22:55:43 -0800 (PST)
MIME-Version: 1.0
References: <CAGF3oAcCi+fG12j-1U0hcrWwkF5K_9WhOi6ZPHBzUUzfkrZDxA@mail.gmail.com>
 <Y+qbFN+PhHVuWT2T@coredump.intra.peff.net> <CAPig+cQ9f0aW0TcP9A5WrKmYcQsEZvPOiPrgmzsy1frWkHd34w@mail.gmail.com>
 <Y+rmNvfjIA/u81em@coredump.intra.peff.net> <CAPig+cSTG2_hsv-amhwDwQNcfLSZ2+if6=MJcyDb6PhKBx-WJQ@mail.gmail.com>
 <CAPig+cT5mORvJt_E+uDYEVW+SYbUp_1U8hmjWT8iUkjzOnJm=A@mail.gmail.com>
 <xmqq7cwk955b.fsf@gitster.g> <CAPig+cQx24PRUsEjEcnuDtokS02SS3n_dUi8MO=WJbBazget8g@mail.gmail.com>
 <xmqq3578924s.fsf@gitster.g>
In-Reply-To: <xmqq3578924s.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 01:55:32 -0500
Message-ID: <CAPig+cQLRDJY_9zjEu2DdZug8h9QNSUVCzDC7W65Cm=eQ-3MiQ@mail.gmail.com>
Subject: Re: bug report: symbolic-ref --short command echos the wrong text
 while use Chinese language
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 1:45 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Using (presumably) valid LANG codes results in the buggy truncated
> > output, but "LANG=C" produces the correct result:
> >
> >   $ for i in C en_US fr_FR de_DE ru_RU zh_CN; do printf "$i: " &&
> > LANG=$i.UTF-8 git symbolic-ref --short HEAD; done
> >   C: 测试-加-增加-加-增加
> >   en_US: 测试-?
> >   fr_FR: 测试-?
> >   de_DE: 测试-?
> >   ru_RU: 测试-?
> >   zh_CN: 测试-?
>
> So the system cares more than just "is this a valid UTF-8 sequence?"
> but somehow knows that the given sequence is a valid Chinese and not
> valid English?  ---oh, no, zh_CN is rejected, but your earlier zh-CN
> somehow was accepted?
>
> Now, it is beyond my ability to guess what macOS is internally doing
> wrong X-<.

I  don't think the earlier incorrect "zh-CN" (in which I used "-"
rather than "_") was accepted. Rather, the system simply didn't
recognize it, thus presumably fell back to "C" locale. The same
"correct" output results from any bogus LANG value:

  $ LANG=bogus git symbolic-ref --short HEAD
  测试-加-增加-加-增加
