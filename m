Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD411F424
	for <e@80x24.org>; Tue, 24 Apr 2018 18:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752532AbeDXS7u (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 14:59:50 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37981 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeDXS7s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 14:59:48 -0400
Received: by mail-ua0-f194.google.com with SMTP id q38so13291474uad.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 11:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ulo6bX+yZraCUvbr/pHwcefXbxORZ8huFEIyIitx02g=;
        b=cuSX2+/DGbSetNZ3QEaF9xlF4/C7D2O827Vw7g/TiVoVanfY45GH76KcsKg/kF1TfS
         x/CPDPeqwK9uOMFKh1Fd2dT7dOSDhLvDmNndiNthsiXd8/xHpTwrJGvmezW53KLv7ygT
         AHxuxf5nvtwr1k8uSHYUifxQc+Qu3BBbP/0cMzQR4LikBUPnmewtwNYoHoiypdYPcwGS
         sCtL/d5bd7CdH9YAnSb9BMMQDQoserQQgu2NfcQJkk+TDwk26crSnltrNS/PRTzl4NlB
         D8kITrLwJIxX/+1unVt0lU3c5fDAr3TZ+zAwqfbAlOXMBJzq8e794weFRSQRdjvk9jhG
         YQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ulo6bX+yZraCUvbr/pHwcefXbxORZ8huFEIyIitx02g=;
        b=SIa1n6fXV/93FxaEVLVFvUXPvDXPSIKC92OGOiXANBYbWL7/xSnzraX0MNU6eo0aju
         njGqjnw/8dvNvXNLIb42yerd8na5DUC4uI3vFxJvXG6XSt0jgciH1cw2KJzlsk+ZBR49
         97gKkI8CeXZgBDrJfVqHfJh5DPJRFPJSQiCSixLY/NhWbiWxndjjlKtQ5O7jqSoBw0SL
         J5X7QIdteP4WFt25s3qY+HihjfDWD1QDSP1i53okBV8VbMoO+3JszgBHvUjL0fd163v0
         OyLVplaA9yhXVp+iHR4VfNbBvISDV+jQVQ3WQY2XeSoq6mWPwvGshXmIr5DwKq5kdCtR
         S95A==
X-Gm-Message-State: ALQs6tCeNfb0UOkjzjKjd+tRYbmPslsRYRh7VekrQY7JSMi1PyIDPsZC
        AsdByDV5aZKBXzJb7Np80TIpu0usqe81vt1pj5Y=
X-Google-Smtp-Source: AIpwx49acxt3olmEtx1aBAC8zKMF9GigU2Ze27uvk97Vbipjlpzy6YUnP2ru1FCo8+90o+68+DKeSYvAKrBp0vUYLyI=
X-Received: by 10.176.24.88 with SMTP id j24mr20238989uag.94.1524596387329;
 Tue, 24 Apr 2018 11:59:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Tue, 24 Apr 2018 11:59:46 -0700 (PDT)
In-Reply-To: <20180424171124.12064-2-benpeart@microsoft.com>
References: <20180420133632.17580-1-benpeart@microsoft.com>
 <20180424171124.12064-1-benpeart@microsoft.com> <20180424171124.12064-2-benpeart@microsoft.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Apr 2018 11:59:46 -0700
Message-ID: <CABPp-BFTywvVFV3Wx1jv9RyoFk_cE7XE8x1neuLVt4qwyw0EMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] merge: Add merge.renames config setting
To:     Ben Peart <Ben.Peart@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "vmiklos@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin@gmx.de" <Johannes.Schindelin@gmx.de>,
        "eckhard.s.maass@googlemail.com" <eckhard.s.maass@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry, I noticed something else I missed on my last reading...

On Tue, Apr 24, 2018 at 10:11 AM, Ben Peart <Ben.Peart@microsoft.com> wrote:
> diff --git a/builtin/merge.c b/builtin/merge.c
> index 8746c5e3e8..3be52cd316 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -424,6 +424,7 @@ static void finish(struct commit *head_commit,
>                 opts.output_format |=
>                         DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
>                 opts.detect_rename = DIFF_DETECT_RENAME;
> +               git_config_get_bool("merge.renames", &opts.detect_rename);
>                 diff_setup_done(&opts);
>                 diff_tree_oid(head, new_head, "", &opts);
>                 diffcore_std(&opts);

Shouldn't this also be turned off if either (a) merge.renames is unset
and diff.renames is false, or (b) the user specifies -Xno-renames?
