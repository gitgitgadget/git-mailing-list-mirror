Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A64D71F404
	for <e@80x24.org>; Tue, 13 Mar 2018 19:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752041AbeCMTMh (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 15:12:37 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:42286 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbeCMTMg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 15:12:36 -0400
Received: by mail-pf0-f196.google.com with SMTP id a16so295008pfn.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hRMAcO0n6vmMrr/ZlWG5vw/eTcg5/6shKyoz+Zo9PGM=;
        b=rbbL4aIkB8Hay0E/tbxz0XjBFV5HJ/aWB6pf3Ygc6t6KTiVVMUP9dYnh3gTnt66X/r
         aq8l5NxoI4uACr4cAzXkE6RAUs+4qoPR7yXZvweL2KzKCU2/zkLgaiY3R0xX0QTL+s5M
         9qaQWcCuP29dNNBMEwhv2aWEonBjfJJ+yaCGSZOtc2dq3QBFcBdJkuGDNhJrSVPDYldP
         0CyiEcVixBtIDpws0IsQkehyzuKbmLzN1hOEECou/vjQpD/Cq2gIzH5u9iMGyMkNLei1
         nHMIitMnCp2PBGnPHXIiRFRjdia1CdCipUTaMpY/z2Q4qgbJH/n+1XmMjcIAPKz0FYjW
         mrcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hRMAcO0n6vmMrr/ZlWG5vw/eTcg5/6shKyoz+Zo9PGM=;
        b=SyaVNaRiSbIKOlWnNllw7FW14kWtwE4G2b5CKwjrwXfveYYUeb5ein4T5l8fwAEJQG
         Ap/vQ1VLwl4r0BaR6LUEbEUZWxFF6Nv/nKJyfFXTY2yb0Iy5k/EpyM+R2Yky49z/hC+/
         jQ3hCjzBRPl/fr3/MBr9EHC/5yjZKXwXXnWzBY8dEEA51ghxa/B2xwwgUONsgvDtLDyO
         e5uq4gaW9oVHH7VoXdWfzq13/3ihUej2n4W00BVdRospu48LjDzy0hvVgOTQ32DVpukb
         jKU9gfun62VRU9jIWxPsHr1zAG0VWmvbYfi4OOHViZg9ZrArVG9s7LH8e6Z2cRYraifm
         S5hg==
X-Gm-Message-State: AElRT7Ga3IgAtVkQ6+dGDpHLe7FZtbDnT3oNL7mknbhww03+zvkqYBVo
        6T5FMMqaac1HtlbDgUOREVrkw4pqPLiheNpvpfY8cg==
X-Google-Smtp-Source: AG47ELt18Z0y77R3Mm9eBbfmmXd19tkn1NhlU4MiowhneDc2eEFTHrEp4RxYntYvpKR9gtfhtrWJ4YLfC0wcsxiSA8c=
X-Received: by 10.98.7.68 with SMTP id b65mr1615002pfd.39.1520968355759; Tue,
 13 Mar 2018 12:12:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.191.144 with HTTP; Tue, 13 Mar 2018 12:12:34 -0700 (PDT)
In-Reply-To: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
References: <010201621edc97a4-a4239b1e-86d2-4400-aaac-d81727710f4f-000000@eu-west-1.amazonses.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 13 Mar 2018 20:12:34 +0100
Message-ID: <CAN0heSoJKxqSb0q5SR2SVfEzh6QjeiNNnESorZyYHTSC71jZuQ@mail.gmail.com>
Subject: Re: [RFC 1/4] ref-filter: start adding strbufs with errors
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13 March 2018 at 11:16, Olga Telezhnaya <olyatelezhnaya@gmail.com> wrote:
> This is a first step in removing any printing from
> ref-filter formatting logic, so that it could be more general.
> Everything would be the same for show_ref_array_item() users.
> But, if you want to deal with errors by your own, you could invoke
> format_ref_array_item(). It means that you need to print everything
> (the result and errors) on your side.
>
> This commit changes signature of format_ref_array_item() by adding
> return value and strbuf parameter for errors, and fixes
> its callers.

Minor nit: Maybe s/fixes its callers/adjusts its callers/. They are not
broken or need to be fixed. They were simply playing the game according
to the old rules, and now they need to learn the new ways. :-)

> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> ---
>  builtin/branch.c |  7 +++++--
>  ref-filter.c     | 17 ++++++++++++-----
>  ref-filter.h     |  7 ++++---
>  3 files changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index 8dcc2ed058be6..f86709ca42d5e 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -391,7 +391,6 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>         struct ref_array array;
>         int maxwidth = 0;
>         const char *remote_prefix = "";
> -       struct strbuf out = STRBUF_INIT;

You move this variable into the loop to reduce its scope. At first I
suspected that this might mean we now start allocating+releasing in each
run of the loop, which might be a performance-regression. But it turns
out, we already did that, so this tightening of the scope has no such
downsides. :-) From the commit message, I wasn't expecting this move,
though. Maybe "While at it, reduce the scope of the out-variable."

>         char *to_free = NULL;
>
>         /*
> @@ -419,7 +418,10 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>         ref_array_sort(sorting, &array);
>
>         for (i = 0; i < array.nr; i++) {
> -               format_ref_array_item(array.items[i], format, &out);
> +               struct strbuf out = STRBUF_INIT;
> +               struct strbuf err = STRBUF_INIT;
> +               if (format_ref_array_item(array.items[i], format, &out, &err))
> +                       die("%s", err.buf);

Using "%s", good.

>                 if (column_active(colopts)) {
>                         assert(!filter->verbose && "--column and --verbose are incompatible");
>                          /* format to a string_list to let print_columns() do its job */
> @@ -428,6 +430,7 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>                         fwrite(out.buf, 1, out.len, stdout);
>                         putchar('\n');
>                 }
> +               strbuf_release(&err);
>                 strbuf_release(&out);
>         }
>
> diff --git a/ref-filter.c b/ref-filter.c
> index 45fc56216aaa8..54fae00bdd410 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2118,9 +2118,10 @@ static void append_literal(const char *cp, const char *ep, struct ref_formatting
>         }
>  }
>
> -void format_ref_array_item(struct ref_array_item *info,
> +int format_ref_array_item(struct ref_array_item *info,
>                            const struct ref_format *format,
> -                          struct strbuf *final_buf)
> +                          struct strbuf *final_buf,
> +                          struct strbuf *error_buf)
>  {
>         const char *cp, *sp, *ep;
>         struct ref_formatting_state state = REF_FORMATTING_STATE_INIT;
> @@ -2148,19 +2149,25 @@ void format_ref_array_item(struct ref_array_item *info,
>                 resetv.s = GIT_COLOR_RESET;
>                 append_atom(&resetv, &state);
>         }
> -       if (state.stack->prev)
> -               die(_("format: %%(end) atom missing"));
> +       if (state.stack->prev) {
> +               strbuf_addstr(error_buf, _("format: %(end) atom missing"));
> +               return -1;
> +       }
>         strbuf_addbuf(final_buf, &state.stack->output);
>         pop_stack_element(&state.stack);
> +       return 0;
>  }
>
>  void show_ref_array_item(struct ref_array_item *info,
>                          const struct ref_format *format)
>  {
>         struct strbuf final_buf = STRBUF_INIT;
> +       struct strbuf error_buf = STRBUF_INIT;
>
> -       format_ref_array_item(info, format, &final_buf);
> +       if (format_ref_array_item(info, format, &final_buf, &error_buf))
> +               die("%s", error_buf.buf);
>         fwrite(final_buf.buf, 1, final_buf.len, stdout);
> +       strbuf_release(&error_buf);

I think this `strbuf_release()` will never actually do anything. If we
get here, we had no error. But it makes sense (to me) to always be clear
about releasing this. In this case it is easy enough.

Possible counterargument: We might want this sort of "error-handling by
strbufs" to follow this simple rule: return an error if and only if you
add some error-string to the buffer. If this rule is universal enough,
it might be ok to skip releasing these sort of buffers if you do not
have an error.

Martin
