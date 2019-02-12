Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D063F1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 10:47:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728877AbfBLKrY (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 05:47:24 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:55254 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728184AbfBLKrY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 05:47:24 -0500
Received: by mail-it1-f194.google.com with SMTP id i145so6055248ita.4
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 02:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DaV127ftFBYdz5mnSgDQ4F6gHLSwtHPsbsEcoJmV4bg=;
        b=jeYtPlJlM1O+U2CP8bwMzokHJ/MS84jz/li4dKgqNP7/eqyEEaI8IYimYZpN24HNCU
         UcCtMJZYJGwdpsUAy1D19yoQOTf5MuNpU10H2STRBK6NmfLWpEQ0XPd1BKFEXCQ8ghbf
         rDzvXXU77amtpSZY4kYV+HMjGDgUpvn+4W9vwUQrZXpWsnC+Imor73lbBjzyj3EEVct+
         iJP3lwdTX2h/CS68L8hQ/aK0Xw7M4uG4fuXsGLL0lyGQ1urcc3sWWHq4VdZVDxU0H/JF
         mYQHg19s8YiprPHtf9TOljLtwTmwIdJ2jz4R77740NoIpKeND17/LCeo94Yb8UMzjADp
         HvUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DaV127ftFBYdz5mnSgDQ4F6gHLSwtHPsbsEcoJmV4bg=;
        b=XPTJ/EmjNNxoIGZF8jaRTRhtgs+ogaKF2DC+zVTHsBSMXlglJxwOUbXcL9lWflljkX
         6KfKCNfEQStvgFazHyAQPvwEwdraYhzK2rbZqcjs1vNGixoX0SNVtfG66zJhm6GY+Bmc
         wqhvctH59gfVvpindruMPmA5tlUDhZy73YOAfZmGRYdlUal/Y5NLjxSVGhU6sspPlfv3
         VXZx2fydUrIe5fBmo4y/LnebtD6cuZS2TjoCE3cCwNVvOnbJNWTkCjKpy5ouRX1uGyIk
         YLeysm/TDe3eMv8YGQ1TV5lrD2aaFZubI3aeU2fnqCotCs3YX5FpCN/+yS7dJYxQX0AW
         5eKg==
X-Gm-Message-State: AHQUAuYHXA0evhYn4LJcJrnalTO7FhpgO5Q/7wPbB3h7UXLEchIfklrd
        jelYnVWc/uzVHYqiIY7cOoghSX8mmnzwTEZ7gS74DbPlaB8=
X-Google-Smtp-Source: AHgI3IbB1JfVINJ/4qezCMgpCXnT1GW9wgtIgvFBsjcM3uFUpdzZLhj8lJ988KDbA8gsutfmVQgnK5ayEE7+udWoNkY=
X-Received: by 2002:a6b:ec19:: with SMTP id c25mr1568898ioh.169.1549968443280;
 Tue, 12 Feb 2019 02:47:23 -0800 (PST)
MIME-Version: 1.0
References: <20190208115045.13256-1-szeder.dev@gmail.com> <20190211195803.1682-1-szeder.dev@gmail.com>
 <20190211234626.GA13301@sigill.intra.peff.net> <20190212003018.GA1622@szeder.dev>
 <20190212003446.GF13301@sigill.intra.peff.net>
In-Reply-To: <20190212003446.GF13301@sigill.intra.peff.net>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Tue, 12 Feb 2019 02:47:12 -0800
Message-ID: <CAPUEspg+j+9mm_UX=rNAn-3dmXWNq_Wh3zHjE-PkGfo34405jg@mail.gmail.com>
Subject: Re: [PATCH] test-lib: fix non-portable pattern bracket expressions
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 11, 2019 at 4:35 PM Jeff King <peff@peff.net> wrote:
>
> Ah, doubly puzzling. It works fine in my Debian dash (but fnmatch was
> enabled in 0.5.8-1 there, too).

FWIW, it is reported by both checkbashisms and shellcheck if "linting"
could be considered of help to track these kind of issues.

other "portability" issues seem safe, mainly because they are either silly
(like the use of local) or meant to be used only with bash (as on the mingw
specific functions or the bash version check that was broken recently for
NetBSD) but the functions run_with_limited_{cmdline,stack} that use `ulimit -s`
might be worth looking into

Carlo
