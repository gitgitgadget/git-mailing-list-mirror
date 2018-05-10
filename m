Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 02B441F406
	for <e@80x24.org>; Thu, 10 May 2018 18:15:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935667AbeEJSPm (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:15:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45559 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935403AbeEJSPl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:15:41 -0400
Received: by mail-pl0-f68.google.com with SMTP id bi12-v6so1749949plb.12
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zHnRmxskQHTENSpnSIMvb+lOb8xBq8LbL2Zkn6VAsSI=;
        b=btkOLB81ANmJ3o/2JzIv7mwmcN+SNW/mFTqaw+5iOAwDYBWTJy1JrA4DgWfv8Gv0SG
         cqeYy6TG967HeLJsJ6/UxaD4rFGHXaGeYYq/9PyI1APc2Qnxd+zD/kASH588OL3e+Y8+
         zFerd8zuXz7fwoqc9MAS24MjrabANkVJXdWN/zJ2Q7DpCquHjv9eVyvCUbmlNYfPe6AR
         3sEV5qkM3dyAB3Rz9LbkXN3ZIh8mVJA9HNbL/Q5bGaYPrfpUgUZ8Y36IuJhv6xQjyjVd
         SW2S+Kb+HwIjvBdn92StAN9+dQg1AK1iYp1+FmiyZ4RvrlOg055gYHDyQwF6SUt51t40
         FLfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zHnRmxskQHTENSpnSIMvb+lOb8xBq8LbL2Zkn6VAsSI=;
        b=aEjkzJJgQr3TS0oDCPowZ6tjBucinN8bLl8uE34x4+L/1BcdBXgetBDc6jx+vWNiAL
         Il3icaqy3YNSUNXuNhrUA1ckhU25TngR5DoWIRtSDk7i3CEh96vo3O1jUcZsOPIEHoZE
         xfooGcpXw5TMr8zobNG8Oc1XmBc4Q8JLX/za4Yz2ZG4PRPxaSfr8/9H/romVE6yFrlDN
         DThOKyfpqcJSTxUrfrfQEeU7lZv3W94kg1cGwdQ/GpevjPnF3Gy9mDf9iODFOR4eSob1
         YAM7/eWs+m2vgyBa6foFFpd3cKafP04kBvu3w4gmvzdgbTbEOVvRbTdVS4jjTT7yYNK7
         4X6A==
X-Gm-Message-State: ALKqPwdN/pKbhLBLxDV6Kszqi6OYVDcm7ms4AlyfQRcLfs+qhmpKyc2b
        6IrbYYpqDnK+lb9IuoHz23flc+mlIYC5DoOVc6Q=
X-Google-Smtp-Source: AB8JxZrML/7o9OsLoECrnbSizYF8RuaJ+NJQEqd6/NCKrgj8xZnkKPwT05N4o+d5z6aN6L0MEIAedLziQA0XCR3zf9Y=
X-Received: by 2002:a17:902:74c6:: with SMTP id f6-v6mr2327932plt.7.1525976141035;
 Thu, 10 May 2018 11:15:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.187.139 with HTTP; Thu, 10 May 2018 11:15:40 -0700 (PDT)
In-Reply-To: <20180510173345.40577-2-dstolee@microsoft.com>
References: <20180417181028.198397-1-dstolee@microsoft.com>
 <20180510173345.40577-1-dstolee@microsoft.com> <20180510173345.40577-2-dstolee@microsoft.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Thu, 10 May 2018 20:15:40 +0200
Message-ID: <CAN0heSrg7W86UFKjCXv-NC1+tYr42B-aUksRhWv7Oug1PG8g8Q@mail.gmail.com>
Subject: Re: [PATCH 01/12] commit-graph: add 'verify' subcommand
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10 May 2018 at 19:34, Derrick Stolee <dstolee@microsoft.com> wrote:
> In case the commit-graph file becomes corrupt, we need a way to
> verify its contents match the object database. In the manner of

s/verify its/verify that its/ might read better.

> 'git fsck' we will implement a 'git commit-graph verify' subcommand
> to report all issues with the file.
>
> Add the 'verify' subcommand to the 'commit-graph' builtin and its
> documentation. The subcommand is currently a no-op except for
> loading the commit-graph into memory, which may trigger run-time
> errors that would be caught by normal use. Add a simple test that
> ensures the command returns a zero error code.
>
> If no commit-graph file exists, this is an acceptable state. Do
> not report any errors.

This all makes sense to me.

> --- a/Documentation/git-commit-graph.txt
> +++ b/Documentation/git-commit-graph.txt

> +'verify'::
> +
> +Read the commit-graph file and verify its contents against the object
> +database. Used to verify for corrupted data.

s/verify for/check for/?

> --- a/builtin/commit-graph.c
> +++ b/builtin/commit-graph.c
> @@ -7,11 +7,17 @@
>
>  static char const * const builtin_commit_graph_usage[] = {
>         N_("git commit-graph [--object-dir <objdir>]"),
> +       N_("git commit-graph verify [--object-dir <objdir>]"),
>         N_("git commit-graph read [--object-dir <objdir>]"),
>         N_("git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--stdin-commits]"),

Minor nit: In the man-page, you added verify after read, which makes
more sense I think (r < v < w).

(I also note that the man-page synopsis doesn't give the no-subcommand
usage.)

> +static int graph_verify(int argc, const char **argv)
> +{
> +       struct commit_graph *graph = 0;
> +       char *graph_name;
> +
> +       static struct option builtin_commit_graph_verify_options[] = {
> +               OPT_STRING(0, "object-dir", &opts.obj_dir,
> +                          N_("dir"),
> +                          N_("The object directory to store the graph")),
> +               OPT_END(),
> +       };
> +
> +       argc = parse_options(argc, argv, NULL,
> +                            builtin_commit_graph_verify_options,
> +                            builtin_commit_graph_verify_usage, 0);
> +
> +       if (!opts.obj_dir)
> +               opts.obj_dir = get_object_directory();
> +
> +       graph_name = get_commit_graph_filename(opts.obj_dir);
> +       graph = load_commit_graph_one(graph_name);
> +
> +       if (!graph)
> +               return 0;
> +       FREE_AND_NULL(graph_name);

Maybe the FREE_AND_NULL could go immediately after the call to
`load_commit_graph_one()`. It makes it more obvious that you're done
with the name, and -- perhaps more importantly -- means that throwing a
leak-checker at this won't complain if we take the early return.

> +
> +       return verify_commit_graph(graph);

A leak-checker would still complain about leaking `graph`. I think it
would be ok to just UNLEAK it before calling `verify_commit_graph()`.
This is IMHO close enough to returning from `cmd_commit_graph()` to make
UNLEAK an acceptable, or even the correct, solution.

I realize that `graph_read()` is doing something similar to this patch
already, so what you have here is certainly the most consistent code.

Martin
