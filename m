Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD342035F
	for <e@80x24.org>; Tue,  8 Nov 2016 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751594AbcKHXzS (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 18:55:18 -0500
Received: from mail-yw0-f195.google.com ([209.85.161.195]:36061 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750832AbcKHXzR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 18:55:17 -0500
Received: by mail-yw0-f195.google.com with SMTP id r204so7598211ywb.3
        for <git@vger.kernel.org>; Tue, 08 Nov 2016 15:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vu7v/rZBKCm77gSiKpdcXVntdWevaKsNiiuGw1jel/w=;
        b=yqkgTOqoDhXwqsS4OlApdn6uGVa46f4qUooXmKm4LTiX2zpI6/bmGFJ7LftmoRkcGw
         UI6IqKElxRjd17zrCtobp3a8WZhhtklc1Vj9/UzDntiZy3Yq372ml0kUq8/YdRy6pb2A
         O/F5fKez7NwafCqaUuZJ5tlem31i9CFfK+VuyWNMpZ+em116cPpPwXoZJ5t1byny9G2e
         7diAi74sZhTdVc0hcsJVNILEdTjv/8AUwLEi+w1KvOO1sviG355tBq3RzfZCCzGfyPVn
         pTFEniFQmD/rWCsIx5N0BjkXHkQw8dnvdn/1Ou50itlo+XRxJ458/3qp0vx9Dj8r6MwV
         Z1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vu7v/rZBKCm77gSiKpdcXVntdWevaKsNiiuGw1jel/w=;
        b=J7V6FIXGXKH0bOYrKZWEmUp7TY7xxoKIUuTQMemfu6ZUBsdHXuM3W6rzaDFj3weJ07
         g5spclfHZo5opxBfPd3Zqmvn2DWlb+iZ1/h6q/naxQdOhrmdiARI6cV0kza3NL3F84pJ
         S/RJFcywnTfvfUdCuSgCMIsUIWsd7xn7ubbPY/SuLaNyZJ/IC9/lV/HZW+vN7+FnViZ2
         ys2pfh33OtUocPfJUyw2vVBy1p28j1sXurTrD09ZAf2z6MbKa4WtJMKbJgfSryYwv8UW
         GtqCMPXN6zf3FP+I9VqTutgldiGgWjO4YGyXZwrjKY3i62Q1tSrwq7HdfX9Hshrtsrku
         XMWw==
X-Gm-Message-State: ABUngveOnjhNBw1xIvw14fhXjEHUc9AhK4Le1pJZ2lFnAKaMUQ+5uVWha7IuC41+LiCKXREnkjiBRy/fhHmuDQ==
X-Received: by 10.129.102.132 with SMTP id a126mr14114478ywc.160.1478649316449;
 Tue, 08 Nov 2016 15:55:16 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Tue, 8 Nov 2016 15:54:56 -0800 (PST)
In-Reply-To: <20161108201211.25213-13-Karthik.188@gmail.com>
References: <20161108201211.25213-1-Karthik.188@gmail.com> <20161108201211.25213-13-Karthik.188@gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 8 Nov 2016 15:54:56 -0800
Message-ID: <CA+P7+xr1N8W9wS4y+=pQwdPzVpuyrFHzURog1ZhbW7bvy1oxpg@mail.gmail.com>
Subject: Re: [PATCH v7 12/17] ref-filter: make remote_ref_atom_parser() use refname_atom_parser_internal()
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
> Use the recently introduced refname_atom_parser_internal() within
> remote_ref_atom_parser(), this provides a common base for all the ref
> printing atoms, allowing %(upstream) and %(push) to also use the
> ':strip' option.
>
> The atoms '%(push)' and '%(upstream)' will retain the ':track' and
> ':trackshort' atom modifiers to themselves as they have no meaning in
> context to the '%(refname)' and '%(symref)' atoms.
>
> Update the documentation and tests to reflect the same.
>

Nice. Good to have all this become common.

> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
> ---
>  Documentation/git-for-each-ref.txt | 27 ++++++++++++++-------------
>  ref-filter.c                       | 26 +++++++++++++++-----------
>  t/t6300-for-each-ref.sh            |  2 ++
>  3 files changed, 31 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
> index a669a32..600b703 100644
> --- a/Documentation/git-for-each-ref.txt
> +++ b/Documentation/git-for-each-ref.txt
> @@ -114,21 +114,22 @@ objectname::
>
>  upstream::
>         The name of a local ref which can be considered ``upstream''
> -       from the displayed ref. Respects `:short` in the same way as
> -       `refname` above.  Additionally respects `:track` to show
> -       "[ahead N, behind M]" and `:trackshort` to show the terse
> -       version: ">" (ahead), "<" (behind), "<>" (ahead and behind),
> -       or "=" (in sync). `:track` also prints "[gone]" whenever
> -       unknown upstream ref is encountered. Append `:track,nobracket`
> -       to show tracking information without brackets (i.e "ahead N,
> -       behind M").  Has no effect if the ref does not have tracking
> -       information associated with it.
> +       from the displayed ref. Respects `:short` and `:strip` in the
> +       same way as `refname` above.  Additionally respects `:track`
> +       to show "[ahead N, behind M]" and `:trackshort` to show the
> +       terse version: ">" (ahead), "<" (behind), "<>" (ahead and
> +       behind), or "=" (in sync). `:track` also prints "[gone]"
> +       whenever unknown upstream ref is encountered. Append
> +       `:track,nobracket` to show tracking information without
> +       brackets (i.e "ahead N, behind M").  Has no effect if the ref
> +       does not have tracking information associated with it.
>
>  push::
> -       The name of a local ref which represents the `@{push}` location
> -       for the displayed ref. Respects `:short`, `:track`, and
> -       `:trackshort` options as `upstream` does. Produces an empty
> -       string if no `@{push}` ref is configured.
> +       The name of a local ref which represents the `@{push}`
> +       location for the displayed ref. Respects `:short`, `:strip`,
> +       `:track`, and `:trackshort` options as `upstream`
> +       does. Produces an empty string if no `@{push}` ref is
> +       configured.
>
>  HEAD::
>         '*' if HEAD matches current ref (the checked out branch), ' '
> diff --git a/ref-filter.c b/ref-filter.c
> index f1d27b5..7d3d3a6 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -52,7 +52,8 @@ static struct used_atom {
>                 char color[COLOR_MAXLEN];
>                 struct align align;
>                 struct {
> -                       enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT } option;
> +                       enum { RR_REF, RR_TRACK, RR_TRACKSHORT } option;
> +                       struct refname_atom refname;
>                         unsigned int nobracket: 1;
>                 } remote_ref;
>                 struct {
> @@ -102,7 +103,9 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>         int i;
>
>         if (!arg) {
> -               atom->u.remote_ref.option = RR_NORMAL;
> +               atom->u.remote_ref.option = RR_REF;
> +               refname_atom_parser_internal(&atom->u.remote_ref.refname,
> +                                            arg, atom->name);
>                 return;
>         }
>
> @@ -112,16 +115,17 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>         for (i = 0; i < params.nr; i++) {
>                 const char *s = params.items[i].string;
>
> -               if (!strcmp(s, "short"))
> -                       atom->u.remote_ref.option = RR_SHORTEN;
> -               else if (!strcmp(s, "track"))
> +               if (!strcmp(s, "track"))
>                         atom->u.remote_ref.option = RR_TRACK;
>                 else if (!strcmp(s, "trackshort"))
>                         atom->u.remote_ref.option = RR_TRACKSHORT;
>                 else if (!strcmp(s, "nobracket"))
>                         atom->u.remote_ref.nobracket = 1;
> -               else
> -                       die(_("unrecognized format: %%(%s)"), atom->name);
> +               else {
> +                       atom->u.remote_ref.option = RR_REF;
> +                       refname_atom_parser_internal(&atom->u.remote_ref.refname,
> +                                                    arg, atom->name);
> +               }
>         }
>
>         string_list_clear(&params, 0);
> @@ -1100,8 +1104,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>                                     struct branch *branch, const char **s)
>  {
>         int num_ours, num_theirs;
> -       if (atom->u.remote_ref.option == RR_SHORTEN)
> -               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
> +       if (atom->u.remote_ref.option == RR_REF)
> +               *s = show_ref(&atom->u.remote_ref.refname, refname);
>         else if (atom->u.remote_ref.option == RR_TRACK) {
>                 if (stat_tracking_info(branch, &num_ours,
>                                        &num_theirs, NULL)) {
> @@ -1133,8 +1137,8 @@ static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>                         *s = ">";
>                 else
>                         *s = "<>";
> -       } else /* RR_NORMAL */
> -               *s = refname;
> +       } else
> +               die("BUG: unhandled RR_* enum");
>  }
>
>  char *get_head_description(void)
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 3d28234..7ca0a12 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -55,8 +55,10 @@ test_atom head refname:strip=1 heads/master
>  test_atom head refname:strip=2 master
>  test_atom head upstream refs/remotes/origin/master
>  test_atom head upstream:short origin/master
> +test_atom head upstream:strip=2 origin/master
>  test_atom head push refs/remotes/myfork/master
>  test_atom head push:short myfork/master
> +test_atom head push:strip=1 remotes/myfork/master
>  test_atom head objecttype commit
>  test_atom head objectsize 171
>  test_atom head objectname $(git rev-parse refs/heads/master)
> --
> 2.10.2
>
