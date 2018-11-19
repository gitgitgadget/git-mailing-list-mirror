Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89E801F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 19:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbeKTGFS (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 01:05:18 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:40610 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726032AbeKTGFS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 01:05:18 -0500
Received: by mail-it1-f194.google.com with SMTP id h193so8756828ita.5
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 11:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gjBG/2ukPtq2zJLEUyJwQFs/RN+/AfVGC5cLjGC3x90=;
        b=WtQRlM7evlSdYeb2XLVrn6CvevSoHOOlKMlpx71IwGjuvHAvRgP8l/vFqvhIuMDwpw
         EcKBiAn7QlndIboWf5lSMb9WZhzmAGBI0zRfZj9luIO76BiyBW6TWx56lOZKbcJk1JaU
         C2k5ntRBk91JJIHNyrgWN4nViZvrxVjjC+MPVYPxIGYF+CUiMasseiHflYCwYkT7R1Kf
         0Fdm/jsxleMTiWhPAk4SDgVhbGXjFnS7J02T7+mHqyTbPOB8+LELMDFD88dKJWFw2yQk
         YNMWYLNwryhFZlLn7qAlWiVWdpQEbOTlPPBCJEt8wPFwnSj3LVz4PWp6/54LfCi0L6Py
         9F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gjBG/2ukPtq2zJLEUyJwQFs/RN+/AfVGC5cLjGC3x90=;
        b=Tnr6dPZ2ero5n9iWj+jiTDKBUvhdDUUDhtG6dZVcVF82O2J+5NkM+QKGLieEZ5zkGh
         0d17ZGhEcooEegVyhlppSOGihYX6H4Obf9hBf4exvyNhOfIFp0Uj44keq+TTXCYPqxvR
         8jSJLGYEEPZUYkpj2Mx37ph3agRFNVbQ7NiO8/QAFbnn0ecT2PGcuvIpW5g6pWpYTGy+
         qqlmWwyW9V4OfX70dwoAoNE1pklPFDmrUvGyGT53NXpS9LNAfyiLUdRgMWoeaFTleF9v
         IPPmtl9xfmFKsCY48eIJKc7ZSxvfWws2wAu9S2FUhxQDChUvjlHkU6Z/2BozPpOJmGrG
         rsPg==
X-Gm-Message-State: AGRZ1gJU1jIEQVfx3nRQPK9ePE1VJLouUBlUPY5M9fbAa8/iuEkcBJld
        6GpbtM8mfCCu69rNvk6b9uBoxtSTo89zJ8Wv4hc=
X-Google-Smtp-Source: AJdET5e3ve9tdBpWj5OONtqvZwRJZAavPkKxdtDV9R2gdskFBbRcxjFW9XVnDUMyEuhByA5HFRrBIep9tDHzi0L7rFc=
X-Received: by 2002:a24:6e94:: with SMTP id w142-v6mr9374150itc.6.1542656412091;
 Mon, 19 Nov 2018 11:40:12 -0800 (PST)
MIME-Version: 1.0
References: <20180817161645.28249-1-pclouds@gmail.com> <20181119082015.77553-1-carenas@gmail.com>
 <37b7a395-3846-6664-9c4d-66d2e4277618@web.de> <a4d29a9a-5ac0-2952-42bc-5f822d44d055@ramsayjones.plus.com>
In-Reply-To: <a4d29a9a-5ac0-2952-42bc-5f822d44d055@ramsayjones.plus.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 19 Nov 2018 11:39:57 -0800
Message-ID: <CAPUEsphTsPnhMtQxv499-Qyz2_3OUqgXNTw1p3AehuoUv6tKLQ@mail.gmail.com>
Subject: Re: [PATCH v5] clone: report duplicate entries on case-insensitive filesystems
To:     ramsay@ramsayjones.plus.com
Cc:     tboegi@web.de, git@vger.kernel.org, pclouds@gmail.com,
        git@jeffhostetler.com, gitster@pobox.com, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 19, 2018 at 9:23 AM Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:
>     ok 99 # skip colliding file detection (missing !CYGWIN of !MINGW,!CYGWIN,CASE_INSENSITIVE_FS)

you need to enable this specific test first (removing !CYGWIN) so it
doesn't get skipped

Carlo
