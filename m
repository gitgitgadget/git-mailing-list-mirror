Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8369F2022A
	for <e@80x24.org>; Tue,  8 Nov 2016 23:23:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751914AbcKHXXO (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:23:14 -0500
Received: from mail-yb0-f195.google.com ([209.85.213.195]:35736 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbcKHXXN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:23:13 -0500
Received: by mail-yb0-f195.google.com with SMTP id d59so3552787ybi.2
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7JNBQrDU6Tg1LJrOyOwPAxoC+0iK1muT/T6CgXZY5Nc=;
        b=mWK6EmyjphyQTbkNZ9im7Q6CXljJcTfPab2Q36Zc6xtw+3Wgu5irk1wiaNu5p+hdE5
         w16VSluMmvoHGYz1NJCgOCFzTZnP7ylxyMBm9tA9OPNq8vsx3k4kNOXpPIZfhuO6anPl
         GwlEBzP8meV03vumGsv+28D9Cl6b2PpgUTv8L0hF0iA6RvoP1oOZF6hnoQ1n0r3/LK9T
         96fQyoyz0dab6d2bl0deTxHz247WUA2djS1wYXG1pUg0b4m+PXLHoFZfVdIW1IGVY2ir
         oM4mp27zmftuq+6PKK9H5iJTqcWsSPuluGNxF6DioLky5g/2Uc3iDblUpmvt/5Obrm6K
         JrDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7JNBQrDU6Tg1LJrOyOwPAxoC+0iK1muT/T6CgXZY5Nc=;
        b=IYLn6/p7S6OTCBqgtu7iBFpiWeIADvwDxp76e+emQiB0Uve5yJLtZzi7dYJMLbfSBo
         EBANim+nz/GkmyxPEz4HVUTvKJD56+j7LYxFoRSxmcsxT73NE30+4SDf0vXhbJcabNxA
         B5kGV+PfUPsHFCDDsGmYinwIXLVpv0Y6i+YHJ78f3gi5vmEEiyZenPVZkyG/DrDVASta
         xFJleTWN0knG69vyL+1Ac3Lt/FTQ6QUuF7PMxi8gloWD45QCx0e6cjfZ82RfG+A9FUyt
         Hw+ICQ5xIr0EHBOOOVPmmM0CMtmBIXAyiFM+pvpgG1TOUij3U/DCUGlMwAfzL4aFYBY/
         ncgA==
X-Gm-Message-State: ABUngvcEFLSJFfvq66jRV9UWGbXNPIv8S/PKDZqwH4C7PJFJjruR2H7z/VAKinEsO+qvE4e6dM71k4zfk4+7Ig==
X-Received: by 10.37.53.213 with SMTP id c204mr15152898yba.57.1478647392514;
 Tue, 08 Nov 2016 15:23:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:22:52 -0800 (PST)
In-Reply-To: <20161108201211.25213-4-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-4-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:22:52 -0800
Message-ID: <CA+P7+xoavgQ=NK8GGGXf90ESuPs+mFwHzEWbsnjWjZ4V7TWpjw@mail.gmail.com>
Subject: Re: [PATCH v7 03/17] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:11 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Implement %(if:equals=<string>) wherein the if condition is only
> satisfied if the value obtained between the %(if:...) and %(then) atom
> is the same as the given '<string>'.
>
> Similarly, implement (if:notequals=<string>) wherein the if condition
> is only satisfied if the value obtained between the %(if:...) and
> %(then) atom is differnt from the given '<string>'.
>
> This is done by introducing 'if_atom_parser()' which parses the given
> %(if) atom and then stores the data in used_atom which is later passed
> on to the used_atom of the %(then) atom, so that it can do the required
> comparisons.
>

Ok. How does this handle whitespace? The previous if implementation
treated whitespace as trimming to ignore. Does this require an exact
whitespace match? It appears by the code that strings must match
exactly. Would it make more sense to always trim the value of
whitespace first before comparison? Hmm.. I think we should avoid
doing that actually.

Otherwise this looks good. I might have implemented the storage as one
value and then a boolean indicating whether to check for equality or
inequality. But I think the current implementation is ok too, and is a
bit more elegant on the code savings.

Thanks,
Jake

> Add tests and Documentation for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  3 +++
>  ref-filter.c                       | 43 +++++++++++++++++++++++++++++++++-----
>  t/t6302-for-each-ref-filter.sh     | 18 ++++++++++++++++
>  3 files changed, 59 insertions(+), 5 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index fed8126..b7b8560 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -155,6 +155,9 @@ if::
>         evaluating the string before %(then), this is useful when we
>         use the %(HEAD) atom which prints either "*" or " " and we
>         want to apply the 'if' condition only on the 'HEAD' ref.
> +       Append ":equals=<string>" or ":notequals=<string>" to compare
> +       the value between the %(if:...) and %(then) atoms with the
> +       given string.
>

This seems to imply that it does not ignore whitespace. Ok.

>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
> diff --git a/ref-filter.c b/ref-filter.c
> index 8392303..44481c3 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -22,6 +22,8 @@ struct align {
>  };
>
>  struct if_then_else {
> +       const char *if_equals,
> +               *not_equals;

Ok so we add both if_equals and not_equals values. Could we re-use the
same string?

>         unsigned int then_atom_seen : 1,
>                 else_atom_seen : 1,
>                 condition_satisfied : 1;
> @@ -49,6 +51,10 @@ static struct used_atom {
>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>                         unsigned int nlines;
>                 } contents;
> +               struct {
> +                       const char *if_equals,
> +                               *not_equals;


Same here, why do we need both strings here stored separately? Could
we instead store which state to check and store the string once? I'm
not sure that really buys us any storage.

> +               } if_then_else;
>                 enum { O_FULL, O_SHORT } objectname;
>         } u;
>  } *used_atom;
> @@ -169,6 +175,19 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
>         string_list_clear(&params, 0);
>  }
>
> +static void if_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +       if (!arg)
> +               return;
> +       else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.if_equals))
> +                ;
> +       else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.not_equals))
> +               ;

Ok so we can't ever have if_equals or not_equals at the same time.

> +       else
> +               die(_("unrecognized %%(if) argument: %s"), arg);
> +}
> +
> +
>  static struct {
>         const char *name;
>         cmp_type cmp_type;
> @@ -209,7 +228,7 @@ static struct {
>         { "color", FIELD_STR, color_atom_parser },
>         { "align", FIELD_STR, align_atom_parser },
>         { "end" },
> -       { "if" },
> +       { "if", FIELD_STR, if_atom_parser },
>         { "then" },
>         { "else" },
>  };
> @@ -410,6 +429,9 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
>         struct ref_formatting_stack *new;
>         struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
>
> +       if_then_else->if_equals = atomv->atom->u.if_then_else.if_equals;
> +       if_then_else->not_equals = atomv->atom->u.if_then_else.not_equals;
> +
>         push_stack_element(&state->stack);
>         new = state->stack;
>         new->at_end = if_then_else_handler;
> @@ -441,10 +463,17 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
>                 die(_("format: %%(then) atom used after %%(else)"));
>         if_then_else->then_atom_seen = 1;
>         /*
> -        * If there exists non-empty string between the 'if' and
> -        * 'then' atom then the 'if' condition is satisfied.
> +        * If the 'equals' or 'notequals' attribute is used then
> +        * perform the required comparison. If not, only non-empty
> +        * strings satisfy the 'if' condition.
>          */
> -       if (cur->output.len && !is_empty(cur->output.buf))
> +       if (if_then_else->if_equals) {
> +               if (!strcmp(if_then_else->if_equals, cur->output.buf))
> +                       if_then_else->condition_satisfied = 1;

Ok so if somehow we end up with both set, if_equals takes precedence.
I think I can be ok with the way we handle this.

> +       } else  if (if_then_else->not_equals) {
> +               if (strcmp(if_then_else->not_equals, cur->output.buf))
> +                       if_then_else->condition_satisfied = 1;
> +       } else if (cur->output.len && !is_empty(cur->output.buf))
>                 if_then_else->condition_satisfied = 1;
>         strbuf_reset(&cur->output);
>  }
> @@ -1137,7 +1166,11 @@ static void populate_value(struct ref_array_item *ref)
>                 } else if (!strcmp(name, "end")) {
>                         v->handler = end_atom_handler;
>                         continue;
> -               } else if (!strcmp(name, "if")) {
> +               } else if (starts_with(name, "if")) {
> +                       const char *s;
> +
> +                       if (skip_prefix(name, "if:", &s))
> +                               v->s = xstrdup(s);
>                         v->handler = if_atom_handler;
>                         continue;
>                 } else if (!strcmp(name, "then")) {
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index fed3013..a09a1a4 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -403,4 +403,22 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'check %(if:equals=<string>)' '
> +       git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
> +       cat >expect <<-\EOF &&
> +       Found master
> +       Not master
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'check %(if:notequals=<string>)' '
> +       git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
> +       cat >expect <<-\EOF &&
> +       Found master
> +       Not master
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.10.2
>
