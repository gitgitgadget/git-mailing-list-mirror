Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE55E20248
	for <e@80x24.org>; Tue, 26 Feb 2019 10:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbfBZKd6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Feb 2019 05:33:58 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45167 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfBZKd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Feb 2019 05:33:58 -0500
Received: by mail-ed1-f67.google.com with SMTP id f19so876806eds.12
        for <git@vger.kernel.org>; Tue, 26 Feb 2019 02:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2yG9jFqMlMT5CKbtSmrvdzBvstselqSvk5TPsi1PBxk=;
        b=fihG8mxC6XJzgyl4QCDRRwudXODeVIYsoOOxlfOy8/ZOowy6B6A0TXrR8aemakDCFU
         YnnPWnVz53OlUdVkHRaClO56vUp3Q9aUXWTa2eK06utv2AcJBf8zmkUr/MPeI01vCmhR
         wt983kmK7DhFCWkBxR3degQxPlv6tucnbaReqmzwphsdXK084SZqC96mt1uIeLSNgqDi
         rBYywGV1f0anSby6KHOYvt5c9EeXDIS5iO8lYrnxP7I4cl0n5FMcIgRLKLyNNPCCldrV
         sYs875mDO1MNqaWTr8y6RlMF2JJRuJwKDvVxEdsga7XTBIryYrGb9TUxuLPiplBsmqCt
         mcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2yG9jFqMlMT5CKbtSmrvdzBvstselqSvk5TPsi1PBxk=;
        b=TBm8hSHLF4y6isgCLMmaeaC/FXieMid3LTKAAD2kiYNuwNdn017nnpFfc5xSQ83tfX
         V6ssvHwfudQLCG6fNZdil+Z/b0JrOHSXj151rQ/mPl2dqD6HjMWz2GutvpJtYgdhLvu7
         s7zn37euTBV+Uf3xLsZYT+r0DXO+mRvfhdnsHerxGudjo5rvW+jUVJqqsO3fV9cSeTIk
         oEHthycUJq+RIE8WkOAp+AaVW8p1KVZewF1ulHFHiCH3PaU2I1jqULayqgDQmaeSdmSw
         QjRlUoh9OYOv/NcOGS7FDlx74BL3v4euNtcXxs9vLQpX70lKpSSV3iBQ8oY/ENbJ71l8
         J8SA==
X-Gm-Message-State: AHQUAua9xF/MCTvSoEyCE559gYnw3DjFoANqr5QgwYrujXHtO5aMFFLa
        rJJiOFiwV4r9eC1QlKFNJNpQP0AADKRN7Kk9m2Y=
X-Google-Smtp-Source: AHgI3IZsk31RD4l/YQMU2FnOhdMzUQZOAP78fGknp8p/rqgHq4ZuqJvDvw97JIm6oRXU0tW1L2ZGU7Cp28Chp2DnuRA=
X-Received: by 2002:a05:6402:185a:: with SMTP id v26mr18253057edy.163.1551177236653;
 Tue, 26 Feb 2019 02:33:56 -0800 (PST)
MIME-Version: 1.0
References: <20190223190309.6728-1-matheus.bernardino@usp.br>
 <20190223190309.6728-4-matheus.bernardino@usp.br> <87va1a3z8e.fsf@evledraar.gmail.com>
 <CAP8UFD2LLL+V54k3XmHzmg5t1zanpAvY_=7GqXL43vLPTTmuww@mail.gmail.com> <CAHd-oW4P-aAKH0_kKrOJeprWmvPCUfa++X3pSNYSQisAV-25HA@mail.gmail.com>
In-Reply-To: <CAHd-oW4P-aAKH0_kKrOJeprWmvPCUfa++X3pSNYSQisAV-25HA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 Feb 2019 11:33:44 +0100
Message-ID: <CAP8UFD1++Uy=FA-Y6jpH-4DgpqxvPnvQXQ9DxC6QxXKBPkA+5w@mail.gmail.com>
Subject: Re: [GSoC][PATCH 3/3] clone: use dir-iterator to avoid explicit dir traversal
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matheus,

On Mon, Feb 25, 2019 at 3:31 AM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> I am a little confused about what I should do next. How should I
> proceed with this series?

When there are different opinions about what you should do, I would
suggest doing only things everyone is ok with, and then resending
saying in the cover letter that such and such issues still need to be
decided. Then hopefully either Junio will decide or a consensus will
eventually appear about what you should do.

In any case please don't wait until something is decided before
resending with improvements (or just pinging us if you have already
made all the improvements that were suggested) as that may not happen.
If people on the list stop hearing about your patch series, they might
just forget about it.

Thanks,
Christian.
