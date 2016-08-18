Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF27B1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 02:22:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754161AbcHSCVb (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 22:21:31 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:36357 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754025AbcHSCU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 22:20:58 -0400
Received: by mail-it0-f45.google.com with SMTP id e63so15576764ith.1
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 19:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=WMpX3NVRhf+sb6P/23K0NuJHBfn9HPTqLzIWRCuODJw=;
        b=SFhtqvf+EEFMMAiB7bAwqmtTKGF86hp1PGEBo8i7HuhFhZljlQaTxzbdfiL/IG+bph
         Cs26IrUCyjeacycdsCoKvk0xB+4taycxbjKIB1T9KjSpltVcIFnchAtvU8nAKtb/FE0D
         vRUeXlSvK/LyWkvWs0alnf1Ok94zI/eTJ0wQWkKzKgd9+ZNUVobMlQXFnztF6JcAm9PW
         HRpAwuR4VlUm5e3oUaDK3JKZlYLFdgyL8Zs2t37RsOHgLh0dS4Wjvpj6b8410HcZXdRi
         JxJGe9dTY2s9pCyzqJGPEUogqpyNY4B5484ACyxfGk+0ACv7oAQMtr984reTCtiHyVMO
         QfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=WMpX3NVRhf+sb6P/23K0NuJHBfn9HPTqLzIWRCuODJw=;
        b=dttu1l80jD7/41Hr4vDpJqdDoAnvK08G1L+/lMXPXFXOPX42mfOKf8mdTPVhJi2NPF
         bJVpHbjBZPnnFQQvIejO44lCAe3Wt4HZ6tEo1YHUxrE/eNuY8AEu5C3jcSPoppXS4hpo
         jLJnIyxnHCBMussrdhDC0obL3aRLCI8PkEC1KZf7tDW0rc81SET1TKhrntPeYpth3SQZ
         ZLOONTWGw68S91esGhrvFoZYKSb/QBCOyvuhGv513bI2HmQ0mbjq06HT9vP1mXrjxnwv
         F5JZAzEGkzGKPmEgOAjbnPvS7sq/X8kA51f01kybKPGqYj2sXUliRCx1Y+REXmvytNGQ
         r6oA==
X-Gm-Message-State: AEkoouvwH+mcn8v0wit1xy7RjPywhQnOGmIUgwA4GdXWULjmLW0CcUlfiRaoXYSC93VParHMuSgwnhD3rEThtb5B
X-Received: by 10.36.127.7 with SMTP id r7mr1300975itc.49.1471547056473; Thu,
 18 Aug 2016 12:04:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 12:04:15 -0700 (PDT)
In-Reply-To: <20160818005131.31600-7-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com> <20160818005131.31600-7-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 12:04:15 -0700
Message-ID: <CAGZ79kaFfrVwe+JXVJBBZVPn=mTv7F1db8T1ZzXEaMtZKoupQA@mail.gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Jacob Keller <jacob.keller@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 17, 2016 at 5:51 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> A future patch is going to add a new submodule diff format which
> displays an inline diff of the submodule changes. To make this easier,
> and to ensure that both submodule diff formats use the same initial
> header, factor out show_submodule_header() function which will print the
> current submodule header line, and then leave the show_submodule_summary
> function to lookup and print the submodule log format.
>
> This does create one format change in that "(revision walker failed)"
> will now be displayed on its own line rather than as part of the message
> because we no longer perform this step directly in the header display
> flow. However, this is a rare case and shouldn't impact much. In
> addition, since we no longer need to run prepare_submodule_summary to
> get the fast_backward and fast_forward variables, these have been
> removed from that call, and the show_submodule_header() function does
> its own mergebase lookup.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  submodule.c | 103 +++++++++++++++++++++++++++++++++++++++++++-----------------
>  1 file changed, 74 insertions(+), 29 deletions(-)
>
> diff --git a/submodule.c b/submodule.c
> index e1a51b7506ff..e341ca7ffefd 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -277,8 +277,7 @@ void handle_ignore_submodules_arg(struct diff_options *diffopt,
>  }
>
>  static int prepare_submodule_summary(struct rev_info *rev, const char *path,
> -               struct commit *left, struct commit *right,
> -               int *fast_forward, int *fast_backward)
> +               struct commit *left, struct commit *right)
>  {
>         struct commit_list *merge_bases, *list;
>
> @@ -290,12 +289,6 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
>         add_pending_object(rev, &left->object, path);
>         add_pending_object(rev, &right->object, path);
>         merge_bases = get_merge_bases(left, right);
> -       if (merge_bases) {
> -               if (merge_bases->item == left)
> -                       *fast_forward = 1;
> -               else if (merge_bases->item == right)
> -                       *fast_backward = 1;
> -       }
>         for (list = merge_bases; list; list = list->next) {
>                 list->item->object.flags |= UNINTERESTING;
>                 add_pending_object(rev, &list->item->object,
> @@ -333,31 +326,23 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
>         strbuf_release(&sb);
>  }
>
> -void show_submodule_summary(FILE *f, const char *path,
> +/* Helper function to display the submodule header line prior to the full
> + * summary output. If it can locate the submodule objects directory it will
> + * attempt to lookup both the left and right commits and put them into the
> + * left and right pointers.
> + */
> +static void show_submodule_header(FILE *f, const char *path,
>                 const char *line_prefix,
>                 unsigned char one[20], unsigned char two[20],
>                 unsigned dirty_submodule, const char *meta,
> -               const char *del, const char *add, const char *reset)
> +               const char *reset,
> +               struct commit **left, struct commit **right)
>  {
> -       struct rev_info rev;
> -       struct commit *left = NULL, *right = NULL;
> +       struct commit_list *merge_bases;
>         const char *message = NULL;
>         struct strbuf sb = STRBUF_INIT;
>         int fast_forward = 0, fast_backward = 0;
>
> -       if (is_null_sha1(two))
> -               message = "(submodule deleted)";
> -       else if (add_submodule_odb(path))
> -               message = "(not initialized)";
> -       else if (is_null_sha1(one))
> -               message = "(new submodule)";
> -       else if (!(left = lookup_commit_reference(one)) ||
> -                !(right = lookup_commit_reference(two)))
> -               message = "(commits not present)";
> -       else if (prepare_submodule_summary(&rev, path, left, right,
> -                                          &fast_forward, &fast_backward))
> -               message = "(revision walker failed)";
> -
>         if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
>                 fprintf(f, "%sSubmodule %s contains untracked content\n",
>                         line_prefix, path);
> @@ -365,11 +350,46 @@ void show_submodule_summary(FILE *f, const char *path,
>                 fprintf(f, "%sSubmodule %s contains modified content\n",
>                         line_prefix, path);
>
> +       if (is_null_sha1(one))
> +               message = "(new submodule)";
> +       else if (is_null_sha1(two))
> +               message = "(submodule deleted)";
> +
> +       if (add_submodule_odb(path)) {
> +               if (!message)
> +                       message = "(submodule not initialized)";

Before it was  "(not initialized)" for this case, I think we'd rather keep that?
Though this code path is only used by the porcelain commands, we'd rather not
want to change this in a subtle way in this commit.

If we were to change those, we could discuss if we want to go with
full sentences
all the time:

    submodule is new
    submodule is deleted
    submodule is not initialized



> +               goto output_header;
> +       }
> +
> +       /*
> +        * Attempt to lookup the commit references, and determine if this is
> +        * a fast forward or fast backwards update

nit: end the sentence with a period

> +        */
> +       *left = lookup_commit_reference(one);
> +       *right = lookup_commit_reference(two);
> +
> +       /*
> +        * Warn about missing commits in the submodule project, but only if
> +        * they aren't null

nit: end the sentence with a period

> +
> +void show_submodule_summary(FILE *f, const char *path,
> +               const char *line_prefix,
> +               unsigned char one[20], unsigned char two[20],
> +               unsigned dirty_submodule, const char *meta,
> +               const char *del, const char *add, const char *reset)
> +{
> +       struct rev_info rev;
> +       struct commit *left = NULL, *right = NULL;
> +
> +       show_submodule_header(f, path, line_prefix, one, two, dirty_submodule,
> +                             meta, reset, &left, &right);
> +
> +       /*
> +        * if we don't have both a left and a right pointer, then we can't
> +        * display a summary
> +        */


nit: Start the sentence with capital letters and end the sentence with a period.
Do we need to do another thing here before the return? (Maybe that could
go into the comment as well?)
