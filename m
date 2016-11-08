Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3B252035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:45:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751537AbcKHXpx (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:45:53 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:33698 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbcKHXpx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:45:53 -0500
Received: by mail-yw0-f169.google.com with SMTP id r204so199071308ywb.0
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:45:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7AEUz6ooazrdAcVl4yvuRHgpTUSMyPTiTBv75ZmsTpE=;
        b=JPdMRqY38Ng9RtAR03rs+Rt8M1fek/qzAiwvn10IGPisQr7R11MQKATSXxr/tmLHwm
         HeLpYl9NB2Y94XC1NahZgE9J0fUEK3F4B0zEIW2aQJWV3rg1iPe2DFqXeEbg5ts/T8LN
         DNzv0rno26Be8lL1aXfyUy0pj58wgfBrrS6sCzUNUMZvzVzwF/AM6oaY3p0NRMGd0Ai2
         uECzlw3kkMW7Gj0ww6T4sTjUhynThiBsFW55Y3aTdBEHUIoNDFngN9IxpsVRZ4bLxAuW
         RMXI5XMxIlnQH9fuxYzwuQ0KFbigCEw0SliC1Eqpd8QKSpK2U5Fx08dGDOVPm3bVd4az
         E08A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7AEUz6ooazrdAcVl4yvuRHgpTUSMyPTiTBv75ZmsTpE=;
        b=Km/ZntR+VUjxdEAZlJtJ7TJ7e3YP9DubiPyqPBlV1d7zMO/RPDv8eAmwiqnFCAb5AG
         VVEqitxPePcOCInqTtSTZ2F30SI3UbyqOBz3/svmowTyxtKeRFkpDB1a23151gD75ELr
         /EnoDOipUO8nvg5ZdMcw8Xi8eNWTEO7oyneLh+sofM7oiP3bBYrk8kxxmTFWrIap2s9z
         vVbF/DaCnhO3PGKbM3CGqSlxN/OCWIAZc6FJDYBPatTLxjcQgnIFGrRPVna1VW2HdCJh
         Bx8VAEHhJvBkrFTCPzxxVX1ACj7LxPn1x3K+2yC6t/nr31Le+0woUFB4IFsoaWlKzGKH
         sZDg==
X-Gm-Message-State: ABUngvdNyLtJLrHyek3ls2Q60yeBrqkga/OxA2UcoK/CfK79m2OYGO4VnBicQgewDKOIsewjOj/mYOPn4Xi8gA==
X-Received: by 10.13.254.71 with SMTP id o68mr11378757ywf.318.1478648752102;
 Tue, 08 Nov 2016 15:45:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:45:31 -0800 (PST)
In-Reply-To: <20161108201211.25213-9-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-9-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:45:31 -0800
Message-ID: <CA+P7+xrm-MMRa9RuaHUGNWJmH8UcYPj3RZCsy1uvVRMuLeP0ZQ@mail.gmail.com>
Subject: Re: [PATCH v7 08/17] ref-filter: add support for %(upstream:track,nobracket)
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
> Add support for %(upstream:track,nobracket) which will print the
> tracking information without the brackets (i.e. "ahead N, behind M").
> This is needed when we port branch.c to use ref-filter's printing APIs.
>

Makes sense. Seems a bit weird that we have the brackets normally
rather than adding them as an option, but I think this is ok. We don't
want to change all previous uses in this case.

My only suggestion here would be to add code so that the options die()
when we use nobracket along with trackshort or without track. This
ensures that the nobracket option only applies to track mode?

> Add test and documentation for the same.
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt |  8 +++--
>  ref-filter.c                       | 67 +++++++++++++++++++++++++-------------
>  t/t6300-for-each-ref.sh            |  2 ++
>  3 files changed, 51 insertions(+), 26 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index fd365eb..3953431 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -118,9 +118,11 @@ upstream::
>         `refname` above.  Additionally respects `:track` to show
>         "[ahead N, behind M]" and `:trackshort` to show the terse
>         version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
> -       or "=" (in sync).  Has no effect if the ref does not have
> -       tracking information associated with it. `:track` also prints
> -       "[gone]" whenever unknown upstream ref is encountered.
> +       or "=" (in sync). `:track` also prints "[gone]" whenever
> +       unknown upstream ref is encountered. Append `:track,nobracket`
> +       to show tracking information without brackets (i.e "ahead N,
> +       behind M").  Has no effect if the ref does not have tracking
> +       information associated with it.
>

Ok so my comment on the previous patch is fixed here, the new wording
makes it much more clear that [gone] is not the same thing as no
information. So I don't think we should bother changing the previous
patch in the series. This might want to document that nobracket works
even without track, even if it doesn't actually do anything? Or make
the code more strict in that we die() if the values are put together
that make no sense?

>  push::
>         The name of a local ref which represents the `@{push}` location
> diff --git a/ref-filter.c b/ref-filter.c
> index 6d51b80..4d7e414 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -46,8 +46,10 @@ static struct used_atom {
>         union {
>                 char color[COLOR_MAXLEN];
>                 struct align align;
> -               enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
> -                       remote_ref;
> +               struct {
> +                       enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
> +                       unsigned int nobracket: 1;
> +               } remote_ref;
>                 struct {
>                         enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
>                         unsigned int nlines;
> @@ -75,16 +77,33 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
>
>  static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>  {
> -       if (!arg)
> -               atom->u.remote_ref = RR_NORMAL;
> -       else if (!strcmp(arg, "short"))
> -               atom->u.remote_ref = RR_SHORTEN;
> -       else if (!strcmp(arg, "track"))
> -               atom->u.remote_ref = RR_TRACK;
> -       else if (!strcmp(arg, "trackshort"))
> -               atom->u.remote_ref = RR_TRACKSHORT;
> -       else
> -               die(_("unrecognized format: %%(%s)"), atom->name);
> +       struct string_list params = STRING_LIST_INIT_DUP;
> +       int i;
> +
> +       if (!arg) {
> +               atom->u.remote_ref.option = RR_NORMAL;
> +               return;
> +       }
> +
> +       atom->u.remote_ref.nobracket = 0;
> +       string_list_split(&params, arg, ',', -1);
> +
> +       for (i = 0; i < params.nr; i++) {
> +               const char *s = params.items[i].string;
> +
> +               if (!strcmp(s, "short"))
> +                       atom->u.remote_ref.option = RR_SHORTEN;
> +               else if (!strcmp(s, "track"))

Should we add die()s here to disallow setting the remote_ref option
multiple times? Otherwise, we should document that the last one wins?
Not sure it's really a big deal here, but we could do it to ensure
consistency for options which don't make sense together?

> +                       atom->u.remote_ref.option = RR_TRACK;
> +               else if (!strcmp(s, "trackshort"))
> +                       atom->u.remote_ref.option = RR_TRACKSHORT;
> +               else if (!strcmp(s, "nobracket"))
> +                       atom->u.remote_ref.nobracket = 1;
> +               else
> +                       die(_("unrecognized format: %%(%s)"), atom->name);
> +       }
> +
> +       string_list_clear(&params, 0);
>  }
>
>  static void body_atom_parser(struct used_atom *atom, const char *arg)
> @@ -1045,25 +1064,27 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>                                     struct branch *branch, const char **s)
>  {
>         int num_ours, num_theirs;
> -       if (atom->u.remote_ref == RR_SHORTEN)
> +       if (atom->u.remote_ref.option == RR_SHORTEN)
>                 *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> -       else if (atom->u.remote_ref == RR_TRACK) {
> +       else if (atom->u.remote_ref.option == RR_TRACK) {
>                 if (stat_tracking_info(branch, &num_ours,
>                                        &num_theirs, NULL)) {
> -                       *s = "[gone]";
> -                       return;
> -               }
> -
> -               if (!num_ours && !num_theirs)
> +                       *s = xstrdup("gone");
> +               } else if (!num_ours && !num_theirs)
>                         *s = "";
>                 else if (!num_ours)
> -                       *s = xstrfmt("[behind %d]", num_theirs);
> +                       *s = xstrfmt("behind %d", num_theirs);
>                 else if (!num_theirs)
> -                       *s = xstrfmt("[ahead %d]", num_ours);
> +                       *s = xstrfmt("ahead %d", num_ours);
>                 else
> -                       *s = xstrfmt("[ahead %d, behind %d]",
> +                       *s = xstrfmt("ahead %d, behind %d",
>                                      num_ours, num_theirs);
> -       } else if (atom->u.remote_ref == RR_TRACKSHORT) {
> +               if (!atom->u.remote_ref.nobracket && *s[0]) {
> +                       const char *to_free = *s;
> +                       *s = xstrfmt("[%s]", *s);
> +                       free((void *)to_free);
> +               }
> +       } else if (atom->u.remote_ref.option == RR_TRACKSHORT) {
>                 if (stat_tracking_info(branch, &num_ours,
>                                        &num_theirs, NULL))
>                         return;
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index a92b36f..2c5f177 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -372,6 +372,8 @@ test_expect_success 'setup for upstream:track[short]' '
>
>  test_atom head upstream:track '[ahead 1]'
>  test_atom head upstream:trackshort '>'
> +test_atom head upstream:track,nobracket 'ahead 1'
> +test_atom head upstream:nobracket,track 'ahead 1'
>  test_atom head push:track '[ahead 1]'
>  test_atom head push:trackshort '>'
>
> --
> 2.10.2
>
