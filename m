Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B9061F51C
	for <e@80x24.org>; Mon, 21 May 2018 22:26:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeEUW0H (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 18:26:07 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:34809 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751202AbeEUW0D (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 18:26:03 -0400
Received: by mail-wm0-f45.google.com with SMTP id a137-v6so13688289wme.1
        for <git@vger.kernel.org>; Mon, 21 May 2018 15:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3avtVG14nKgTZ5ld+LcIZr3YUpT3+UvHvB5NECOIPkg=;
        b=aEMn6Y6lG3an+xw8NUcF88uxEGvFVTybHKdxwFx7zwKRZ+QQk6NnVk/3HkykLyMXbE
         1ORNL1lf++fRYCKW4mpv3N58/EtdsCAaoKAHZgA8hVoW6etZphLocig1gpeZtK+z19Od
         P4svrSZdXAhZXfxjgmjEmIojTJLZuDiFtO+HY40G2Rt8xD3aX1w7AYPvuO8jNlFxX+Kw
         EUBlfcvEC8lIwsSC4rZJPi30iBhPVwK2wXSx1/yv7l3V2SuRDawyyqDiRH5u5D/cLMpe
         JFDk2MLE5gHFf6ff3zrVC7hKhTk4/p1HgN1z2StsW9er3Fg5eCmv0CfTGiG59p3QaITu
         LSrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3avtVG14nKgTZ5ld+LcIZr3YUpT3+UvHvB5NECOIPkg=;
        b=o0P9D04GGogzT8YE+LgGgnU3EKMrpu0Z4Qg+hqrKfoILqv7EBnECN9KJ78WxkfXka1
         HTy3Hvf9J+CSngXBdnIWS2o/gzcq+vJeJC756e30SfVconRoELwyXxZHhKn8G97vHv+P
         u4WqFA/KLIdJgVzT+SjSHPY5eNx9UHaKCWDUsEOLG/M1xirlMFEaS6x8r687WjbSbMKI
         mhZg+tt0HiNR+dtOwHnU19yK3K17vSU6VWUHd4Qd06Z/Lql4H9k5DDbmV0LQyA/KmjJz
         IF1shE5MQsu6xEIhygNjADY2HIm2FcoSZoYnY4gREQ6596rMSG93WjBmUoheaPSorsLs
         F/fA==
X-Gm-Message-State: ALKqPwe+zlgJyXNAR5/DjrX1PCR214eQzoK98DMlYfqoKL68R/p01Zrk
        fm0BTDcxNsweR0Fg/Cq5sv5Nkv0E4kZd7QvdUSQ=
X-Google-Smtp-Source: AB8JxZr3JTu1XgQAm8dLr1atZ/WMpkdF15LS2Y/sTW42500vGTHI13lOsv6NoqCPlqXp67quipdyXf439QuTmzNLG+Q=
X-Received: by 2002:a50:cd0b:: with SMTP id z11-v6mr25164280edi.118.1526941561527;
 Mon, 21 May 2018 15:26:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.80.234.135 with HTTP; Mon, 21 May 2018 15:25:40 -0700 (PDT)
In-Reply-To: <20180521215443.GC16623@sigill.intra.peff.net>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com> <20180521215443.GC16623@sigill.intra.peff.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 21 May 2018 15:25:40 -0700
Message-ID: <CA+P7+xpC6bSy0wJhmgT=UMev2AdDz0LVG11Ok7Y5j0Fsr-s08Q@mail.gmail.com>
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 2:54 PM, Jeff King <peff@peff.net> wrote:
> Yes, I think this is clearly a case where all of the single merge-bases
> we could show are equally good. And I don't think we should promise to
> show a particular one, but I _do_ think it's friendly for us to have
> deterministic tie-breakers (we certainly don't now).
>
> -Peff

Right. I think we should probably have some mechanism that will allow
us to always give the same answer, even if it's somewhat arbitrary.

Regards,
Jake
