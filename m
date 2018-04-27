Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EFD8D1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 06:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757379AbeD0GWZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 02:22:25 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:46756 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755199AbeD0GWY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 02:22:24 -0400
Received: by mail-qt0-f194.google.com with SMTP id m16-v6so927562qtg.13
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 23:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=WnV+RkUQLLUYOFD06amc/bJB/8ytxjBPlZroMUC/ZSY=;
        b=rtKTZOlwEY3YHf1p3INlL4rMat5tf6C49YuCjQNukC/AZiGn25B/yyW0Hl88yOOcCN
         6IDsJUi45LiWxfLaxYodPMUNQZ1lX3PdAlG+yNMIFDRfVuzvWIeiogWYBgduvoL3A2AH
         QcimjZuUFtdrwsEdl3UxYqIU8S1vudKDj8oL7/WjK06DENpTYO5ddA/CKd/S7KPJMI4Y
         JMbMkR37h7Mu/JnrHTB0VHr/5l2wjlEQ0+wFhtCHN9zDlgUiijFaahhMVic/rD7sLTvq
         GE5oT1kQ30btpBE+S8gHadKCOwyyNKu+aXWgobXECY7BcefNyGDMpFTvoRxAoCMqCiBh
         oWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=WnV+RkUQLLUYOFD06amc/bJB/8ytxjBPlZroMUC/ZSY=;
        b=MzaP/4Y6s9ba7yJ61959AFkzulVDco+WamwpbBQgfRihzpRr2+ESSvMvUUix4N0JO5
         St4TdlBFI1uhzM8lyux74QsoHh7RCS0zSbyuwDBxS3WY0FM2in8lbBfEsklAaUZ3KLZU
         vRVBDywEfBvzhJ6N5nhU9Hbhto8R+T701Fom1L02PrkqA8L/nBKgKihxXUPfp3yd/eeR
         hpyicKZxUnAwa3eXbi2wYjluSm/JUZwvMrkn6HbF++SGMOufji7nACv6EO1MdfbNRyg+
         00wTeD0YAz6kM+bXPBEhtz9zczFNjoWf13gIdTM7mTDFIu9TcxkLfgSzD/83NvKyxTut
         vffQ==
X-Gm-Message-State: ALQs6tATs1/cFen50EJ6Iayin1L6bP5X4csw/MKgthAqjEQtkNN7t8cC
        fU+r9AnTBUHmsUVPCDYo+6vy55yubHV1+yyHIEY=
X-Google-Smtp-Source: AB8JxZreIDOfobOsSzLb7egYUVMeqg/vxNBgk1pcAVHPxcxTeGuChnpVl3R0rbJZOnf9zIOMeg2925aYHLmku+MVAtA=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr821838qtd.165.1524810143826;
 Thu, 26 Apr 2018 23:22:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.170.75 with HTTP; Thu, 26 Apr 2018 23:22:23 -0700 (PDT)
In-Reply-To: <d9a737fde37e778c637de67e1215960f467c629d.1524722247.git.me@ttaylorr.com>
References: <cover.1524716420.git.me@ttaylorr.com> <cover.1524722247.git.me@ttaylorr.com>
 <d9a737fde37e778c637de67e1215960f467c629d.1524722247.git.me@ttaylorr.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 27 Apr 2018 02:22:23 -0400
X-Google-Sender-Auth: YqaxTdn3nnfFCHTR-t_GDTpPhSc
Message-ID: <CAPig+cQx3RKCyAisVdEiwLpVPEhPRVWJ2rdA8yawZFq1891mwg@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] builtin/config: introduce `color` type specifier
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 1:58 AM, Taylor Blau <me@ttaylorr.com> wrote:
> [...]
> For consistency, let's introduce `--type=color` and encourage its use
> with `--default` together over `--get-color` alone.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> @@ -228,6 +232,8 @@ Valid `<type>`'s include:
>         output it as the ANSI color escape sequence to the standard
>         output.  The optional `default` parameter is used instead, if
>         there is no color configured for `name`.
> ++
> +`--type=color [--default=<default>]` is preferred over `--get-color`.

Rather than augmenting the documentation of --get-color like this, I
wonder if it would instead make more sense to replace it entirely,
like this:

    --get-color name [<default>]
        Deprecated alias for `--type=color [--default=<default>]`.

Not necessarily worth a re-roll; could be done as a follow-up if
someone cares enough.

> diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
> @@ -931,6 +931,36 @@ test_expect_success 'get --expiry-date' '
> +test_expect_success 'get --type=color' '
> +       rm .git/config &&

I would feel more confident about the robustness of this test if it
instead used 'rm -f .git/config', as is already done elsewhere in this
test script.

> +       git config foo.color "red" &&
> +       git config --get --type=color foo.color >actual.raw &&
> +       test_decode_color <actual.raw >actual &&
> +       echo "<RED>" >expect &&
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'set --type=color' '
> +       rm .git/config &&

Ditto.

> +       git config --type=color foo.color "red" &&
> +       test_cmp expect .git/config
> +'
