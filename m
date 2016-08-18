Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_06_12,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D56B1F6C1
	for <e@80x24.org>; Fri, 19 Aug 2016 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754256AbcHSBW7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 21:22:59 -0400
Received: from mail-it0-f43.google.com ([209.85.214.43]:35554 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753998AbcHSBW5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 21:22:57 -0400
Received: by mail-it0-f43.google.com with SMTP id x131so14631814ite.0
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 18:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jQfDmXpEA2NfJ9MBzE6u/+NtF+PBzcFIj0cCmuC0PG8=;
        b=aWcc/fM/g65Z4vW3apjPAcx+gZ8iYloYZBNM9r/bmdi32X4epyoNPzpr46ol6W/mkw
         aSsON0gB95R6eg6F18z2nGT4uoDBtJ7mqjT4uBD7Wa+mtcePJpKrNxm3U8IOBER3eQMx
         Mz2DZK/dFI8wOZUeaD7hV882JZy4Vv1boVnMMHw4ZpSjEpxyuNPoHdvR/rvpQ6vpFQ2H
         R24CZM27HGLioD4AqRh0PLvUz3UsfS7HkPYq8N4zOhSan71N8hH9//mtAqpFpQGCGaoS
         0zXW/Dx0dITyxVHmCriHwbXKoVhI2Jv8dZI5+alRLbtVQx7PdvL5ZmX07+LoAobmqBNt
         LgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jQfDmXpEA2NfJ9MBzE6u/+NtF+PBzcFIj0cCmuC0PG8=;
        b=jEtx4QwV6a3MQvKpTuUh81Stg4tacdd3ogzLIWhJmiQvTEPXJqtr5lf9pZ/qE1ZgGG
         OUqtoYPPbuHtOnRG+gQVKL7YV+tZ9ecZh3D2Zy/wA55ddDx2bJnvKRVs4gzHvWrsBJye
         2V/y9bv1hmpAnHF4Pk2RaZtHf8kUW9qgHxtixStctT9PCsBu3DZkySctGlzg2dzIYjUu
         2I2B3l2a8FPxMBMca3ETow9l4USG4bsAgJi6iuUsKAJdNV9UtnCQKAeqRm2ggmK/FOt3
         ms3vWDaCavAXSlpMfe3iyKkBENUDWk4Dyt8Cvn4ySq7kMnZMARpAuNgIIBtcmT4JEZRg
         TqfQ==
X-Gm-Message-State: AEkoouutM0lhNE/4zvGopBZjIHqxJ6kB8GH4uY8ttUmQWhBWpGKV8ORH8MBTU6jljuOm0vgRSEecP1GPACm6X0NE
X-Received: by 10.36.228.138 with SMTP id o132mr932934ith.49.1471542970003;
 Thu, 18 Aug 2016 10:56:10 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 18 Aug 2016 10:56:09 -0700 (PDT)
In-Reply-To: <20160818005131.31600-3-jacob.e.keller@intel.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com> <20160818005131.31600-3-jacob.e.keller@intel.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 18 Aug 2016 10:56:09 -0700
Message-ID: <CAGZ79kZeSwteU84-=GZ0cZDCJUf6=VrGzAiNqC_gx7DgTQX-8Q@mail.gmail.com>
Subject: Re: [PATCH v7 2/7] graph: add support for --line-prefix on all
 graph-aware output
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
> Add an extension to git-diff and git-log (and any other graph-aware
> displayable output) such that "--line-prefix=<string>" will print the
> additional line-prefix on every line of output.
>
> To make this work, we have to fix a few bugs in the graph API that force
> graph_show_commit_msg to be used only when you have a valid graph.
> Additionally, we extend the default_diff_output_prefix handler to work
> even when no graph is enabled.
>
> This is somewhat of a hack on top of the graph API, but I think it
> should be acceptable here.
>
> This will be used by a future extension of submodule display which
> displays the submodule diff as the actual diff between the pre and post
> commit in the submodule project.
>
> Add some tests for both git-log and git-diff to ensure that the prefix
> is honored correctly.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>  Documentation/diff-options.txt                     |   3 +
>  builtin/rev-list.c                                 |  70 ++---
>  diff.c                                             |   7 +
>  diff.h                                             |   2 +
>  graph.c                                            | 104 ++++---
>  graph.h                                            |  22 +-
>  log-tree.c                                         |   5 +-
>  t/t4013-diff-various.sh                            |   6 +
>  ...diff.diff_--line-prefix=abc_master_master^_side |  29 ++
>  t/t4013/diff.diff_--line-prefix_--cached_--_file0  |  15 +
>  t/t4202-log.sh                                     | 323 +++++++++++++++++++++
>  11 files changed, 506 insertions(+), 80 deletions(-)
>  create mode 100644 t/t4013/diff.diff_--line-prefix=abc_master_master^_side
>  create mode 100644 t/t4013/diff.diff_--line-prefix_--cached_--_file0
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 705a87394200..cc4342e2034d 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -569,5 +569,8 @@ endif::git-format-patch[]
>  --no-prefix::
>         Do not show any source or destination prefix.
>
> +--line-prefix=<prefix>::
> +       Prepend an additional prefix to every line of output.
> +
>  For more detailed explanation on these common options, see also
>  linkgit:gitdiffcore[7].
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 0ba82b1635b6..1a75a83538f4 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -122,48 +122,40 @@ static void show_commit(struct commit *commit, void *data)
>                 ctx.fmt = revs->commit_format;
>                 ctx.output_encoding = get_log_output_encoding();
>                 pretty_print_commit(&ctx, commit, &buf);
> -               if (revs->graph) {
> -                       if (buf.len) {
> -                               if (revs->commit_format != CMIT_FMT_ONELINE)
> -                                       graph_show_oneline(revs->graph);
> +               if (buf.len) {
> +                       if (revs->commit_format != CMIT_FMT_ONELINE)
> +                               graph_show_oneline(revs->graph);
>
> -                               graph_show_commit_msg(revs->graph, &buf);
> +                       graph_show_commit_msg(revs->graph, stdout, &buf);
>
> -                               /*
> -                                * Add a newline after the commit message.
> -                                *
> -                                * Usually, this newline produces a blank
> -                                * padding line between entries, in which case
> -                                * we need to add graph padding on this line.
> -                                *
> -                                * However, the commit message may not end in a
> -                                * newline.  In this case the newline simply
> -                                * ends the last line of the commit message,
> -                                * and we don't need any graph output.  (This
> -                                * always happens with CMIT_FMT_ONELINE, and it
> -                                * happens with CMIT_FMT_USERFORMAT when the
> -                                * format doesn't explicitly end in a newline.)
> -                                */
> -                               if (buf.len && buf.buf[buf.len - 1] == '\n')
> -                                       graph_show_padding(revs->graph);
> -                               putchar('\n');
> -                       } else {
> -                               /*
> -                                * If the message buffer is empty, just show
> -                                * the rest of the graph output for this
> -                                * commit.
> -                                */
> -                               if (graph_show_remainder(revs->graph))
> -                                       putchar('\n');
> -                               if (revs->commit_format == CMIT_FMT_ONELINE)
> -                                       putchar('\n');
> -                       }
> +                       /*
> +                               * Add a newline after the commit message.

I wondered if it is my webmailer displaying things wrongly here so I checked
it at public inbox, and fetched the mails and applied them.

It seems to me as if this long comment is broken in indentation
(i.e. you removed a blank ' ' directly in front of the '*' instead of a '\t' ?)


> +                               *
> +                               * Usually, this newline produces a blank
> +                               * padding line between entries, in which case
> +                               * we need to add graph padding on this line.
> +                               *
> +                               * However, the commit message may not end in a
> +                               * newline.  In this case the newline simply
> +                               * ends the last line of the commit message,
> +                               * and we don't need any graph output.  (This
> +                               * always happens with CMIT_FMT_ONELINE, and it
> +                               * happens with CMIT_FMT_USERFORMAT when the
> +                               * format doesn't explicitly end in a newline.)
> +                               */

> - if (!graph)
> + if (!graph) {
> +         graph_show_line_prefix(default_diffopt);
>           return;
> + }

> -       if (graph_is_commit_finished(graph))
> +       if (graph_is_commit_finished(graph)) {
> +               graph_show_line_prefix(&graph->revs->diffopt);
>                 return 0;
> +       }

This seems to be a reoccurring pattern, i.e. we need to add a lot of
one off instructions before a return. Is it possible to make the call
earlier instead
of just before the returns? (or later for that matter) ?


Thanks,
Stefan
