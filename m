Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B7CF1FAFB
	for <e@80x24.org>; Thu,  6 Apr 2017 18:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754706AbdDFSPr (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Apr 2017 14:15:47 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:34375 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753736AbdDFSPp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2017 14:15:45 -0400
Received: by mail-pg0-f43.google.com with SMTP id 21so43252256pgg.1
        for <git@vger.kernel.org>; Thu, 06 Apr 2017 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HnMhftKiFKgvOAGPFLaTnM6onDmSzePM3+LBGHtx6eQ=;
        b=fJUO3PqLDCRXF8wJmjqXmvR9B8ALGsPJPn3zCA9IHc0gIHpUrYmWYr07C00/SwQ4wj
         kbzlVo13tnDT0UoQy7VSASAPrP4mpngxx38HdkGuo0/e7A5RQG2XFD3h/4pcgX0rIW/T
         1XbuEtnzS/WDMbG0XRQ/9cuQZMHl68IUoZrqI0kw3ku1w6DBxBfLQvSIHggwsd/XEVPl
         qvNssVoPvRXRviPkCdudEjb0OKFh6GCe1qgxZnbfwUmRZ5Emv6p2m7TXQ0KtBeJj2kMH
         3K/sceBDHFiNVdLa8Hp9cn+S0q4qEu3sXnRBUvfXDKt8hJ1sref69wkQ649QTKtSXqnw
         TpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HnMhftKiFKgvOAGPFLaTnM6onDmSzePM3+LBGHtx6eQ=;
        b=t/y+h9Jhmd7vjBSTHMg2/LttHOziARwkJ1k7vRtg+KjwEq5pCzKUoZnoYXlSREag6R
         nuYpYBi0oZVCKRvsmHOqUZverYHh6GufQDns1ylTHzqhg0vIBFanO44KoCmlpZPW29Kq
         yKtlfVY77XqGT5e2CVL1uJEXEHhLp1Q/esXOZbiZPQ9KPlvNTy8dBz20hDVIoAqgkKpT
         +zYy19I28J6woifeHrwaOEi5HwfLrCBUHeZy9cm2ISVBMVMQc/CGXQk7r6baCjXTfJ9B
         1ojZ842BR7+53PqwEpu0I7mv89ME7MWKAc1iP1IDeJPMwCdmWCATYk5Zs34bPUdAwC+Z
         J5xg==
X-Gm-Message-State: AFeK/H1Ztj+kt6XiD+4HN7Kc6jq+jykzv+xhR4C2l8g/2wwWHZB/SoMrIkqL4J3hzSTjtRJVW8d2olJUjjmdGqhQ
X-Received: by 10.98.72.66 with SMTP id v63mr36871650pfa.8.1491502544397; Thu,
 06 Apr 2017 11:15:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.186.196 with HTTP; Thu, 6 Apr 2017 11:15:43 -0700 (PDT)
In-Reply-To: <20170406060053.4453-1-pc44800@gmail.com>
References: <20170406060053.4453-1-pc44800@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 6 Apr 2017 11:15:43 -0700
Message-ID: <CAGZ79kYULEaVYFX6_HGJi=CEA1E3Z8i4sKw+8bMaVsqiyWsuGw@mail.gmail.com>
Subject: Re: [GSoC][PATCH v1] Disallow git commands from within unpopulated submodules
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 5, 2017 at 11:00 PM, Prathamesh Chavan <pc44800@gmail.com> wrot=
e:
> The main motivations for disallowing git commands within an
> unpopulated submodule are:
>
> Whenever we run "git -C status" within an unpopulated submodule, it
> falls back to the superproject. This occurs since there is no .git
> file in the submodule directory. So superproject's status gets displayed.
> Also, the user's intention is not clear behind running the command
> in an unpopulated submodule. Hence we prefer to error out.
>
> When we run the command "git -C sub add ." within a submodule, the
> results observed are:
>
> In the case of the populated submodule, it acts like running =E2=80=9Cgit=
 add .=E2=80=9C
> inside the submodule. This is uncontroversial and runs as expected.
>
> In the case of the unpopulated submodule, the user's intention behind
> entering the above command is unclear. He may have intended to add
> the submodule to the superproject or to add all files inside the
> sub/ directory to the submodule or superproject. Hence we=E2=80=99ll pref=
er
> to error out in these case.
>
> Eventually, we use a check_prefix_inside_submodule to see check if the
> path is inside an unpopulated submodule. If it is, then we report the
> user about the unpopulated submodule.
>
> Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
> ---
>
> Since this patch effectively uses RUN_SETUP, builtin commands like
> 'diff' and other non-builtin commands are not filtered.
> For such cases, I think, we need to handle them separately.
>
> Also since currently, git-submodule is not a builtin command, the
> command for initializing and updating the submodule doesn't return an
> error message, but once it is converted to builtin, we need to handle
> its case explicitly.
>
> The build report of this patch is available on:
> https://travis-ci.org/pratham-pc/git/builds/219030999
>
> Also, the above patch was initially my GSoC project topic, but I changed
> it later on and added these bug fixes to my wishlist of the proposal.

Thanks for picking this topic up. :)

A couple of weeks back I floated a similar proposal of a patch[1], but
as far as I remember Peff hinted that it is a bad UI to do it on such a
generic early level[2]. And you also mention here that we'd not affect
git-diff or other commands that do not have RUN_SETUP set.

[1] https://public-inbox.org/git/20170119193023.26837-1-sbeller@google.com/
[2] from the same thread as [1]:
  https://public-inbox.org/git/20170120191728.l3ne5tt5pwbmafjh@sigill.intra=
.peff.net/

And I agree with Peff here that this high level catching is not the best wa=
y to
go. Rather we'd have to go through each command, e.g. in git-status I could
imagine it could look like: (white space mangled):

    diff --git a/builtin/commit.c b/builtin/commit.c
    index 4e288bc513..e3c44d4ac4 100644
    --- a/builtin/commit.c
    +++ b/builtin/commit.c
    @@ -1328,6 +1328,23 @@ static int git_status_config(const char *k,
const char *v, void *cb)
         return git_diff_ui_config(k, v, NULL);
     }

    +static void print_warning_inside_submodule(int status_format,
const char *prefix)
    +{
    +    switch (status_format) {
    +    case STATUS_FORMAT_UNSPECIFIED: /* fall through */
    +    case STATUS_FORMAT_NONE:     /* fall through */
    +    case STATUS_FORMAT_LONG:
    +        printf(_("\n\nWARNING: \n\nIn uninitialized submodule
'%s'\n\n\n"), prefix);
    +    case STATUS_FORMAT_SHORT:
    +        printf(_("WARNING: In uninitialized submodule '%s'\n"), prefix=
);
    +    case STATUS_FORMAT_PORCELAIN:
    +        /* cannot encode the warning in porcelain v1. */
    +        break;
    +    case STATUS_FORMAT_PORCELAIN_V2:
    +        printf("# WARNING prefix in submodule\n");
    +    }
    +}
    +
     int cmd_status(int argc, const char **argv, const char *prefix)
     {
         static struct wt_status s;
    @@ -1380,6 +1397,9 @@ int cmd_status(int argc, const char **argv,
const char *prefix)
         read_cache_preload(&s.pathspec);
         refresh_index(&the_index, REFRESH_QUIET|REFRESH_UNMERGED,
&s.pathspec, NULL, NULL);

    +    if (prefix && check_prefix_inside_submodule(prefix))
    +        print_warning_inside_submodule(status_format, prefix);
    +
         fd =3D hold_locked_index(&index_lock, 0);

         s.is_initial =3D get_sha1(s.reference, oid.hash) ? 1 : 0;

>
> +#define MODULE_LIST_INIT { NULL, 0, 0 }

I'd keep this initializer macro near the definition, i.e. in the header
(compare to STRBUF_INIT or STRING_LIST_INIT_* for example),
as this can then be used where ever we can use the data structure.

> +void check_prefix_inside_submodule(const char *prefix)

I think we'll need this function in returning way, i.e.

    int check_prefix_inside_submodule(const char *prefix)
    {
        ... do check ...
        return result;
    }

> +{
> +       struct module_list list =3D MODULE_LIST_INIT;
> +       int i;
> +
> +       if (read_cache() < 0)
> +               die(_("index file corrupt"));
> +
> +       for (i =3D 0; i < active_nr; i++) {
> +               const struct cache_entry *ce =3D active_cache[i];
> +
> +               if (!S_ISGITLINK(ce->ce_mode))
> +                               continue;
> +
> +               ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
> +               list.entries[list.nr++] =3D ce;
> +               while (i + 1 < active_nr &&
> +                       !strcmp(ce->name, active_cache[i + 1]->name))
> +                        /*
> +                         * Skip entries with the same name in different =
stages
> +                         * to make sure an entry is returned only once.
> +                         */
> +                       i++;
> +       }

The code up to here seems to be partially duplicate of
submodule--helper.c#module_list_compute().

At first I tried coming up with a nice code deduplication (i.e. put
the essential parts as a function somewhere), but I think this doesn't
make sense from an algorithmic point of view, because this runs in O(n)
of active_cache.

active_cache is sorted by (1st) alphabet and (2nd) the index stage.
The second sorting is why we have the while loop with the comment
in the code.

The problem we are trying to solve here, is "Does the active_index contain
prefix?", which can be done in O(log n) with a binary search, because
active_index is sorted by alphabet.

So I am not sure how much code we can reuse here. nevertheless:

> +       for(i =3D 0; i < list.nr; i++) {

Style nit: We prefer a whitespace between a control statement
(for, if, while) and the opening parens, i.e. "for (i =3D .."

> +               if(strlen((*list.entries[i]).name) =3D=3D  strlen(prefix)=
) {

(*list.entries[i]).name

can be simplified. The dereference *, combined with an access
of the struct member can be done as ->.
(*foo).bar is equal to foo->bar.

> +               }
> +               else if(strlen((*list.entries[i]).name) =3D=3D  strlen(pr=
efix)-1) {

The Git coding style prefers to have the closing brace and the else
on the same line:

        ..
    } else if (..) {
        ..


> +                       const char *out =3D NULL;
> +                       if(skip_prefix(prefix, (*list.entries[i]).name, &=
out)) {
> +                               if(strlen(out) =3D=3D 1 && out[0] =3D=3D =
'/')

The strlen operation can take quite long potentially (O(n) with n the
length of out).
So you could put the cheaper operation first, or the following would
check the same
without having to compute the length:

    if (out && out[0] =3D=3D '/' && !out + 1)
        ..

> +                                       die(_("command from inside unpopu=
lated submodule '%s' not supported."), (*list.entries[i]).name);

Once we have this function inside each command, we can be more precise
the error message. :)

Thanks,
Stefan
