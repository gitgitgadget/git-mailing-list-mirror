Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8446B1F404
	for <e@80x24.org>; Tue, 20 Mar 2018 18:18:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeCTSSo (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:18:44 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:41165 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751448AbeCTSSn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:18:43 -0400
Received: by mail-qt0-f175.google.com with SMTP id j4so2625563qth.8
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:18:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=sdo6VcmQ+tgZGs9Vq3Ae16iK4LRIWdGKyQ/C9DqQceE=;
        b=aFFCt+nRnvyWmGnaerGfIa53uCvndQXzHL/no+UAcyiCpFBageBtSRfMIaH0Yemr4W
         kRzws8Ox4iGukhAdiuQ2fSSLxopU0YP+sxK+3U7wPnQytANeh67zTX/ldWd7K9kydZYu
         CfuZPH8A11X6cQ4rMORmGAa0s3HOxTZVMMfKJDp+Nx4K7Rgdzy/aulfpun4OhKjcoQ83
         RXyN98qIAo/BtQRC9UMz7X47/TePBTAmfTjLmt00PLEhNt5R99qkp2kSfJ5pP7VgQkdB
         D6okXseM1h2VkAA+At/F/Zp3Ksoh9NK04LPDd+nEnxyVGmUe3otxrFNmbjH0RuVRU3l/
         Mcww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=sdo6VcmQ+tgZGs9Vq3Ae16iK4LRIWdGKyQ/C9DqQceE=;
        b=ZtJCa3f81QLATMI0iSIlsjhrccyzCFYr3K3+CDMsrUKOGsYaC1/PEbM0yhGSK5KSjg
         /x3m0JeeZSMrpc1PB/WUfEioX3PhmcESvVV1Yt0+lQH6v6qDvDwACqnk+FaJPKWyG96m
         NoT2cp36HStaGdqm0z9JoUDM8PV1iFK2sXa8A5ZheDv+MGkhMlSRn98VTDxjCIuECrPo
         X1u0PngWZU/2UbLXBZQJZUeYywfNN8cto3KEKSZeLNyB7CUX+zncHtAfWYt72sD+SDHO
         q016BmF4rrQdh30fJVF2RbvnJ4yPrb+ZqLeuCCMY77A4v/3sqFOGsRaCFsHW7ltaD8gc
         x8ag==
X-Gm-Message-State: AElRT7FoOzvg7lZkLT2Vz7BpCDbkYx4sP7Wwx/M7f1zSAvN9nCSs0Bzq
        +DdpX6MYWOvm6f/1fY5ZKlGo4zTQNiq9/MjIvpwZZA==
X-Google-Smtp-Source: AG47ELsuFSqo+CcHtYQVfY8BCVQjUBaWcbZvTk6h8s4AjqCtntHOIdZLwDZ3h8+n6w/A9gS4E9ME0QKAs+kgkFUC4wk=
X-Received: by 10.200.1.2 with SMTP id e2mr20569058qtg.121.1521569922663; Tue,
 20 Mar 2018 11:18:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Tue, 20 Mar 2018 11:18:42 -0700 (PDT)
In-Reply-To: <010201624428190c-441272b2-bc7d-42af-82f8-6a805bb27f6c-000000@eu-west-1.amazonses.com>
References: <01020162442818b4-c153f9ce-3813-41a6-aebd-f5cb2b98b1fa-000000@eu-west-1.amazonses.com>
 <010201624428190c-441272b2-bc7d-42af-82f8-6a805bb27f6c-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 20 Mar 2018 14:18:42 -0400
X-Google-Sender-Auth: q9JcMG15Pj-b9fGdCB9WEzZOjFU
Message-ID: <CAPig+cT5jh0y9Rmw0E6ns0k5mSwaxAqdaN8oWCayCE8V+jYZow@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] ref-filter: add return value && strbuf to handlers
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 20, 2018 at 12:05 PM, Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
> Continue removing die() calls from ref-filter formatting logic,
> so that it could be used by other commands.
> [...]
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> @@ -596,19 +603,24 @@ static int is_empty(const char *s)
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

This pattern of transforming:

    if (cond)
        die("...");

to:

    if (cond) {
        strbuf_add*(...);
        return -1;
    }

is repeated many, many times throughout this patch series and makes
for quite noisy diffs. Such repetition and noise suggests that this
patch series (and other similar ones) could benefit from a convenience
function similar to the existing error() function. For instance:

    int strbuf_error(struct strbuf *buf, const char *fmt, ...);

which appends the formatted message to 'buf' and unconditionally
returns -1. Thus, the above transformation simplifies to:

    if (cond)
        return strbuf_error(&err, "...", ...);

which makes for a much less noisy diff, thus is easier to review.

A new patch introducing such a function at the head of this patch
series might be welcome.
