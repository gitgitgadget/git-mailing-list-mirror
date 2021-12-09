Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 629DBC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhLITVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:21:17 -0500
Received: from mail-pj1-f45.google.com ([209.85.216.45]:37412 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLITVQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:21:16 -0500
Received: by mail-pj1-f45.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so7718414pjb.2
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:17:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMAuIcAsuorDH+2fV7ksRMHLN3m7o3L04VF7FpD2c2g=;
        b=k62md6jGhQFtlTUplErO5Pp50T03Er+VNMvZ3DsaNWjBlp8IIhxS17SdnwF7zHCPR9
         nRTazaBDozjEYgXnVPhpr04IlXTkWWXlE+GIEm1q9893JM1mTvWJDByWN/ARxK7EqfvR
         RHNjr9HK0T1kbhSQFOHJy9QtmiZAToYMwRP+2t8DpA/xy2SoNUBiHYK3xmPCo45GGa+e
         7jEMTXAWv1O4D8pS5bwGDpBOlpfP9hMZ3hryl403XuwtZaJHsBS82y1EPkGkcQHrvKii
         KC5E+hFEcAhCy+2615oVjoJ5jWNdFVN2X5wNvpirFgN3yf2GzP16xUbZQOx3POLeqQKf
         Aexg==
X-Gm-Message-State: AOAM533Z12Do58UGdvjkbCJvILXKUDr88n7+qNDtjnVLdLKR8/C8+qVh
        8h9xlftve/QzY5Qi1g9vY11l57y+yLIEvyj3258=
X-Google-Smtp-Source: ABdhPJx+A6ObsEmetYrw5U9WPo6yyYGcgG6zHpBc3Fv/e+FjRV1BZ6D2d5+Krv9fjKSWYKZgjjt/EMU+lFhEs14uj8Q=
X-Received: by 2002:a17:90b:4d08:: with SMTP id mw8mr18300552pjb.236.1639077462934;
 Thu, 09 Dec 2021 11:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20211209051115.52629-1-sunshine@sunshineco.com> <CABPp-BFM5ZbFAzVfvDE3=zm6Q4LN2fWthPP8WH5kbgVPSxomtA@mail.gmail.com>
In-Reply-To: <CABPp-BFM5ZbFAzVfvDE3=zm6Q4LN2fWthPP8WH5kbgVPSxomtA@mail.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 9 Dec 2021 14:17:32 -0500
Message-ID: <CAPig+cRD_DzisMo-8ZuT4NzESEe4i2vPk_1Y-_JTeV9rbdwkLg@mail.gmail.com>
Subject: Re: [PATCH 00/19] tests: fix broken &&-chains & abort loops on error
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 9, 2021 at 12:03 PM Elijah Newren <newren@gmail.com> wrote:
> On Wed, Dec 8, 2021 at 11:39 PM Eric Sunshine <sunshine@sunshineco.com> wrote:
> > Although the new chainlint implementation has been complete for several
> > months, I'm still working out how to organize its patch series. In the
> > meantime, _this_ patch series fixes problems discovered by the new
> > linter due to its improved coverage and extra semantic knowledge about
> > Git tests. As much as possible, I resisted the temptation to make
> > ancillary cleanups (including indentation fixes) to tests even when such
> > cleanups would be obvious improvements. Avoiding such unrelated cleanups
> > should make the long patches in this series, which touch a lot of tests,
> > easier to review (--color-words helps a lot here).
>
> I have to admit to starting to skim once I got to the last four
> patches, since they were a bit longer and all the same type of change.

Understandable. Those bulk-change patches tend to be mind-numbing to
review, though `git diff --color-words` helps out somewhat (at least
by making it easier to skim the changes).

> You did an excellent job of explaining the changes and presented them
> in a logical fashion.  The few things I thought I caught, you've
> already answered were already correct.  I do think making the second
> commit message be a bit clearer about the importance of the ordering
> would be helpful.  Anyway:
>
> Reviewed-by: Elijah Newren <newren@gmail.com>

Thanks. I'll wait a couple days and resend with a clarified commit
message for the second patch unless, perhaps, Junio would accept a
resend of just that patch so I don't have to spam the list again.
