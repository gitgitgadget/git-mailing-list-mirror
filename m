Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66E0F20281
	for <e@80x24.org>; Mon,  2 Oct 2017 13:45:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751657AbdJBNpD (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Oct 2017 09:45:03 -0400
Received: from mail-qt0-f175.google.com ([209.85.216.175]:51460 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751421AbdJBNor (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Oct 2017 09:44:47 -0400
Received: by mail-qt0-f175.google.com with SMTP id q4so7253634qtq.8
        for <git@vger.kernel.org>; Mon, 02 Oct 2017 06:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=BMxWYM5yUi7MqX5hE4ZKdpRDT+sgILg6bimaWjGCcX8=;
        b=kbq6AGBX31hyX6gxgEr+mnIBUTFmZz3OY8K1qZbFic7PrtXW8uwhGb7GvG3xSEXaIN
         003WCquoadZCMyyaIlZp+GZZZ/izSuR7GTbLZU3Q1tCSE5BUj5BAkWPaSN9KgdorDCex
         Lvgt90TcFDIdmYzgZ4Oy9ZN9d2Ly32tIZPR/Af3pm/ATwIcSOfEjLlqweUPdzCC4eGCl
         xObijvQG79Lt2LGHlmx5IFTvpQ2Ohju166L3NQWGKWYsDaRZ4/zMMrM5F/zp98PKCDrT
         /6BQw71XqFe5i8n2q4fTdEd+pWs2uT7CfRUFGJSkE2f3K5coeolX+nD6dYSBuH0rHIBq
         5IXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=BMxWYM5yUi7MqX5hE4ZKdpRDT+sgILg6bimaWjGCcX8=;
        b=qX0NcFaLQhH40rhnwUG7HvrhtFkgPnzqkeYefyN5rCJQieQN5F+mH1f6K76Ym8ixF/
         iVYeSfJ0Ph1tFjxU2lfQYc+xb0f/tpzCM23e8kdco0YbZYK3z7LMHuKkozmBk1gXHZ3U
         8n5kH+oXlbbmclbE3v6Wdg1xq6NeNzU4gCdfqMZ2IUlLSxyNI60mc2hnwj6BrR38Uq4M
         whvM98HvE8XsdhBwepQMTuVVaQVhU/G9V2J2x2i1NVRlVbV1bhZUTzK35He4YtL/yKIh
         UteaGExDLmr+aiC8j92DA+0nY0pSO/6FV5xBSFab/pI4n3HKZAUPGeiykLvBEb2fvXZg
         7Eew==
X-Gm-Message-State: AMCzsaVbt42n50phIKxMRXcIOOeu9vgjvvgEjfuyPXUCSx0D2Z4lbdqo
        mHyLx8L/Ggzic5dtUTLk9kCrwKPw+w7SG7fPet4=
X-Google-Smtp-Source: AOwi7QAlAnh7xQFYLz8qMlI83m7bQRCvOEiN6ZXqp+hsD7j3FLFki6VsFbD1CWDIql92EKJnIMMiwnDnocE9JrMMOBw=
X-Received: by 10.237.59.135 with SMTP id r7mr66632qte.13.1506951886584; Mon,
 02 Oct 2017 06:44:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.98.242 with HTTP; Mon, 2 Oct 2017 06:44:45 -0700 (PDT)
In-Reply-To: <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
References: <CAFZEwPOjK25m84BgTF7AL72DL_K1dHf7OrYoX=_vky9r3GayNw@mail.gmail.com>
 <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
 <5ca7a863-5b85-23b1-4432-cf74dcc7c4e0@ramsayjones.plus.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Mon, 2 Oct 2017 19:14:45 +0530
Message-ID: <CAFZEwPN2BeogeVqXp7xh+GPUF6SDJa5JwQ3knZzOD_H6zcEwvQ@mail.gmail.com>
Subject: Re: [PATCH v16 1/6] bisect--helper: use OPT_CMDMODE instead of OPT_BOOL
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey Ramsay,

On Sat, Sep 30, 2017 at 6:29 PM, Ramsay Jones
<ramsay@ramsayjones.plus.com> wrote:

> Hi Pranit,
>
> Just before Junio dropped your 'pb/bisect' branch from his
> repository (and What's cooking), I fetched it locally with
> the intention of finishing it off. (It would have been silly
> to waste all your good work).

Thanks!

> Although I have rebased your branch a few times, and added
> a few commits while 'reading' the code, I haven't actually
> added much to your branch (only 12 commits and I had meant
> to squash some of those together)!
>
> However, there were some bug fixes in there, so you may want
> to take a look at:
>
>     git://repo.or.cz/git/raj.git branch 'bisect'
>
> [the 'pb-bisect' branch was the original branch from Junio,
> including the 'SQUASH' commit that I squashed!]

Yes, I have checked it out. I had worked on Stephan's review and
updated a few parts. I think you have included that as well as some of
your modifications. I will squash it in together and send the series
out in parts.

> These patches seem to relate to patches 1-5 & 8 of the original
> series. The diff between these patches and the first 6 patches
> of my bisect branch is given below. Note that most of the diff
> seems to be caused by swapping patch #6 for #8, but not all of
> the hunks are caused by this.
>
> Note that I moved some code between patches (e.g. some of the
> GIT_PATH_FUNC()s moved out of patch #4, because they were not
> used in that patch. Ah, is that why you moved patch #8 up?).
> [Also I added the 'bisect clean' message to delet_refs() to
> patch #4 as well.]

Even I thought keeping GIT_PATH_FUNC()s should be declared whenever
required. Did that change in this patch series.

> Look for []-ed comments in the commit messages for a note of
> the changes I made to your original patches, in patches #2,
> #4, #7-9, #11-12 and #14.
>
> The commits I added, which are just WIP, are as follows:
>
>   $ git log --oneline bisect~12..bisect
>   7d7117040 (raj/bisect, bisect) bisect--helper: convert to struct object_id
>   188ea5855 bisect--helper: add the get_bad_commit() function
>   b75f46fb4 bisect--helper: add a log_commit() helper function
>   4afc34403 bisect--helper: reduce the scope of a variable
>   62495f6ae bisect--helper: remove useless sub-expression in condition
>   964f4e2b0 bisect--helper: set correct term from --term-new= option
>   62efc099f bisect--helper: remove redundant assignment to has_double_dash
>   d35950b92 bisect--helper: remove redundant goto's
>   b33f313ac bisect--helper: remove space just before \n in string
>   3eb407156 bisect--helper: remove some unnecessary braces
>   c2b89c9b8 bisect--helper: add some vertical whitespace
>   8c883701c bisect--helper: fix up some coding style issues
>   $
>
> Again IIRC, there are a couple of bug fixes in these commits ...

There is actually a major bug in the later part of previous series
mostly in the bisect-next which actually caused delays. I think you
have fixed it in your commit 682d0bff0. Although I would need to have
a closer look at it. In original series, I did get a sigserv, and as
you mention it in the commit that you have fixed it.

> I have to go now, so I will leave it with you. ;-)
>
> Hope that helps.
>
> ATB,
> Ramsay Jones

Again Thanks!

>
> -- >8 --
> diff --git a/bisect.c b/bisect.c
> index 2838d672d..b19311ca7 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -1066,7 +1066,7 @@ int bisect_clean_state(void)
>         struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
>         for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
>         string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> -       result = delete_refs("bisect: remove", &refs_for_removal, REF_NODEREF);
> +       result = delete_refs("bisect: clean", &refs_for_removal, REF_NODEREF);
>         refs_for_removal.strdup_strings = 1;
>         string_list_clear(&refs_for_removal, 0);
>         unlink_or_warn(git_path_bisect_expected_rev());
> diff --git a/builtin/am.c b/builtin/am.c
> index c973bd96d..aa66f9915 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -32,22 +32,6 @@
>  #include "apply.h"
>  #include "string-list.h"
>
> -/**
> - * Returns 1 if the file is empty or does not exist, 0 otherwise.
> - */
> -static int is_empty_file(const char *filename)
> -{
> -       struct stat st;
> -
> -       if (stat(filename, &st) < 0) {
> -               if (errno == ENOENT)
> -                       return 1;
> -               die_errno(_("could not stat %s"), filename);
> -       }
> -
> -       return !st.st_size;
> -}
> -
>  /**
>   * Returns the length of the first line of msg.
>   */
> @@ -1300,7 +1284,7 @@ static int parse_mail(struct am_state *state, const char *mail)
>                 goto finish;
>         }
>
> -       if (is_empty_file(am_path(state, "patch"))) {
> +       if (is_empty_or_missing_file(am_path(state, "patch"))) {
>                 printf_ln(_("Patch is empty."));
>                 die_user_resolve(state);
>         }
> @@ -1883,7 +1867,7 @@ static void am_run(struct am_state *state, int resume)
>                 resume = 0;
>         }
>
> -       if (!is_empty_file(am_path(state, "rewritten"))) {
> +       if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
>                 assert(state->rebasing);
>                 copy_notes_for_rebase(state);
>                 run_post_rewrite_hook(state);
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 35d2105f9..2af024f60 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -5,8 +5,6 @@
>  #include "refs.h"
>
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
> -static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
> -static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
>
>  static const char * const git_bisect_helper_usage[] = {
>         N_("git bisect--helper --next-all [--no-checkout]"),
> @@ -45,8 +43,8 @@ static int check_term_format(const char *term, const char *orig_term)
>         if (res)
>                 return error(_("'%s' is not a valid term"), term);
>
> -       if (one_of(term, "help", "start", "skip", "next", "reset",
> -                       "visualize", "replay", "log", "run", "terms", NULL))
> +       if (one_of(term, "help", "start", "terms", "skip", "next", "reset",
> +                       "visualize", "replay", "log", "run", NULL))
>                 return error(_("can't use the builtin command '%s' as a term"), term);
>
>         /*
> @@ -82,37 +80,12 @@ static int write_terms(const char *bad, const char *good)
>         return (res < 0) ? -1 : 0;
>  }
>
> -static int is_expected_rev(const char *expected_hex)
> -{
> -       struct strbuf actual_hex = STRBUF_INIT;
> -       int res = 0;
> -       if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 40) {
> -               strbuf_trim(&actual_hex);
> -               res = !strcmp(actual_hex.buf, expected_hex);
> -       }
> -       strbuf_release(&actual_hex);
> -       return res;
> -}
> -
> -static void check_expected_revs(const char **revs, int rev_nr)
> -{
> -       int i;
> -
> -       for (i = 0; i < rev_nr; i++) {
> -               if (!is_expected_rev(revs[i])) {
> -                       unlink_or_warn(git_path_bisect_ancestors_ok());
> -                       unlink_or_warn(git_path_bisect_expected_rev());
> -               }
> -       }
> -}
> -
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>         enum {
>                 NEXT_ALL = 1,
>                 WRITE_TERMS,
> -               BISECT_CLEAN_STATE,
> -               CHECK_EXPECTED_REVS
> +               BISECT_CLEAN_STATE
>         } cmdmode = 0;
>         int no_checkout = 0;
>         struct option options[] = {
> @@ -122,8 +95,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                          N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
>                 OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
>                          N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
> -               OPT_CMDMODE(0, "check-expected-revs", &cmdmode,
> -                        N_("check for expected revs"), CHECK_EXPECTED_REVS),
>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>                 OPT_END()
> @@ -140,17 +111,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                 return bisect_next_all(prefix, no_checkout);
>         case WRITE_TERMS:
>                 if (argc != 2)
> -                       return error(_("--write-terms requires two arguments"));
> +                       die(_("--write-terms requires two arguments"));
>                 return write_terms(argv[0], argv[1]);
>         case BISECT_CLEAN_STATE:
>                 if (argc != 0)
> -                       return error(_("--bisect-clean-state requires no arguments"));
> +                       die(_("--bisect-clean-state requires no arguments"));
>                 return bisect_clean_state();
> -       case CHECK_EXPECTED_REVS:
> -               check_expected_revs(argv, argc);
> -               return 0;
>         default:
> -               return error("BUG: unknown subcommand '%d'", cmdmode);
> +               die("BUG: unknown subcommand '%d'", cmdmode);

I will keep the return rather than die since Christian and I had a few
conversations long back.

Regards,
Pranit Bauva
www.bauva.com
