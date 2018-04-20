Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAF31F424
	for <e@80x24.org>; Fri, 20 Apr 2018 07:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753627AbeDTHIo (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 03:08:44 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35624 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753532AbeDTHIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 03:08:43 -0400
Received: by mail-qt0-f194.google.com with SMTP id s2-v6so8539817qti.2
        for <git@vger.kernel.org>; Fri, 20 Apr 2018 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Vq2pvNlaGNy7FkPQK7Tlj7AH0EA8JfnPjlGOvo8uphw=;
        b=Ga0RLPbZISyyJqzfmZ8R7TwBR5xhuZkJEKN/29yKNcyLYmFNUzyCaIxaTi7goWMpRz
         bsSG3sA0asW6ZmGhRkP9Bbmau7FQvN/S6dIVjRjBaomA7N8pnzZMbN41ZvjiSTgbdL25
         TCItFnI9Sq+LX1hrwHAhkklbne2csPvdNytyoDNR9rmnYFoioYLlW400gwWxsHhsrFVd
         54T4Dsg7UmNq70EHXH3JnVJ8NtuE/FZ8sO8LJpQ0c80UnMW/hhdFO6Vo+pct8nR2IGAp
         s1MP6YvK2XF2PkTKIUgwEj9TuWlWbnh5nAaQuDXtyYIiNr8l8SJOuH1wqW4s6elIxAWC
         KbOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Vq2pvNlaGNy7FkPQK7Tlj7AH0EA8JfnPjlGOvo8uphw=;
        b=CetDxdsVCTXBGb4rbxWm1jtDMlHzNoafi7OXeaIaA97PsCybr//6M8BZ24oXZIh/so
         Eyepwe4ZMA8Cx3VovO1Q3M5lYnB0OYl/XBeXl1yStDYsowkuOYcq3CkwZnWaCDaKlmUZ
         KkyB1ZTAGBTFg3EQ6wSvkSJIFNBt3ie7zwOaVfc+jgQHIHha49wVwEJF7lUZ3o/lXdrG
         2w5my2kdeWQ1saFURLSJVGRJMTklzbbWSEWztTEGbZB5miV18XihCR/Ug7ZWRC0qTP8j
         NuEViDd5mFQPNzprwbMy4aD46PyUB+SkueN+CTnF8KzGh3EdZcz30CGWjUl81sFrPRBg
         crCA==
X-Gm-Message-State: ALQs6tBItC6NDkOAm0io4MhpWSRHKmju3q/ufAd5qOQ/ZVuuW5vbzeLi
        LT/+YEVVKXc+J8ZFWIbOByvUvUJhQ5N2CSEKQ4A=
X-Google-Smtp-Source: AB8JxZqsVRzm2xcbSsx6mVUtgY9UoPYqGRmAivRjXPeAyiy9DkSSHAaNFY7ldibQ1vtcbmyic1ZS1fLtE0f7TuwHrZQ=
X-Received: by 2002:aed:26a4:: with SMTP id q33-v6mr9310326qtd.165.1524208122710;
 Fri, 20 Apr 2018 00:08:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.174.202 with HTTP; Fri, 20 Apr 2018 00:08:42 -0700 (PDT)
In-Reply-To: <20180418030655.19378-2-sxlijin@gmail.com>
References: <20180418030655.19378-1-sxlijin@gmail.com> <20180418030655.19378-2-sxlijin@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 20 Apr 2018 03:08:42 -0400
X-Google-Sender-Auth: klRPthZW8kxEbBrRc57ldki-FLQ
Message-ID: <CAPig+cQp8c8v5cfaWqPNajcTdxYEj-FrOHykjOi+RAbEa4-VzQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] commit: fix --short and --porcelain
To:     Samuel Lijin <sxlijin@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 17, 2018 at 11:06 PM, Samuel Lijin <sxlijin@gmail.com> wrote:
> Make invoking `git commit` with `--short` or `--porcelain` return status
> code zero when there is something to commit.
>
> Mark the commitable flag in the wt_status object in the call to
> `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
> and simplify the logic in the latter function to take advantage of the
> logic shifted to the former.
>
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
> diff --git a/wt-status.c b/wt-status.c
> @@ -754,26 +770,25 @@ static void wt_longstatus_print_unmerged(struct wt_status *s)
>  static void wt_longstatus_print_updated(struct wt_status *s)
>  {
> -       int shown_header = 0;
> -       int i;
> +       if (!s->commitable) {
> +               return;
> +       }
> +
> +       wt_longstatus_print_cached_header(s);
>
> +       int i;
>         for (i = 0; i < s->change.nr; i++) {

Declaration after statement: Declare 'i' at the top of the function as
it was before this patch.
