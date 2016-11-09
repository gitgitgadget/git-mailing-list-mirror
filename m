Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC232035F
	for <e@80x24.org>; Wed,  9 Nov 2016 00:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752977AbcKIA2k (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 19:28:40 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:32936 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbcKIA2j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 19:28:39 -0500
Received: by mail-yb0-f196.google.com with SMTP id v78so3986123ybe.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 16:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=CcSppVxI24X0FYEjmzC/cy8BfR8F6tQUEAhD1lwLMQg=;
        b=ApnN2YiSRuxSQo5ortHyu+VHzxFUAEYDg4O/nkW9H9xckivKjhMroWjgkgLtnLoCl3
         aSF+s9rCaHa4W9StkLIlkGN0FtGmhZST7pt/bxkzEfmZHSxVxQltf/mVOjx2xFNMIW4q
         i5hgVqzRZZmzdav0luk8r1tjpw1VGavcznUR1QlOho3ptUQMWBOaimCbH4xsDOD26tXw
         oyPr7sS2jFAT45djYhjaRnkoN4zXR3AWdxgUiQljWc5nhWDiAmiSXaE00dXNgksIQOKJ
         jivYGmUii0q5jdPFurizXRk87zVCNyyLfV8Hjjum0DFSk5w7s1g4uluBrca3PU9Qu1eg
         IwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=CcSppVxI24X0FYEjmzC/cy8BfR8F6tQUEAhD1lwLMQg=;
        b=Y/VNMO5mROjOJAujLZMiyNIcwXcsX7XAl5AxBR1MSqZuTRssDNoDUV4lrs50s9sUZu
         KTfT9/EU9+1Yaj8K5PI+W1WsFhRFs/VLJDjEtGOfPI6nI8XXdV300ldRioIn7FezQyzy
         wHV3KP7zlMsoIn8f/x5Y0nqXxiWH1gyl3lOWB6OtzrwnZbJ3HPlfbc3od+fmboGvaG8q
         IjdBl5ozAped89lbB9QLj8Vu1rnpL1EgkqMwZSCMPULNZMCP1c/+X0YHBrtO4MO+798E
         fDT6w2LjWnW0K/le9SLXri92/GsmwJ9e3m5ikSh5hxEJLx4bV4SPUgwyUjYsjeap43M/
         GjlA==
X-Gm-Message-State: ABUngvfH6wEzPRvyVrGB0/ZM4f1Yva1w7noxA201Ac7RYEIPlFo+uWQvX7ka16cznf/56/8iujuRvemgKhdFqw==
X-Received: by 10.37.53.213 with SMTP id c204mr15333247yba.57.1478650463923;
 Tue, 08 Nov 2016 16:14:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 16:14:03 -0800 (PST)
In-Reply-To: <20161108201211.25213-17-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-17-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 16:14:03 -0800
Message-ID: <CA+P7+xr20UyKMKUZBpP-SjtEhbow2df+iT6nF67mOAZ8BAaxEg@mail.gmail.com>
Subject: Re: [PATCH v7 16/17] branch: use ref-filter printing APIs
To:     Karthik Nayak <karthik.188@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 8, 2016 at 12:12 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>
> Port branch.c to use ref-filter APIs for printing. This clears out
> most of the code used in branch.c for printing and replaces them with
> calls made to the ref-filter library.

Nice. This looks correct based on checking against the current
branch.c implementation by hand. There was one minor change I
suggested but I'm not really sure it buys is that much.

Thanks,
Jake

>
> Introduce build_format() which gets the format required for printing
> of refs. Make amendments to print_ref_list() to reflect these changes.
>

Ok.

> Change calc_maxwidth() to also account for the length of HEAD ref, by
> calling ref-filter:get_head_discription().
>
> Also change the test in t6040 to reflect the changes.


Right.

>
> Before this patch, all cross-prefix symrefs weren't shortened. Since
> we're using ref-filter APIs, we shorten all symrefs by default. We also
> allow the user to change the format if needed with the introduction of
> the '--format' option in the next patch.
>

This also makes sense.

> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  builtin/branch.c         | 234 ++++++++++++++---------------------------------
>  t/t3203-branch-output.sh |   2 +-
>  t/t6040-tracking-info.sh |   2 +-
>  3 files changed, 70 insertions(+), 168 deletions(-)
>
> diff --git a/builtin/branch.c b/builtin/branch.c
> index dead2b8..a19e05d 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -36,12 +36,12 @@ static unsigned char head_sha1[20];
>
>  static int branch_use_color = -1;
>  static char branch_colors[][COLOR_MAXLEN] = {
> -       GIT_COLOR_RESET,
> -       GIT_COLOR_NORMAL,       /* PLAIN */
> -       GIT_COLOR_RED,          /* REMOTE */
> -       GIT_COLOR_NORMAL,       /* LOCAL */
> -       GIT_COLOR_GREEN,        /* CURRENT */
> -       GIT_COLOR_BLUE,         /* UPSTREAM */
> +       "%(color:reset)",
> +       "%(color:reset)",       /* PLAIN */
> +       "%(color:red)",         /* REMOTE */
> +       "%(color:reset)",       /* LOCAL */
> +       "%(color:green)",       /* CURRENT */
> +       "%(color:blue)",        /* UPSTREAM */
>  };
>  enum color_branch {
>         BRANCH_COLOR_RESET = 0,
> @@ -280,162 +280,6 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>         return(ret);
>  }
>
> -static void fill_tracking_info(struct strbuf *stat, const char *branch_name,
> -               int show_upstream_ref)
> -{
> -       int ours, theirs;
> -       char *ref = NULL;
> -       struct branch *branch = branch_get(branch_name);
> -       const char *upstream;
> -       struct strbuf fancy = STRBUF_INIT;
> -       int upstream_is_gone = 0;
> -       int added_decoration = 1;
> -
> -       if (stat_tracking_info(branch, &ours, &theirs, &upstream) < 0) {
> -               if (!upstream)
> -                       return;
> -               upstream_is_gone = 1;
> -       }
> -
> -       if (show_upstream_ref) {
> -               ref = shorten_unambiguous_ref(upstream, 0);
> -               if (want_color(branch_use_color))
> -                       strbuf_addf(&fancy, "%s%s%s",
> -                                       branch_get_color(BRANCH_COLOR_UPSTREAM),
> -                                       ref, branch_get_color(BRANCH_COLOR_RESET));
> -               else
> -                       strbuf_addstr(&fancy, ref);
> -       }
> -
> -       if (upstream_is_gone) {
> -               if (show_upstream_ref)
> -                       strbuf_addf(stat, _("[%s: gone]"), fancy.buf);
> -               else
> -                       added_decoration = 0;
> -       } else if (!ours && !theirs) {
> -               if (show_upstream_ref)
> -                       strbuf_addf(stat, _("[%s]"), fancy.buf);
> -               else
> -                       added_decoration = 0;
> -       } else if (!ours) {
> -               if (show_upstream_ref)
> -                       strbuf_addf(stat, _("[%s: behind %d]"), fancy.buf, theirs);
> -               else
> -                       strbuf_addf(stat, _("[behind %d]"), theirs);
> -
> -       } else if (!theirs) {
> -               if (show_upstream_ref)
> -                       strbuf_addf(stat, _("[%s: ahead %d]"), fancy.buf, ours);
> -               else
> -                       strbuf_addf(stat, _("[ahead %d]"), ours);
> -       } else {
> -               if (show_upstream_ref)
> -                       strbuf_addf(stat, _("[%s: ahead %d, behind %d]"),
> -                                   fancy.buf, ours, theirs);
> -               else
> -                       strbuf_addf(stat, _("[ahead %d, behind %d]"),
> -                                   ours, theirs);
> -       }
> -       strbuf_release(&fancy);
> -       if (added_decoration)
> -               strbuf_addch(stat, ' ');
> -       free(ref);
> -}
> -
> -static void add_verbose_info(struct strbuf *out, struct ref_array_item *item,
> -                            struct ref_filter *filter, const char *refname)
> -{
> -       struct strbuf subject = STRBUF_INIT, stat = STRBUF_INIT;
> -       const char *sub = _(" **** invalid ref ****");
> -       struct commit *commit = item->commit;
> -
> -       if (!parse_commit(commit)) {
> -               pp_commit_easy(CMIT_FMT_ONELINE, commit, &subject);
> -               sub = subject.buf;
> -       }
> -
> -       if (item->kind == FILTER_REFS_BRANCHES)
> -               fill_tracking_info(&stat, refname, filter->verbose > 1);
> -
> -       strbuf_addf(out, " %s %s%s",
> -               find_unique_abbrev(item->commit->object.oid.hash, filter->abbrev),
> -               stat.buf, sub);
> -       strbuf_release(&stat);
> -       strbuf_release(&subject);
> -}
> -
> -static void format_and_print_ref_item(struct ref_array_item *item, int maxwidth,
> -                                     struct ref_filter *filter, const char *remote_prefix)
> -{
> -       char c;
> -       int current = 0;
> -       int color;
> -       struct strbuf out = STRBUF_INIT, name = STRBUF_INIT;
> -       const char *prefix_to_show = "";
> -       const char *prefix_to_skip = NULL;
> -       const char *desc = item->refname;
> -       char *to_free = NULL;
> -
> -       switch (item->kind) {
> -       case FILTER_REFS_BRANCHES:
> -               prefix_to_skip = "refs/heads/";
> -               skip_prefix(desc, prefix_to_skip, &desc);
> -               if (!filter->detached && !strcmp(desc, head))
> -                       current = 1;
> -               else
> -                       color = BRANCH_COLOR_LOCAL;
> -               break;
> -       case FILTER_REFS_REMOTES:
> -               prefix_to_skip = "refs/remotes/";
> -               skip_prefix(desc, prefix_to_skip, &desc);
> -               color = BRANCH_COLOR_REMOTE;
> -               prefix_to_show = remote_prefix;
> -               break;
> -       case FILTER_REFS_DETACHED_HEAD:
> -               desc = to_free = get_head_description();
> -               current = 1;
> -               break;
> -       default:
> -               color = BRANCH_COLOR_PLAIN;
> -               break;
> -       }
> -
> -       c = ' ';
> -       if (current) {
> -               c = '*';
> -               color = BRANCH_COLOR_CURRENT;
> -       }
> -
> -       strbuf_addf(&name, "%s%s", prefix_to_show, desc);
> -       if (filter->verbose) {
> -               int utf8_compensation = strlen(name.buf) - utf8_strwidth(name.buf);
> -               strbuf_addf(&out, "%c %s%-*s%s", c, branch_get_color(color),
> -                           maxwidth + utf8_compensation, name.buf,
> -                           branch_get_color(BRANCH_COLOR_RESET));
> -       } else
> -               strbuf_addf(&out, "%c %s%s%s", c, branch_get_color(color),
> -                           name.buf, branch_get_color(BRANCH_COLOR_RESET));
> -
> -       if (item->symref) {
> -               const char *symref = item->symref;
> -               if (prefix_to_skip)
> -                       skip_prefix(symref, prefix_to_skip, &symref);
> -               strbuf_addf(&out, " -> %s", symref);
> -       }
> -       else if (filter->verbose)
> -               /* " f7c0c00 [ahead 58, behind 197] vcs-svn: drop obj_pool.h" */
> -               add_verbose_info(&out, item, filter, desc);
> -       if (column_active(colopts)) {
> -               assert(!filter->verbose && "--column and --verbose are incompatible");
> -               string_list_append(&output, out.buf);
> -       } else {
> -               printf("%s\n", out.buf);
> -       }
> -       strbuf_release(&name);
> -       strbuf_release(&out);
> -       free(to_free);
> -}
> -
>  static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>  {
>         int i, max = 0;
> @@ -446,7 +290,12 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>
>                 skip_prefix(it->refname, "refs/heads/", &desc);
>                 skip_prefix(it->refname, "refs/remotes/", &desc);
> -               w = utf8_strwidth(desc);
> +               if (it->kind == FILTER_REFS_DETACHED_HEAD) {
> +                       char *head_desc = get_head_description();
> +                       w = utf8_strwidth(head_desc);
> +                       free(head_desc);
> +               } else
> +                       w = utf8_strwidth(desc);
>
>                 if (it->kind == FILTER_REFS_REMOTES)
>                         w += remote_bonus;
> @@ -456,12 +305,52 @@ static int calc_maxwidth(struct ref_array *refs, int remote_bonus)
>         return max;
>  }
>
> +static char *build_format(struct ref_filter *filter, int maxwidth, const char *remote_prefix)
> +{
> +       struct strbuf fmt = STRBUF_INIT;
> +       struct strbuf local = STRBUF_INIT;
> +       struct strbuf remote = STRBUF_INIT;
> +

Ok, so here we go for reviewing the new formats.

> +       strbuf_addf(&fmt, "%%(if)%%(HEAD)%%(then)* %s%%(else)  %%(end)", branch_get_color(BRANCH_COLOR_CURRENT));
> +

The first thing we print, is the * when it's HEAD or two spaces,
followed by getting the current color scheme. Ok, this matches what we
do with branch today.

> +       if (filter->verbose) {
> +               strbuf_addf(&local, "%%(align:%d,left)%%(refname:strip=2)%%(end)", maxwidth);
> +               strbuf_addf(&local, "%s", branch_get_color(BRANCH_COLOR_RESET));
> +               strbuf_addf(&local, " %%(objectname:short=7) ");
> +

Now, for verbose mode we setup local to be left aligned to a maximum
width, with the refname stripped by 2 fields.

Then, we reset the color, and print the object name shorted to 7 characters. Ok.

> +               if (filter->verbose > 1)
> +                       strbuf_addf(&local, "%%(if)%%(upstream)%%(then)[%s%%(upstream:short)%s%%(if)%%(upstream:track)"
> +                                   "%%(then): %%(upstream:track,nobracket)%%(end)] %%(end)%%(contents:subject)",
> +                                   branch_get_color(BRANCH_COLOR_UPSTREAM), branch_get_color(BRANCH_COLOR_RESET));

When we have extra verbose, we check whether we have an upstream, and
if so, we print the short name of that upstream inside brackets. If we
have tracking information, we print that without brackets, and then we
end this section. Finally we print the subject.

We could almost re-use the code for the subject bits, but I'm not sure
it's worth it. Maybe drop the %contents:subject part and add it
afterwards since we always want it? It would remove some duplication
but overall not sure it's actually worth it.


> +               else
> +                       strbuf_addf(&local, "%%(if)%%(upstream:track)%%(then)%%(upstream:track) %%(end)%%(contents:subject)");
> +
> +               strbuf_addf(&remote, "%s%%(align:%d,left)%s%%(refname:strip=2)%%(end)%s%%(if)%%(symref)%%(then) -> %%(symref:short)"
> +                           "%%(else) %%(objectname:short=7) %%(contents:subject)%%(end)",
> +                           branch_get_color(BRANCH_COLOR_REMOTE), maxwidth,
> +                           remote_prefix, branch_get_color(BRANCH_COLOR_RESET));

Here we handle the remote value, which is always the same for verbose
with either one or two value.

> +       } else {
> +               strbuf_addf(&local, "%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
> +                           branch_get_color(BRANCH_COLOR_RESET));
> +               strbuf_addf(&remote, "%s%s%%(refname:strip=2)%s%%(if)%%(symref)%%(then) -> %%(symref:short)%%(end)",
> +                           branch_get_color(BRANCH_COLOR_REMOTE), remote_prefix, branch_get_color(BRANCH_COLOR_RESET));
> +       }
> +
> +       strbuf_addf(&fmt, "%%(if:notequals=remotes)%%(refname:base)%%(then)%s%%(else)%s%%(end)", local.buf, remote.buf);
> +

Finally we check to see whether the base is remotes and print the
local vs the remote buf. Neat trick.

> +       strbuf_release(&local);
> +       strbuf_release(&remote);
> +       return strbuf_detach(&fmt, NULL);
> +}
> +
>  static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sorting)
>  {
>         int i;
>         struct ref_array array;
>         int maxwidth = 0;
>         const char *remote_prefix = "";
> +       struct strbuf out = STRBUF_INIT;
> +       char *format;
>
>         /*
>          * If we are listing more than just remote branches,
> @@ -473,12 +362,14 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>
>         memset(&array, 0, sizeof(array));
>
> -       verify_ref_format("%(refname)%(symref)");
>         filter_refs(&array, filter, filter->kind | FILTER_REFS_INCLUDE_BROKEN);
>
>         if (filter->verbose)
>                 maxwidth = calc_maxwidth(&array, strlen(remote_prefix));
>
> +       format = build_format(filter, maxwidth, remote_prefix);
> +       verify_ref_format(format);
> +
>         /*
>          * If no sorting parameter is given then we default to sorting
>          * by 'refname'. This would give us an alphabetically sorted
> @@ -490,10 +381,21 @@ static void print_ref_list(struct ref_filter *filter, struct ref_sorting *sortin
>                 sorting = ref_default_sorting();
>         ref_array_sort(sorting, &array);
>
> -       for (i = 0; i < array.nr; i++)
> -               format_and_print_ref_item(array.items[i], maxwidth, filter, remote_prefix);
> +       for (i = 0; i < array.nr; i++) {
> +               format_ref_array_item(array.items[i], format, 0, &out);
> +               if (column_active(colopts)) {
> +                       assert(!filter->verbose && "--column and --verbose are incompatible");
> +                        /* format to a string_list to let print_columns() do its job */
> +                       string_list_append(&output, out.buf);
> +               } else {
> +                       fwrite(out.buf, 1, out.len, stdout);
> +                       putchar('\n');
> +               }
> +               strbuf_release(&out);
> +       }
>
>         ref_array_clear(&array);
> +       free(format);
>  }
>
>  static void reject_rebase_or_bisect_branch(const char *target)
> diff --git a/t/t3203-branch-output.sh b/t/t3203-branch-output.sh
> index c6a3ccb..980c732 100755
> --- a/t/t3203-branch-output.sh
> +++ b/t/t3203-branch-output.sh
> @@ -189,7 +189,7 @@ test_expect_success 'local-branch symrefs shortened properly' '
>         git symbolic-ref refs/heads/ref-to-remote refs/remotes/origin/branch-one &&
>         cat >expect <<-\EOF &&
>           ref-to-branch -> branch-one
> -         ref-to-remote -> refs/remotes/origin/branch-one
> +         ref-to-remote -> origin/branch-one
>         EOF
>         git branch >actual.raw &&
>         grep ref-to <actual.raw >actual &&
> diff --git a/t/t6040-tracking-info.sh b/t/t6040-tracking-info.sh
> index 3d5c238..97a0765 100755
> --- a/t/t6040-tracking-info.sh
> +++ b/t/t6040-tracking-info.sh
> @@ -44,7 +44,7 @@ b1 [ahead 1, behind 1] d
>  b2 [ahead 1, behind 1] d
>  b3 [behind 1] b
>  b4 [ahead 2] f
> -b5 g
> +b5 [gone] g
>  b6 c
>  EOF
>
> --
> 2.10.2
>
