Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7EC1FAE3
	for <e@80x24.org>; Tue, 13 Mar 2018 19:13:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752143AbeCMTNq (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:13:46 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44639 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeCMTNp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:13:45 -0400
Received: by mail-pl0-f68.google.com with SMTP id 9-v6so358508ple.11
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=a9t7y5G1TbSaaZwu5irpscAkpmsrbHmIP7QbaOQFOE0=;
        b=PWUb82fmaAIwtNcSGDfmqCIIcCWae7IZSnEwwwQLk5fNG+LqOv5/RQ6P5wfGS5wAvV
         QK/2FDehb1reAm3XXAIEgPtSyCsO7vtzlN8nURNlBKL80jh0aNU48+f+zUc5MF3U6NZm
         np3kKbBIh2DsUGPmi23p3oKtBcB1OA/KatRK4MdybVe/uKd9tmjnDKR3syyUAEMmHHG1
         RTRr5SsUUIDcYePX63kkzqm9IaftAo+7IPVb2Q9H9Wx6ZLEwNYQ/4+regHuf/cldlH+a
         bdIwDwlte47F4OMo+pXoBI92Z8ydAK1rhjNCxy8Lev5ahpHkrwDL0oi5BKoruNoCjVK2
         Cj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=a9t7y5G1TbSaaZwu5irpscAkpmsrbHmIP7QbaOQFOE0=;
        b=p9QQMRXxdwmr1URNBeHZRBccy/Q//ac+NV/F5YieXPt8+nq7zkj21IfVHbPNWnu8lX
         X0FFoUXDTQJtv0uvom9Xe4RnosZi0yVn3cWtXkYQzZKQMCVsyxQz9MzRn2l8lUaQYs0u
         XtOlItRF5GgDxeCAVpLYMfOdwPGk/6NnYQl4CjXnSxazLQGLCJvsLgCYzVX5NDfZNx2P
         kOGWcUVeR9F+fisVSONSH06L2nU+prKAlqUJJkEBPSZGxa6/swnQ4sjYAT3JRL3g49wh
         7fQGwwMjcW4ubmHxaYK6pMVTQxR4Kad/82iseOaxivaC8EEOu4x7jbi8LivQH7gN+QAI
         crQg==
X-Gm-Message-State: AElRT7GOAdc03we8hD1GDkyYYjFj/d3BVaSjHEVpLUM1z0J07E5vhrKi
        yd+uvBznzR1htXySicmHvfieYgBuBhpaSWC5vMSPqA==
X-Google-Smtp-Source: AG47ELsh0csTNPFhSXCQf4o3w8AmFU5iTYbax5SppXvVKWLJlgdItZcf10iqjDf5wR4KPyczNUrmDpwF+Ob8OBvBW90=
X-Received: by 2002:a17:902:ab89:: with SMTP id f9-v6mr1496097plr.369.1520968424741;
 Tue, 13 Mar 2018 12:13:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 13 Mar 2018 12:13:44 -0700 (PDT)
In-Reply-To: <010201621edc9811-4197d53b-2ebd-4543-b316-22b58804c6b4-000000@eu-west-1.amazonses.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
 <010201621edc9811-4197d53b-2ebd-4543-b316-22b58804c6b4-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 20:13:44 +0100
Message-ID: <CAN0heSokC8twry_4_2N42tswZ_vhrDp8svo-MUk-dg-HyQKtQA@mail.gmail.com>
Subject: Re: [RFC 2/4] ref-filter: add return value && strbuf to handlers
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2018 at 11:16, Olga Telezhnaya <olyatelezhnaya@gmail.com> wrote:
> -static void append_atom(struct atom_value *v, struct ref_formatting_state *state)
> +static int append_atom(struct atom_value *v, struct ref_formatting_state *state,
> +                      struct strbuf *err)
>  {
>         /*
>          * Quote formatting is only done when the stack has a single
> @@ -493,6 +495,7 @@ static void append_atom(struct atom_value *v, struct ref_formatting_state *state
>                 quote_formatting(&state->stack->output, v->s, state->quote_style);
>         else
>                 strbuf_addstr(&state->stack->output, v->s);
> +       return 0;
>  }

Maybe "unused_err" instead of "err", to document that we are aware that
"err" is not being used and that it is ok. Something similar is done in
builtin/difftool.c.

> -static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +static int then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state,
> +                            struct strbuf *err)
>  {
>         struct ref_formatting_stack *cur = state->stack;
>         struct if_then_else *if_then_else = NULL;
>
>         if (cur->at_end == if_then_else_handler)
>                 if_then_else = (struct if_then_else *)cur->at_end_data;
> -       if (!if_then_else)
> -               die(_("format: %%(then) atom used without an %%(if) atom"));
> -       if (if_then_else->then_atom_seen)
> -               die(_("format: %%(then) atom used more than once"));
> -       if (if_then_else->else_atom_seen)
> -               die(_("format: %%(then) atom used after %%(else)"));
> +       if (!if_then_else) {
> +               strbuf_addstr(err, _("format: %(then) atom used without an %(if) atom"));
> +               return -1;
> +       } else if (if_then_else->then_atom_seen) {
> +               strbuf_addstr(err, _("format: %(then) atom used more than once"));
> +               return -1;
> +       } else if (if_then_else->else_atom_seen) {
> +               strbuf_addstr(err, _("format: %(then) atom used after %(else)"));
> +               return -1;
> +       }

I slowly start to wonder if we want a function (or macro)
error_strbuf_addstr(), which returns -1. That could probably wait,
though.

Martin
