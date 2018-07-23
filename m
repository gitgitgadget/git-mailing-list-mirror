Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D58E81F597
	for <e@80x24.org>; Mon, 23 Jul 2018 16:28:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388857AbeGWRam (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 13:30:42 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:53951 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388193AbeGWRam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 13:30:42 -0400
Received: by mail-it0-f66.google.com with SMTP id 72-v6so2404175itw.3
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ENs05SsSA/IYNkrm6JE8/Vp84qFYnXgdcdq7oDwJSR8=;
        b=cWWwehiguqgQVgoysBOz5JAbkU82WmWtjexaNinGkrUDTVlpPsbR8U4x/AP713Xe08
         CHEJag2jDMpca+n4BolKNvg+sEr65Aog6vao22/lZR0zB47+eqyxjd9IV+AQ9EO6n5FS
         gkWEbxT9VianPlrOMAwkrd4z0K+sCwrXI4kcRteoQS22f8ItjQMWV0MQYYGPb1lS1pmJ
         Jb7XPXggxKWB1f6HsjL1bl6t66ePAnE6VHbqvIVbR5zx2ZKPl7YrTosfUs0CpXGzJgq1
         Gddlwrn4MeQayrz7LdjyFgc2BCe9vsVBeBnPYt/Q0nXKiz6PQq9/qnisbbtMA/p7gQBN
         70dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ENs05SsSA/IYNkrm6JE8/Vp84qFYnXgdcdq7oDwJSR8=;
        b=l32OQItBoOPCTfiGrLHyHO8wfxU4LhYcSRAq9x+o6OkOCKr7s1YyjlXQf73dtmFXsG
         HdZ4/FKBbk/BA6hstLZJtFO0csQAh8buC9tJ/HEhjyLNEQN0O88vS1GncADuM1JDm4qp
         WHwRPrEl+TpaNBpIJO0cHoa2MByNhBm4OlDu9JXlCYiWlp4kokELZ9YusKJZaUW/feqd
         wKn5IY3wx4XJs7fRtB6rNFKu4+/MgIOC9xCBFV14imoSbrBlH8Z7yM0ABGUdg4fJIRsC
         +gUDIcBBPDRtl2cqvXJMhKpxQWw2UBIBzcBsTOjlgBjEpUO09fIDTmB0NnMJ+jHR5FLT
         Wl3g==
X-Gm-Message-State: AOUpUlFAaz5UhouNmbuZO3lgZvh85z3/2Bj5wwZwBFEBe4rzzFjBhtO/
        Ar5THSXsCJLAvue9W4VSTruAAHISvBZi1k8+kww=
X-Google-Smtp-Source: AAOMgpee/u/HM9rvEEKFP7zTNsm9M1vMU3lJ8bOtKtgOnm1YTANlDQChQi0aBD0crygC/JH5RhEsNelRHEQ9hEwdv/s=
X-Received: by 2002:a24:b101:: with SMTP id o1-v6mr10416671itf.121.1532363322910;
 Mon, 23 Jul 2018 09:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com> <20180722095717.17912-11-sunshine@sunshineco.com>
In-Reply-To: <20180722095717.17912-11-sunshine@sunshineco.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 23 Jul 2018 18:28:16 +0200
Message-ID: <CACsJy8AOeiKp2JnG0h9mw40TdsNft80vUu573ORtqKMor7B+vw@mail.gmail.com>
Subject: Re: [PATCH 10/14] format-patch: add --range-diff option to embed diff
 in cover letter
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 22, 2018 at 11:58 AM Eric Sunshine <sunshine@sunshineco.com> wrote:
> diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
> index f8a061794d..e7f404be3d 100644
> --- a/Documentation/git-format-patch.txt
> +++ b/Documentation/git-format-patch.txt
> @@ -24,6 +24,7 @@ SYNOPSIS
>                    [--to=<email>] [--cc=<email>]
>                    [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
>                    [--interdiff=<previous>]
> +                  [--range-diff=<previous>]

I wonder if people will use both --interdiff=<rev> and
--range-diff=<rev> often enough to justify a shortcut
"--all-kinds-of-diff=<rev>" so that we don't have to type <previous>
twice. But I guess we don't have to worry about this right now.
-- 
Duy
