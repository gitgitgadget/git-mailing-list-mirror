Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E41BE20248
	for <e@80x24.org>; Sun, 17 Mar 2019 13:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726850AbfCQNYn (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 09:24:43 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:37597 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfCQNYn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 09:24:43 -0400
Received: by mail-it1-f194.google.com with SMTP id z124so17433582itc.2
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 06:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h2Jz8UjJqV6zyKQk0TYqJxUh1CI/gEJpBak9tiEtacE=;
        b=sMy3Y3iLVbSuiC6QpHQGplj4QD4YM+zMcFbAvRRDp55kTDh1ligTrfWJ1JHN0J7ifX
         UHBmxweAPqr2xJQOqJ59IuV9eJ0i8WnrsBW+Pt4AO0cmyOhrRI68lTKv0Lz3PqUJjuYk
         euwrawFt5+a35yxQ2KdnwvnewMQYQwIohH61GrqRE5/kKrNpCQjcv7fXTsFRf4/B40vR
         /wtrR0v6FidxkiVpaTp+vCs2V3ZxdadGaz97LVDGwr/UTrH1t9vpf9t6BXrsLEVYeBBA
         6DJOEp4Io3Nu3yRdeIaY7dECSvFNMc9mDyOYij1j+DTAJCM8ZmnEx90x58hzGxnx9yaz
         w/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h2Jz8UjJqV6zyKQk0TYqJxUh1CI/gEJpBak9tiEtacE=;
        b=AEpfvzjvtilWXORNdgMg+SKS23/a4RT68MnubqVSXYscPwRqhi4ZXvQ1kHys24breo
         QJExTt40WaKzX8/X94296NbEwg+59YN+vsISr2kW09vYR2GCu+6sMuX7puMKhlfC98Bh
         PsGw2JOeNX201fB1Up8iJ5mal+AS31azYaocZlRESMnV4wBP31pxXP+s2Hj9iku5gC0g
         /uipH4g8j9NhYtU/jP5MNeoDJ6MDEi8CWs6bnTbNLbgjWgp/+TYs18VskwmY5qPfEtqb
         YALZxBGcEFrQL2Jt6rtBP2Iv8BlfAqZlqdJmCUq1gSt6vgE40NdZFYuY/iyGp+PlY4u9
         u9Sg==
X-Gm-Message-State: APjAAAXxyfASlRbCpK9YnXIE6j5WshPKrjeFN6X0VIK+guH0Irvggzi3
        PYgLNT3tdQcUonVGu3YNQRUBETi3cgaJCk9Q1gE=
X-Google-Smtp-Source: APXvYqzrgbBdwcxXjUNqrdPMN+eVHmdBsMMoyY3FggoN0MTtIKX5QXj75M1NiNbUDgxxgyRYhjc5tBx+Bj8rtKuRatQ=
X-Received: by 2002:a24:ccc5:: with SMTP id x188mr7748452itf.123.1552829082346;
 Sun, 17 Mar 2019 06:24:42 -0700 (PDT)
MIME-Version: 1.0
References: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
In-Reply-To: <bc7c3f9d769b2d5a108ff4cdc3c7277e112fdb56.1552820745.git.liu.denton@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sun, 17 Mar 2019 20:24:16 +0700
Message-ID: <CACsJy8DU02_kOqAHhU5EgMHKmkNSGdvt+7XzSHoZDB+b9sDRqg@mail.gmail.com>
Subject: Re: [PATCH] git-diff.txt: prefer not using <commit>..<commit>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 17, 2019 at 6:09 PM Denton Liu <liu.denton@gmail.com> wrote:
>
> The documentation used to consider
>
>         git diff <commit> <commit>
>
> and
>
>         git diff <commit>..<commit>
>
> to be equal counterparts. However, rev-list-ish commands also use the
> <commit>..<commit> notation, but in a logically conflicting manner which
> was confusing for some users (including me!).
>
> Deprecating the notation entirely is not really an option because it
> would be an arduous process without much end-value. In addition, there
> are some valid use-cases that we don't want to break.
>
> Document the preference of the first form so that future confusion can
> be minimised.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Thanks all on your feedback on the discussion thread[1]! I opted for
> just the documentation-only route so we don't break any valid use-cases.
>
> [1]: https://public-inbox.org/git/20190311093751.GA31092@archbookpro.localdomain/
>
>  Documentation/git-diff.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
> index 72179d993c..10c7a2220c 100644
> --- a/Documentation/git-diff.txt
> +++ b/Documentation/git-diff.txt
> @@ -63,7 +63,11 @@ two blob objects, or changes between two files on disk.
>
>  'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
>
> -       This is synonymous to the previous form.  If <commit> on
> +       This is synonymous to the previous form.  However,
> +       users should prefer the previous form over this form
> +       as this form may be more confusing due to the same
> +       notation having a logically conflicting meaning in
> +       linkgit:git-rev-list[1]-ish commands.  If <commit> on
>         one side is omitted, it will have the same effect as
>         using HEAD instead.

This is fine as-is. But another option to reduce even more exposure of
these forms (both <commit>..[<commit>] and <commit>...[<commit>]) is
to delete these forms in "DESCRIPTION" section and add maybe "EXOTIC
SYNTAX" (or something) section after "OPTIONS" for just them.

> --
> 2.21.0.512.g57bf1b23e1
>


-- 
Duy
