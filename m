Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62C941F597
	for <e@80x24.org>; Mon, 23 Jul 2018 12:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388090AbeGWN5e (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 09:57:34 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38466 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387898AbeGWN5e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 09:57:34 -0400
Received: by mail-lf1-f67.google.com with SMTP id a4-v6so392652lff.5
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 05:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FbcimXtonw/KtYwCTuoj6BqZqdVpmp3RC8xP3WP/vA0=;
        b=mIdyZQ9AoLktAsCpL42h8zj/rn4IVaXLXSotYL9hpxpa7x+y5D9SkIA12ekd56BHKe
         pGzBpfcDwkOxtPQ6783lNhzqKpanWKezPKCBDNb611CiyRUuu7BUgCyGnIkUzZn9aMzt
         MuyvtVLT1CKLVeQjgRKj4cxmr7LsjBJ7weGR9VPS7QLIMO5mC1SutER/lrHE06KCy7Nq
         UnAFxIO/sY9XDrcvRl8pekwvamPUKvbG/ZOJljUOenFdpbmskWnVAs0fxlZm8RR4wJOu
         mCGzTVkZAR7Wi1YO3Df0Sd39pbYqY0+8WTn32LzzG4T9Q5iqFkDxOcHt0U05LTXTLnwc
         8VOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FbcimXtonw/KtYwCTuoj6BqZqdVpmp3RC8xP3WP/vA0=;
        b=DOwmieZbkdoYYkdKDWu4luyjMiFv9sU1SAs5L2mACWhRVWj/PY6OsZDAzoXP5YMsiq
         pEqeJxyNjMxMrAZYPZhmduCEVJCY+/6ZgvISG6o+XhQgKLMap2Fv4PsbHNCyqQYcLN2R
         dXbent59sbhEpyUnwamJK/9JF/aJ/RbWMpjkbl5cLyyYzjRX9YRPPueuC8hTIeoyvOL7
         b6Qdtbtv0rHH+NrkHGWIKqWZIvJwJdfbTA6GDeyKWMldV1GEWtC4tGZ7KVx/0w2wwSwW
         d4FMeY5S4RgWv5zBxzAybBKa03VaPWy4FaiDrVIpDxn5c2qW1VynmQxWQGx+eycyqWV8
         5gWQ==
X-Gm-Message-State: AOUpUlGrd4/87Wz7GRpCFqYC5jKo/uQq5MrC61PX7/yYuYEGZ3jm1AD+
        piqn6yq1hNfpU6UheFlI79smUM1Z0asXPQYhfrzTIQ==
X-Google-Smtp-Source: AAOMgpdYBQ9lxHRljDDi3jHtKYx95/sYgt8km3Z8AU/TY7AjNBSIV+30Z+ET8jeHM82YDes5O1iWOXDlzw+IzdCzl3Y=
X-Received: by 2002:a19:a04c:: with SMTP id j73-v6mr7708387lfe.123.1532350585910;
 Mon, 23 Jul 2018 05:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <a7e0bcd5-5bef-097e-f032-d152d51515aa@gmail.com>
 <20180619114143.206568-1-dstolee@microsoft.com> <CACsJy8AkUyU+yECMSoNUm=SSNn+zXN5QbWEvYjkcngp0PzJ9PA@mail.gmail.com>
 <d5511564-ef51-7e6c-521d-b9ccc2af1773@gmail.com>
In-Reply-To: <d5511564-ef51-7e6c-521d-b9ccc2af1773@gmail.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 23 Jul 2018 14:56:14 +0200
Message-ID: <CAM0VKj=CuhY1VB6Hepe0an5pJvTufinewZrLkR2ofHc=HU962A@mail.gmail.com>
Subject: Re: [PATCH 01/15] contrib: add cocci script to replace index compat macros
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 5:21 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/19/2018 10:51 AM, Duy Nguyen wrote:

> > Do we run 'make coccicheck'
> > automatically somewhere? If true, I need to move this script elsewhere
> > because it's meant to run manually. You run it when you intend to do
> > more manual fixups afterwards. For builtin/, I think I'll wait until
> > 'struct repository *' conversion is complete then maybe fix them one
> > by one.
>
> I don't think it is part of the CI runs, but some community members run
> this themselves on 'next' and 'master'.

Travis CI does run 'make coccicheck' already, that's the
"StaticAnalysis" build job.

Alas, it's not particularly useful as it is, because Coccinelle's and
in turn 'make coccicheck's exit code only indicates that Coccinelle
managed to finish its analysis without any errors (e.g. no unknown
--options, no missing files, no syntax errors in the semantic patches,
etc.), but it doesn't indicate whether it found any undesired code
patterns to transform or not.

I have been sitting on two patches implementing two different
approaches to improve this situation for several months now (sorry :)
I think I'll just pick the shorter-simpler of the two, and submit it
shortly.
