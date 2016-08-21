Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E3951F859
	for <e@80x24.org>; Sun, 21 Aug 2016 11:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbcHULSK (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 07:18:10 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:33603 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752443AbcHULSJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 07:18:09 -0400
Received: by mail-yb0-f195.google.com with SMTP id e31so2362275ybi.0
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 04:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=Qpmom3AgK/WNTXR7ta5ng9tbf9npX3eNgP0ljNZ5apM=;
        b=SNVWsNVpomFBgHE4gXr8Dcxg+vMzFsXssdCLjYzFsN9C/C/471i/GXVUh3WtJRp0+i
         41+x3uX5DNYBBk19pzh32kUJMYql/idzYCKpeQrOlzMvx3z8DJqCb6hYeXNmVMF+zdgW
         RBF+TqqvFmh1Hq4ZR54xQ/uTiIgZULvTziEzwNXChU8gkCJ4BC25l/igNksiJMvqIUkr
         /6YOjuB1dZ/t3fTIWaI0TdcCB66aNlNmS6AGtkHyv87F554WOKX0vqtpLKGRbGr0o/kC
         akpj56a4aanBt9hBO/2wLgJaL5D1E9HiglZ40fHa7chxNiHxI6i6wlICCNOyfBmjTiQW
         syIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=Qpmom3AgK/WNTXR7ta5ng9tbf9npX3eNgP0ljNZ5apM=;
        b=TfR4epteUH+8uz9h3zWeHgV+/yhfS7zCD5paNEIG6+uHpEU2r4IkVW4oS90z50tXbP
         uSm0lQs/+ktPWvvKN6jUJnkxa0lme2knSR1o/Gw1IsFNk1GPnsu6RmRzkpBZE5thNUha
         tWRoulMUyB3KjTNMpSp++rGFPDB6hFf97O3FCP5WbLloXoTwo8luBKIvdXmJG7rCMAM0
         E5V03yHFqP2ye2bEFtj2l4vrnAHpeWQMxfAmIc8Sc+jTA5gyVFT3DPKlGDmokO5y6GP8
         AVioPT+Pex14AXIlxjHes/07Yh7aAqyVGzzyD31zh3U6IhkiVIg83XQu8wmxg4r+VayP
         pHyQ==
X-Gm-Message-State: AEkoouvOLXB1yVp/yOQICa67RNY6YRDUxo1TTiFSBFvwqy16/8F8ms6K+RfrVnrxBa7uez6zm6p0ZeiSwyzb7Q==
X-Received: by 10.37.58.129 with SMTP id h123mr2872783yba.131.1471778287970;
 Sun, 21 Aug 2016 04:18:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.129.89.132 with HTTP; Sun, 21 Aug 2016 04:18:07 -0700 (PDT)
In-Reply-To: <01020156a48145a8-d2a03d0a-e6e8-42ae-9960-2effc5547b7c-000000@eu-west-1.amazonses.com>
References: <01020156a48144f8-c0e127c1-8cd9-4295-ac16-449a54315cac-000000@eu-west-1.amazonses.com>
 <01020156a48145a8-d2a03d0a-e6e8-42ae-9960-2effc5547b7c-000000@eu-west-1.amazonses.com>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Sun, 21 Aug 2016 16:48:07 +0530
Message-ID: <CAFZEwPOLuOBdA5rD0oqwApZm=MfSpBX+cQFZhGkAASbM-_PVSg@mail.gmail.com>
Subject: Re: [PATCH v13 04/13] bisect--helper: `bisect_clean_state` shell
 function in C
To:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey,

On Sat, Aug 20, 2016 at 2:02 AM, Pranit Bauva <pranit.bauva@gmail.com> wrote:
> Reimplement `bisect_clean_state` shell function in C and add a
> `bisect-clean-state` subcommand to `git bisect--helper` to call it from
> git-bisect.sh .
>
> Using `--bisect-clean-state` subcommand is a measure to port shell
> function to C so as to use the existing test suite. As more functions
> are ported, this subcommand will be retired but its implementation  will
> be called by bisect_reset() and bisect_start().
>
> Mentored-by: Lars Schneider <larsxschneider@gmail.com>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
> ---
>  bisect.c                 | 43 +++++++++++++++++++++++++++++++++++++++++++
>  bisect.h                 |  2 ++
>  builtin/bisect--helper.c | 14 +++++++++++++-
>  git-bisect.sh            | 26 +++-----------------------
>  4 files changed, 61 insertions(+), 24 deletions(-)
>
> diff --git a/bisect.c b/bisect.c
> index 6f512c2..45d598d 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -430,6 +430,12 @@ static int read_bisect_refs(void)
>
>  static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
>  static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
> +static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
> +static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
> +static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
> +static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
> +static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
> +static GIT_PATH_FUNC(git_path_head_name, "head-name")
>
>  static void read_bisect_paths(struct argv_array *array)
>  {
> @@ -1040,3 +1046,40 @@ int estimate_bisect_steps(int all)
>
>         return (e < 3 * x) ? n : n - 1;
>  }
> +
> +static int mark_for_removal(const char *refname, const struct object_id *oid,
> +                           int flag, void *cb_data)
> +{
> +       struct string_list *refs = cb_data;
> +       char *ref = xstrfmt("refs/bisect%s", refname);
> +       string_list_append(refs, ref);
> +       return 0;
> +}
> +
> +int bisect_clean_state(void)
> +{
> +       int result = 0;
> +
> +       /* There may be some refs packed during bisection */
> +       struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
> +       for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
> +       string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
> +       result = delete_refs(&refs_for_removal, REF_NODEREF);
> +       refs_for_removal.strdup_strings = 1;
> +       string_list_clear(&refs_for_removal, 0);
> +       unlink_or_warn(git_path_bisect_expected_rev());
> +       unlink_or_warn(git_path_bisect_ancestors_ok());
> +       unlink_or_warn(git_path_bisect_log());
> +       unlink_or_warn(git_path_bisect_names());
> +       unlink_or_warn(git_path_bisect_run());
> +       unlink_or_warn(git_path_bisect_terms());
> +       /* Cleanup head-name if it got left by an old version of git-bisect */
> +       unlink_or_warn(git_path_head_name());
> +       /*
> +        * Cleanup BISECT_START last to support the --no-checkout option
> +        * introduced in the commit 4796e823a.
> +        */
> +       unlink_or_warn(git_path_bisect_start());
> +
> +       return result;
> +}
> diff --git a/bisect.h b/bisect.h
> index acd12ef..0ae63d4 100644
> --- a/bisect.h
> +++ b/bisect.h
> @@ -28,4 +28,6 @@ extern int estimate_bisect_steps(int all);
>
>  extern void read_bisect_terms(const char **bad, const char **good);
>
> +extern int bisect_clean_state(void);
> +
>  #endif
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index 30e1031..e50934c 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -5,10 +5,15 @@
>  #include "refs.h"
>
>  static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
> +static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
> +static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
> +static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
> +static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
>
>  static const char * const git_bisect_helper_usage[] = {
>         N_("git bisect--helper --next-all [--no-checkout]"),
>         N_("git bisect--helper --write-terms <bad_term> <good_term>"),
> +       N_("git bisect--helper --bisect-clean-state"),
>         NULL
>  };
>
> @@ -83,7 +88,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>         enum {
>                 NEXT_ALL = 1,
> -               WRITE_TERMS
> +               WRITE_TERMS,
> +               BISECT_CLEAN_STATE
>         } cmdmode = 0;
>         int no_checkout = 0;
>         struct option options[] = {
> @@ -91,6 +97,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                          N_("perform 'git bisect next'"), NEXT_ALL),
>                 OPT_CMDMODE(0, "write-terms", &cmdmode,
>                          N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
> +               OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
> +                        N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
>                 OPT_BOOL(0, "no-checkout", &no_checkout,
>                          N_("update BISECT_HEAD instead of checking out the current commit")),
>                 OPT_END()
> @@ -109,6 +117,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>                 if (argc != 2)
>                         die(_("--write-terms requires two arguments"));
>                 return write_terms(argv[0], argv[1]);
> +       case BISECT_CLEAN_STATE:
> +               if (argc != 0)
> +                       die(_("--bisect-clean-state requires no arguments"));
> +               return bisect_clean_state();
>         default:
>                 die("BUG: unknown subcommand '%d'", cmdmode);
>         }
> diff --git a/git-bisect.sh b/git-bisect.sh
> index 9ef6cb8..f1202df 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -186,7 +186,7 @@ bisect_start() {
>         #
>         # Get rid of any old bisect state.
>         #
> -       bisect_clean_state || exit
> +       git bisect--helper --bisect-clean-state || exit
>
>         #
>         # Change state.
> @@ -195,7 +195,7 @@ bisect_start() {
>         # We have to trap this to be able to clean up using
>         # "bisect_clean_state".
>         #
> -       trap 'bisect_clean_state' 0
> +       trap 'git bisect--helper --bisect-clean-state' 0
>         trap 'exit 255' 1 2 3 15
>
>         #
> @@ -430,27 +430,7 @@ bisect_reset() {
>                 die "$(eval_gettext "Could not check out original HEAD '\$branch'.
>  Try 'git bisect reset <commit>'.")"
>         fi
> -       bisect_clean_state
> -}
> -
> -bisect_clean_state() {
> -       # There may be some refs packed during bisection.
> -       git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
> -       while read ref hash
> -       do
> -               git update-ref -d $ref $hash || exit
> -       done
> -       rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
> -       rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
> -       rm -f "$GIT_DIR/BISECT_LOG" &&
> -       rm -f "$GIT_DIR/BISECT_NAMES" &&
> -       rm -f "$GIT_DIR/BISECT_RUN" &&
> -       rm -f "$GIT_DIR/BISECT_TERMS" &&
> -       # Cleanup head-name if it got left by an old version of git-bisect
> -       rm -f "$GIT_DIR/head-name" &&
> -       git update-ref -d --no-deref BISECT_HEAD &&
> -       # clean up BISECT_START last
> -       rm -f "$GIT_DIR/BISECT_START"
> +       git bisect--helper --bisect-clean-state || exit
>  }
>
>  bisect_replay () {

The change as compared to the v12 is that the function
`bisect_clean_state()` has been moved to bisect.c from
builtin/bisect--helper.c because in a future function conversion
(bisect_next()) I needed bisect_clean_state() in bisect.c because
bisect.c uses exit() whose signals can be easily trapped by the shell
function and then do the cleanup. But now it would be essential to
convert those exit() statements to return statements. This has been
done. One can find it here[1].

[1]: https://github.com/pranitbauva1997/git/pull/22

Regards,
Pranit Bauva
