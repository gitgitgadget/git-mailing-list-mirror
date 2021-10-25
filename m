Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2851C433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 825DF60F22
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 16:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbhJYQlo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 12:41:44 -0400
Received: from mail-ed1-f49.google.com ([209.85.208.49]:41750 "EHLO
        mail-ed1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJYQlo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 12:41:44 -0400
Received: by mail-ed1-f49.google.com with SMTP id l13so1694090edi.8
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 09:39:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0E3H+Q7mrdYh5/Tipq+3URWasq7maETX1kt1arOBN64=;
        b=2J78LRwOEUtP0tegagXAw81356vTlOpC57FfnwxOITl75QG1DGZo0DUYpIYOBUPAUi
         ESonoGGQfX1hfVe+5yw3zolhpSro0RzcCEaMZ49hDrgzVe9OCEZfnFeOLI27ykrD1WRA
         TsU7DkIO8mliT3f56kJlMGElkTCm7OiAGxsN3AJS5cutgHl+NHlr0uOxGl4Fnk8Fy2Ne
         yDL3b5UT5vOV4x1W9eW/kDufPAgC8wpNLyNLLC+dlYp0dB7TAEfuuN73cvpAuTQwNX+S
         h+7CX6ZzvE8i7C7RkACxRLpyZ+C6eLISCIdHHh0pZYEA0UtNYxYmjMNnBe1IslWQhsz/
         P+jA==
X-Gm-Message-State: AOAM531TnVzlBR52ck68eF5dHAQPodslwaMRvlPMILYae+frOy9wHokY
        rMeB1vHBVzLYdioIIi55fKlC40ZSbnAeXr0ym4Y=
X-Google-Smtp-Source: ABdhPJwwdCmbyxl6rgYJIL8HzZVKsBx4yLTxuO0k+L924E6wUkznwK1t34XKZ5qqRINS1/8/k2o1CISQTctHyowwmjk=
X-Received: by 2002:a05:6402:1693:: with SMTP id a19mr13646198edv.231.1635179959128;
 Mon, 25 Oct 2021 09:39:19 -0700 (PDT)
MIME-Version: 1.0
References: <20211022064543.28950-1-bagasdotme@gmail.com> <CAPig+cRAi4ZR+_+Dh+DoUBkG=sgWTekxadob2YvThJQhr9tqfA@mail.gmail.com>
 <xmqqcznvbg2m.fsf@gitster.g>
In-Reply-To: <xmqqcznvbg2m.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 25 Oct 2021 12:39:07 -0400
Message-ID: <CAPig+cQ8NEKY3nwuFi_7Hc7L7rnbcUShf3zw60PvBB8LOPEgPA@mail.gmail.com>
Subject: Re: [PATCH v4] archive: describe compression level option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Git List <git@vger.kernel.org>, vagabon.xyz@gmail.com,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 23, 2021 at 5:13 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> >> +-<digit>::
> >> +       Regulate compression level using the specified <digit>. Higher
> >> +       values enables smaller size at the expense of slower time.
> >
> > s/enables/enable/
> >
> > A couple notes:
> >
> > "slower time" is an unusual way to convey the concept; perhaps say it
> > takes "more time".
> > [...]
> >> +       Supported values are from `-0` (store-only) to `-9` (best ratio).
> >> +       Default is `-6` if isn't specified.
> >
> > s/if isn't/if it isn't/
> > ...or...
> > s/if isn't/if not/
>
> Sounds all sensible.
>
> In summary, perhaps something like this?  I still have "-9 (best
> ratio)" which does not say it is merely the intent and not
> guarantee, but the resulting text read a bit funny with "best ratio"
> replaced with "try hardest".

This version looks fine. Thanks.
