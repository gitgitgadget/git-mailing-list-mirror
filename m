Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 804E62022A
	for <e@80x24.org>; Tue,  8 Nov 2016 23:14:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbcKHXN4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:13:56 -0500
Received: from mail-yb0-f194.google.com ([209.85.213.194]:36809 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751244AbcKHXNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:13:54 -0500
Received: by mail-yb0-f194.google.com with SMTP id d128so3922379ybh.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:13:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YfKAQLpjZIG+vZhG/8MXBgSpXrQBrBG/G0PtEaKFcqs=;
        b=m6Fa6CnG9oUW6xdQvZag/vBOIuyQtpa2Ovu5cDaKCIn346Ue4QO6zk8bB03SrKwbXT
         Fb27rgLanTTbDtT/h0wZNVKOp3m5/blmIIG3lGH4X3qyu2k5ibCgXntSjAK/J4kAZgk1
         OHFKAX3/aoPwUQ95CNPGttWhoDK2ANxC1OPAsTiiKi84IPiR0iJ62gRekfbRiONGd2dW
         G+lgLQCclCr/5aeXoSau6Y81HMpJyOXxfhdmsHHeIxLLmWWT2oTPs8FcRsO5CCtEIW/d
         pFA9hfI4v1BePueFdgIEjgTHPaltqVA+qpxbpK3pSbOTkDIR2CASvm+vePO2vS2OPTBc
         xoag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YfKAQLpjZIG+vZhG/8MXBgSpXrQBrBG/G0PtEaKFcqs=;
        b=SaZmx3vYOOmRObTTy4d/l1aHoCRkqv1HIDPSgyc4yt/QWVWLPMaGVFs5h6i/JzJBec
         c3hfWInoq0e9Kj04jYD+77jtAsr37FHuSCTbi9K8SPaScA4l5+EhVAcP6/hYfiFBG8IA
         dtBCyMJYhmkCF6inFK7I8z61SGL1MmHhQs2jkV3ClHtCFL9H2SVCsA0Gp3X/BhLOfDYT
         TnkKtHGK5ihNZuCG6odGu72shVSGqMldL/YA0HYwSVyphXZ/g0Kn7Fku/zPbcjdJdIms
         tOcI+ow98rY0FAmcNno93u4ut2Tebwfc+mUj9GLz0tOoR4oUlgymRHg2KBWsz4IT+9Y/
         icPQ==
X-Gm-Message-State: ABUngvc0oDBDq29JOlhIvU02K81uH9KxfeWEyDNZNU5IterAG/y15kQyBhcpnqqwqmneH5CT0qi+JH1fVTsMnA==
X-Received: by 10.37.53.213 with SMTP id c204mr15117865yba.57.1478646831087;
 Tue, 08 Nov 2016 15:13:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:13:30 -0800 (PST)
In-Reply-To: <20161108201211.25213-2-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-2-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:13:30 -0800
Message-ID: <CA+P7+xoAmYqi0OazZux+rooXW+D_N9L5s+2BzUyJJJXtmLZX-Q@mail.gmail.com>
Subject: Re: [PATCH v7 01/17] ref-filter: implement %(if), %(then), and
 %(else) atoms
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
> Implement %(if), %(then) and %(else) atoms. Used as
> %(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
> format string between %(if) and %(then) expands to an empty string, or
> to only whitespaces, then the whole %(if)...%(end) expands to the string
> following %(then). Otherwise, it expands to the string following
> %(else), if any. Nesting of this construct is possible.
>
> This is in preparation for porting over `git branch -l` to use
> ref-filter APIs for printing.
>
> Add Documentation and tests regarding the same.
>

Ok, so I have only one minor nit, but otherwise this looks quite good
to me. A few comments explaining my understanding, but only one
suggested
change which is really a minor nit and not worth re-rolling just for it.

Thanks,
Jake

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  40 +++++++++++
>  ref-filter.c                       | 133 +++++++++++++++++++++++++++++++++++--
>  t/t6302-for-each-ref-filter.sh     |  76 +++++++++++++++++++++
>  3 files changed, 242 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index f57e69b..fed8126 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -146,6 +146,16 @@ align::
>         quoted, but if nested then only the topmost level performs
>         quoting.
>
> +if::
> +       Used as %(if)...%(then)...(%end) or
> +       %(if)...%(then)...%(else)...%(end).  If there is an atom with
> +       value or string literal after the %(if) then everything after
> +       the %(then) is printed, else if the %(else) atom is used, then
> +       everything after %(else) is printed. We ignore space when
> +       evaluating the string before %(then), this is useful when we
> +       use the %(HEAD) atom which prints either "*" or " " and we
> +       want to apply the 'if' condition only on the 'HEAD' ref.
> +
>  In addition to the above, for commit and tag objects, the header
>  field names (`tree`, `parent`, `object`, `type`, and `tag`) can
>  be used to specify the value in the header field.
> @@ -181,6 +191,20 @@ As a special case for the date-type fields, you may specify a format for
>  the date by adding `:` followed by date format name (see the
>  values the `--date` option to linkgit:git-rev-list[1] takes).
>
> +Some atoms like %(align) and %(if) always require a matching %(end).
> +We call them "opening atoms" and sometimes denote them as %($open).
> +
> +When a scripting language specific quoting is in effect (i.e. one of
> +`--shell`, `--perl`, `--python`, `--tcl` is used), except for opening
> +atoms, replacement from every %(atom) is quoted when and only when it
> +appears at the top-level (that is, when it appears outside
> +%($open)...%(end)).
> +
> +When a scripting language specific quoting is in effect, everything
> +between a top-level opening atom and its matching %(end) is evaluated
> +according to the semantics of the opening atom and its result is
> +quoted.
> +
>

Nice, I like the explanation above.

>  EXAMPLES
>  --------
> @@ -268,6 +292,22 @@ eval=`git for-each-ref --shell --format="$fmt" \
>  eval "$eval"
>  ------------
>
> +
> +An example to show the usage of %(if)...%(then)...%(else)...%(end).
> +This prefixes the current branch with a star.
> +
> +------------
> +git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/
> +------------
> +
> +
> +An example to show the usage of %(if)...%(then)...%(end).
> +This prints the authorname, if present.
> +
> +------------
> +git for-each-ref --format="%(refname)%(if)%(authorname)%(then) %(color:red)Authored by: %(authorname)%(end)"
> +------------
> +
>  SEE ALSO
>  --------
>  linkgit:git-show-ref[1]
> diff --git a/ref-filter.c b/ref-filter.c
> index d4c2931..8c183a0 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -21,6 +21,12 @@ struct align {
>         unsigned int width;
>  };
>
> +struct if_then_else {
> +       unsigned int then_atom_seen : 1,
> +               else_atom_seen : 1,
> +               condition_satisfied : 1;
> +};
> +
>  /*
>   * An atom is a valid field atom listed below, possibly prefixed with
>   * a "*" to denote deref_tag().
> @@ -203,6 +209,9 @@ static struct {
>         { "color", FIELD_STR, color_atom_parser },
>         { "align", FIELD_STR, align_atom_parser },
>         { "end" },
> +       { "if" },
> +       { "then" },
> +       { "else" },
>  };
>
>  #define REF_FORMATTING_STATE_INIT  { 0, NULL }
> @@ -210,7 +219,7 @@ static struct {
>  struct ref_formatting_stack {
>         struct ref_formatting_stack *prev;
>         struct strbuf output;
> -       void (*at_end)(struct ref_formatting_stack *stack);
> +       void (*at_end)(struct ref_formatting_stack **stack);
>         void *at_end_data;
>  };
>
> @@ -343,13 +352,14 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
>         *stack = prev;
>  }
>
> -static void end_align_handler(struct ref_formatting_stack *stack)
> +static void end_align_handler(struct ref_formatting_stack **stack)
>  {

So we now have to pass an array of stacks to the end_align_handler
instead? Ok. But for align this is simple since it just expects a
singleton.

> -       struct align *align = (struct align *)stack->at_end_data;
> +       struct ref_formatting_stack *cur = *stack;
> +       struct align *align = (struct align *)cur->at_end_data;
>         struct strbuf s = STRBUF_INIT;
>
> -       strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
> -       strbuf_swap(&stack->output, &s);
> +       strbuf_utf8_align(&s, align->position, align->width, cur->output.buf);
> +       strbuf_swap(&cur->output, &s);
>         strbuf_release(&s);
>  }
>
> @@ -363,6 +373,103 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
>         new->at_end_data = &atomv->u.align;
>  }
>
> +static void if_then_else_handler(struct ref_formatting_stack **stack)
> +{
> +       struct ref_formatting_stack *cur = *stack;
> +       struct ref_formatting_stack *prev = cur->prev;
> +       struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
> +
> +       if (!if_then_else->then_atom_seen)
> +               die(_("format: %%(if) atom used without a %%(then) atom"));
> +
> +       if (if_then_else->else_atom_seen) {
> +               /*
> +                * There is an %(else) atom: we need to drop one state from the
> +                * stack, either the %(else) branch if the condition is satisfied, or
> +                * the %(then) branch if it isn't.
> +                */
> +               if (if_then_else->condition_satisfied) {
> +                       strbuf_reset(&cur->output);
> +                       pop_stack_element(&cur);

So here, once we have a satisfied condition, we just drop the "else"
element entirely.

> +               } else {
> +                       strbuf_swap(&cur->output, &prev->output);
> +                       strbuf_reset(&cur->output);
> +                       pop_stack_element(&cur);

Otherwise, we swap our current value into the value of the previous
element, and then drop the current. This is a bit tricky, but it
works.

> +               }
> +       } else if (!if_then_else->condition_satisfied)

Minor nit. I'm not sure what standard we use here at Git, but
traditionally, I prefer to see { } blocks on all sections even if only
one of them needs it. (That is, only drop the braces when every
section is one line.) It also looks weird with a comment since it
appears as multiple lines to the reader. I think the braces improve
readability.

I don't know whether that's Git's code base standard or not, however.
It's not really worth a re-roll unless something else would need to
change.

> +               /*
> +                * No %(else) atom: just drop the %(then) branch if the
> +                * condition is not satisfied.
> +                */
> +               strbuf_reset(&cur->output);

Finally, if no else element, then we just reset the current pointer.

> +
> +       *stack = cur;
> +       free(if_then_else);
> +}
> +
> +static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +       struct ref_formatting_stack *new;
> +       struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
> +
> +       push_stack_element(&state->stack);
> +       new = state->stack;
> +       new->at_end = if_then_else_handler;
> +       new->at_end_data = if_then_else;
> +}
> +

Ok, so the new method is that to handle "if"s we push the sets onto
the stack and check their values. I like this, it makes things pretty
straight forward and simple. Allows for quite a bit of expression.

> +static int is_empty(const char *s)
> +{
> +       while (*s != '\0') {
> +               if (!isspace(*s))
> +                       return 0;
> +               s++;
> +       }
> +       return 1;
> +}
> +
> +static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +       struct ref_formatting_stack *cur = state->stack;
> +       struct if_then_else *if_then_else = NULL;
> +
> +       if (cur->at_end == if_then_else_handler)
> +               if_then_else = (struct if_then_else *)cur->at_end_data;
> +       if (!if_then_else)
> +               die(_("format: %%(then) atom used without an %%(if) atom"));
> +       if (if_then_else->then_atom_seen)
> +               die(_("format: %%(then) atom used more than once"));
> +       if (if_then_else->else_atom_seen)
> +               die(_("format: %%(then) atom used after %%(else)"));
> +       if_then_else->then_atom_seen = 1;
> +       /*
> +        * If there exists non-empty string between the 'if' and
> +        * 'then' atom then the 'if' condition is satisfied.
> +        */
> +       if (cur->output.len && !is_empty(cur->output.buf))
> +               if_then_else->condition_satisfied = 1;
> +       strbuf_reset(&cur->output);
> +}

So once we have a "%(then)" atom, we reset all the accumulated string
data we've gotten so far. Simple.

> +
> +static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
> +{
> +       struct ref_formatting_stack *prev = state->stack;
> +       struct if_then_else *if_then_else = NULL;
> +
> +       if (prev->at_end == if_then_else_handler)
> +               if_then_else = (struct if_then_else *)prev->at_end_data;
> +       if (!if_then_else)
> +               die(_("format: %%(else) atom used without an %%(if) atom"));
> +       if (!if_then_else->then_atom_seen)
> +               die(_("format: %%(else) atom used without a %%(then) atom"));
> +       if (if_then_else->else_atom_seen)
> +               die(_("format: %%(else) atom used more than once"));
> +       if_then_else->else_atom_seen = 1;
> +       push_stack_element(&state->stack);
> +       state->stack->at_end_data = prev->at_end_data;
> +       state->stack->at_end = prev->at_end;
> +}

So for an else atom, we basically create another stack element on top
of the current one. Nice.

> +
>  static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
>  {
>         struct ref_formatting_stack *current = state->stack;
> @@ -370,14 +477,17 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
>
>         if (!current->at_end)
>                 die(_("format: %%(end) atom used without corresponding atom"));
> -       current->at_end(current);
> +       current->at_end(&state->stack);
> +
> +       /*  Stack may have been popped within at_end(), hence reset the current pointer */
> +       current = state->stack;
>
>         /*
>          * Perform quote formatting when the stack element is that of
>          * a supporting atom. If nested then perform quote formatting
>          * only on the topmost supporting atom.
>          */
> -       if (!state->stack->prev->prev) {
> +       if (!current->prev->prev) {
>                 quote_formatting(&s, current->output.buf, state->quote_style);
>                 strbuf_swap(&current->output, &s);
>         }
> @@ -1029,6 +1139,15 @@ static void populate_value(struct ref_array_item *ref)
>                 } else if (!strcmp(name, "end")) {
>                         v->handler = end_atom_handler;
>                         continue;
> +               } else if (!strcmp(name, "if")) {
> +                       v->handler = if_atom_handler;
> +                       continue;
> +               } else if (!strcmp(name, "then")) {
> +                       v->handler = then_atom_handler;
> +                       continue;
> +               } else if (!strcmp(name, "else")) {
> +                       v->handler = else_atom_handler;
> +                       continue;
>                 } else
>                         continue;
>
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index d0ab09f..fed3013 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -327,4 +327,80 @@ test_expect_success 'reverse version sort' '
>         test_cmp expect actual
>  '
>
> +test_expect_success 'improper usage of %(if), %(then), %(else) and %(end) atoms' '
> +       test_must_fail git for-each-ref --format="%(if)" &&
> +       test_must_fail git for-each-ref --format="%(then) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(else) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(else) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(then) %(then) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(then) %(else) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(else) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(then) %(else)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(else) %(then) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(then) %(else) %(else) %(end)" &&
> +       test_must_fail git for-each-ref --format="%(if) %(end)"
> +'
> +
> +test_expect_success 'check %(if)...%(then)...%(end) atoms' '
> +       git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Author: %(authorname)%(end)" >actual &&
> +       cat >expect <<-\EOF &&
> +       refs/heads/master Author: A U Thor
> +       refs/heads/side Author: A U Thor
> +       refs/odd/spot Author: A U Thor
> +       refs/tags/annotated-tag
> +       refs/tags/doubly-annotated-tag
> +       refs/tags/doubly-signed-tag
> +       refs/tags/foo1.10 Author: A U Thor
> +       refs/tags/foo1.3 Author: A U Thor
> +       refs/tags/foo1.6 Author: A U Thor
> +       refs/tags/four Author: A U Thor
> +       refs/tags/one Author: A U Thor
> +       refs/tags/signed-tag
> +       refs/tags/three Author: A U Thor
> +       refs/tags/two Author: A U Thor
> +       EOF
> +       test_cmp expect actual
> +'
> +
> +test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
> +       git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No author%(end): %(refname)" >actual &&
> +       cat >expect <<-\EOF &&
> +       A U Thor: refs/heads/master
> +       A U Thor: refs/heads/side
> +       A U Thor: refs/odd/spot
> +       No author: refs/tags/annotated-tag
> +       No author: refs/tags/doubly-annotated-tag
> +       No author: refs/tags/doubly-signed-tag
> +       A U Thor: refs/tags/foo1.10
> +       A U Thor: refs/tags/foo1.3
> +       A U Thor: refs/tags/foo1.6
> +       A U Thor: refs/tags/four
> +       A U Thor: refs/tags/one
> +       No author: refs/tags/signed-tag
> +       A U Thor: refs/tags/three
> +       A U Thor: refs/tags/two
> +       EOF
> +       test_cmp expect actual
> +'
> +test_expect_success 'ignore spaces in %(if) atom usage' '
> +       git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
> +       cat >expect <<-\EOF &&
> +       master: Head ref
> +       side: Not Head ref
> +       odd/spot: Not Head ref
> +       annotated-tag: Not Head ref
> +       doubly-annotated-tag: Not Head ref
> +       doubly-signed-tag: Not Head ref
> +       foo1.10: Not Head ref
> +       foo1.3: Not Head ref
> +       foo1.6: Not Head ref
> +       four: Not Head ref
> +       one: Not Head ref
> +       signed-tag: Not Head ref
> +       three: Not Head ref
> +       two: Not Head ref
> +       EOF
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> 2.10.2
>
